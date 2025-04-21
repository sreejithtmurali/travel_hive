import 'dart:async';
import 'package:my_travelmate/app/utils.dart';
import 'package:stacked/stacked.dart';

import '../../../models/mytrips/Data.dart';
import '../../../services/api_services.dart';
class TripViewModel extends BaseViewModel {
  late MyTrip myTrip;
  static final ApiEnvironment currentEnv = ApiEnvironment.dev;
  var userid;
  // Use the selected environment's base URL
  final String baseUrl = currentEnv.baseUrl;

  TripViewModel({required this.myTrip});
  var lines=2;

  void toggleDescription() {
    if(lines==2){
      lines=10;
    }
    else{
      lines=2;
    }
    notifyListeners();
  }
  Future<bool?> joingrop() async {
  try{
    bool s=await apiservice.joingroup(myTrip.chatRoom!.id!);
   return s;
  }catch(e){
    return false;

  }
  }
}
