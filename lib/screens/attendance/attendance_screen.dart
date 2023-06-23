import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/screens/attendance/attendance_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceController>(builder: (cont)
    {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,elevation: 0.0,
            title: buildTextMediumWidget("Attendance", whiteColor,context, 16,align: TextAlign.center),
          ),
          drawer: Drawer(
            child: SizedBox(
                height: double.infinity,
                child: ListView(
                  physics:const NeverScrollableScrollPhysics(),
                  children: [
                    Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height/1.1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildDrawer(context,cont.name),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0,left: 10.0,bottom: 50.0,right: 10.0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      showWarningOnAttendanceDialog(context,"Confirm Logout...!!!","Do you want to logout from an app?",logoutFeature:true,cont);
                                    },
                                    child: const Icon(Icons.logout),
                                  ),
                                  const SizedBox(width: 7.0,),
                                  GestureDetector(
                                      onTap:(){
                                        showWarningOnAttendanceDialog(context,"Confirm Logout...!!!","Do you want to logout from an app?",logoutFeature:true,cont);
                                      },
                                      child:buildTextBoldWidget("Logout", blackColor, context, 15.0)
                                  ),const Spacer(),
                                  GestureDetector(
                                    onTap:(){
                                    },
                                    child: buildTextRegularWidget("App Version 1.0", grey, context, 14.0),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),
          body:
              cont.isLoading ? buildCircularIndicator():
          cont.currentAddress==null ? const Text(""):
          ListView(
            children: [
              Text("Latitude : ${cont.currentPosition!.latitude.toString()}"),
              Text("Longitude : ${cont.currentPosition!.latitude.toString()}"),
              Text("Address : ${cont.currentAddress!}"),
            ],
          )
      );
    });
  }
}