import 'dart:async';
import 'package:my_travelmate/app/app.locator.dart';
import 'package:my_travelmate/app/app.router.dart';
import 'package:my_travelmate/app/utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../models/roomres/RoomsRes.dart';

class GroupsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  List<RoomsRes>? mylist = [];

  Future<void> fetch() async {
    clearErrors();
    setBusy(true);

    try {
      mylist = await apiservice.getRooms();
      // Sort rooms by last message timestamp if available
      mylist?.sort((a, b) {
        if (a.lastMessage?.timestamp == null) return 1;
        if (b.lastMessage?.timestamp == null) return -1;

        try {
          final dateA = DateTime.parse(a.lastMessage!.timestamp!);
          final dateB = DateTime.parse(b.lastMessage!.timestamp!);
          return dateB.compareTo(dateA); // Most recent first
        } catch (e) {
          return 0;
        }
      });
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  void navigateToGroupChat(RoomsRes room) {
    _navigationService.navigateTo(
      Routes.groupChatView,
      arguments: GroupChatViewArguments(roomId: room.id!,roomName: room.name)
    );
  }

  void navigateToCreateGroup() {
   // _navigationService.navigateTo(Routes.createGroupView);
  }
}