import 'package:biznew/common_widget/error_text.dart';
import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/constant/provider/custom_exception.dart';
import 'package:biznew/constant/repository/api_repository.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/timesheet_form/timesheet_model.dart';
import 'package:biznew/screens/timesheet_new/timesheet_new_model.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:biznew/utils/custom_response.dart';
import 'package:biznew/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class TimesheetNewFormController extends GetxController {
  final ApiRepository repository;

  // ignore: unnecessary_null_comparison
  TimesheetNewFormController({required this.repository})
      : assert(repository != null);

  ///common
  String userId = "";
  String userName = "";
  String name = "";
  bool loader = false;
  DateTime todayDate = DateTime.now();

  ///employee list
  List<ClientListData> allottedEmployeeList = [];
  static List<ClientListData> item = [];
  List<ClientListData> allottedTimesheetSelectedEmpList = [];
  List<TimesheetServicesListData> allottedTimesheetSelectedServiceList = [];
  List<String> allottedTimesheetSelectedMultipleEmpIdList = [];
  List<String> allottedTimesheetSelectedTimeList = [];
  List<String> allottedTimesheetSelectedMultipleServiceIdList = [];
  List<MultiSelectItem<ClientListData>> items = [];
  List<MultiSelectItem<TimesheetServicesListData>> serviceItems = [];
  final multiSelectKey = GlobalKey<FormFieldState>();
  String removeFirstBracket = "";
  String removeFirstBracketForService = "";
  String removeFirstBracketForClientApplicableService = "";
  String removeSecondBracket = "";
  String removeSecondBracketForService = "";
  String removeSecondBracketForClientApplicableService = "";

  List<String> timesheetSelectedWorkAt = [];
  List<String> timesheetSelectedMultipleWorkAt = [];
  String removeFirstBracketFromWorkAt = "";
  String removeSecondBracketFromWorkAt = "";

  ///stepper
  int currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  List<String> stepsList = [];

  ///stepper one
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedTimeForCalculation = const TimeOfDay(hour: 24, minute: 0);
  TimeOfDay selectedStartTime24 = TimeOfDay.now();
  TimeOfDay selectedEndTime24 = TimeOfDay.now();
  String selectedDateToSend = "";
  String selectedDateToShow = "";
  String selectedStartTimeToShow = "";
  String selectedEndTimeToShow = "";
  TextEditingController stepper1InTime = TextEditingController();
  TextEditingController stepper1OutTime = TextEditingController();
  TextEditingController timesheetTotalTime = TextEditingController();
  bool validateInTime = false;
  bool validateOutTime = false;
  bool validateTotalTime = false;
  bool validateStartDate = false;
  bool validateWorkAt = false;
  Duration difference = const Duration();
  String totalTimeToShow = "";
  String selectedWorkAt = "";
  List<String> noDataList = ["No Data Found!"];
  List<String> workAtList = [
    "Office",
    "Client Location",
    "Work From Home",
    "Govt. Department"
  ];
  //static List<String> workAtItems = [];
  List<MultiSelectItem<String>> workAtItems = [];

  ///stepper two
  List<TimesheetServicesListData> allottedServiceList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userId = GetStorage().read("userId") ?? "";
    userName = GetStorage().read("userName") ?? "";
    name = GetStorage().read("name") ?? "";
    repository.getData();

    // selectedDateToShow =
    //     "${todayDate.day}-${todayDate.month}-${todayDate.year}";
    // selectedDateToSend =
    //     "${todayDate.year}-${todayDate.month}-${todayDate.day}";

    workAtItems = workAtList
        .map((value) => MultiSelectItem<String>(value, value))
        .toList();

    callEmployeeList();
    callTimesheetBackDateCount();
  }

  //--------------------------------------Stepper One------------------------------------------//

  updateSelectedWorkAt(String value) {
    selectedWorkAt = value;
    if (selectedWorkAt == "") {
      validateWorkAt = true;
      update();
    } else {
      validateWorkAt = false;
      update();
    }
  }

  onSelectionForMultipleWorkAt(List<String> workAtList) {
    updateLoader(true);
    timesheetSelectedWorkAt = workAtList;
    for (var element in workAtList) {
      removeFirstBracketFromWorkAt =
          timesheetSelectedWorkAt.toString().replaceAll("[", "");
      removeSecondBracketFromWorkAt =
          removeFirstBracketFromWorkAt.replaceAll("]", "");
      update();
    }
    validateWorkAt = false;
  }

  onDeleteMultipleWorkAt(String value) {
    updateLoader(true);
    timesheetSelectedWorkAt.remove(value);
    removeFirstBracketFromWorkAt =
        timesheetSelectedWorkAt.toString().replaceAll("[", "");
    removeSecondBracketFromWorkAt =
        removeFirstBracketFromWorkAt.replaceAll("]", "");
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    isLoadingForStepper1=true;

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate:selectedDate,
        firstDate : DateTime(selectedDate.year, selectedDate.month, selectedDate.day - totalBackDateCount),
        lastDate: selectedDate,
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      selectedDateToShow = "${selectedDate.day.toString().length==1 ? "0${selectedDate.day}" :selectedDate.day}/"
          "${selectedDate.month.toString().length==1 ? "0${selectedDate.month}" :selectedDate.month}/"
          "${selectedDate.year}";
      selectedDateToSend = "${selectedDate.year}-"
          "${selectedDate.month.toString().length==1 ? "0${selectedDate.month}" :selectedDate.month}-"
          "${selectedDate.day.toString().length==1 ? "0${selectedDate.day}" :selectedDate.day}";
      callTimesheetCheck(selectedDateToSend);
      update();
    }
    // selectedDateToShow =
    //     "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
    // selectedDateToSend =
    //     "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
    // validateStartDate = false;
    // validateStartDate = false;

    else{
      isLoadingForStepper1 = false; update();
    }

    update();
  }

  ///non allotted
  int remainingFromMinNonAllotted = 0;
  List<int> hrNonAllottedList = [];
  List<int> minNonAllottedList = [];
  var hrNonAllottedSum = 0;
  var minNonAllottedSum = 0;

  ///office
  int remainingFromMinOffice = 0;
  List<int> hrOfficeList = [];
  List<int> minOfficeList = [];
  var hrOfficeSum = 0;
  var minOfficeSum = 0;
  List<String> officeAddedTime = [];

  int totalOfficeTimeLength =0;
  Future<void> selectTime(BuildContext context, String timeFor) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 12, minute: 00),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    );
    update();
    if (picked != null && picked != selectedDate) {
      timeFor == "start"
          ? selectedStartTime24 = picked
          : timeFor == "end"
              ? selectedEndTime24 = picked
              : selectedTime = picked;
      Utils.dismissKeyboard();
      update();
    }
    if (timeFor == "start") {
      //selectedStartTime24 = selectedTime;
      selectedStartTimeToShow =
          "${selectedStartTime24.hour}:${selectedStartTime24.minute}";
      stepper1InTime.text = selectedStartTimeToShow;
      stepper1InTime.text.isEmpty
          ? validateInTime = true
          : validateInTime = false;
      update();

      ///difference
      calculateTotalTime();
      Utils.dismissKeyboard();
      update();
    } else if (timeFor == "end") {
      selectedEndTimeToShow =
          "${selectedEndTime24.hour}:${selectedEndTime24.minute}";
      stepper1OutTime.text = selectedEndTimeToShow;

      if (selectedEndTime24.hour < selectedStartTime24.hour) {
        validateOutTime = true;
        update();
      } else {
        validateOutTime = false;

        ///difference
        calculateTotalTime();
        update();
      }
      Utils.dismissKeyboard();
      update();
    } else if (timeFor == "office") {
      selectedOfficeTime = "${selectedTime.hour}:${selectedTime.minute}";

      if(hrOfficeList.isEmpty){
        officeAddedTime.add(selectedOfficeTime);
        hrOfficeList.add(selectedTime.hour);
        minOfficeList.add(selectedTime.minute);
      }
      else{
        officeAddedTime.removeAt(officeAddedTime.length-1);
        hrOfficeList.removeAt(hrOfficeList.length-1);
        minOfficeList.removeAt(minOfficeList.length-1);
        officeAddedTime.insert(officeAddedTime.length,selectedOfficeTime);
        hrOfficeList.insert(hrOfficeList.length,selectedTime.hour);
        minOfficeList.insert(minOfficeList.length,selectedTime.minute);
      }

      hrOfficeSum = hrOfficeList.reduce((a, b) => a + b);
      minOfficeSum = minOfficeList.reduce((a, b) => a + b);

      if (minOfficeSum >= 60) {
        remainingFromMinOffice = minOfficeSum ~/ 60;
        minOfficeSum = minOfficeSum % 60;
      }

      hrOfficeSum = hrOfficeSum + remainingFromMinOffice;

      Utils.dismissKeyboard();
      update();
    } else if (timeFor == "nonAllotted") {

      selectedNonAllottedTime = "${selectedTime.hour}:${selectedTime.minute}";

      if(hrNonAllottedList.isEmpty){
        hrNonAllottedList.add(selectedTime.hour);
        minNonAllottedList.add(selectedTime.minute);
      }
      else{
        hrNonAllottedList.removeAt(hrNonAllottedList.length-1);
        minNonAllottedList.removeAt(minNonAllottedList.length-1);
        hrNonAllottedList.insert(hrNonAllottedList.length,selectedTime.hour);
        minNonAllottedList.insert(minNonAllottedList.length,selectedTime.minute);
      }


      hrNonAllottedSum = hrNonAllottedList.reduce((a, b) => a + b);
      minNonAllottedSum = minNonAllottedList.reduce((a, b) => a + b);

      if (minNonAllottedSum >= 60) {
        remainingFromMinNonAllotted = minNonAllottedSum ~/ 60;
        minNonAllottedSum = minNonAllottedSum % 60;
      }

      hrNonAllottedSum = hrNonAllottedSum + remainingFromMinNonAllotted;

      update();
    }
    Utils.dismissKeyboard();
    update();
  }

  checkTotalTimeValidation() {
    if (timesheetTotalTime.text.isEmpty) {
      validateTotalTime = true;
      update();
    } else {
      validateTotalTime = false;
      update();
    }
  }

  calculateTotalTime() {
    var format = DateFormat("HH:mm");
    var one = format.parse(stepper1InTime.text);
    var two = format.parse(stepper1OutTime.text);
    difference = two.difference(one);
    totalTimeToShow = "${difference.inHours}:${difference.inMinutes.remainder(60)}";
    timesheetTotalTime.text = totalTimeToShow;
    update();
  }

  int totalHrSpent = 0;
  int totalMinuteSpent = 0;

  //--------------------------------------Stepper Two------------------------------------------//

  bool cbNonAllotted = false;
  bool cbOffice = false;
  bool isFillTimesheetSelected = false;
  List<TimesheetNewModel> totalSelectionList = [];
  List<TimesheetNewModel> timesheetNewModelList = [];
  String currentService = "allotted";
  bool showOffice = false;
  bool isAddingMoreAllotted = false;

  String allottedSelectedClientName = "";

  ///allotted employee list
  void callEmployeeList() async {
    allottedEmployeeList.clear();
    updateLoader(true);
    try {
      TimesheetClientListModel? response = currentService == "allotted"
          ? (await repository.getTimesheetClientNameList())
          : (await repository.getTimesheetClientNameNonAllottedList());


      if (response.success!) {
        if (response.data!.isEmpty) {
        } else {
          allottedEmployeeList.addAll(response.data!);
          // items = allottedEmployeeList
          //     .map((value) => MultiSelectItem<ClientListData>(value, value.firmClientFirmName!))
          //     .toList();

          update();
        }
        updateLoader(false);
        update();
      } else {
        updateLoader(false);
        update();
      }
    } on CustomException {
      updateLoader(false);
      update();
    } catch (error) {
      updateLoader(false);
      update();
    }
  }


  // onSelectionForMultipleEmployee(List<ClientListData> selectedEmpListFromDesign){
  //   updateLoader(true);
  //   //allottedTimesheetSelectedServiceList.clear();
  //   allottedTimesheetSelectedEmpList.clear();
  //   //detailsControllerList.clear();
  //   //timesheetTaskListData.clear();
  //   allottedTimesheetSelectedEmpList = selectedEmpListFromDesign;
  //
  //   for (var element in allottedTimesheetSelectedEmpList) {
  //     callServiceListForAllotted(element.firmClientId!,element.firmClientFirmName!);
  //   }
  //
  //   // for (var element in selectedEmpListFromDesign) {
  //   //   allottedTimesheetSelectedMultipleEmpIdList.add(element.id!);
  //   //   update();
  //   // }
  //   update();
  // }
  //
  // onDeleteMultipleEmployee(ClientListData value){
  //   updateLoader(true);
  //   allottedServiceList.clear();
  //   allottedTimesheetSelectedServiceList.clear();
  //   allottedTimesheetSelectedEmpList.remove(value);
  //   allottedTimesheetSelectedMultipleEmpIdList.remove(value.id!);
  //   removeFirstBracket = allottedTimesheetSelectedMultipleEmpIdList.toString().replaceAll("[", "");
  //   removeSecondBracket = removeFirstBracket.replaceAll("]", "");
  //
  //   for (var element in allottedTimesheetSelectedEmpList) {
  //     callServiceListForAllotted(element.firmClientId!,element.firmClientFirmName!);
  //   }
  //
  //   update();
  // }

  onSelectionAllottedEmp(String value) {
    allottedSelectedClientName = value;
    update();
  }
  onSelectionAllottedService(String value) {
    allottedSelectedServiceName = value;
    update();
  }

  bool loaderAllottedForSerice=false;
  addAllottedClientNameAndId(String id, String name) {
    allottedSelectedClientName = name;
    //allottedTimesheetSelectedMultipleEmpIdList.add(id);
    loaderAllottedForSerice=true;
    callServiceListForAllotted(id, name);

    update();
  }

  String allottedSelectedServiceName= "";
  addAllottedServiceNameAndId(String id, String name, TimesheetServicesListData selectedServiceListFromDesign) {
    allottedSelectedServiceName = name;

    allottedTimesheetSelectedServiceList.add(selectedServiceListFromDesign);

    for (var element in allottedTimesheetSelectedServiceList) {
      loader = true;

      callTaskListForAllotted(
          element.serviceId!,
          element.id!,
          element.serviceName!,element.period!,
          element.selectedClientId!,
          element.selectedClientName!);
    }

    update();
  }

  List<TimesheetListData> addedAllTimesheetData = [];
  List<String> allottedClientApplicableServiceIdList = [];

  /// allotted service list
  void callServiceListForAllotted(
      String selectedClientId, String selectedClient) async {
    try {
      TimesheetServiceListModel? response =
          (await repository.getTimesheetServicesList(selectedClientId));

      if (response.success!) {
        if (response.data!.isEmpty) {
          loaderAllottedForSerice=false;update();
        } else {
          for (var element in response.data!) {
            allottedServiceList.add(TimesheetServicesListData(
                id: element.id,
                serviceId: element.serviceId,
                selectedClientId: selectedClientId,
                serviceName: element.serviceName,
                selectedClientName: selectedClient,
                period: element.period,
                serviceDueDatePeriodicity: element.serviceDueDatePeriodicity));
          }

          serviceItems = allottedServiceList
              .map((value) => MultiSelectItem<TimesheetServicesListData>(
                  value, value.serviceName!))
              .toList();

          loaderAllottedForSerice=false;update();
        }

        update();
      } else {
        loaderAllottedForSerice=false;
        update();
      }
    } on CustomException {
      loaderAllottedForSerice=false;
      update();
    } catch (error) {
      loaderAllottedForSerice=false;
      update();
    }
  }

  /// allotted task list
  List<TimesheetTaskListData> taskList = [];
  List<TextEditingController> timeSpentControllerList = [];
  List<String> taskIdList = [];
  List<String> taskIdListToCallApi = [];
  List<String> addedAllottedStatusNameList = [];

  List<TimesheetTaskListData> timesheetTaskListData = [];
  List<TimesheetTaskDetailsData> timesheetTaskDetailsListData = [];
  int totalTaskLength = 0;

  String toShowServiceId = "";
  String toShowClientServiceId = "";
  List<String> clientIdInTask = [];
  List<String> timeInTask = [];
  List<String> serviceIdInTask = [];
  List<String> clientServiceIdInTask = [];
  List<String> taskIdInTask = [];

  void callTaskListForAllotted(
      String selectedServiceId,
      String clientApplicableServiceId,
      String serviceName,String servicePeriod,
      String clientId,
      String clientName) async {
    try {
      checkStartList.clear();
      checkStatusList.clear();
      TimesheetTaskListData? response =
      (await repository.getTimesheetNewTaskList(
          selectedServiceId, clientApplicableServiceId));
      toShowServiceId = selectedServiceId;
      toShowClientServiceId = clientApplicableServiceId;
      if (response.success!) {
        if (response.timesheetTaskDetailsData!.isEmpty) {} else {
          timesheetTaskListData.add(TimesheetTaskListData(
            timesheetTaskDetailsData: response.timesheetTaskDetailsData,
            clientName: clientName,
            clientId: clientId,
            serviceName: serviceName,
            servicePeriod: servicePeriod,
            serviceId: selectedServiceId,
            message: response.message,
            success: response.success,
            //servicePeriodicity: response.servicePeriodicity
          ));
        }

        totalTaskLength = response.timesheetTaskDetailsData!.length;

        for (var element in response.timesheetTaskDetailsData!) {
          timeSpentControllerList.add(TextEditingController(text: ""));
          addedAllottedStatusNameList.add("");
          taskIdListToCallApi.add(element.taskId!);

          dataList.add("");
          serviceIdInTask.add(selectedServiceId);
          clientServiceIdInTask.add(clientApplicableServiceId);
          clientIdInTask.add(clientId);
        }

        for(int i =0; i<response.timesheetTaskDetailsData!.length; i++) {
          // callStatusList(response.timesheetTaskDetailsData![i].taskId!,
          //     clientApplicableServiceId,i);

          TimesheetStatusModel? statusResponse = await repository.getTimesheetStatusList(
              clientApplicableServiceId,response.timesheetTaskDetailsData![i].taskId!);

          if (statusResponse.success!) {
            if (statusResponse.list!.isEmpty) {
            } else {
              checkStartList.add(statusResponse.start!);
              checkStatusList.add(statusResponse.status!);
            }
            update();
          } else {
            update();
          }

          print("checkStatusList");
          print(checkStatusList);
        }
        loader = false;
        update();
      }

      clientAppServiceId = clientApplicableServiceId;

      // for (var element in taskIdListToCallApi) {
      //   callStatusList(element, clientApplicableServiceId,taskIdListToCallApi.length);
      // }
      loader = false;
      update();
    }
    catch (error) {
      loader = false;
    update();
    }
  }

  List<String> dataList=[];
  //List<StatusList> statusList = [];
  List<StatusList> statusListToShow = [];
  List<String> allottedStartedStatusList = [
    "Inprocess",
    "Awaiting for Client Input",
    "Submitted for Checking",
    "Put on Hold",
    "Completed",
    "Cancel",
    "Sent for rework"
  ];
  List<String> nonAllottedStartedStatusList = [
    "Inprocess",
    "Awaiting for Client Input",
    "Submitted for Checking",
    "Put on Hold",
    "Completed",
    "Cancel",
    "Sent for rework"
  ];
  String selectedAllottedStatus = "";
  List<int> addedAllottedStatus = [];
  TextEditingController allottedStatusRemarkText = TextEditingController();

  String statusToCheck = "";
  updateSelectedAllottedStatus(BuildContext context, String val, int index,
      String selectedTaskIdToStart,String clientApplicableId,int taskDetailsIndex) {

    //selectedTaskId = taskIdList[index]; //to pass for remark
    selectedTaskId = selectedTaskIdToStart; //to pass for remark
    statusToCheck = val;
    if (statusToCheck == "Inprocess" ||
        statusToCheck == "Completed" ||
        statusToCheck == "Sent for rework") {
      //selectedAllottedStatus = val;
      if (addedAllottedStatus.contains(index)) {
        addedAllottedStatus.remove(index);
        update();
      } else {
        addedAllottedStatus.add(index);
        update();
      }

      if (addedAllottedStatusNameList.asMap().containsKey(index)) {
        addedAllottedStatusNameList.removeAt(index);
        addedAllottedStatusNameList.insert(index, val);
        update();
      } else {
        addedAllottedStatusNameList.add(val);
        update();
      }
      callTimesheetUpdateWithoutPopup(context,selectedTaskIdToStart,clientApplicableId, taskDetailsIndex,val);
      update();
    } else {
      showStatusRemarkDialog(context, index, val,selectedTaskIdToStart,clientApplicableId,taskDetailsIndex);
      update();
    }
    update();
  }

  String selectedNonAllottedStatus = "";

  updateSelectedNonAllottedStatus(BuildContext context, String val,
     String clientApplicableId) {
    selectedNonAllottedStatus = val;

    print("val");
    print(val);
    print("selectedTaskIdToStart");
    print(selectedNonAllottedTaskId);
    print("clientApplicableId");
    print(clientApplicableId);
    // if (selectedNonAllottedStatus == "Inprocess" ||
    //     selectedNonAllottedStatus == "Completed" ||
    //     selectedNonAllottedStatus == "Sent for rework") {
    //   callTimesheetUpdateForNonAllotted(context,selectedNonAllottedTaskId,clientApplicableId);
    //   update();
    // } else {
    //   showStatusRemarkDialogForNonAllotted(context,val,selectedNonAllottedTaskId,clientApplicableId);
    //   update();
    // }
    update();
  }

  bool validateRemark = false;
  showStatusRemarkDialog(BuildContext context, int index, String val,
      String selectedTaskIdToStart, String clientApplicableId, int taskDetailsIndex) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setter) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 200.0,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildTextRegularWidget("Remark", blackColor, context, 20,
                        align: TextAlign.left),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        color: textFormBgColor,
                        border: Border.all(color: textFormBgColor),
                      ),
                      child: TextFormField(
                        controller: allottedStatusRemarkText,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.left,
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.done,
                        onTap: () {},
                        style: const TextStyle(fontSize: 15.0),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: "Enter remark",
                          hintStyle: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              color: subTitleTextColor,
                              fontSize: 15,
                            ),
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        onChanged: (text) {
                          setter(() {
                            checkRemarkValidation();
                          });
                        },
                      ),
                    ),
                    validateRemark == true
                        ? ErrorText(
                            errorMessage: "Please enter valid remark",
                          )
                        : const Opacity(opacity: 0.0),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              setter(() {
                                allottedStatusRemarkText.clear();
                                Navigator.pop(context);
                              });
                            },
                            child: buildButtonWidget(context, "Close"),
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              if (addedAllottedStatus.contains(index)) {
                                addedAllottedStatus.remove(index);
                                update();
                              } else {
                                addedAllottedStatus.add(index);
                                update();
                              }

                              if (addedAllottedStatusNameList
                                  .asMap()
                                  .containsKey(index)) {
                                addedAllottedStatusNameList.removeAt(index);
                                addedAllottedStatusNameList.insert(index, val);
                                update();
                              } else {
                                addedAllottedStatusNameList.add(val);
                                update();
                              }

                              print("selectedTaskIdToStart in dialog");
                              print(selectedTaskIdToStart);
                              callTimesheetUpdateWithPopup(context,selectedTaskIdToStart,clientApplicableId,taskDetailsIndex,val);
                            },
                            child: buildButtonWidget(context, "Save"),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  TextEditingController nonAllottedStatusRemarkText = TextEditingController();

  showStatusRemarkDialogForNonAllotted(BuildContext context, String val,
      String selectedTaskIdToStart, String clientApplicableId) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setter) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 200.0,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildTextRegularWidget("Remark", blackColor, context, 20,
                        align: TextAlign.left),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(4)),
                        color: textFormBgColor,
                        border: Border.all(color: textFormBgColor),
                      ),
                      child: TextFormField(
                        controller: nonAllottedStatusRemarkText,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.left,
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.done,
                        onTap: () {},
                        style: const TextStyle(fontSize: 15.0),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: "Enter remark",
                          hintStyle: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              color: subTitleTextColor,
                              fontSize: 15,
                            ),
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        onChanged: (text) {
                          setter(() {
                            checkRemarkValidation();
                          });
                        },
                      ),
                    ),
                    validateRemark == true
                        ? ErrorText(
                      errorMessage: "Please enter valid remark",
                    )
                        : const Opacity(opacity: 0.0),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              setter(() {
                                allottedStatusRemarkText.clear();
                                Navigator.pop(context);
                              });
                            },
                            child: buildButtonWidget(context, "Close"),
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              callTimesheetUpdateForNonAllotted(context,selectedTaskIdToStart,clientApplicableId);
                            },
                            child: buildButtonWidget(context, "Save"),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  checkRemarkValidation() {
    if (allottedStatusRemarkText.text.isEmpty) {
      validateRemark = true;
      update();
    } else {
      validateRemark = false;
      update();
    }
  }

  String clientAppServiceId = "";
  String selectedTaskId = "";
  bool isChangeStatusLoading = false;

  void callTimesheetUpdateWithoutPopup(BuildContext context,String selectedTaskIdToStart,
      String clientApplicableIdToStart,int taskDetailsIndex,String statusName) async {
    isChangeStatusLoading = true;
    try {
      ApiResponse? response = (await repository.getTimesheetStatusUpdate(
          clientAppServiceId,
          selectedTaskId,
          //selectedTaskIdToStart,
          allottedStatusRemarkText.text,
          statusName == "Inprocess" ? "1" :
          statusName == "Awaiting for Client Input" ? "2" :
          statusName == "Submitted for Checking" ? "3" :
          statusName == "Put on Hold" ? "4" :
          statusName == "Completed" ? "5" :
          statusName == "Cancel" ? "6" :
          statusName == "Sent for rework" ? "7" : ""
        //"statusStart"
      ));
      if (response.success!) {
        addedAllottedStatus.clear();
        Utils.showSuccessSnackBar(response.message);
        selectedAllottedStatus = statusName;
        callStatusList(selectedTaskIdToStart, clientApplicableIdToStart,taskDetailsIndex,isEdit: true);
        allottedStatusRemarkText.clear();
        isChangeStatusLoading=false;
        update();
      } else {
        addedAllottedStatus.clear();isChangeStatusLoading=false;
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);
        update();
      }
      update();
    } on CustomException catch (e) {
      addedAllottedStatus.clear();isChangeStatusLoading=false;
      Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      addedAllottedStatus.clear();isChangeStatusLoading=false;
      Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }
  }

  void callTimesheetUpdateWithPopup(BuildContext context,String selectedTaskIdToStart,
      String clientApplicableIdToStart,int taskDetailsIndex,String statusName) async {
    isChangeStatusLoading = true;
    try {
      ApiResponse? response = (await repository.getTimesheetStatusUpdate(
          clientAppServiceId,
          selectedTaskId,
          //selectedTaskIdToStart,
          allottedStatusRemarkText.text,
          statusName == "Inprocess" ? "1" :
          statusName == "Awaiting for Client Input" ? "2" :
          statusName == "Submitted for Checking" ? "3" :
          statusName == "Put on Hold" ? "4" :
          statusName == "Completed" ? "5" :
          statusName == "Cancel" ? "6" :
          statusName == "Sent for rework" ? "7" : ""
          //"statusStart"
      ));
      if (response.success!) {
        selectedAllottedStatus = statusName;
        if (context.mounted)  Navigator.pop(context) ;
        print("addedAllottedStatus");
        print(addedAllottedStatus);
        //addedAllottedStatus.clear();

        update();
        print("selectedAllottedStatus after edit");
        print(selectedAllottedStatus);
        callStatusList(selectedTaskIdToStart, clientApplicableIdToStart,taskDetailsIndex,isEdit: true);
        allottedStatusRemarkText.clear();
        isChangeStatusLoading=false;
        Utils.showSuccessSnackBar(response.message);
        update();
      } else {
        if (context.mounted)  Navigator.pop(context);
        addedAllottedStatus.clear();isChangeStatusLoading=false;
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);
        update();
      }
      update();
    } on CustomException catch (e) {
      if (context.mounted) Navigator.pop(context);
      addedAllottedStatus.clear();isChangeStatusLoading=false;
      Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      if (context.mounted) Navigator.pop(context);
      addedAllottedStatus.clear();isChangeStatusLoading=false;
      Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }
  }

  void callTimesheetUpdateForNonAllotted(BuildContext context,String selectedTaskIdToStart,
      String clientApplicableIdToStart) async {
    try {
      ApiResponse? response = (await repository.getTimesheetStatusUpdate(
          clientAppServiceId,
          selectedTaskId,
          allottedStatusRemarkText.text,
          selectedAllottedStatus == "Inprocess" ? "1" :
          selectedAllottedStatus == "Awaiting for Client Input" ? "2" :
          selectedAllottedStatus == "Submitted for Checking" ? "3" :
          selectedAllottedStatus == "Put on Hold" ? "4" :
          selectedAllottedStatus == "Completed" ? "5" :
          selectedAllottedStatus == "Cancel" ? "6" :
          selectedAllottedStatus == "Sent for rework" ? "7" : ""
        //"statusStart"
      ));
      if (response.success!) {
        if (context.mounted) Navigator.pop(context);
        Utils.showSuccessSnackBar(response.message);
        callStatusListForNonAllotted(selectedNonAllottedClientApplicableService);
        updateLoader(false);
        update();
      } else {
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);
        update();
      }
      update();
    } on CustomException catch (e) {
      Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }
  }

  List<String> checkStartList = [];
  List<String> checkStatusList = [];
  void callStatusList(String taskId, String clientApplicableServiceId, int taskDetailsIndex,{bool isEdit = false}) async {
    try {
      TimesheetStatusModel? response = (await repository.getTimesheetStatusList(
          clientApplicableServiceId, taskId));

      print("taskDetailsIndex in api");
      print(taskDetailsIndex);
      if (response.success!) {
        if (response.list!.isEmpty) {
        } else {
          // for (var element in response.list!) {
          //   statusList.add(StatusList(
          //     taskId: taskId,
          //     id: element.id,
          //     name: element.name,
          //   ));
          // }

          if(isEdit == true){
            checkStartList.removeAt(taskDetailsIndex);
            checkStatusList.removeAt(taskDetailsIndex);
            checkStartList.insert(taskDetailsIndex,response.start!);
            checkStatusList.insert(taskDetailsIndex,response.start!);
            // statusList.removeWhere((element) => element.taskId==taskId);
            // for (var element in response.list!) {
            //   statusList.add(StatusList(
            //     taskId: taskId,
            //     id: element.id,
            //     name: element.name,
            //   ));
            // }
          }

          else{
            // checkStartList.add(response.start!);
            // checkStatusList.add(response.status!);
            checkStartList.add(response.start!);
            checkStatusList.add(response.status!);
            // checkStartList.removeAt(taskDetailsIndex);
            // checkStatusList.removeAt(taskDetailsIndex);
            // checkStartList.insert(taskDetailsIndex,response.start!);
            // checkStatusList.insert(taskDetailsIndex,response.status!);
            print("taskDetailsIndex");
            print(taskDetailsIndex);
            print(checkStatusList);
          }
        }
        update();
      } else {
        update();
      }
    } on CustomException {
      update();
    } catch (error) {
      update();
    }
  }

  String nonAllottedStart = "";
  String nonAllottedStatus = "";
  void callStatusListForNonAllotted(String clientApplicableServiceId) async {
    try {
      TimesheetStatusModel? response = (await repository.getTimesheetStatusList(
          clientApplicableServiceId, selectedNonAllottedTaskId));

      if (response.success!) {
        if (response.list!.isEmpty) {
          loaderForNonAllottedStatus=false;
        } else {
          nonAllottedStart = response.start!;
          nonAllottedStatus = response.status!;
          loaderForNonAllottedStatus=false;
        }
        update();
      } else {
        loaderForNonAllottedStatus=false;
        update();
      }
    } on CustomException {
      loaderForNonAllottedStatus=false;
      update();
    } catch (error) {
      loaderForNonAllottedStatus=false;
      update();
    }
  }

  /// start timesheet
  void callTimesheetStart(BuildContext context, int taskDetailsIndex,
      String clientApplicableIdToStart, String selectedTaskIdToStart) async {
    try {
      ApiResponse? response = (await repository.getTimesheetStart(
          clientApplicableIdToStart, selectedTaskIdToStart));
      if (response.success!) {

        callStatusList(selectedTaskIdToStart, clientApplicableIdToStart,taskDetailsIndex,isEdit: true);
        Utils.showSuccessSnackBar(response.message);
        updateLoader(false);
        update();
      } else {
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);
        update();
      }
      update();
    } on CustomException catch (e) {
      Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }
  }

  void callTimesheetStartForNonAllotted(BuildContext context) async {
    loaderForNonAllottedStatus = true;
    try {
      ApiResponse? response = (await repository.getTimesheetStart(
          selectedNonAllottedClientApplicableService, selectedNonAllottedTaskId));
      if (response.success!) {
        callStatusListForNonAllotted(selectedNonAllottedClientApplicableService);
        Utils.showSuccessSnackBar(response.message);
        updateLoader(false);
        update();
      } else {
        Utils.showErrorSnackBar(response.message);loaderForNonAllottedStatus=false;
        updateLoader(false);
        update();
      }
      update();
    } on CustomException catch (e) {
      Utils.showErrorSnackBar(e.getMsg());loaderForNonAllottedStatus=false;
      updateLoader(false);
      update();
    } catch (error) {
      Utils.showErrorSnackBar(error.toString());loaderForNonAllottedStatus=false;
      updateLoader(false);
      update();
    }
  }

  onSelectionForMultipleService(
      List<TimesheetServicesListData> selectedServiceListFromDesign) {
    updateLoader(true);

    allottedTimesheetSelectedServiceList = selectedServiceListFromDesign;

    for (var element in allottedTimesheetSelectedServiceList) {
      callTaskListForAllotted(
          element.serviceId!,
          element.id!,
          element.serviceName!,element.period!,
          element.selectedClientId!,
          element.selectedClientName!);
    }
  }

  onDeleteMultipleService(TimesheetServicesListData value) {
    updateLoader(true);
    fillTimesheet();
    timesheetTaskListData.clear();
    allottedTimesheetSelectedServiceList.remove(value);
    allottedTimesheetSelectedMultipleServiceIdList.remove(value.serviceId!);
    removeFirstBracketForService = allottedTimesheetSelectedMultipleServiceIdList
            .toString().replaceAll("[", "");
    removeSecondBracketForService = removeFirstBracketForService.replaceAll("]", "");

    allottedClientApplicableServiceIdList.remove(value.id!);
    removeFirstBracketForClientApplicableService =
        allottedClientApplicableServiceIdList.toString().replaceAll("[", "");
    removeSecondBracketForClientApplicableService =
        removeFirstBracketForClientApplicableService.replaceAll("]", "");

    taskList.removeWhere((element) => value.serviceId == element.serviceId);

    for (var element in allottedTimesheetSelectedServiceList) {
      callTaskListForAllotted(
          element.serviceId!,
          element.id!,
          element.serviceName!,element.period!,
          element.selectedClientId!,
          element.selectedClientName!);
    }
    update();
  }

  updateNonAllottedCheckBox(bool selectNonAllotted) {
    if (selectNonAllotted) {
      stepsList.add("Non Allotted");
      update();
    }

    cbNonAllotted = selectNonAllotted;
    update();
  }

  updateOfficeCheckBox(bool selectOffice) {
    if (selectOffice) {
      stepsList.add("Office");
      update();
    }

    cbOffice = selectOffice;
    update();
  }

  bool isLoadingStepper2 = false;

  fillTimesheet() {
    if (allottedSelectedClientName == "") {
      Utils.showErrorSnackBar("Please select client");isLoadingStepper2 = false;
      update();
    } else if (allottedTimesheetSelectedServiceList.isEmpty) {
      Utils.showErrorSnackBar("Please select service");isLoadingStepper2 = false;
      update();
    } else {
      isFillTimesheetSelected = true;
      isLoadingStepper2 = false;
      update();
    }
  }

  List<int> addedTime = [];

  List<TimeOfDay> selectedTimeForAllList = [];
  int prevHr = 0;
  int prevMin = 0;
  int reminderFromMin = 0;
  int remainingFromMin = 0;
  List<int> hrList = [];
  List<int> minList = [];
  var hrSum = 0;
  var minSum = 0;
  int prevIndex = 0;

  List<AllottedStepperOneTestModel> testingAllotted = [];
  List<TimesheetTaskDetailsData> testTaskList = [];
  TextEditingController detailsAddController = TextEditingController();

  Future<void> selectTimeForTask(
      BuildContext context, int listIndex, int index, String taskId) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 12, minute: 00),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    );
   update();

    if (picked != null && picked != selectedDate) {
      selectedTime = picked;
      selectedTimeForAllList.add(selectedTime);
      selectedStartTimeToShow = "${selectedTime.hour}:${selectedTime.minute}";

      timesheetTaskListData[listIndex].timesheetTaskDetailsData![index].timeSpent = selectedStartTimeToShow;

      if(taskIdList.contains(taskId)){
      }
      else{
        taskIdList.add(taskId);
      }

      print("taskIdList on time selection");
      print(taskIdList);
      print("time spent");
      print(timesheetTaskListData[listIndex].timesheetTaskDetailsData![index].timeSpent);
      print("selectedStartTimeToShow");
      print(selectedStartTimeToShow);
      print("timeInTask");
      print(timeInTask);

      if (isAddingMoreAllotted = true) {
        index = hrList.length + index;
      } else {
        index = index;
      }
      if (hrList.asMap().containsKey(index)) {
        hrList.removeAt(index);
        hrList.insert(index, selectedTime.hour);
        minList.removeAt(index);
        minList.insert(index, selectedTime.minute);
        // if(dataList.isEmpty || dataList[index].toString().isEmpty){
        //   isDetailsAdd = false;
        // }
        // else{
        //   isDetailsAdd = true;
        // }
      } else {
        hrList.add(selectedTime.hour);
        minList.add(selectedTime.minute);

        // if(dataList.isEmpty || dataList[index].toString().isEmpty){
        //   isDetailsAdd = false;
        // }
        // else{
        //   isDetailsAdd = true;
        // }
      }

      hrSum = hrList.reduce((a, b) => a + b);
      minSum = minList.reduce((a, b) => a + b);

      if (minSum >= 60) {
        remainingFromMin = minSum ~/ 60;
        minSum = minSum % 60;
      }

      hrSum = hrSum + remainingFromMin;
      Utils.dismissKeyboard();
      isTimeSpentAdd = true;
      update();
    }

    else{
      isTimeSpentAdd = false;
      update();
    }
    // if(dataList.isEmpty || dataList[index].toString().isEmpty){
    //   isDetailsAdd = false;
    // }
    // else{
    //   isDetailsAdd = true;
    // }
    update();
  }

  int remainingFromTotalSpentMin = 0;
  Duration diff = const Duration();

  calculateTimeDifference() {

    totalHrSpent = hrSum + hrNonAllottedSum == 0 ? 0 : hrNonAllottedSum
        + hrOfficeSum == 0 ? 0 : hrOfficeSum;
    totalMinuteSpent = minSum + minNonAllottedSum == 0 ? 0 : minNonAllottedSum
        + minOfficeSum == 0 ? 0 : minOfficeSum;

    if(totalMinuteSpent >= 60) {
      remainingFromTotalSpentMin = minSum ~/ 60;
      totalMinuteSpent = totalMinuteSpent % 60;
    }

    totalHrSpent = hrSum + hrNonAllottedSum + hrOfficeSum;
    totalMinuteSpent = minSum + minNonAllottedSum + minOfficeSum;

    print("hrSum");
    print(hrSum);
    print("hrNonAllottedSum");
    print(hrNonAllottedSum);
    print("hrOfficeSum");
    print(hrOfficeSum);
    if(totalMinuteSpent >= 60) {
      remainingFromTotalSpentMin = totalMinuteSpent ~/ 60;
      totalMinuteSpent = totalMinuteSpent % 60;
    }

    totalHrSpent = totalHrSpent + remainingFromTotalSpentMin;

    var format = DateFormat("HH:mm");

    String formattedTotalSpentTime = "$totalHrSpent:$totalMinuteSpent";
    var one = format.parse(formattedTotalSpentTime);
    var two = format.parse(timesheetTotalTime.text.toString());
    diff = two.difference(one);

    print("diff");
    print(diff);
    update();
  }

  showConfirmationDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setter) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 100.0,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildTextRegularWidget(
                        "Do you want to add more ?", blackColor, context, 16.0,
                        align: TextAlign.left),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              setter(() {
                                Navigator.of(context).pop();

                                if (currentService == "allotted") {
                                  stepsList.add("Allotted");
                                 // isFillTimesheetSelected = false;
                                  saveCurrentAllottedList();
                                } else {
                                  currentService = "nonAllotted";
                                 // isFillTimesheetSelected = false;
                                  saveCurrentNonAllottedList();
                                }
                              });
                            },
                            child: buildButtonWidget(context, "Yes",
                                height: 40.0, buttonColor: approveColor),
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              setter(() {
                                Navigator.of(context).pop();
                                allottedEmployeeList.clear();
                                allottedServiceList.clear();
                                if(currentService == "allotted"){
                                  currentService = "nonAllotted";
                                  stepsList.add("Allotted");
                                  saveCurrentAllottedList();
                                }
                                else{
                                  cbNonAllotted = false;
                                  clearNonAllotted();
                                }
                                update();
                              });
                            },
                            child: buildButtonWidget(context, "No",
                                height: 40.0, buttonColor: errorColor),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  List<TimesheetTaskDetailsData> allottedLocalStoreTaskList = [];
  List<String> allottedLocalStoreDetailsList = [];
  List<String> allottedLocalStoreTimeSpentList = [];
  List<String> allottedLocalTaskIdList = [];
  List<String> allottedLocalStoreStatusList = [];
  bool isDetailsFill = false;
  bool isDetailsAdd = false;
  bool isTimeSpentAdd = false;
  int taskIndex = 0;
  List<int> addedTask = [];

  checkValidationForAllotted(BuildContext context) {
    // if(isDetailsAdd==true && isTimeSpentAdd==false){
    //   Utils.showErrorSnackBar("Please enter valid details!");
    // }
    // else if(isDetailsAdd==false && isTimeSpentAdd==true){
    //   Utils.showErrorSnackBar("Please enter valid time spent!");
    // }
    // else if(isDetailsAdd==false && isTimeSpentAdd==false){
    //   Utils.showErrorSnackBar("Please enter valid data!");
    // }
    // else if(isDetailsAdd==true && isTimeSpentAdd==true){
    //   showConfirmationDialog(context);
    // }
    showConfirmationDialog(context);
  }

  String removeFirstDetailsBracket = "";
  String removeSecondDetailsBracket = "";
  String removeFirstTimeSpentBracket = "";
  String removeSecondTimeSpentBracket = "";
  String removeFirstStatusBracket = "";
  String removeSecondStatusBracket = "";
  String removeFirstTaskIdListBracket = "";
  String removeSecondTaskIdListBracket = "";

  saveCurrentAllottedList() {
    updateLoader(true);
    for (var element in timesheetTaskListData) {
      allottedLocalStoreTaskList = element.timesheetTaskDetailsData!;
    }
   ///time spent
    for (var element in allottedLocalStoreTaskList) {
      if (element == "") {
      } else {
        if(element.timeSpent==null){}
        else{
          allottedLocalStoreTimeSpentList.add(element.timeSpent!);
        }
      }
    }
    ///details
    for (var element in dataList) {
      if(element.isEmpty || element==""){}
      else{
        allottedLocalStoreDetailsList.add(element);
      }
    }

    print(allottedLocalStoreTimeSpentList);

    allottedLocalStoreTimeSpentList.isEmpty ? null :
    allottedTimesheetSelectedTimeList.add(allottedLocalStoreTimeSpentList.toString());

    print("allottedTimesheetSelectedTimeList");
    print(allottedTimesheetSelectedTimeList);
    for(int i =0;i < allottedLocalStoreTimeSpentList.length;i++){
      serviceIdInTask.isEmpty ? null :
      allottedTimesheetSelectedMultipleServiceIdList.add(serviceIdInTask[i]);

      clientServiceIdInTask.isEmpty ? null :
      allottedClientApplicableServiceIdList.add(clientServiceIdInTask[i]);

      clientIdInTask.isEmpty ? null :
      allottedTimesheetSelectedMultipleEmpIdList.add(clientIdInTask[i]);

      //allottedLocalTaskIdList.add(taskIdList.toString());
      //taskIdList.add(taskIdList[i]);
    }
    allottedLocalTaskIdList = taskIdList;

    //allottedLocalTaskIdList.add(taskIdList.toString());
    ///status name
    for (var element in addedAllottedStatusNameList) {
      if (element == "") {
      } else {
        allottedLocalStoreStatusList.add(element);
      }
    }
    ///task id
    removeFirstDetailsBracket = allottedLocalStoreDetailsList.toString().replaceAll("[", "");
    removeSecondDetailsBracket = removeFirstDetailsBracket.replaceAll("]", "");

    //removeFirstTimeSpentBracket = allottedLocalStoreTimeSpentList.toString().replaceAll("[", "");
    removeFirstTimeSpentBracket = allottedTimesheetSelectedTimeList.toString().replaceAll("[", "");
    removeSecondTimeSpentBracket = removeFirstTimeSpentBracket.replaceAll("]", "");

    removeFirstTaskIdListBracket = allottedLocalTaskIdList.toString().replaceAll("[", "");
    removeSecondTaskIdListBracket = removeFirstTaskIdListBracket.replaceAll("]", "");

    removeFirstBracket = allottedTimesheetSelectedMultipleEmpIdList.toString().replaceAll("[", "");
    removeSecondBracket = removeFirstBracket.replaceAll("]", "");

    removeFirstBracketForService = allottedTimesheetSelectedMultipleServiceIdList.toString().replaceAll("[", "");
    removeSecondBracketForService = removeFirstBracketForService.replaceAll("]", "");

    removeFirstBracketForClientApplicableService = allottedClientApplicableServiceIdList.toString().replaceAll("[", "");
    removeSecondBracketForClientApplicableService = removeFirstBracketForClientApplicableService.replaceAll("]", "");

    // removeFirstBracket = allottedTimesheetSelectedMultipleEmpIdList.toString().replaceAll("[", "");
    // removeSecondBracket = removeFirstBracket.replaceAll("]", "");

    finalDetails = removeSecondDetailsBracket;
    finalClientId = removeSecondBracket;
    finalService = removeSecondBracketForService;
    finalClientApplicableService = removeSecondBracketForClientApplicableService;
    finalTaskId = removeSecondTaskIdListBracket;
    finalTimeSpent = removeSecondTimeSpentBracket;

    clearAllotted();
    update();
  }

  clearAllotted() {
    timesheetTaskListData.clear();

    for (var element in timesheetTaskListData) {
      element.timesheetTaskDetailsData!.clear();
    }
    timeSpentControllerList.clear();
    //taskIdList.clear();
    //statusList.clear();
    taskIdListToCallApi.clear();
    addedAllottedStatusNameList.clear();

    allottedEmployeeList.clear();
    allottedTimesheetSelectedEmpList.clear();
    items.clear();
    allottedServiceList.clear();
    allottedTimesheetSelectedServiceList.clear();
    serviceItems.clear();
    allottedSelectedClientName = "";
    allottedSelectedServiceName = "";
    dataList.clear();
    clientIdInTask.clear();
    serviceIdInTask.clear();
    clientServiceIdInTask.clear();
    allottedLocalStoreTimeSpentList.clear();
    isDetailsAdd = false;
    isTimeSpentAdd = false;

    if (currentService == "allotted") {
      isAddingMoreAllotted = true;
      callEmployeeList();
    } else if (cbNonAllotted == true && cbOffice == true) {
      currentService = "nonAllotted";
      callEmployeeList();
      update();
    } else if (cbNonAllotted == true && cbOffice == false) {
      currentService = "nonAllotted";
      callEmployeeList();
      update();
    } else if (cbNonAllotted == false && cbOffice == true) {
      currentService = "office";
      callTimesheetTypeOfWork();
      showOffice = true;
      update();
    } else if (cbNonAllotted == false && cbOffice == false) {
      currentService = "";
      continued();
      update();
    }

    print("allotted data");
    print(selectedDateToSend);
    print(removeSecondBracket);
    print(removeSecondBracketForService);
    print(removeSecondBracketForClientApplicableService);
    print(removeSecondTaskIdListBracket);
    print(removeSecondDetailsBracket);
    print(removeSecondTimeSpentBracket);
    updateLoader(false);
    update();
  }

  bool isLoadingForStepper1 = false;
  checkValidationForStepper1() {
    if (selectedDateToShow == "" ||
        timesheetSelectedWorkAt.isEmpty ||
        stepper1InTime.text.isEmpty ||
        stepper1OutTime.text.isEmpty ||
        timesheetTotalTime.text.isEmpty) {
      selectedDateToShow == ""
          ? validateStartDate = true
          : validateStartDate = false;
      timesheetSelectedWorkAt.isEmpty
          ? validateWorkAt = true
          : validateWorkAt = false;
      stepper1InTime.text.isEmpty
          ? validateInTime = true
          : validateInTime = false;
      stepper1OutTime.text.isEmpty
          ? validateOutTime = true
          : validateOutTime = false;

      updateLoader(false);
      isLoadingForStepper1 = false;
      update();
    } else {
      //callTimesheetCheck();
      callTimesheetAdd();
      update();
    }
  }

  /// check timesheet
  void callTimesheetCheck(String selectedDateToApi) async {
    try {
      CheckTimesheetApiResponse? response =
          (await repository.getTimesheetCheck(selectedDateToApi));

      if (response.success!) {
        //callTimesheetAdd();
        validateStartDate = false;
        validateStartDate = false;
        updateLoader(false);
        isLoadingForStepper1 = false;
        if(response.flag==""){
          selectedDate = DateTime.now();update();
        }
        else{
          selectedDateToShow = "";
          selectedDateToSend = "";
          selectedDate = DateTime.now();
          Utils.showErrorSnackBar(response.flag);
        }
        update();
      } else {
        selectedDate = DateTime.now();
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);isLoadingForStepper1 = false;
        update();
      }
      update();
    } on CustomException catch (e) {
      selectedDate = DateTime.now();
      Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);isLoadingForStepper1 = false;
      update();
    } catch (error) {
      selectedDate = DateTime.now();
      Utils.showErrorSnackBar(error.toString());
      updateLoader(false);isLoadingForStepper1 = false;
      update();
    }
  }

  int totalBackDateCount = 0;
  void callTimesheetBackDateCount() async {
    try {
      TimesheetDateCountResponse? response = (await repository.getTimesheetBackdateCount());

      print("backdate response");
      print(response);
      if (response.success==true) {
        response.data!.isEmpty ? null :
        totalBackDateCount = int.parse(response.data![0].taskno!);
        print("totalBackDateCount");
        print(totalBackDateCount);
        update();
      } else {
        updateLoader(false);isLoadingForStepper1 = false;
        update();
      }
      update();
    } on CustomException catch (e) {
      updateLoader(false);isLoadingForStepper1 = false;
      update();
    } catch (error) {
      updateLoader(false);isLoadingForStepper1 = false;
      update();
    }
  }

  /// add timesheet
  void callTimesheetAdd() async {
    try {
      ApiResponse? response = (await repository.getTimesheetAdd(
          selectedDateToSend,
          stepper1InTime.text,
          stepper1OutTime.text,
          timesheetTotalTime.text,
          removeSecondBracketFromWorkAt));
      if (response.success!) {
        Utils.showSuccessSnackBar(response.message);
        updateLoader(false);
        isLoadingForStepper1 = false;
        continued();
        update();
      } else {
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);isLoadingForStepper1 = false;
        update();
      }
      update();
    } on CustomException catch (e) {
      Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);isLoadingForStepper1 = false;
      update();
    } catch (error) {
      Utils.showErrorSnackBar(error.toString());
      updateLoader(false);isLoadingForStepper1 = false;
      update();
    }
  }

  bool isLoadingForStepper3 = false;

  String finalDetails = "";
  String finalClientId = "";
  String finalService = "";
  String finalClientApplicableService = "";
  String finalTaskId = "";
  String finalTimeSpent = "";

  callApiToSaveAll(String action) {
    isLoadingForStepper3 = true;

    // if(removeSecondNonAllottedDetailsListBracket == "") {
    //   removeSecondDetailsBracket = removeSecondDetailsBracket.replaceAll(", ", ",");
    // } else {
    // removeSecondDetailsBracket = "${removeSecondDetailsBracket.replaceAll(", ", ",")},"
    // "${removeSecondNonAllottedDetailsListBracket.replaceAll(", ", ",")}";
    // }

    ///details
    if(removeSecondDetailsBracket!="" && removeSecondNonAllottedDetailsListBracket == ""){
      finalDetails = removeSecondDetailsBracket.replaceAll(", ", ",");
    }
    else if (removeSecondDetailsBracket=="" && removeSecondNonAllottedDetailsListBracket != "") {
      finalDetails = removeSecondNonAllottedDetailsListBracket.replaceAll(", ", ",");
    }
    else if (removeSecondDetailsBracket=="" && removeSecondNonAllottedDetailsListBracket == "") {
      finalDetails = "";
    }
    else {
      finalDetails = "${removeSecondDetailsBracket.replaceAll(", ", ",")},"
          "${removeSecondNonAllottedDetailsListBracket.replaceAll(", ", ",")}";
    }
    ///client id
    if (removeSecondBracket!="" && removeSecondNonAllottedClientIdListBracket == "") {
      finalClientId = removeSecondBracket.replaceAll(", ", ",");
    }
    else if (removeSecondBracket=="" && removeSecondNonAllottedClientIdListBracket != "") {
      finalClientId = removeSecondNonAllottedClientIdListBracket.replaceAll(", ", ",");
    } else if (removeSecondBracket=="" && removeSecondNonAllottedClientIdListBracket == "") {
      finalClientId = "";
    }else {
      finalClientId = "${removeSecondBracket.replaceAll(", ", ",")},${removeSecondNonAllottedClientIdListBracket.replaceAll(", ", ",")}";
    }
    ///service id
    if (removeSecondBracketForService!="" && removeSecondNonAllottedServiceIdListBracket == "") {
      finalService = removeSecondBracketForService.replaceAll(", ", ",");
    }
    else if (removeSecondBracketForService=="" && removeSecondNonAllottedServiceIdListBracket != "") {
      finalService = removeSecondNonAllottedServiceIdListBracket.replaceAll(", ", ",");
    }else if (removeSecondBracketForService=="" && removeSecondNonAllottedServiceIdListBracket == "") {
      finalService = "";
    } else {
      finalService = "${removeSecondBracketForService.replaceAll(", ", ",")},${removeSecondNonAllottedServiceIdListBracket.replaceAll(", ", ",")}";
    }
    ///client applicable service id
    if (removeSecondBracketForClientApplicableService!="" && removeSecondNonAllottedClientServiceIdListBracket == "") {
     finalClientApplicableService = removeSecondBracketForClientApplicableService.replaceAll(", ", ",");
    }
    else if (removeSecondBracketForClientApplicableService=="" && removeSecondNonAllottedClientServiceIdListBracket != "") {
      finalClientApplicableService = removeSecondNonAllottedClientServiceIdListBracket.replaceAll(", ", ",");
    }else if (removeSecondBracketForClientApplicableService=="" && removeSecondNonAllottedClientServiceIdListBracket == "") {
      finalClientApplicableService = "";
    } else {
      finalClientApplicableService = "${removeSecondBracketForClientApplicableService.replaceAll(", ", ",")},${removeSecondNonAllottedClientServiceIdListBracket.replaceAll(", ", ",")}";
    }
    ///task id
    if (removeSecondTaskIdListBracket!="" && removeSecondNonAllottedTaskIdBracket == "") {
      finalTaskId = removeSecondTaskIdListBracket.replaceAll(", ", ",");
    }
    else if (removeSecondTaskIdListBracket=="" && removeSecondNonAllottedTaskIdBracket != "") {
      finalTaskId = removeSecondNonAllottedTaskIdBracket.replaceAll(", ", ",");
    }else if (removeSecondTaskIdListBracket=="" && removeSecondNonAllottedTaskIdBracket == "") {
      finalTaskId = "";
    } else {
      finalTaskId = "${removeSecondTaskIdListBracket.replaceAll(", ", ",")},${removeSecondNonAllottedTaskIdBracket.replaceAll(", ", ",")}";
    }
    ///time spent
    if (removeSecondTimeSpentBracket !="" && removeSecondNonAllottedTimeListBracket == "") {
      finalTimeSpent = removeSecondTimeSpentBracket.replaceAll(", ", ",");
    }
    else if (removeSecondTimeSpentBracket =="" && removeSecondNonAllottedTimeListBracket != "") {
      finalTimeSpent = removeSecondNonAllottedTimeListBracket.replaceAll(", ", ",");
    }else if (removeSecondTimeSpentBracket =="" && removeSecondNonAllottedTimeListBracket == "") {
      finalTimeSpent = "";
    } else {
      finalTimeSpent = "${removeSecondTimeSpentBracket.replaceAll(", ", ",")},${removeSecondNonAllottedTimeListBracket.replaceAll(", ", ",")}";
    }

    officeAction = action;

    print("final data");
    print(finalDetails);
    print(finalClientId);
    print(finalService);
    print(finalClientApplicableService);
    print(finalTaskId);
    print(finalDetails);
    print(finalTimeSpent);
    if(finalDetails=="" || finalClientId=="" || finalService=="" || finalClientApplicableService==""||
        finalTaskId==""|| finalTimeSpent==""){
      print("call office");
      callSaveOffice();
    }
    else{
      print("call allo");
      callSaveAllotted();
    }
  }

  onDetailsTextChange(String value,String taskId,int indexForTask){
    if(taskIdList.contains(taskId)){}
    else{
      taskIdList.add(taskId);
    }

    // if (dataList.asMap().containsKey(indexForTask)) {
    //   print("Before remove");
    //   print(dataList);
    //   dataList.removeAt(indexForTask);
    //   print("After remove");
    //   print(dataList);
    //   dataList.insert(indexForTask, value);
    //
    //   print("In if text");
    //   print(dataList);
    //   isDetailsAdd = true;
    //   update();
    // } else {
    //   dataList.add(value);
    //   print("In else text");
    //   print(dataList);
    //   isDetailsAdd = true;
    //   update();
    // }


    //dataList.add(value);

    if(dataList.isEmpty){
      dataList.add(value);
    }
    else{
      dataList.removeAt(indexForTask-1);
      dataList.insert(indexForTask-1, value);
    }

    if(hrList.isEmpty || hrList[indexForTask].toString().contains("")){
      isTimeSpentAdd = false;
    }
    else{
      isTimeSpentAdd = true;
    }
    update();
  }

  callSaveAllotted() async {
    try {
      // ApiResponse? response = (await repository.getTimesheetAddAllotted(
      //     selectedDateToSend,
      //     removeSecondBracket,
      //     removeSecondBracketForService,
      //     removeSecondBracketForClientApplicableService,
      //     removeSecondTaskIdListBracket,
      //     removeSecondDetailsBracket,
      //     removeSecondTimeSpentBracket));

      ApiResponse? response = (await repository.getTimesheetAddAllotted(
          selectedDateToSend,
          finalClientId,
          finalService,
          finalClientApplicableService,
          finalTaskId,
          finalDetails,
          finalTimeSpent));

      if (response.success!) {
        Utils.showSuccessSnackBar(response.message);

        ///if office is selected
        if (stepsList.contains("Office")) {
          callSaveOffice();
        } else {
          isLoadingForStepper3 =false;
          Get.offAllNamed(AppRoutes.bottomNav);update();
        }

        updateLoader(false);
      } else {
        Utils.showErrorSnackBar(response.message);
        isLoadingForStepper3 =false;
        updateLoader(false);
      }
    } on CustomException catch (e) {
      Utils.showErrorSnackBar(e.getMsg());
      isLoadingForStepper3 =false;
      updateLoader(false);
      update();
    } catch (error) {
      Utils.showErrorSnackBar(error.toString());
      isLoadingForStepper3 =false;
      updateLoader(false);
      update();
    }
  }

  nextFromAllotted() {
    // if(cbNonAllotted==true){
    //   stepsList.add("Non Allotted");
    //   saveCurrentAllottedList();
    // }
    // else if(){
    //   stepsList.add("Office");
    // }
    // else{
    //   allottedEmployeeList.clear();
    //   allottedServiceList.clear();
    //   continued();
    //   update();
    // }

    // saveCurrentAllottedList();
    // allottedEmployeeList.clear();
    // allottedServiceList.clear();
    // continued();
    // update();
  }

  //-------non allotted------//

  String nonAllottedSelectedClientName = "";
  List<String> selectedNonAllottedClientNameList = [];
  List<String> selectedNonAllottedClientIdList = [];
  String nonAllottedSelectedServiceName = "";
  List<String> selectedNonAllottedServiceNameList = [];
  List<String> selectedNonAllottedServiceIdList = [];
  List<String> selectedNonAllottedClientIdServiceIdList = [];
  String nonAllottedSelectedTaskName = "";
  List<String> selectedNonAllottedTaskNameList = [];
  List<String> selectedNonAllottedTaskIdList = [];
  bool loaderNonAllottedService = false;

  ///client
  addNonAllottedClientNameAndId(String id, String name) {
    selectedNonAllottedClientNameList.add(name);
    selectedNonAllottedClientIdList.add(id);
    loaderNonAllottedService = true;
    callServiceListForNonAllotted(id, name);

    update();
  }

  onNonAllottedClientName(String val) {
    nonAllottedSelectedClientName = val;
    update();
  }

  String toshowId= "";
  String toshowClientId= "";
  bool loaderNonAllottedForTask = false;
  String selectedNonAllottedClientApplicableService = "";

  ///service
  addNonAllottedServiceNameAndId(
      String id, String name, String clientId, String clientServiceId) {
    nonAllottedTaskList.clear();nonAllottedSelectedTaskName = "";
    selectedNonAllottedClientApplicableService = clientServiceId;
    selectedNonAllottedServiceNameList.add(name);
    selectedNonAllottedServiceIdList.add(id);
    selectedNonAllottedClientIdServiceIdList.add(clientServiceId);

    toshowId = id;
    toshowClientId = clientId;
    loaderNonAllottedForTask = true;
    callTaskListForNonAllotted(id, clientServiceId);
    update();
  }

  onNonAllottedServiceName(String val) {
    nonAllottedSelectedServiceName = val;
    update();
  }

  String selectedNonAllottedTaskId = "";
  bool loaderForNonAllottedStatus = false;
  ///task
  addNonAllottedTaskNameAndId(String id, String name) {
    loaderForNonAllottedStatus=true;
    selectedNonAllottedTaskId = id;
    selectedNonAllottedTaskNameList.add(name);
    selectedNonAllottedTaskIdList.add(id);
    callStatusListForNonAllotted(selectedNonAllottedClientApplicableService);
    update();
  }

  onNonAllottedTaskName(String val) {
    nonAllottedSelectedTaskName = val;
    update();
  }

  checkValidationForNonAllotted(BuildContext context) {
    if (nonAllottedSelectedClientName == "") {
      Utils.showErrorSnackBar("Please select client!");
      update();
    } else if (nonAllottedSelectedServiceName == "") {
      Utils.showErrorSnackBar("Please select service!");
      update();
    } else if (nonAllottedSelectedTaskName == "") {
      Utils.showErrorSnackBar("Please select task!");
      update();
    } else if (nonAllottedDetailsController.text.isEmpty) {
      Utils.showErrorSnackBar("Please add details!");
      update();
    } else if (selectedNonAllottedTime == "") {
      Utils.showErrorSnackBar("Please select time!");
      update();
    } else {
      showConfirmationDialogForNonAllotted(context);
      update();
    }
  }

  showConfirmationDialogForNonAllotted(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setter) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 100.0,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildTextRegularWidget(
                        "Do you want to add more ?", blackColor, context, 16.0,
                        align: TextAlign.left),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              setter(() {
                                Navigator.of(context).pop();
                                saveCurrentNonAllottedList();
                              });
                            },
                            child: buildButtonWidget(context, "Yes",
                                height: 40.0, buttonColor: approveColor),
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              setter(() {
                                Navigator.of(context).pop();
                                cbNonAllotted = false;
                                nextFromNonAllottedOrOffice();
                                update();
                              });
                            },
                            child: buildButtonWidget(context, "No",
                                height: 40.0, buttonColor: errorColor),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  String removeFirstNonAllottedDetailsListBracket = "";
  String removeSecondNonAllottedDetailsListBracket = "";
  String removeFirstNonAllottedTimeListBracket = "";
  String removeSecondNonAllottedTimeListBracket = "";
  String removeFirstNonAllottedClientIdListBracket = "";
  String removeSecondNonAllottedClientIdListBracket = "";
  String removeFirstNonAllottedServiceIdListBracket = "";
  String removeSecondNonAllottedServiceIdListBracket = "";
  String removeFirstNonAllottedClientServiceIdListBracket = "";
  String removeSecondNonAllottedClientServiceIdListBracket = "";
  String removeFirstNonAllottedTaskIdBracket = "";
  String removeSecondNonAllottedTaskIdBracket = "";

  saveCurrentNonAllottedList({bool fromNonAllottedNext = false}) {
    updateLoader(true);

    nonAllottedDetailsList.add(nonAllottedDetailsController.text);
    nonAllottedTimeList.add(selectedNonAllottedTime);

    nonAllottedDetailsController.clear();
    selectedNonAllottedTime = "";

    prevIndex = hrList.length;
    update();

    removeFirstNonAllottedDetailsListBracket =
        nonAllottedDetailsList.toString().replaceAll("[", "");
    removeSecondNonAllottedDetailsListBracket =
        removeFirstNonAllottedDetailsListBracket.replaceAll("]", "");

    removeFirstNonAllottedTimeListBracket =
        nonAllottedTimeList.toString().replaceAll("[", "");
    removeSecondNonAllottedTimeListBracket =
        removeFirstNonAllottedTimeListBracket.replaceAll("]", "");

    removeFirstNonAllottedClientIdListBracket =
        selectedNonAllottedClientIdList.toString().replaceAll("[", "");
    removeSecondNonAllottedClientIdListBracket =
        removeFirstNonAllottedClientIdListBracket.replaceAll("]", "");

    removeFirstNonAllottedServiceIdListBracket =
        selectedNonAllottedServiceIdList.toString().replaceAll("[", "");
    removeSecondNonAllottedServiceIdListBracket =
        removeFirstNonAllottedServiceIdListBracket.replaceAll("]", "");

    removeFirstNonAllottedClientServiceIdListBracket =
        selectedNonAllottedClientIdServiceIdList.toString().replaceAll("[", "");
    removeSecondNonAllottedClientServiceIdListBracket =
        removeFirstNonAllottedClientServiceIdListBracket.replaceAll("]", "");

    removeFirstNonAllottedTaskIdBracket =
        selectedNonAllottedTaskIdList.toString().replaceAll("[", "");
    removeSecondNonAllottedTaskIdBracket =
        removeFirstNonAllottedTaskIdBracket.replaceAll("]", "");

    clearNonAllotted(fromNonAllottedNext: fromNonAllottedNext);
    update();
  }

  clearNonAllotted({bool fromNonAllottedNext = false}) {
    allottedEmployeeList.clear();
    allottedServiceList.clear();
    nonAllottedTaskList.clear();
    nonAllottedDetailsController.clear();
    nonAllottedSelectedClientName = "";
    nonAllottedSelectedServiceName = "";
    nonAllottedSelectedTaskName = "";
    selectedNonAllottedTime = "";

   if(fromNonAllottedNext){
     if (cbOffice == true) {
       currentService = "office";
       showOffice = true;
       callTimesheetTypeOfWork();
       update();
     }
     else {
       currentService = "";
       continued();
       update();
     }
   }
   else{
     if (cbNonAllotted == true && cbOffice == true) {
       currentService = "nonAllotted";
       callEmployeeList();
       update();
     }
     else if (cbNonAllotted == true && cbOffice == false) {
       currentService = "nonAllotted";
       callEmployeeList();
       update();
     }
     else if (cbNonAllotted == false && cbOffice == true) {
       currentService = "office";
       showOffice = true;
       callTimesheetTypeOfWork();
       update();
     }
     else if (cbNonAllotted == false && cbOffice == false) {
       currentService = "";
       continued();
       update();
     }
   }

    print("non allotted data");
    print("${removeSecondBracket.replaceAll(", ", ",")},${removeSecondNonAllottedClientIdListBracket.replaceAll(", ", ",")}");
    print("${removeSecondBracketForService.replaceAll(", ", ",")},${removeSecondNonAllottedServiceIdListBracket.replaceAll(", ", ",")}");
    print("${removeSecondBracketForClientApplicableService.replaceAll(", ", ",")},${removeSecondNonAllottedClientServiceIdListBracket.replaceAll(", ", ",")}");
    print("${removeSecondTaskIdListBracket.replaceAll(", ", ",")},${removeSecondNonAllottedTaskIdBracket.replaceAll(", ", ",")}");
    print("${removeSecondTimeSpentBracket.replaceAll(", ", ",")},${removeSecondNonAllottedTimeListBracket.replaceAll(", ", ",")}");
    updateLoader(false);
    update();
  }

  callSaveNonAllotted() async {
    try {
      ApiResponse? response = (await repository.getTimesheetAddAllotted(
        selectedDateToSend,
        "${removeSecondBracket.replaceAll(", ", ",")},${removeSecondNonAllottedClientIdListBracket.replaceAll(", ", ",")}",
        "${removeSecondBracketForService.replaceAll(", ", ",")},${removeSecondNonAllottedServiceIdListBracket.replaceAll(", ", ",")}",
        "${removeSecondBracketForClientApplicableService.replaceAll(", ", ",")},${removeSecondNonAllottedClientServiceIdListBracket.replaceAll(", ", ",")}",
        "${removeSecondTaskIdListBracket.replaceAll(", ", ",")},${removeSecondNonAllottedTaskIdBracket.replaceAll(", ", ",")}",
        allottedStatusRemarkText.text.isEmpty || allottedStatusRemarkText.text=="" ? "" : allottedStatusRemarkText.text,
        "${removeSecondTimeSpentBracket.replaceAll(", ", ",")},${removeSecondNonAllottedTimeListBracket.replaceAll(", ", ",")}",
      ));
      if (response.success!) {
        callSaveOffice();
        Utils.showSuccessSnackBar("Non Allotted ${response.message}");
        updateLoader(false);
      } else {
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);
      }
    } on CustomException catch (e) {
      Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }
  }

  nextFromNonAllottedOrOffice() {
    if (currentService == "nonAllotted") {
      saveCurrentNonAllottedList();
    } else {
      saveOfficeRelated();
    }
    update();
  }

  nextFromOffice(bool nextFromOffice) {
    cbOffice = false;
    saveOfficeRelated();
    currentService = "";
    continued(nextFromOffice:nextFromOffice);
    update();
  }

  /// service non allotted
  void callServiceListForNonAllotted(
      String selectedClientId, String selectedClient) async {
    allottedServiceList.clear();
    try {
      TimesheetServiceListModel? response = (await repository.getTimesheetNonAllottedServicesList(selectedClientId));

      if (response.success!) {
        if (response.data!.isEmpty) {
          loaderNonAllottedService = false; update();
        } else {
          for (var element in response.data!) {
            allottedServiceList.add(TimesheetServicesListData(
                id: element.id,
                serviceId: element.serviceId,
                selectedClientId: selectedClientId,
                serviceName: element.serviceName,
                selectedClientName: selectedClient,
                period: element.period,
                serviceDueDatePeriodicity: element.serviceDueDatePeriodicity));
          }

          serviceItems = allottedServiceList
              .map((value) => MultiSelectItem<TimesheetServicesListData>(
                  value, value.serviceName!))
              .toList();

          loaderNonAllottedService = false;
          update();
        }
        loaderNonAllottedService = false;
        update();
      } else {
        loaderNonAllottedService = false;
        update();
      }
    } on CustomException {
      loaderNonAllottedService = false;
      update();
    } catch (error) {
      loaderNonAllottedService = false;
      update();
    }
  }

  List<TimesheetTaskDetailsData> nonAllottedTaskList = [];

  /// task non allotted
  void callTaskListForNonAllotted(
      String selectedServiceId, String clientApplicableServiceId) async {
    nonAllottedTaskList.clear();
    try {
      TimesheetTaskListData? response =
          (await repository.getTimesheetNonAllottedNewTaskList(
              selectedServiceId, clientApplicableServiceId));

      if (response.success!) {
        if (response.timesheetTaskDetailsData!.isEmpty) {
          selectedNonAllottedClientIdList.clear();
          selectedNonAllottedServiceIdList.clear();
          selectedNonAllottedClientIdServiceIdList.clear();
        } else {
          nonAllottedTaskList.addAll(response.timesheetTaskDetailsData!);
        }
        loaderNonAllottedForTask = false;
        update();
      } else {
        loaderNonAllottedForTask = false;
        update();
      }
    } on CustomException {
      loaderNonAllottedForTask = false;
      update();
    } catch (error) {
      loaderNonAllottedForTask = false;
      update();
    }
  }

  TextEditingController nonAllottedDetailsController = TextEditingController();
  String selectedNonAllottedTime = "";
  List<String> nonAllottedDetailsList = [];
  List<String> nonAllottedTimeList = [];

  ///office
  List<TypeOfWorkList> workList = [];
  TextEditingController officeDetailsController = TextEditingController();
  List<String> officeWorkIdList = [];
  List<String> officeWorkNameList = [];
  List<String> officeDetailsList = [];
  List<String> officeTimeList = [];
  String selectedOfficeWorkId = "";
  String selectedOfficeWorkName = "";
  String selectedOfficeTime = "";

  ///type of work
  void callTimesheetTypeOfWork() async {
    workList.clear();
    try {
      TypeOfWorkModel? response = (await repository.getTimesheetTypeOfWork());
      if (response.success!) {
        updateLoader(false);
        if (response.typeOfWorkList!.isNotEmpty) {
          workList.addAll(response.typeOfWorkList!);
        }
        update();
      } else {
        updateLoader(false);
        update();
      }
      update();
    } on CustomException {
      updateLoader(false);
      update();
    } catch (error) {
      updateLoader(false);
      update();
    }
  }

  ///type of work
  addOfficeWorkNameAndId(String id, String name) {
    selectedOfficeWorkId = id;
    selectedOfficeWorkName = name;
    officeWorkIdList.add(id);
    officeWorkNameList.add(name);
    update();
  }

  onOfficeWorkType(String val) {
    selectedOfficeWorkName = val;
    update();
  }

  checkValidationForOffice(BuildContext context) {
    if (selectedOfficeWorkName == "") {
      Utils.showErrorSnackBar("Please select work type!");
      update();
    } else if (officeDetailsController.text.isEmpty) {
      Utils.showErrorSnackBar("Please add details!");
      update();
    } else if (selectedOfficeTime == "") {
      Utils.showErrorSnackBar("Please select time!");
      update();
    } else {
      showConfirmationDialogForOffice(context);
      update();
    }
    // showConfirmationDialogForOffice(context);
    // update();
  }

  showConfirmationDialogForOffice(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setter) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 100.0,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildTextRegularWidget(
                        "Do you want to add more ?", blackColor, context, 16.0,
                        align: TextAlign.left),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              setter(() {
                                Navigator.of(context).pop();
                                cbOffice = true;
                                selectedOfficeWorkName = "";
                                officeDetailsController.clear();
                                selectedOfficeTime = "";
                                callTimesheetTypeOfWork();
                                saveOfficeRelated();
                              });
                            },
                            child: buildButtonWidget(context, "Yes",
                                height: 40.0, buttonColor: approveColor),
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              setter(() {
                                Navigator.of(context).pop();
                                cbOffice = false;
                                //nextFromNonAllottedOrOffice();
                                nextFromOffice(false);
                                update();
                              });
                            },
                            child: buildButtonWidget(context, "No",
                                height: 40.0, buttonColor: errorColor),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  String removeFirstOfficeDetailsListBracket = "";
  String removeSecondOfficeDetailsListBracket = "";
  String removeFirstOfficeTimeListBracket = "";
  String removeSecondOfficeTimeListBracket = "";
  String removeFirstOfficeWorkIdListBracket = "";
  String removeSecondOfficeWorkIdListBracket = "";
  String removeFirstOfficeWorkNameListBracket = "";
  String removeSecondOfficeWorkNameListBracket = "";
  String removeFirstOfficeAddedTimeListBracket = "";
  String removeSecondOfficeAddedTimeListBracket = "";

  saveOfficeRelated() {
    officeDetailsList.add(officeDetailsController.text);
    officeTimeList.add(selectedOfficeTime);

    removeFirstOfficeDetailsListBracket =
        officeDetailsList.toString().replaceAll("[", "");
    removeSecondOfficeDetailsListBracket =
        removeFirstOfficeDetailsListBracket.replaceAll("]", "");

    removeFirstOfficeTimeListBracket =
        officeTimeList.toString().replaceAll("[", "");
    removeSecondOfficeTimeListBracket =
        removeFirstOfficeTimeListBracket.replaceAll("]", "");

    removeFirstOfficeWorkIdListBracket =
        officeWorkIdList.toString().replaceAll("[", "");
    removeSecondOfficeWorkIdListBracket =
        removeFirstOfficeWorkIdListBracket.replaceAll("]", "");

    removeFirstOfficeWorkNameListBracket = officeWorkNameList.toString().replaceAll("[", "");
    removeSecondOfficeWorkNameListBracket = removeFirstOfficeWorkNameListBracket.replaceAll("]", "");

    removeFirstOfficeAddedTimeListBracket = officeAddedTime.toString().replaceAll("[", "");
    removeSecondOfficeAddedTimeListBracket = removeFirstOfficeAddedTimeListBracket.replaceAll("]", "");

    clearOfficeRelated();
    update();
  }

  clearOfficeRelated() {
    selectedOfficeWorkId = "";
    selectedOfficeWorkName = "";
    officeDetailsController.clear();
    selectedOfficeTime = "";
    officeAddedTime.clear();

    if (cbOffice == false) {
      currentService = "";
      continued();
      update();
    } else {}

    updateLoader(false);
    update();
  }

  String officeAction = "";
  void callSaveOffice() async {
    try {
      ApiResponse? response = (await repository.getTimesheetAddOfficeRelated(
          selectedDateToSend,
          removeSecondOfficeWorkIdListBracket,
          removeSecondOfficeDetailsListBracket,
          removeSecondOfficeAddedTimeListBracket,
          officeAction));
      if (response.success!) {
        Utils.showSuccessSnackBar("Office ${response.message}");
        updateLoader(false);
        isLoadingForStepper3 =false;

        finalDetails="";finalClientId="";finalService="";
        finalClientApplicableService="";finalTaskId=""; finalTimeSpent="";

        update();
        Get.offAllNamed(AppRoutes.bottomNav);
      } else {
        Utils.showErrorSnackBar(response.message);
        isLoadingForStepper3 =false;
        finalDetails="";finalClientId="";finalService="";
        finalClientApplicableService="";finalTaskId=""; finalTimeSpent="";
        updateLoader(false);
        update();
      }
      updateLoader(false);
      update();
    } on CustomException catch (e) {
      finalDetails="";finalClientId="";finalService="";
      finalClientApplicableService="";finalTaskId=""; finalTimeSpent="";
      Utils.showErrorSnackBar(e.getMsg());isLoadingForStepper3 =false;
      updateLoader(false);
      update();
    } catch (error) {
      finalDetails="";finalClientId="";finalService="";
      finalClientApplicableService="";finalTaskId=""; finalTimeSpent="";
      Utils.showErrorSnackBar(error.toString());isLoadingForStepper3 =false;
      updateLoader(false);
      update();
    }
  }

  ///previous click
  goToPreviousFromStepper3() {
    print("currentService");
    print(currentService);
    if (stepsList.contains("Office")) {
      showOffice = true;
      cbOffice=true;
      currentService = "office";
      print("if currentService");
      print(currentService);
      callTimesheetTypeOfWork();
      cancel();
      update();
    } else if (stepsList.contains("Non Allotted")) {
      cbNonAllotted=true;
      currentService = "nonAllotted";
      print("else if currentService");
      print(currentService);
      callEmployeeList();
      cancel();
      update();
    } else if (stepsList.contains("Allotted")) {
      currentService = "allotted";
      callEmployeeList();
      print("else if allo currentService");
      print(currentService);
      cancel();
      update();
    } else {
      currentStep = 1;
      print("else");
      print(currentService);
      cancel();
      update();
    }
    update();
  }

  goToPreviousFromOffice() {
    if (stepsList.contains("Non Allotted")) {
      showOffice = false;
      currentService = "nonAllotted";
      callEmployeeList();
      currentStep = 1;
      update();
    } else if (stepsList.contains("Allotted")) {
      showOffice = false;
      currentService = "allotted";
      callEmployeeList();
      currentStep = 1;
      update();
    } else {
      cancel();
      update();
    }
    update();
  }

  goToPreviousFromNonAllotted() {
    if (stepsList.contains("Allotted")) {
      currentService = "allotted";

      if (stepsList.contains("Non Allotted")) {
        cbNonAllotted = true;
        update();
      }
      else{
        cbNonAllotted = false;
      }
      update();
    } else {
      cancel();
    }
    update();
  }

  goToPreviousFromAllotted() {
    cancel();
    update();
  }

  ///common

  onWillPopBackTimesheetList() {
    Get.offAllNamed(AppRoutes.bottomNav);
    update();
  }

  continued({bool nextFromOffice = false}) {
    currentStep < 2 ? currentStep += 1 : null;
    //currentStep == 2 ? nextFromOffice == true ? calculateTimeDifference() : null : null;
    calculateTimeDifference();
    update();
  }

  cancel() {
    currentStep > 0 ? currentStep -= 1 : null;
    update();
  }

  tapped(int step) {
    currentStep = step;
    update();
  }

  updateLoader(bool val) {
    loader = val;
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
