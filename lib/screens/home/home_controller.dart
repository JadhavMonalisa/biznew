import 'package:biznew/constant/repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:biznew/utils/utils.dart';
import '../../routes/app_pages.dart';

class HomeController extends GetxController {
  final ApiRepository repository;

  // ignore: unnecessary_null_comparison
  HomeController({required this.repository}) : assert(repository != null);

  ///common
  String userId = "";
  String userName = "";
  String name = "";
  bool loader = false;

  ///home screen menu
  List<String> menuNameList = [
    "Dashboard",
    "Leaves",
    "Claim",
    "Timesheet",
    "Appointment",
    "Reports",
    "Petty Task"
  ];
  List<String> menuDescriptionList = [
    "Show recent activities",
    "Manage your leaves",
    "Manage your claims",
    "Manage your timesheet",
    "Book your appointment",
    "Display all reports",
    "Add petty task"
  ];
  List<IconData> menuIconList = [
    Icons.dashboard,
    Icons.calendar_today,
    Icons.filter_frames,
    Icons.timer,
    Icons.edit,
    Icons.file_copy_outlined,
    Icons.task
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userId = GetStorage().read("userId") ?? "";
    userName = GetStorage().read("userName") ?? "";
    name = GetStorage().read("name") ?? "";
  }

  updateLoader(bool val) {
    loader = val;
    update();
  }

  navigateFromMenuScreen(String title) {
    updateLoader(true);
    if (title == "Claim") {
      Get.toNamed(AppRoutes.claimList);
    } else if (title == "Timesheet") {
      Get.toNamed(AppRoutes.timesheetList);
      //Get.toNamed(AppRoutes.tryScreen);
    } else if (title == "Leaves") {
      Get.toNamed(AppRoutes.leaveList);
    } else if (title == "Petty Task") {
      Get.toNamed(AppRoutes.pettyTaskFrom);
    } else {
      Get.toNamed(AppRoutes.serviceDashboard, arguments: [title]);
    }
    updateLoader(false);
    update();
  }

  callLogout() {
    Utils.showLoadingDialog();
    GetStorage().remove("userId");
    GetStorage().remove("userName");
    GetStorage().remove("name");
    GetStorage().remove("firmId");
    GetStorage().erase();
    Utils.showSuccessSnackBar("Logout Successfully!");
    Utils.dismissLoadingDialog();
    Get.offNamedUntil(AppRoutes.login, (route) => false);
    update();
  }
}
