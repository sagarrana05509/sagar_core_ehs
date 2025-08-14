import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:responsive_screen_utils/responsive_screen_utils.dart';
import 'package:sagar_core_ehs_demo/firebase_options.dart';
import 'app_binding.dart';
import 'routes/routes.dart';
import 'shared/constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      // statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const App());
  configLoading();
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreenUtilInit(
      designSize: Size(375, 812),
      allowFontScaling: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.HOME,
        defaultTransition: Transition.native,
        getPages: AppPages.routes,
        initialBinding: AppBinding(),
        smartManagement: SmartManagement.keepFactory,
        title: 'Core ehs',
        supportedLocales: [const Locale('en', 'US')],
        builder: EasyLoading.init(),
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    // ..indicatorSize = 45.0
    ..radius = 10.0
    ..indicatorSize = 20
    // ..progressColor = Colors.yellow
    ..backgroundColor = ColorConstants.black
    ..indicatorColor = ColorConstants.white
    ..textColor = ColorConstants.white
    ..maskColor = ColorConstants.black.withOpacity(0.5)
    ..maskType = EasyLoadingMaskType.custom
    ..toastPosition = EasyLoadingToastPosition.bottom
    // ..maskColor = Colors.red
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale
    ..successWidget = Container(height: 100, width: 100, color: Colors.blue);
}
