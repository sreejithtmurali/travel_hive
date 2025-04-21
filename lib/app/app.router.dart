// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i17;
import 'package:flutter/material.dart';
import 'package:my_travelmate/models/mytrips/Data.dart' as _i18;
import 'package:my_travelmate/ui/screens/add_emergency_contact/add_emergency_contact_view.dart'
    as _i13;
import 'package:my_travelmate/ui/screens/createTrip/createtrip_view.dart'
    as _i6;
import 'package:my_travelmate/ui/screens/dashboard/dashboard_view.dart' as _i4;
import 'package:my_travelmate/ui/screens/groupChatView/group_chat_view.dart'
    as _i16;
import 'package:my_travelmate/ui/screens/groups/Groups_view.dart' as _i7;
import 'package:my_travelmate/ui/screens/home/Home_view.dart' as _i11;
import 'package:my_travelmate/ui/screens/login/login_view.dart' as _i3;
import 'package:my_travelmate/ui/screens/myemergencycontacts/myemergencycontactsview.dart'
    as _i14;
import 'package:my_travelmate/ui/screens/MyTrips/mytrips_view.dart' as _i8;
import 'package:my_travelmate/ui/screens/Profile/Profile_view.dart' as _i9;
import 'package:my_travelmate/ui/screens/SignUpScreen/SignUpScreen_view.dart'
    as _i5;
import 'package:my_travelmate/ui/screens/Sos/Sos_view.dart' as _i10;
import 'package:my_travelmate/ui/screens/splash/splash_view.dart' as _i2;
import 'package:my_travelmate/ui/screens/updateTrip/updatetrip_view.dart'
    as _i15;
import 'package:my_travelmate/ui/screens/viewTrip/viewtrip_view.dart' as _i12;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i19;

class Routes {
  static const splashView = '/';

  static const loginView = '/login-view';

  static const dashboardView = '/dashboard-view';

  static const signUpScreen = '/sign-up-screen';

  static const createTripView = '/create-trip-view';

  static const groupsView = '/groups-view';

  static const myTripsView = '/my-trips-view';

  static const profileView = '/profile-view';

  static const sOSView = '/s-os-view';

  static const homeView = '/home-view';

  static const tripView = '/trip-view';

  static const addEmergencyContactView = '/add-emergency-contact-view';

  static const myEmergencyContactView = '/my-emergency-contact-view';

  static const updateTripView = '/update-trip-view';

  static const groupChatView = '/group-chat-view';

  static const all = <String>{
    splashView,
    loginView,
    dashboardView,
    signUpScreen,
    createTripView,
    groupsView,
    myTripsView,
    profileView,
    sOSView,
    homeView,
    tripView,
    addEmergencyContactView,
    myEmergencyContactView,
    updateTripView,
    groupChatView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashView,
      page: _i2.SplashView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i3.LoginView,
    ),
    _i1.RouteDef(
      Routes.dashboardView,
      page: _i4.DashboardView,
    ),
    _i1.RouteDef(
      Routes.signUpScreen,
      page: _i5.SignUpScreen,
    ),
    _i1.RouteDef(
      Routes.createTripView,
      page: _i6.CreateTripView,
    ),
    _i1.RouteDef(
      Routes.groupsView,
      page: _i7.GroupsView,
    ),
    _i1.RouteDef(
      Routes.myTripsView,
      page: _i8.MyTripsView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i9.ProfileView,
    ),
    _i1.RouteDef(
      Routes.sOSView,
      page: _i10.SOSView,
    ),
    _i1.RouteDef(
      Routes.homeView,
      page: _i11.HomeView,
    ),
    _i1.RouteDef(
      Routes.tripView,
      page: _i12.TripView,
    ),
    _i1.RouteDef(
      Routes.addEmergencyContactView,
      page: _i13.AddEmergencyContactView,
    ),
    _i1.RouteDef(
      Routes.myEmergencyContactView,
      page: _i14.MyEmergencyContactView,
    ),
    _i1.RouteDef(
      Routes.updateTripView,
      page: _i15.UpdateTripView,
    ),
    _i1.RouteDef(
      Routes.groupChatView,
      page: _i16.GroupChatView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashView(),
        settings: data,
      );
    },
    _i3.LoginView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.LoginView(),
        settings: data,
      );
    },
    _i4.DashboardView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.DashboardView(),
        settings: data,
      );
    },
    _i5.SignUpScreen: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.SignUpScreen(),
        settings: data,
      );
    },
    _i6.CreateTripView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.CreateTripView(),
        settings: data,
      );
    },
    _i7.GroupsView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.GroupsView(),
        settings: data,
      );
    },
    _i8.MyTripsView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.MyTripsView(),
        settings: data,
      );
    },
    _i9.ProfileView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.ProfileView(),
        settings: data,
      );
    },
    _i10.SOSView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.SOSView(),
        settings: data,
      );
    },
    _i11.HomeView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.HomeView(),
        settings: data,
      );
    },
    _i12.TripView: (data) {
      final args = data.getArgs<TripViewArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.TripView(myTrip: args.myTrip, key: args.key),
        settings: data,
      );
    },
    _i13.AddEmergencyContactView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.AddEmergencyContactView(),
        settings: data,
      );
    },
    _i14.MyEmergencyContactView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.MyEmergencyContactView(),
        settings: data,
      );
    },
    _i15.UpdateTripView: (data) {
      final args = data.getArgs<UpdateTripViewArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i15.UpdateTripView(key: args.key, myTrip: args.myTrip),
        settings: data,
      );
    },
    _i16.GroupChatView: (data) {
      final args = data.getArgs<GroupChatViewArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i16.GroupChatView(
            key: args.key, roomId: args.roomId, roomName: args.roomName),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class TripViewArguments {
  const TripViewArguments({
    required this.myTrip,
    this.key,
  });

  final _i18.MyTrip myTrip;

  final _i17.Key? key;

  @override
  String toString() {
    return '{"myTrip": "$myTrip", "key": "$key"}';
  }

  @override
  bool operator ==(covariant TripViewArguments other) {
    if (identical(this, other)) return true;
    return other.myTrip == myTrip && other.key == key;
  }

  @override
  int get hashCode {
    return myTrip.hashCode ^ key.hashCode;
  }
}

class UpdateTripViewArguments {
  const UpdateTripViewArguments({
    this.key,
    required this.myTrip,
  });

  final _i17.Key? key;

  final _i18.MyTrip myTrip;

  @override
  String toString() {
    return '{"key": "$key", "myTrip": "$myTrip"}';
  }

  @override
  bool operator ==(covariant UpdateTripViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.myTrip == myTrip;
  }

  @override
  int get hashCode {
    return key.hashCode ^ myTrip.hashCode;
  }
}

class GroupChatViewArguments {
  const GroupChatViewArguments({
    this.key,
    required this.roomId,
    this.roomName,
  });

  final _i17.Key? key;

  final num roomId;

  final String? roomName;

  @override
  String toString() {
    return '{"key": "$key", "roomId": "$roomId", "roomName": "$roomName"}';
  }

  @override
  bool operator ==(covariant GroupChatViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.roomId == roomId &&
        other.roomName == roomName;
  }

  @override
  int get hashCode {
    return key.hashCode ^ roomId.hashCode ^ roomName.hashCode;
  }
}

extension NavigatorStateExtension on _i19.NavigationService {
  Future<dynamic> navigateToSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDashboardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.dashboardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSignUpScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.signUpScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateTripView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.createTripView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGroupsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.groupsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMyTripsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.myTripsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSOSView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.sOSView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTripView({
    required _i18.MyTrip myTrip,
    _i17.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.tripView,
        arguments: TripViewArguments(myTrip: myTrip, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddEmergencyContactView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addEmergencyContactView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMyEmergencyContactView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.myEmergencyContactView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUpdateTripView({
    _i17.Key? key,
    required _i18.MyTrip myTrip,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.updateTripView,
        arguments: UpdateTripViewArguments(key: key, myTrip: myTrip),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGroupChatView({
    _i17.Key? key,
    required num roomId,
    String? roomName,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.groupChatView,
        arguments: GroupChatViewArguments(
            key: key, roomId: roomId, roomName: roomName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDashboardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.dashboardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSignUpScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.signUpScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateTripView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.createTripView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithGroupsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.groupsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMyTripsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.myTripsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSOSView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.sOSView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTripView({
    required _i18.MyTrip myTrip,
    _i17.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.tripView,
        arguments: TripViewArguments(myTrip: myTrip, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddEmergencyContactView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addEmergencyContactView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMyEmergencyContactView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.myEmergencyContactView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUpdateTripView({
    _i17.Key? key,
    required _i18.MyTrip myTrip,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.updateTripView,
        arguments: UpdateTripViewArguments(key: key, myTrip: myTrip),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithGroupChatView({
    _i17.Key? key,
    required num roomId,
    String? roomName,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.groupChatView,
        arguments: GroupChatViewArguments(
            key: key, roomId: roomId, roomName: roomName),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
