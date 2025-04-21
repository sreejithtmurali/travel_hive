import 'dart:async';
import 'package:my_travelmate/app/app.router.dart';
import 'package:my_travelmate/app/utils.dart';
import 'package:stacked/stacked.dart';
class SplashViewModel extends BaseViewModel {
  starttimer(){
    Timer(Duration(seconds: 4),() async {
             var user=await userservice.getUser();
             if(user!=null){
               navigationService.pushNamedAndRemoveUntil(Routes.dashboardView);
             }else{
               navigationService.pushNamedAndRemoveUntil(Routes.loginView);
             }
    });
  }

}
