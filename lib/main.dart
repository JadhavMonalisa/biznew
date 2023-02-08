import 'package:biznew/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter/services.dart';
import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runZonedGuarded(() {
    runApp(const MyApp());
  }, (error, stackTrace) {
    // FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      textStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
      backgroundColor: Colors.black,
      radius: 5.0,
      textPadding: const EdgeInsets.all(10.0),
      animationCurve: Curves.easeIn,
      position: ToastPosition.center,
      //animationBuilder: const Miui10AnimBuilder(),
      animationDuration: const Duration(milliseconds: 200),
      duration: const Duration(seconds: 3),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Right Choice",
        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            },
          ),
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        defaultTransition: Transition.fade,
        opaqueRoute: Get.isOpaqueRouteDefault,
        popGesture: Get.isPopGestureEnable,
        getPages: AppPages.all,
        initialRoute: AppPages.initial,
      ),
    );
  }
}