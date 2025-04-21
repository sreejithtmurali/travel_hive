import 'dart:async';
import 'package:my_travelmate/app/app.router.dart';
import 'package:my_travelmate/app/utils.dart';
import 'package:my_travelmate/models/mytrips/Data.dart';
import 'package:stacked/stacked.dart';

import '../../../services/api_services.dart';
class HomeViewModel extends BaseViewModel {
  Future<dynamic> getId() async {
    return await userservice.getUserField("id");
  }
  // Fetch trips from API
  List<MyTrip>? allTrips = []; // Initialize as empty list
  static final ApiEnvironment currentEnv = ApiEnvironment.dev;
var userid;
  // Use the selected environment's base URL
  final String baseUrl = currentEnv.baseUrl;

  bool isloading=false;
  toggleloading(){
    isloading=!isloading;
    notifyListeners();
  }
  Future<void> getAllTrips() async {
    int? id2 = await getId();

    if (id2 == null ) {
      throw Exception("User is not authenticated. Access token is missing.");
    }else{
      userid=id2;
      notifyListeners();
    }

    toggleloading();
    try {
      allTrips = await apiservice.fetchUpComingTrips();
      notifyListeners();
      toggleloading();// Notify UI to rebuild
    } catch (e) {
      toggleloading();
      print("Error fetching trips: $e");
    } finally {

      notifyListeners();
    }
  }
   void jointrip(int id){
    apiservice.jointrip(id);
   }

  void navigatetripView(MyTrip myTrip) {
navigationService.navigateTo(Routes.tripView,arguments: TripViewArguments(myTrip: myTrip));
  }
}
