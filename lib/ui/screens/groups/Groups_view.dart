import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_travelmate/constants/color_constants.dart';
import 'package:my_travelmate/ui/tools/screen_size.dart';
import 'package:stacked/stacked.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../constants/assets.gen.dart';
import '../../../models/roomres/RoomsRes.dart';
import 'Groups_viewmodel.dart';

class GroupsView extends StatelessWidget {
  const GroupsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GroupsViewModel>.reactive(
      onViewModelReady: (model) {
        model.fetch();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorConstants.primaryRed,
            elevation: 4,
            title: Text(
              'Group Chats',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed: () => model.fetch(),
                tooltip: 'Refresh',
              ),
            ],
          ),

          body: _buildBody(context, model),
        );
      },
      viewModelBuilder: () => GroupsViewModel(),
    );
  }

  Widget _buildBody(BuildContext context, GroupsViewModel model) {
    if (model.isBusy) {
      return const Center(
        child: CircularProgressIndicator(color: ColorConstants.primaryRed),
      );
    }

    if (model.hasError) {
      return _buildErrorView(context, model);
    }

    if (model.mylist == null || model.mylist!.isEmpty) {
      return _buildEmptyView(context);
    }

    return _buildGroupsList(context, model);
  }

  Widget _buildErrorView(BuildContext context, GroupsViewModel model) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          Text(
            "Failed to Load Groups",
            style: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Something went wrong. Please try again.",
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => model.fetch(),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.primaryRed,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Text(
              "Retry",
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.logo.image(
            width: ScreenSize.width / 4,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 20),
          Text(
            "No Groups Available For Chat",
            style: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Join a Trip to get started!",
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGroupsList(BuildContext context, GroupsViewModel model) {
    return RefreshIndicator(
      onRefresh: () async => await model.fetch(),
      color: ColorConstants.primaryRed,
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: model.mylist!.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final room = model.mylist![index];
          return _buildGroupItem(context, room, model);
        },
      ),
    );
  }

  Widget _buildGroupItem(BuildContext context, RoomsRes room, GroupsViewModel model) {
    final hasUnread = (room.unreadCount ?? 0) > 0;

    return InkWell(
      onTap: () => model.navigateToGroupChat(room),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            _buildGroupAvatar(room),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          room.name ?? "Unnamed Group",
                          style: GoogleFonts.roboto(
                            fontWeight: hasUnread ? FontWeight.bold : FontWeight.w500,
                            fontSize: 16,
                            color: ColorConstants.mainblack,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (room.lastMessage != null)
                        Text(
                          _formatMessageTime(room.lastMessage!.timestamp ?? ""),
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _getLastMessagePreview(room),
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: hasUnread ? ColorConstants.primaryRed : Colors.grey[600],
                            fontWeight: hasUnread ? FontWeight.w500 : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (hasUnread)
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: ColorConstants.primaryRed,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${room.unreadCount}',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${room.members?.length ?? 0} members',
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupAvatar(RoomsRes room) {
    final firstLetter = (room.name?.isNotEmpty == true) ? room.name![0].toUpperCase() : '?';
    final color = _getColorFromName(room.name ?? "");

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          firstLetter,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Color _getColorFromName(String name) {
    if (name.isEmpty) return Colors.grey;

    // Generate color based on the room name
    final colorIndex = name.codeUnits.fold<int>(0, (prev, element) => prev + element) % 5;

    switch (colorIndex) {
      case 0: return ColorConstants.primaryRed;
      case 1: return Colors.blue;
      case 2: return Colors.green;
      case 3: return Colors.purple;
      case 4: return Colors.orange;
      default: return Colors.teal;
    }
  }

  String _getLastMessagePreview(RoomsRes room) {
    if (room.lastMessage == null || room.lastMessage!.content == null) {
      return "No messages yet";
    }

    final senderName = room.lastMessage!.sender?.name ?? "Unknown";
    final content = room.lastMessage!.content ?? "";

    return "$senderName: $content";
  }

  String _formatMessageTime(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();

      if (now.difference(dateTime).inDays < 1) {
        return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
      } else if (now.difference(dateTime).inDays < 7) {
        return timeago.format(dateTime, locale: 'en_short');
      } else {
        return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
      }
    } catch (e) {
      return "";
    }
  }
}