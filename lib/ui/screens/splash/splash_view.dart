import 'package:flutter/material.dart';
import 'package:my_travelmate/ui/screens/splash/splash_viewmodel.dart';
import 'package:my_travelmate/ui/tools/screen_size.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/assets.gen.dart';


class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      onViewModelReady: (model) {
       model.starttimer();
        },
      builder: (context, model, child) {

        return Scaffold(
          body: Center(child: Assets.images.logo.image(

              width: ScreenSize.width/4,
              fit: BoxFit.fill

          ),),

        );
      },
      viewModelBuilder: () => SplashViewModel(),
    );
  }
}
