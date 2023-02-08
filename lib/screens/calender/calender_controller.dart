import 'dart:collection';
import 'dart:math';
import 'package:biznew/constant/provider/custom_exception.dart';
import 'package:biznew/constant/repository/api_repository.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/calender/calender_model.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:biznew/utils/utils.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source){
    appointments = source;
  }
}

class CalenderViewController extends GetxController {
  final ApiRepository repository;

  // ignore: unnecessary_null_comparison
  CalenderViewController({required this.repository}) : assert(repository != null);

  ///common
  String userId="";
  String userName="";
  String name="";
  bool loader = false;
  DateTime todayDate = DateTime.now();
  CalendarController canController = CalendarController();

  ///appointment
  String selectedYear = "";
  List<CalenderData> calenderDataList = [];
  String dateOfAppointment = "";
  String typeToSendApi = "";
  List<Appointment> appointments = <Appointment>[];

  @override
  void onInit() {
    super.onInit();

    selectedYear = "";
    typeToSendApi = "";
    calenderDataList.clear();

    userId = GetStorage().read("userId")??"";
    userName = GetStorage().read("userName")??"";
    name = GetStorage().read("name")??"";
    repository.getData();
    selectedYear = todayDate.year.toString();
    callCalender();
  }

  viewChanged(ViewChangedDetails viewChangedDetails){
    //calenderDataList = [];
    //calenderDataList.clear();

    SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
      calenderDataList.clear();
      appointments.clear();
      AppointmentDataSource(appointments).appointments!.clear();
      selectedYear = DateFormat('yyyy').format(viewChangedDetails
          .visibleDates[viewChangedDetails.visibleDates.length ~/ 2]).toString();
      //canController.selectedDate = viewChangedDetails.visibleDates[0];

      //selectedYear = todayDate.year.toString();
      canController.selectedDate = null;

      //canController.selectedDate = todayDate;
      //canController.selectedDate = null;
      calenderDataList.clear();
      appointments.clear();

      callCalender();
      update();
    });
  }

  AppointmentDataSource getCalendarDataSource() {
    appointments.clear();

    for(int i = 0; i< calenderDataList.length; i++) {
      appointments.add(Appointment(
        startTime: DateTime.parse(calenderDataList[i].start!),
        endTime: DateTime.parse(calenderDataList[i].start!).add(const Duration(hours: 12)),
        subject: calenderDataList[i].title!,
        color:Colors.primaries[Random().nextInt(Colors.primaries.length)],
        startTimeZone: '',
        endTimeZone: '',
        notes: calenderDataList[i].constraint,
        location: calenderDataList[i].start,
      ));
     }

    return AppointmentDataSource(appointments);
  }

  ///calender
  void callCalender() async {
    calenderDataList.clear();
    appointments.clear();
    AppointmentDataSource(appointments).appointments!.clear();
    update();

    try {
      CalenderModel? response = (await repository.getCalender(selectedYear));

      if (response.success!) {
        calenderDataList.addAll(response.calenderData!);
        //List<String> result = LinkedHashSet<String>.from(calenderDataList).toList();
        print("in response");
        print(selectedYear);
        update();
      } else {
        update();
      }
      update();
    } on CustomException catch (e) {
      update();
    } catch (error) {
      update();
    }
  }
  ///calender due date
  List<CalendarDueData> dueDateList = [];

  onAppointmentClick(BuildContext context,CalendarAppointmentDetails calendarAppointmentDetails){
    for (var element in calendarAppointmentDetails.appointments) {
      dateOfAppointment = element.location;
      typeToSendApi = element.notes;
      showCalendarDueDateDialog(context);
    }
    calenderDataList.clear();
    appointments.clear();
    update();
  }

  updateLoader(bool val) { loader = val; update(); }

  void callCalenderDueDate() async {
    dueDateList.clear();
    try {
      CalendarDueDateModel? response = (await repository.getCalenderDueDate(dateOfAppointment,typeToSendApi));

      if (response.success!) {
        dueDateList.addAll(response.data!);
        Get.toNamed(AppRoutes.calenderMeetingData);
        updateLoader(false);
        update();
      } else {
        updateLoader(false);
        //Utils.showErrorSnackBar(response.message);
        update();
      }
      update();
    } on CustomException catch (e) {
      updateLoader(false);
      //Utils.showErrorSnackBar(e.getMsg());
      update();
    } catch (error) {
      updateLoader(false);
      //Utils.showErrorSnackBar(error.toString());
      update();
    }
  }

  DateTime dateOnDueDataScreen = DateTime.now();

  addParameter(String dateToSend, String type){
    updateLoader(true);
    dateOfAppointment = dateToSend;
    dateOnDueDataScreen = DateTime.parse(dateOfAppointment);
    typeToSendApi = type;
    callCalenderDueDate();
    update();
  }
  ///show dialog calendar due date
  showCalendarDueDateDialog(BuildContext context){
    //callCalenderDueDate(context);

    showDialog(
      barrierDismissible: true,
      context:context,
      builder:(BuildContext context){
        return StatefulBuilder(builder: (context,setter){
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 180.0,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildTextRegularWidget("Statutory Due Date", blackColor, context, 20,align: TextAlign.left),const SizedBox(height: 10.0,),
                    const SizedBox(height: 20.0,),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: dueDateList.length,
                        itemBuilder: (context,index){
                          return Container(
                            color: Colors.red,
                            child: buildTextMediumWidget(dueDateList[index].triggerDate!, blackColor, context, 14.0,align: TextAlign.left),
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );

    update();
  }

  navigateToBottomScreen(){
    typeToSendApi = "";
    appointments.clear();
    dueDateList.clear();
    calenderDataList.clear();
    update();
    Get.toNamed(AppRoutes.bottomNav);
  }

  navigateToCalenderScreen(){
    typeToSendApi = "";
    appointments.clear();
    dueDateList.clear();
    calenderDataList.clear();
    update();
    callCalender();
    Get.toNamed(AppRoutes.calenderScreen);
  }

  callLogout(){
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