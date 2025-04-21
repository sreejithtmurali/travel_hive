import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:my_travelmate/ui/screens/groupChatView/imagidialogue.dart';
import 'package:my_travelmate/ui/widgets/setup_dependencies.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_travelmate/ui/tools/screen_size.dart';
import 'package:my_travelmate/app/app.locator.dart';
import 'package:my_travelmate/app/app.router.dart';
import 'package:my_travelmate/constants/app_strings.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  if (!kIsWeb) {
    if (Platform.isAndroid) {
      // ByteData data = await PlatformAssetBundle().load(
      //   Assets.ca.letsEncryptR3,
      // );
      // SecurityContext.defaultContext.setTrustedCertificatesBytes(
      //   data.buffer.asUint8List(),
      // );
    }
  }
  setupDependencies();
  runApp( const MyApp());

}

Future<void> setupDependencies() async {
  setupLocator();
  setupDialogUi();
}
void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.basic: (context, request, completer) =>
        EmojiDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFFFBF1)),
      title: AppStrings.appName,
      builder: (context, child) {
        FlutterSmartDialog.init();
        ScreenSize.init(context);
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1)),
          child: child!,
        );
      },
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorObservers: [
        StackedService.routeObserver,
        FlutterSmartDialog.observer
      ],
    );



  }
}
