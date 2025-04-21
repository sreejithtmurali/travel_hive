import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:my_travelmate/app/utils.dart';
import 'package:my_travelmate/ui/screens/Profile/Profile_view.dart';
import 'package:my_travelmate/ui/screens/Sos/Sos_view.dart';
import 'package:my_travelmate/ui/screens/groups/Groups_view.dart';
import 'package:my_travelmate/ui/screens/home/Home_view.dart';
import 'package:stacked/stacked.dart';

import '../../../models/allproducts/Data.dart';
class DashboardViewModel extends BaseViewModel {
  List<Products>? productlist;
  bool isloading=false;
  String? access;
 Future<void> init()  async {
    var user=await userservice.getUser();
    if(user!=null){
      user.access;
    }
    notifyListeners();
    fetchdata();
  }
  toggleloading(){
    isloading=!isloading;
    notifyListeners();
  }


  Future<void> fetchdata() async {
    toggleloading();
    //productlist=await (apiservice.getAllProducts(token: access!))!;
    print("products loaded");
    notifyListeners();
    toggleloading();
  }

  int selectedIndex = 0;
  List<Widget> myScreens = [
    HomeView(),
    GroupsView(),
    SOSView(),
    ProfileView()
  ];
}
