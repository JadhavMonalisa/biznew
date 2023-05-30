import 'dart:io';

import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/screens/claim_form/claim_list.dart';
import 'package:biznew/screens/dashboard/client/client_dashboard.dart';
import 'package:biznew/screens/dashboard/employee/employee_dashboard.dart';
import 'package:biznew/screens/dashboard/service_dashboard.dart';
import 'package:biznew/screens/leave_form/leave_list.dart';
import 'package:biznew/screens/timesheet_form/timesheet_list.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../constant/repository/api_repository.dart';
import '../../routes/app_pages.dart';

class BottomNavController extends GetxController {
  final ApiRepository repository;

  BottomNavController({required this.repository});

  ///bottom navigation
  int selectedTabIndex = 0;
  var userId="";
  String userName="";
  String name="";
  String firmId="";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userId = GetStorage().read("userId")??"";
    userName = GetStorage().read("userName")??"";
    name = GetStorage().read("name")??"";
  }

  bool noData = false; bool loader = false;
  updateLoader(bool val) { loader = val; update(); }

  ///set pages in body
  buildWidget(){
    return selectedTabIndex == 0 ? const ServiceDashboardScreen() :
    selectedTabIndex == 1 ? const EmployeeDashboardScreen() :
    selectedTabIndex == 2 ?  const ClientDashboard() :
    selectedTabIndex == 3 ? const TimesheetList() : const ServiceDashboardScreen();
  }

  ///on tap index change
  checkLoggedInUser(int index) {
    selectedTabIndex = index;
    update();
  }

  ///change index on bottom nav
  changeIndex(int index) {
    selectedTabIndex = index;
    update();
  }

  onWillPopBack(){
    Get.offNamedUntil(AppRoutes.bottomNav, (route) => false);
    update();
  }

  showExitDialog(BuildContext context){
    showDialog(barrierDismissible: true,
      context:context,
      builder:(BuildContext context){
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))
          ),
          content: Container(
            height: 150.0,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildTextRegularWidget("Exit!", blackColor, context, 20,align: TextAlign.left),const SizedBox(height: 10.0,),
                buildTextRegularWidget("Do you want to exit from an app?", blackColor, context, 16.0,align: TextAlign.left,),
                const SizedBox(height: 20.0,),
                Row(
                  children: [
                    Flexible(child:
                    GestureDetector(
                      onTap: (){
                        exit(0);
                      },
                      child: buildButtonWidget(context, "Yes",radius: 5.0,width: MediaQuery.of(context).size.width),
                    )
                    ),
                    const SizedBox(width: 3.0,),
                    Flexible(child:GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: buildButtonWidget(context, "No",radius: 5.0,width: MediaQuery.of(context).size.width),
                    )),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
