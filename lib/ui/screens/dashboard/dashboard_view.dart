import 'package:flutter/material.dart';
import 'package:my_travelmate/ui/screens/dashboard/dashboard_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/color_constants.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      onViewModelReady: (model) {
        model.init();
      },
      builder: (context, model, child) {
        return Scaffold(
          body: model.myScreens[model.selectedIndex],
          backgroundColor: ColorConstants.mainwhite,
          bottomNavigationBar: BottomNavigationBar(
              currentIndex:model.selectedIndex,
              selectedItemColor: ColorConstants.primaryRed,
              unselectedItemColor: ColorConstants.primaryRed.withOpacity(  0.3),
              onTap: (value) {
                model.selectedIndex = value;
                model.notifyListeners();
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
                BottomNavigationBarItem(icon: Icon(Icons.group), label: "groups"),
                BottomNavigationBarItem(icon: Icon(Icons.sos), label: "sos"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_box_rounded), label: "profile")
              ]),
        );
        // return Scaffold(
        //   appBar: AppBar(),
        //   body: model.isloading
        //       ? ListView.builder(
        //           itemCount: 10,
        //           itemBuilder: (BuildContext context, int index) {
        //             return Shimmer.fromColors(
        //                 baseColor: Colors.grey[300]!,
        //                 highlightColor: Colors.grey[100]!,
        //                 child: ListTile(
        //                   leading: CircleAvatar(
        //                     backgroundColor: Colors.grey,
        //                   ),
        //                   title: Container(
        //                     height: 15,
        //                     width: double.maxFinite,
        //                     color: Colors.grey,
        //                   ),
        //                   subtitle: Container(
        //                     height: 12,
        //                     width: double.maxFinite,
        //                     color: Colors.grey,
        //                   ),
        //                 ));
        //           },
        //         )
        //       : ListView.builder(
        //           itemCount: model.productlist?.length,
        //           itemBuilder: (BuildContext context, int index) {
        //             Products p=model.productlist![index];
        //             print("$index");
        //             return ListTile(
        //               leading: CircleAvatar(
        //                 backgroundImage: NetworkImage(
        //                     "${p.imageUrl}"),
        //               ),
        //               title: Text("${p.name}"),
        //               subtitle: Text("${p.category}"),
        //             );
        //           },
        //         ),
        // );
      },
      viewModelBuilder: () => DashboardViewModel(),
    );
  }
}
