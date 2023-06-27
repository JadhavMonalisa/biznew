import 'dart:async';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../constant/assets.dart';
import '../../../routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  String userId = "";
  @override
  void initState() {
    super.initState();
    getData();
    startTime();
    getAppTransparency();
  }

  getData() {
    userId = GetStorage().read("userId") ?? "";
  }

  getAppTransparency() async {
    final status = await AppTrackingTransparency.requestTrackingAuthorization();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, navigationPage);
  }

  Future<void> navigationPage() async {
    if (userId == "") {
      Get.toNamed(AppRoutes.login);
    } else {
      Get.toNamed(AppRoutes.bottomNav);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Center(
            child: SizedBox(
          height: MediaQuery.of(context).size.height / 7,
          width: MediaQuery.of(context).size.width / 1.3,
          child: Image.asset(Assets.splashLogo, fit: BoxFit.fill),
        )),
      ),
    );
  }
}
