import 'package:my_travelmate/ui/screens/MyTrips/mytrips_view.dart';
import 'package:my_travelmate/ui/screens/Profile/Profile_view.dart';
import 'package:my_travelmate/ui/screens/SignUpScreen/SignUpScreen_view.dart';
import 'package:my_travelmate/ui/screens/Sos/Sos_view.dart';
import 'package:my_travelmate/ui/screens/add_emergency_contact/add_emergency_contact_view.dart';
import 'package:my_travelmate/ui/screens/createTrip/createtrip_view.dart';
import 'package:my_travelmate/ui/screens/dashboard/dashboard_view.dart';
import 'package:my_travelmate/ui/screens/groups/Groups_view.dart';
import 'package:my_travelmate/ui/screens/home/Home_view.dart';
import 'package:my_travelmate/ui/screens/login/login_view.dart';
import 'package:my_travelmate/ui/screens/myemergencycontacts/myemergencycontactsview.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/api_services.dart';
import '../services/user_service.dart';
import '../ui/screens/groupChatView/group_chat_view.dart';
import '../ui/screens/splash/splash_view.dart';
import '../ui/screens/updateTrip/updatetrip_view.dart';
import '../ui/screens/viewTrip/viewtrip_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: DashboardView),
    MaterialRoute(page: SignUpScreen),
    MaterialRoute(page: CreateTripView),
    MaterialRoute(page: GroupsView),
    MaterialRoute(page: MyTripsView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: SOSView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: TripView),
    MaterialRoute(page: AddEmergencyContactView),
    MaterialRoute(page: MyEmergencyContactView),
    MaterialRoute(page: UpdateTripView),
    MaterialRoute(page: GroupChatView)
  ],
  dependencies: [
    LazySingleton(classType: ApiService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: UserService),
  ],
)
class AppSetUp {}
