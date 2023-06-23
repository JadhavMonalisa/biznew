import 'dart:math';
import 'package:biznew/constant/provider/custom_exception.dart';
import 'package:biznew/constant/repository/api_repository.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/calender/appointment_data_source.dart';
import 'package:biznew/screens/calender/calender_model.dart';
import 'package:biznew/screens/calender/event_model.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:biznew/utils/utils.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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

  List<Event> events = <Event>[];
  final kToday = DateTime.now();
  final kFirstDay = DateTime(2000,01,01);
  final kLastDay =  DateTime(3000,01,01);
  //late final ValueNotifier<List<Event>> selectedEvents;
  CalendarFormat calendarFormat = CalendarFormat.month;
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  DateTime? rangeStart;
  DateTime? rangeEnd;
  Color randomColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  bool isLoading = true;

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

    update();
  }

  viewChanged(ViewChangedDetails viewChangedDetails){
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

  // final kEvents = LinkedHashMap<DateTime, List<Event>>(
  //   equals: isSameDay,
  //   hashCode: getHashCode,
  // )..addAll(_kEventSource);

  // final _kEventSource = { for (var item in List.generate(calenderDataList.length, (index) => index))
  //   DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5) : List.generate(
  //       item , (index) => Event('Event $item | ${index + 1}')) }
  //   ..addAll({
  //     kToday: [
  //       Event('Today\'s Event 1'),
  //       Event('Today\'s Event 2'),
  //     ],
  //   });

  /// Returns a list of [DateTime] objects from [first] to [last], inclusive.
  List<DateTime> daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
          (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }


  ///calender
  void callCalender() async {
    calenderDataList.clear();
    appointments.clear();
    AppointmentDataSource(appointments).appointments!.clear();
    isLoading = true;
    update();

    try {
      CalenderModel? response = (await repository.getCalender(selectedYear));

      if (response.success!) {
        calenderDataList.addAll(response.calenderData!);

        for(int i = 0; i< calenderDataList.length; i++) {
          events.add(Event(calenderDataList[i].start!));
        }

        // for (var element in calenderDataList) {
        //   calenderDataList.add(CalenderData(
        //     ranColor: randomColor
        //   ));
        // }

        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
      update();
    } on CustomException {
      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
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
    isLoading = true;
    try {
      CalendarDueDateModel? response = (await repository.getCalenderDueDate(dateOfAppointment,typeToSendApi));

      if (response.success!) {
        dueDateList.addAll(response.data!);
        Get.toNamed(AppRoutes.calenderMeetingData);
        updateLoader(false);
        isLoading = false;
        update();
      } else {
        updateLoader(false);
        isLoading = false;
        //Utils.showErrorSnackBar(response.message);
        update();
      }
      update();
    } on CustomException {
      updateLoader(false);
      isLoading = false;
      //Utils.showErrorSnackBar(e.getMsg());
      update();
    } catch (error) {
      updateLoader(false);
      isLoading = false;
      //Utils.showErrorSnackBar(error.toString());
      update();
    }
  }

  DateTime dateOnDueDataScreen = DateTime.now();

  addParameter(String dateToSend, String type){
    updateLoader(true);
    if(type == "holiday"){
      Utils.showAlertSnackBar("Holiday on this day");
      updateLoader(false);
    }
    else{
      dateOfAppointment = dateToSend;
      dateOnDueDataScreen = DateTime.parse(dateOfAppointment);
      typeToSendApi = type;
      callCalenderDueDate();
    }
    update();
  }

  navigateToCalenderDetailScreen(String type,String dateToSend){
    updateLoader(true);
    isLoading = true;
    if(type == "holiday"){
      Utils.showAlertSnackBar("Holiday on this day");
      updateLoader(false); isLoading = false;
    }
    else{
      dateOfAppointment = dateToSend;
      dateOnDueDataScreen = DateTime.parse(dateOfAppointment);
      typeToSendApi = type;
      callCalenderDueDate();
    }
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
    selectedYear = todayDate.year.toString();
    Get.offAllNamed(AppRoutes.bottomNav);
   // callCalender();
    update();
  }

  navigateToCalenderScreen(){
    typeToSendApi = "";
    appointments.clear();
    dueDateList.clear();
    calenderDataList.clear();
    update();
    //callCalender();
    //Get.toNamed(AppRoutes.calenderScreen);
    Get.offAllNamed(AppRoutes.calenderDemoScreen);
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