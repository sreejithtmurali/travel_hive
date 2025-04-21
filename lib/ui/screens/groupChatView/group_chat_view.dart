import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import '../../../constants/color_constants.dart';
import 'group_chat_view_model.dart';
class GroupChatView extends StatelessWidget {
  final num roomId;
  final String? roomName;

  const GroupChatView({
    super.key,
    required this.roomId,
    this.roomName,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GroupChatViewModel>.reactive(
      viewModelBuilder: () => GroupChatViewModel(roomId: roomId,roomName: roomName),
      onViewModelReady: (model) => model.init(roomId),
     // onDispose: (model) => model.dispose(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: ColorConstants.primaryRed,
          elevation: 4,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            viewModel.currentRoom?.name ?? roomName ?? 'Chat',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline, color: Colors.white),
              onPressed: () => viewModel.showGroupInfo(),
            ),
          ],
        ),
        body: Column(
          children: [
            if (!viewModel.isConnected) _buildConnectionBanner(),
            Expanded(child: _buildMessages(viewModel)),
            _buildMessageInput(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionBanner() {
    return Container(
      color: Colors.red[100],
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Icon(Icons.error_outline, size: 16, color: Colors.red[700]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Disconnected - Reconnecting...',
              style: GoogleFonts.roboto(color: Colors.red[700]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessages(GroupChatViewModel model) {
    return ListView.builder(
      controller: model.scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: model.messages.length,
      itemBuilder: (context, index) {
        final msg = model.messages[index];
        final isMine = msg.sender?.id == model.userId;
        List<int> bytes = msg.content!.codeUnits; // Convert to bytes
        String correctText = utf8.decode(bytes, allowMalformed: true);



        return Align(
          alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isMine ? ColorConstants.primaryRed : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isMine ? 16 : 0),
                bottomRight: Radius.circular(isMine ? 0 : 16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
              isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isMine)
                  Text(
                    msg.sender?.name ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                if (msg.content != null && msg.content!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      correctText.trim(),
                      style: TextStyle(
                        fontSize: 15,
                        color: isMine ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    _formatTime(msg.timestamp),
                    style: TextStyle(
                      fontSize: 10,
                      color: isMine ? Colors.white70 : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessageInput(GroupChatViewModel model) {
    return SafeArea(
      child: Card(
        color: const Color(0xfffdd7d7),
        elevation: 10,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: model.messageController,
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (text) => model.sendTypingIndicator(text.isNotEmpty),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.red),
                onPressed: model.sendMessage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(String? timestamp) {
    if (timestamp == null) return '';
    final time = DateTime.tryParse(timestamp);
    if (time == null) return '';
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
