import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_travelmate/app/utils.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../models/chat/ChatMessage.dart';
import '../../../models/chat/Sender.dart';
import '../../../models/roomres/RoomsRes.dart';
import '../../../services/api_services.dart';

class GroupChatViewModel extends BaseViewModel {
  final num roomId;
  final String? roomName;
  GroupChatViewModel({required this.roomId, required this.roomName});
  final ApiService _apiService = ApiService();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  static final ApiEnvironment currentEnv = ApiEnvironment.dev;
  num? userId;
  String? userName;
  final String baseUrl = currentEnv.baseUrl;
  WebSocketChannel? _channel;
  List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;
  Timer? _reconnectTimer;

  RoomsRes? _currentRoom;
  RoomsRes? get currentRoom => _currentRoom;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  bool get isConnected => _channel != null && _channel!.closeCode == null;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void init(num roomId) async {
    if (isConnected) {
      print("WebSocket already connected, skipping initialization");
      return;
    }

    notifyListeners();
    setBusy(true);
    try {
      print("Initializing chat for room ID: $roomId");

      // Get the current user ID from the stored token
      final token = await _apiService.getToken();
      print("Token retrieved: ${token?.substring(0, 10)}...");

      final tokenData = _parseToken(token!);
      userId = tokenData['id'];
      userName = tokenData['name'];
      print("User ID: $userId, User name: $userName");

      // Fetch room details and previous messages
      print("Fetching room details...");
      _currentRoom = await _fetchRoomDetails(roomId);
      print("Room details retrieved: ${_currentRoom?.name}");

      print("Fetching previous messages...");
      final previousMessages = await _fetchPreviousMessages(roomId);
      _messages = previousMessages;
      print("Retrieved ${_messages.length} previous messages");

      // Connect to WebSocket
      print("Connecting to WebSocket...");
      await _connectWebSocket(roomId);

      // Scroll to the bottom to show latest messages
      _scrollToBottom();
    } catch (e) {
      print("Error initializing chat: $e");
      _errorMessage = 'Failed to load chat: ${e.toString()}';
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Map<String, dynamic> _parseToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        return {'id': 0, 'name': 'Unknown User'};
      }

      String normalizedPayload = parts[1].replaceAll('-', '+').replaceAll('_', '/');
      while (normalizedPayload.length % 4 != 0) {
        normalizedPayload += '=';
      }

      final payloadBytes = base64Url.decode(normalizedPayload);
      final payloadString = utf8.decode(payloadBytes);
      final payload = json.decode(payloadString);

      return payload;
    } catch (e) {
      print('Error parsing token: $e');
      return {'id': 0, 'name': 'Unknown User'};
    }
  }

  Future<RoomsRes> _fetchRoomDetails(num roomId) async {
    return await _apiService.getRoomDetails(roomId);
  }

  Future<List<ChatMessage>> _fetchPreviousMessages(num roomId) async {
    try {
      final response = await _apiService.getChatMessages(roomId: roomId);
      response.sort((a, b) {
        final dateA = DateTime.parse(a.timestamp ?? '');
        final dateB = DateTime.parse(b.timestamp ?? '');
        return dateA.compareTo(dateB);
      });
      return response;
    } catch (e) {
      print('Error fetching messages: $e');
      return [];
    }
  }

  Future<void> _connectWebSocket(num roomId) async {
    try {
      String? token = await userservice.getUserField("access");;

      if (token == null) {
        throw Exception('Authentication token not found');
      }

      // Connect to WebSocket with authentication
      final wsUrl = Uri.parse('ws://${baseUrl.replaceAll('http://', '')}/ws/chat/$roomId/?token=$token');
      print("Connecting to WebSocket: $wsUrl");
      _channel = WebSocketChannel.connect(wsUrl);

      _channel!.stream.listen(
            (dynamic message) {
          try {
            final data = jsonDecode(message);
            print("Received WebSocket message: $data");
            _handleIncomingMessage(data);
          } catch (e) {
            print('Error parsing WebSocket message: $e');
          }
        },
        onError: (error) {
          print('WebSocket error: $error');
          if (error is WebSocketChannelException) {
            print('WebSocketChannelException details: ${error.message}');
          }
          _errorMessage = 'WebSocket error: ${error.toString()}';
          notifyListeners();
          if (_channel?.closeCode == null) {
            _channel?.sink.close();
            _channel = null;
          }
          _scheduleReconnect(roomId);
        },
        onDone: () {
          print('WebSocket connection closed with code: ${_channel?.closeCode}, reason: ${_channel?.closeReason}');
          _errorMessage = 'WebSocket connection closed';
          notifyListeners();
          _channel = null;
          _scheduleReconnect(roomId);
        },
      );

      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      print('Failed to connect WebSocket: $e');
      if (e is WebSocketChannelException) {
        print('WebSocketChannelException details: ${e.message}');
      }
      _errorMessage = 'Failed to connect: ${e.toString()}';
      notifyListeners();
      _scheduleReconnect(roomId);
    }
  }

  void _scheduleReconnect(num roomId, {int attempt = 1}) {

    if (_reconnectTimer?.isActive ?? false) {
      print("Reconnect timer already active, skipping schedule");
      return;
    }

    const maxAttempts = 10;
    if (attempt > maxAttempts) {
      print("Max reconnection attempts ($maxAttempts) reached, stopping");
      _errorMessage = 'Unable to reconnect after multiple attempts';
      notifyListeners();
      return;
    }

    final delay = Duration(seconds: (3));
    print("Scheduling reconnection attempt #$attempt in ${delay.inSeconds} seconds");
    _reconnectTimer = Timer(delay, () async {
      if (!isConnected) {
        init(roomId);


        if (!isConnected) {
          _scheduleReconnect(roomId, attempt: attempt + 1);
        } else {
          print("WebSocket reconnected successfully");
        }
      }
    });
  }

  void _handleIncomingMessage(Map<String, dynamic> data) {
    print("Handling incoming message: $data");
    final messageType = data['type'];

    switch (messageType) {
      case 'chat_message':
        if (data.containsKey('message')) {
          final messageData = data['message'];
          print("Processing chat message: $messageData");

          final newMessage = ChatMessage(
            id: messageData['id'] ?? DateTime.now().millisecondsSinceEpoch,
            content: messageData['content'],
            sender: Sender(
              id: messageData['sender']['id'],
              name: messageData['sender']['name'],
            ),
            timestamp: messageData['timestamp'] ?? DateTime.now().toIso8601String(),
            isRead: messageData['is_read'] ?? false,
          );

          print("Created message object: ${newMessage.content}");

          if (!_messages.any((msg) => msg.id == newMessage.id)) {
            _messages.add(newMessage);
            notifyListeners();
            _scrollToBottom();
          } else {
            print("Duplicate message ID ${newMessage.id}, skipping");
          }
        } else {
          print("Message data missing expected format");
        }
        break;
      case 'user_joined':
        _showNotification('${data['username']} joined the chat');
        break;
      case 'user_left':
        _showNotification('${data['username']} left the chat');
        break;
      case 'typing_indicator':
        break;
      default:
        print('Unknown message type: $messageType');
    }
  }

  void sendMessage() async {
    final content = messageController.text.trim();
    if (content.isEmpty) return;

    setBusy(true);
    try {
      final message = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch,
        content: content,
        sender: Sender(id: userId!, name: userName!),
        timestamp: DateTime.now().toIso8601String(),
        isRead: false,
      );

      final success = await _apiService.sendChatMessage(message, roomId);

      if (success) {
        _messages.add(message);
        messageController.clear();
        notifyListeners();
        _scrollToBottom();
      } else {
        _showErrorDialog("Failed to send message. Please try again.");
      }
    } catch (e) {
      print("Error sending message: $e");
      _showErrorDialog("Error sending message: ${e.toString()}");
    } finally {
      setBusy(false);
    }
  }

  void sendTypingIndicator(bool isTyping) {
    if (_channel == null || !isConnected) return;
    try {
      final payload = jsonEncode({
        'type': 'typing_indicator',
        'is_typing': isTyping,
      });
      print("Sending typing indicator: $payload");
      _channel!.sink.add(payload);
    } catch (e) {
      print('Error sending typing indicator: $e');
    }
  }

  void showGroupInfo() {
    if (_currentRoom == null) return;

    final members = _currentRoom!.members?.map((member) => '• ${member.username} ${member.isAdmin! ? '(Admin)' : ''}').join('\n');

    _dialogService.showDialog(
      title: _currentRoom!.name,
      description: '${_currentRoom!.roomType} Chat\n\n'
          'Members (${_currentRoom!.members?.length ?? 0}):\n'
          '${members ?? 'No members'}\n\n'
          'Description: ${_currentRoom!.description ?? 'No description'}\n'
          'Created: ${_formatDate(_currentRoom!.createdAt)}',
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Unknown';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return 'Invalid date';
    }
  }

  void showAttachmentOptions() {
    _dialogService.showDialog(
      title: 'Attach File',
      description: 'This feature is not implemented yet.',
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showErrorDialog(String message) {
    _dialogService.showDialog(
      title: 'Error',
      description: message,
    );
  }

  void _showNotification(String message) {
    ScaffoldMessenger.of(_navigationService.navigatorKey!.currentContext!).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> closeConnection() async {
    _reconnectTimer?.cancel();
    if (_channel != null) {
      print("Closing WebSocket connection");
      await _channel!.sink.close();
      _channel = null;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    closeConnection();
    messageController.dispose();
    scrollController.dispose();
    notifyListeners();
    super.dispose();
  }

  void pickEmoji() async {
    final dialogService = locator<DialogService>();

    final response = await dialogService.showCustomDialog(
      title: 'Choose an emoji',
    );

    if (response != null && response.confirmed && response.data is String) {
      messageController.text += response.data;
      messageController.selection = TextSelection.fromPosition(
        TextPosition(offset: messageController.text.length),
      );
      notifyListeners();
    }
  }
}