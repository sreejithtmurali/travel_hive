import 'package:my_travelmate/services/api_services.dart';
import 'package:my_travelmate/services/user_service.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';

NavigationService get navigationService => locator<NavigationService>();
UserService  get userservice=>locator<UserService>();
ApiService  get apiservice=>locator<ApiService>();
DialogService  get dialogservice=>locator<DialogService>();