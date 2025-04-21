import 'dart:async';
import 'package:my_travelmate/app/app.router.dart';
import 'package:my_travelmate/app/utils.dart';
import 'package:stacked/stacked.dart';

import '../../../models/mytrips/Data.dart';
import '../../../services/api_services.dart';
class MyTripsViewModel extends BaseViewModel {

  List<MyTrip>? allTrips = []; // Initialize as empty list
  static final ApiEnvironment currentEnv = ApiEnvironment.dev;

  // Use the selected environment's base URL
  final String baseUrl = currentEnv.baseUrl;

  bool isloading=false;
  toggleloading(){
    isloading=!isloading;
    notifyListeners();
  }
  Future<void> getAllTrips() async {
    toggleloading();
    try {
      allTrips = await apiservice.fetchMyTrip();
      notifyListeners();
      toggleloading();// Notify UI to rebuild
    } catch (e) {
      print("Error fetching trips: $e");
      toggleloading();
    } finally {

      notifyListeners();
    }
  }
  void navigatetripView(MyTrip myTrip) {
    navigationService.navigateTo(Routes.updateTripView,arguments: UpdateTripViewArguments(myTrip: myTrip));
  }
}
