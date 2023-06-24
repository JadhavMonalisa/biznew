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
  TimesheetNewFormController({required this.repository}) : assert(repository != null);

  ///common
  String userId="";
  String userName="";
  String name="";
  bool loader = false;
  DateTime todayDate = DateTime.now();

  ///employee list
  List<ClientListData> allottedEmployeeList = [];
  static List<ClientListData> item = [];
  List<ClientListData> allottedTimesheetSelectedEmpList = [];
  List<TimesheetServicesListData> allottedTimesheetSelectedServiceList = [];
  List<String> allottedTimesheetSelectedMultipleEmpIdList = [];
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
  TimeOfDay selectedTimeForCalculation = const TimeOfDay(hour: 24,minute: 0);
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
  Duration? difference;
  String totalTimeToShow = "";
  String selectedWorkAt = "";
  List<String> noDataList = ["No Data Found!"];
  List<String> workAtList = ["Office","Client Location","Work From Home","Govt. Department"];
  //static List<String> workAtItems = [];
  List<MultiSelectItem<String>> workAtItems = [];

  ///stepper two
  List<TimesheetServicesListData> allottedServiceList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userId = GetStorage().read("userId")??"";
    userName = GetStorage().read("userName")??"";
    name = GetStorage().read("name")??"";
    repository.getData();

    selectedDateToShow = "${todayDate.day}-${todayDate.month}-${todayDate.year}";
    selectedDateToSend = "${todayDate.year}-${todayDate.month}-${todayDate.day}";

    workAtItems = workAtList
        .map((value) => MultiSelectItem<String>(value, value))
        .toList();

    callEmployeeList();
  }

  //--------------------------------------Stepper One------------------------------------------//

  updateSelectedWorkAt(String value){
    selectedWorkAt = value;
    if(selectedWorkAt==""){validateWorkAt=true;update();}
    else{validateWorkAt=false;update();}
  }

  onSelectionForMultipleWorkAt(List<String> workAtList){
    updateLoader(true);
    timesheetSelectedWorkAt = workAtList;
    for (var element in workAtList) {
      removeFirstBracketFromWorkAt = timesheetSelectedWorkAt.toString().replaceAll("[", "");
      removeSecondBracketFromWorkAt = removeFirstBracketFromWorkAt.replaceAll("]", "");
      update();
    }
    validateWorkAt = false;
  }

  onDeleteMultipleWorkAt(String value){
    updateLoader(true);
    timesheetSelectedWorkAt.remove(value);
    removeFirstBracketFromWorkAt = timesheetSelectedWorkAt.toString().replaceAll("[", "");
    removeSecondBracketFromWorkAt = removeFirstBracketFromWorkAt.replaceAll("]", "");
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1700, 1),
        lastDate: DateTime(2100, 1));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
    selectedDateToShow = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
    selectedDateToSend = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
    validateStartDate = false; validateStartDate = false;
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

  Future<void> selectTime(BuildContext context,String timeFor) async {
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
      timeFor == "start" ? selectedStartTime24 = picked :
      timeFor == "end" ? selectedEndTime24 = picked :
      selectedTime = picked;
      Utils.dismissKeyboard();
      update();
    }
    if(timeFor == "start"){
      //selectedStartTime24 = selectedTime;
      selectedStartTimeToShow = "${selectedStartTime24.hour}:${selectedStartTime24.minute}";
      stepper1InTime.text = selectedStartTimeToShow;
      stepper1InTime.text.isEmpty ? validateInTime = true : validateInTime = false;update();

      ///difference
      calculateTotalTime();
      Utils.dismissKeyboard();
      update();
    }
    else if(timeFor=="end"){
      selectedEndTimeToShow = "${selectedEndTime24.hour}:${selectedEndTime24.minute}";
      stepper1OutTime.text = selectedEndTimeToShow;

      if(selectedEndTime24.hour < selectedStartTime24.hour){
        validateOutTime = true; update();
      }
      else{
        validateOutTime = false;
        ///difference
        calculateTotalTime();
        update();
      }
      Utils.dismissKeyboard();
      update();
    }
    else if (timeFor == "office"){
      selectedOfficeTime = "${selectedTime.hour}:${selectedTime.minute}";

      hrOfficeList.add(selectedTime.hour);
      minOfficeList.add(selectedTime.minute);

      hrOfficeSum = hrOfficeList.reduce((a, b) => a + b);
      minOfficeSum = minOfficeList.reduce((a, b) => a + b);

      if(minOfficeSum>=60){
        remainingFromMinOffice = minOfficeSum ~/ 60;
        minOfficeSum = minOfficeSum % 60;
      }

      hrOfficeSum = hrOfficeSum + remainingFromMinOffice;

      print("hrOfficeSum");
      print(hrOfficeSum);
      Utils.dismissKeyboard();
      update();
    }
    else if (timeFor == "nonAllotted"){
      selectedNonAllottedTime = "${selectedTime.hour}:${selectedTime.minute}";

      hrNonAllottedList.add(selectedTime.hour);
      minNonAllottedList.add(selectedTime.minute);

      hrNonAllottedSum = hrNonAllottedList.reduce((a, b) => a + b);
      minNonAllottedSum = minNonAllottedList.reduce((a, b) => a + b);

      if(minNonAllottedSum>=60){
        remainingFromMinNonAllotted = minNonAllottedSum ~/ 60;
        minNonAllottedSum = minNonAllottedSum % 60;
      }

      hrNonAllottedSum = hrNonAllottedSum + remainingFromMinNonAllotted;

      print("hrNonAllottedSum");
      print(hrNonAllottedSum);
      update();
    }
    Utils.dismissKeyboard();
    update();
  }

  checkTotalTimeValidation(){
    if(timesheetTotalTime.text.isEmpty){validateTotalTime=true;update();}
    else{validateTotalTime=false;update();}
  }

  calculateTotalTime(){
    var format = DateFormat("HH:mm");
    var one = format.parse(stepper1InTime.text);
    var two = format.parse(stepper1OutTime.text);
    difference = two.difference(one);
    totalTimeToShow = "${difference!.inHours}:${difference!.inMinutes.remainder(60)}";
    timesheetTotalTime.text = totalTimeToShow;
    update();
  }

  //--------------------------------------Stepper Two------------------------------------------//

  bool cbNonAllotted = false;
  bool cbOffice = false;
  bool isFillTimesheetSelected = false;
  List<TimesheetNewModel> totalSelectionList = [];
  List<TimesheetNewModel> timesheetNewModelList = [];
  String currentService = "allotted";
  bool showOffice = false;
  bool isAddingMoreAllotted = false;

  ///allotted employee list
  void callEmployeeList() async {
    allottedEmployeeList.clear();
    updateLoader(true);
    try {
      TimesheetClientListModel? response = (await repository.getTimesheetClientNameList());

      if (response.success!) {
        if (response.data!.isEmpty) {
        }
        else{
          allottedEmployeeList.addAll(response.data!);
          items = allottedEmployeeList
              .map((value) => MultiSelectItem<ClientListData>(value, value.firmClientFirmName!))
              .toList();

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

  onSelectionForMultipleEmployee(List<ClientListData> selectedEmpListFromDesign){
    updateLoader(true);
    //allottedTimesheetSelectedServiceList.clear();
    allottedTimesheetSelectedEmpList.clear();
    //detailsControllerList.clear();
    //timesheetTaskListData.clear();
    allottedTimesheetSelectedEmpList = selectedEmpListFromDesign;

    for (var element in allottedTimesheetSelectedEmpList) {
      callServiceListForAllotted(element.firmClientId!,element.firmClientFirmName!);
    }

    // for (var element in selectedEmpListFromDesign) {
    //   allottedTimesheetSelectedMultipleEmpIdList.add(element.id!);
    //   update();
    // }
    update();
  }

  onDeleteMultipleEmployee(ClientListData value){
    updateLoader(true);
    allottedServiceList.clear();
    allottedTimesheetSelectedServiceList.clear();
    allottedTimesheetSelectedEmpList.remove(value);
    allottedTimesheetSelectedMultipleEmpIdList.remove(value.id!);
    removeFirstBracket = allottedTimesheetSelectedMultipleEmpIdList.toString().replaceAll("[", "");
    removeSecondBracket = removeFirstBracket.replaceAll("]", "");

    for (var element in allottedTimesheetSelectedEmpList) {
      callServiceListForAllotted(element.firmClientId!,element.firmClientFirmName!);
    }

    update();
  }

  List<TimesheetListData> addedAllTimesheetData = [];
  List<String> allottedClientApplicableServiceIdList = [];

  /// allotted service list
  void callServiceListForAllotted(String selectedClientId,String selectedClient) async {
    //allottedServiceList.clear();
    //allottedTimesheetSelectedEmpList.clear();
    try {
      TimesheetServiceListModel? response = (await repository.getTimesheetServicesList(selectedClientId));

      if (response.success!) {
        if (response.data!.isEmpty) {
        }
        else{
          //serviceList.addAll(response.data!);

          for (var element in response.data!) {
            allottedServiceList.add(TimesheetServicesListData(
                id: element.id,
                serviceId: element.serviceId,
                selectedClientId: selectedClientId,
                serviceName: element.serviceName,
                selectedClientName: selectedClient,
                period: element.period,
                serviceDueDatePeriodicity: element.serviceDueDatePeriodicity
            ));
          }

          serviceItems = allottedServiceList
              .map((value) => MultiSelectItem<TimesheetServicesListData>(value, value.serviceName!))
              .toList();
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
  /// allotted task list
  List<TimesheetTaskListData> taskList = [];
  List<TextEditingController> detailsControllerList = [];
  List<TextEditingController> timeSpentControllerList = [];
  List<String> timeSpentList = [];
  List<String> taskIdList = [];
  List<String> addedAllottedStatusNameList = [];

  List<TimesheetTaskListData> timesheetTaskListData = [];
  int totalTaskLength = 0;

  void callTaskListForAllotted(String selectedServiceId,String clientApplicableServiceId,
      String serviceName,String clientId,String clientName) async {
    //taskList.clear();
    try {
      TimesheetTaskListData? response = (await repository.getTimesheetNewTaskList(selectedServiceId,clientApplicableServiceId));

      if (response.success!) {
        if (response.timesheetTaskDetailsData!.isEmpty) {
        }

        else{
          timesheetTaskListData.add(TimesheetTaskListData(
            timesheetTaskDetailsData: response.timesheetTaskDetailsData,
            clientName: clientName,
            clientId: clientId,
            serviceName: serviceName,
            serviceId: selectedServiceId,
            message: response.message,
            success: response.success,
          ));

          totalTaskLength = response.timesheetTaskDetailsData!.length;


          for (var element in response.timesheetTaskDetailsData!) {
            TimesheetTaskDetailsData(testTaskDetails: TextEditingController(text: ""));
          }

          for (var element in response.timesheetTaskDetailsData!) {
            detailsControllerList.add(TextEditingController(text: ""));
            timeSpentControllerList.add(TextEditingController(text: ""));
            timeSpentList.add("");
            addedAllottedStatusNameList.add("");
            taskIdList.add(element.taskId!);

            allottedTimesheetSelectedMultipleServiceIdList.add(selectedServiceId);
            allottedClientApplicableServiceIdList.add(clientApplicableServiceId);
            allottedTimesheetSelectedMultipleEmpIdList.add(clientId);
          }

          // for (var element in allottedTimesheetSelectedEmpList) {
          //   allottedTimesheetSelectedMultipleEmpIdList.add(element.id!);
          // }

          print("totalTaskLength before");
          print(totalTaskLength);

          totalTaskLength = totalTaskLength + timesheetTaskListData.length;
          print("totalTaskLength after");
          print(totalTaskLength);
        }

        clientAppServiceId = clientApplicableServiceId;

        // for (var element in response.timesheetTaskDetailsData!) {
        //   callStatusList(element.taskId!,clientApplicableServiceId);
        // }

        for (var element in taskIdList) {
          callStatusList(element,clientApplicableServiceId);
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

  List<StatusList> statusList = [];
  List<StatusList> statusListToShow = [];
  List<String> allottedStartedStatusList = ["Inprocess","Awaiting for Client Input","Submitted for Checking","Put on Hold","Completed","Cancel","Sent for rework"];
  String selectedAllottedStatus = "";
  List<int> addedAllottedStatus = [];
  TextEditingController allottedStatusRemarkText = TextEditingController();

  updateSelectedAllottedStatus(BuildContext context,String val,int index){
    selectedAllottedStatus = val;
    selectedTaskId = taskIdList[index];//to pass for remark

    print("selectedTaskId");
    print(selectedTaskId);
    print(selectedTaskId);
    if(selectedAllottedStatus == "Inprocess" || selectedAllottedStatus == "Completed" || selectedAllottedStatus == "Sent for rework"){
      if(addedAllottedStatus.contains(index)){
        addedAllottedStatus.remove(index);
        update();
      }
      else{
        addedAllottedStatus.add(index);
        update();
      }

      if(addedAllottedStatusNameList.asMap().containsKey(index)){
        addedAllottedStatusNameList.removeAt(index);
        addedAllottedStatusNameList.insert(index, val);
        update();
      }
      else{
        addedAllottedStatusNameList.add(val);
        update();
      }

      update();
    }
    else {
      showStatusRemarkDialog(context,index,val);
      update();
    }

    update();
  }

  bool validateRemark = false;
  showStatusRemarkDialog(BuildContext context,int index,String val){
    showDialog(
      barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return StatefulBuilder(builder: (context,setter){
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 180.0,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildTextRegularWidget("Remark", blackColor, context, 20,align: TextAlign.left),const SizedBox(height: 10.0,),
                    const SizedBox(height: 20.0,),
                    const Divider(color: Colors.grey,),
                    const SizedBox(height: 10.0,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        color: textFormBgColor,
                        border: Border.all(color: textFormBgColor),),
                      child: TextFormField(
                        controller: allottedStatusRemarkText,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.left,
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.done,
                        onTap: () {},
                        style:const TextStyle(fontSize: 15.0),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: "Enter remark",
                          hintStyle: GoogleFonts.rubik(textStyle: TextStyle(
                            color: subTitleTextColor, fontSize: 15,),),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        onChanged: (text) {
                          setter((){
                            checkRemarkValidation();
                          });
                        },
                      ),
                    ),
                    validateRemark == true
                        ? ErrorText(errorMessage: "Please enter valid remark",)
                        : const Opacity(opacity: 0.0),
                    Row(
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: (){
                              setter((){
                                allottedStatusRemarkText.clear();
                                Navigator.pop(context);
                              });
                            },
                            child: buildButtonWidget(context, "Close"),
                          ),
                        ),const SizedBox(width: 5.0,),
                        Flexible(
                          child: GestureDetector(
                            onTap: (){
                              if(addedAllottedStatus.contains(index)){
                                addedAllottedStatus.remove(index);
                                update();
                              }
                              else{
                                addedAllottedStatus.add(index);
                                update();
                              }

                              if(addedAllottedStatusNameList.asMap().containsKey(index)){
                                addedAllottedStatusNameList.removeAt(index);
                                addedAllottedStatusNameList.insert(index, val);
                                update();
                              }
                              else{
                                addedAllottedStatusNameList.add(val);
                                update();
                              }

                              callTimesheetUpdate(context);
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
  checkRemarkValidation(){
    if(allottedStatusRemarkText.text.isEmpty){
      validateRemark = true;update();
    }
    else{
      validateRemark = false;update();
    }
  }

  String clientAppServiceId = "" ;
  String selectedTaskId = "";

  void callTimesheetUpdate(BuildContext context) async {
    try {
      ApiResponse? response = (await repository.getTimesheetStatusUpdate(
          clientAppServiceId,selectedTaskId,allottedStatusRemarkText.text,"statusStart"));
      if (response.success!) {
        if (context.mounted) Navigator.pop(context);
        Utils.showSuccessSnackBar(response.message);
        updateLoader(false);
        update();
      } else {
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
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
  void callStatusList(String taskId,String clientApplicableServiceId) async {
    try {
      TimesheetStatusModel? response = (await repository.getTimesheetStatusList(clientApplicableServiceId,taskId));

      if (response.success!) {
        if (response.list!.isEmpty) {
        }
        else{
          //statusList.addAll(response.list!);
          for (var element in response.list!) {
            statusList.add(StatusList(
              taskId: taskId,
              id: element.id,
              name: element.name,
            ));
          }
          checkStartList.add(response.start!);
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

  /// start timesheet
  void callTimesheetStart(BuildContext context,String clientApplicableIdToStart,String selectedTaskIdToStart) async {
    try {
      ApiResponse? response = (await repository.getTimesheetStart(clientApplicableIdToStart,selectedTaskIdToStart));
      if (response.success!) {
        callStatusList(selectedTaskIdToStart, clientApplicableIdToStart);
        Utils.showSuccessSnackBar(response.message);
        updateLoader(false);
        update();
      } else {
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
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

  onSelectionForMultipleService(List<TimesheetServicesListData> selectedServiceListFromDesign){
    updateLoader(true);

    allottedTimesheetSelectedServiceList = selectedServiceListFromDesign;

    print("allottedTimesheetSelectedServiceList.length");
    print(allottedTimesheetSelectedServiceList.length);
    for (var element in allottedTimesheetSelectedServiceList) {
      callTaskListForAllotted(element.serviceId!,element.id!,element.serviceName!,
          element.selectedClientId!,element.selectedClientName!);
    }

    // for (var element in selectedServiceListFromDesign) {
    //   allottedTimesheetSelectedMultipleServiceIdList.add(element.serviceId!);
    //   removeFirstBracketForService = allottedTimesheetSelectedMultipleServiceIdList.toString().replaceAll("[", "");
    //   removeSecondBracketForService = removeFirstBracketForService.replaceAll("]", "");
    //
    //   allottedClientApplicableServiceIdList.add(element.id!);
    //   removeFirstBracketForClientApplicableService = allottedClientApplicableServiceIdList.toString().replaceAll("[", "");
    //   removeSecondBracketForClientApplicableService = removeFirstBracketForClientApplicableService.replaceAll("]", "");
    //
    //   update();
    // }
  }

  onDeleteMultipleService(TimesheetServicesListData value){
    updateLoader(true);
    print("value");
    print(value.serviceName);
    fillTimesheet();
    timesheetTaskListData.clear();
    //allottedTimesheetSelectedEmpList.clear();
    //detailsControllerList.clear();
    print(taskList.length);

    //timesheetTaskListData.remove(value);
    allottedTimesheetSelectedServiceList.remove(value);
    allottedTimesheetSelectedMultipleServiceIdList.remove(value.serviceId!);
    removeFirstBracketForService = allottedTimesheetSelectedMultipleServiceIdList.toString().replaceAll("[", "");
    removeSecondBracketForService = removeFirstBracketForService.replaceAll("]", "");

    allottedClientApplicableServiceIdList.remove(value.id!);
    removeFirstBracketForClientApplicableService = allottedClientApplicableServiceIdList.toString().replaceAll("[", "");
    removeSecondBracketForClientApplicableService = removeFirstBracketForClientApplicableService.replaceAll("]", "");

    taskList.removeWhere((element) => value.serviceId==element.serviceId);

    for (var element in allottedTimesheetSelectedServiceList) {
      callTaskListForAllotted(element.serviceId!,element.id!,element.serviceName!,
          element.selectedClientId!,element.selectedClientName!);
    }
    update();
  }

  updateNonAllottedCheckBox(bool selectNonAllotted){
    if(selectNonAllotted){
      stepsList.add("Non Allotted"); update();
    }

    cbNonAllotted = selectNonAllotted;
    update();
  }

  updateOfficeCheckBox(bool selectOffice){
    if(selectOffice){
      stepsList.add("Office"); update();
    }

    cbOffice = selectOffice; update();
  }

  fillTimesheet(){
    if(allottedTimesheetSelectedEmpList.isEmpty){
      Utils.showErrorSnackBar("Please select employee"); update();
    }
    else if(allottedTimesheetSelectedServiceList.isEmpty){
      Utils.showErrorSnackBar("Please select service"); update();
    }
    else{
      isFillTimesheetSelected = true; update();
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

  Future<void> selectTimeForTask(BuildContext context,int index) async {
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

      timeSpentList.removeAt(index);
      timeSpentList.insert(index,selectedStartTimeToShow);

      // if(allottedLocalStoreTimeSpentList.isEmpty){
      //   allottedLocalStoreTimeSpentList.add(selectedStartTimeToShow);
      // }
      // else{
      //   allottedLocalStoreTimeSpentList.removeAt(allottedLocalStoreTimeSpentList.length+index);
      //   allottedLocalStoreTimeSpentList.insert(allottedLocalStoreTimeSpentList.length+index,selectedStartTimeToShow);
      // }

      if(isAddingMoreAllotted = true){
        index = hrList.length + index;
      }
      else{
        index = index;
      }

      print("index");
      print(index);

      if (hrList.asMap().containsKey(index)) {
        hrList.removeAt(index);
        hrList.insert(index,selectedTime.hour);
        minList.removeAt(index);
        minList.insert(index,selectedTime.minute);
      } else {
        hrList.add(selectedTime.hour);
        minList.add(selectedTime.minute);
      }

      hrSum = hrList.reduce((a, b) => a + b);
      minSum = minList.reduce((a, b) => a + b);

      if(minSum>=60){
        remainingFromMin = minSum ~/ 60;
        minSum = minSum % 60;
      }

      hrSum = hrSum + remainingFromMin;
      print("hrList.length");
      print(hrList.length);
      print(hrList);

      Utils.dismissKeyboard();
      update();
    }

    update();
  }

  showConfirmationDialog(BuildContext context){
    showDialog(
      barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return StatefulBuilder(builder: (context,setter){
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 100.0,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    buildTextRegularWidget("Do you want to add more ?", blackColor, context, 16.0,align: TextAlign.left),
                    const Divider(color: Colors.grey,),
                    const SizedBox(height: 10.0,),

                    Row(
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: (){
                              setter((){
                                Navigator.of(context).pop();

                                if(currentService == "allotted") {
                                  stepsList.add("Allotted");
                                  saveCurrentAllottedList();
                                }
                                else{
                                  currentService = "nonAllotted";
                                  saveCurrentNonAllottedList();
                                }
                              });
                            },
                            child: buildButtonWidget(context, "Yes",height: 40.0,buttonColor: approveColor),
                          ),
                        ),const SizedBox(width: 5.0,),
                        Flexible(
                          child: GestureDetector(
                            onTap: (){
                              setter((){
                                Navigator.of(context).pop();
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
                            child: buildButtonWidget(context, "No",height: 40.0,buttonColor: errorColor),
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

  List<TimesheetTaskDetailsData> allottedLocalStoreTaskList =[];
  List<String> allottedLocalStoreDetailsList =[];
  List<String> allottedLocalStoreTimeSpentList =[];
  List<String> allottedLocalStoreStatusList =[];

  checkValidationForAllotted(BuildContext context){
    if(allottedTimesheetSelectedEmpList.isEmpty){
      Utils.showErrorSnackBar("Please select employee!"); update();
    }
    else if(allottedTimesheetSelectedServiceList.isEmpty){
      Utils.showErrorSnackBar("Please select service!"); update();
    }
    else if(timesheetTaskListData.isEmpty){
      Utils.showErrorSnackBar("Please select task!"); update();
    }
    // ignore: iterable_contains_unrelated_type
    else if(detailsControllerList.isEmpty || detailsControllerList.contains("")){
      Utils.showErrorSnackBar("Please fill all task details!"); update();
    }
    else if(timeSpentList.contains("")){
      Utils.showErrorSnackBar("Please fill all task time spent!"); update();
    }
    else{
      showConfirmationDialog(context);
      update();
    }
  }

  String removeFirstDetailsBracket="";
  String removeSecondDetailsBracket="";
  String removeFirstTimeSpentBracket="";
  String removeSecondTimeSpentBracket="";
  String removeFirstStatusBracket="";
  String removeSecondStatusBracket="";
  String removeFirstTaskIdListBracket="";
  String removeSecondTaskIdListBracket="";

  saveCurrentAllottedList(){
    updateLoader(true);
    for (var element in timesheetTaskListData) {
      allottedLocalStoreTaskList = element.timesheetTaskDetailsData!;
    }

    for (var element in detailsControllerList) {
      if(element.text==""){

      }
      else{
        allottedLocalStoreDetailsList.add(element.text);
      }
    }

    for (var element in timeSpentList) {
      if(element==""){

      }
      else{
        allottedLocalStoreTimeSpentList.add(element);
      }
    }

    for (var element in allottedLocalStoreTimeSpentList) {
      if(element==""){

      }
      else{
        //allottedLocalStoreTimeSpentList.add(element);
        print("test allottedLocalStoreTimeSpentList");
        print(allottedLocalStoreTimeSpentList);
      }
    }

    for (var element in addedAllottedStatusNameList) {
      if(element==""){

      }
      else{
        allottedLocalStoreStatusList.add(element);
      }
    }

    removeFirstDetailsBracket = allottedLocalStoreDetailsList.toString().replaceAll("[", "");
    removeSecondDetailsBracket = removeFirstDetailsBracket.replaceAll("]", "");

    removeFirstTimeSpentBracket = allottedLocalStoreTimeSpentList.toString().replaceAll("[", "");
    removeSecondTimeSpentBracket = removeFirstTimeSpentBracket.replaceAll("]", "");

    removeFirstTaskIdListBracket = taskIdList.toString().replaceAll("[", "");
    removeSecondTaskIdListBracket = removeFirstTaskIdListBracket.replaceAll("]", "");

    removeFirstBracket = allottedTimesheetSelectedMultipleEmpIdList.toString().replaceAll("[", "");
    removeSecondBracket = removeFirstBracket.replaceAll("]", "");

    removeFirstBracketForService = allottedTimesheetSelectedMultipleServiceIdList.toString().replaceAll("[", "");
    removeSecondBracketForService = removeFirstBracketForService.replaceAll("]", "");

    removeFirstBracketForClientApplicableService = allottedClientApplicableServiceIdList.toString().replaceAll("[", "");
    removeSecondBracketForClientApplicableService = removeFirstBracketForClientApplicableService.replaceAll("]", "");

    removeFirstBracket = allottedTimesheetSelectedMultipleEmpIdList.toString().replaceAll("[", "");
    removeSecondBracket = removeFirstBracket.replaceAll("]", "");

    print("allottedLocalStoreDetailsList");
    print(removeSecondDetailsBracket);
    print("allottedLocalStoreTimeSpentList");
    print(allottedLocalStoreTimeSpentList);
    print("allottedLocalStoreStatusList");
    print(allottedLocalStoreStatusList);
    print("removeSecondBracketForService");
    print(removeSecondBracketForService);
    print("removeSecondBracketForClientApplicableService");
    print(removeSecondBracketForClientApplicableService);
    print("removeSecondBracket client id");
    print(removeSecondBracket);
    clearAllotted();
    update();
  }

  clearAllotted(){
    timesheetTaskListData.clear();
    detailsControllerList.clear();
    timeSpentControllerList.clear();
    timeSpentList.clear();
    taskIdList.clear();
    statusList.clear();
    addedAllottedStatusNameList.clear();

    allottedEmployeeList.clear();
    allottedTimesheetSelectedEmpList.clear();
    items.clear();
    allottedServiceList.clear();
    allottedTimesheetSelectedServiceList.clear();
    serviceItems.clear();

    if(currentService == "allotted"){
      isAddingMoreAllotted = true;
      callEmployeeList();
    }
    else if(cbNonAllotted == true && cbOffice == true){
      currentService = "nonAllotted";
      callEmployeeList();
      update();
    }
    else if(cbNonAllotted == true && cbOffice == false){
      currentService = "nonAllotted";callEmployeeList(); update();
    }
    else if(cbNonAllotted == false && cbOffice == true){
      currentService = "office"; callTimesheetTypeOfWork(); showOffice = true; update();
    }
    else if(cbNonAllotted == false && cbOffice == false){
      currentService = ""; continued(); update();
    }

    updateLoader(false);
    update();
  }

  checkValidationForStepper1(){
    if(selectedDateToShow=="" || timesheetSelectedWorkAt.isEmpty ||  stepper1InTime.text.isEmpty
        || stepper1OutTime.text.isEmpty || timesheetTotalTime.text.isEmpty){

      selectedDateToShow=="" ? validateStartDate=true: validateStartDate=false;
      timesheetSelectedWorkAt.isEmpty ? validateWorkAt=true: validateWorkAt=false;
      stepper1InTime.text.isEmpty ? validateInTime=true: validateInTime=false;
      stepper1OutTime.text.isEmpty ? validateOutTime=true: validateOutTime=false;

      updateLoader(false);
      print("if");
      update();
    }
    else{
      callTimesheetCheck();
      update();
    }
  }

  /// check timesheet
  void callTimesheetCheck() async {
    try {
      CheckTimesheetApiResponse? response = (await repository.getTimesheetCheck(selectedDateToSend));

      print("response");
      print(response);
      if (response.success!) {

        callTimesheetAdd();
        updateLoader(false);
        update();
      } else {
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
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
  /// add timesheet
  void callTimesheetAdd() async {
    try {
      ApiResponse? response = (await repository.getTimesheetAdd(selectedDateToSend,stepper1InTime.text,
          stepper1OutTime.text,timesheetTotalTime.text,selectedWorkAt));
      if (response.success!) {
        Utils.showSuccessSnackBar(response.message);
        updateLoader(false);
        continued();
        update();
      } else {
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
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

  callApiToSaveAll(){
    if(removeSecondNonAllottedDetailsListBracket==""){
      removeSecondDetailsBracket = removeSecondDetailsBracket.replaceAll(", ", ",");
    }
    else{
      removeSecondDetailsBracket = "${removeSecondDetailsBracket.replaceAll(", ", ",")},${removeSecondNonAllottedDetailsListBracket.replaceAll(", ", ",")}";
    }
    if(removeSecondNonAllottedClientIdListBracket==""){
      removeSecondBracket = removeSecondBracket.replaceAll(", ", ",");
    }
    else{
      removeSecondBracket = "${removeSecondBracket.replaceAll(", ", ",")},${removeSecondNonAllottedClientIdListBracket.replaceAll(", ", ",")}";
    }
    if(removeSecondNonAllottedServiceIdListBracket==""){
      removeSecondBracketForService = removeSecondBracketForService.replaceAll(", ", ",");
    }
    else{
      removeSecondBracketForService = "${removeSecondBracketForService.replaceAll(", ", ",")},${removeSecondNonAllottedServiceIdListBracket.replaceAll(", ", ",")}";
    }
    if(removeSecondNonAllottedClientServiceIdListBracket==""){
      removeSecondBracketForClientApplicableService = removeSecondBracketForClientApplicableService.replaceAll(", ", ",");
    }
    else{
      removeSecondBracketForClientApplicableService = "${removeSecondBracketForClientApplicableService.replaceAll(", ", ",")},${removeSecondNonAllottedClientServiceIdListBracket.replaceAll(", ", ",")}";
    }
    if(removeSecondNonAllottedTaskIdBracket==""){
      removeSecondTaskIdListBracket = removeSecondTaskIdListBracket.replaceAll(", ", ",");
    }
    else{
      removeSecondTaskIdListBracket = "${removeSecondTaskIdListBracket.replaceAll(", ", ",")},${removeSecondNonAllottedTaskIdBracket.replaceAll(", ", ",")}";
    }
    if(removeSecondNonAllottedTimeListBracket==""){
      removeSecondTimeSpentBracket = removeSecondTimeSpentBracket.replaceAll(", ", ",");
    }
    else{
      removeSecondTimeSpentBracket = "${removeSecondTimeSpentBracket.replaceAll(", ", ",")},${removeSecondNonAllottedTimeListBracket.replaceAll(", ", ",")}";
    }

    print(removeSecondBracket);
    print(removeSecondBracketForService);
    print(removeSecondBracketForClientApplicableService);
    print(removeSecondTaskIdListBracket);
    print(removeSecondDetailsBracket);
    print(removeSecondTimeSpentBracket);
    //callSaveAllotted();
    // callSaveNonAllotted();
    // callSaveOffice();
  }

  callSaveAllotted() async{
    try {
      ApiResponse? response = (await repository.getTimesheetAddAllotted(selectedDateToSend,
          removeSecondBracket, removeSecondBracketForService,
          removeSecondBracketForClientApplicableService,
          removeSecondTaskIdListBracket,
          //allottedStatusRemarkText.text??"",
          removeSecondDetailsBracket,
          removeSecondTimeSpentBracket));

      if (response.success!) {
        //callSaveNonAllotted();

        Utils.showSuccessSnackBar(response.message);

        ///if office is selected
        if(stepsList.contains("Office")){
          callSaveOffice();
        }
        else {
          Get.offNamed(AppRoutes.bottomNav);
        }

        updateLoader(false);
      }
      else{
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);
      }
      print("allotted response");
      print(response);
    }
    on CustomException catch (e) {
      print("allotted exception");
      print(e);
      print(e.getMsg());
      print(e.getResponse());
      Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    }
    catch (error) {
      print("allotted error");
      print(error);
      Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }
  }

  nextFromAllotted(){
    saveCurrentAllottedList(); continued();update();
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

  ///client
  addNonAllottedClientNameAndId(String id, String name){
    selectedNonAllottedClientNameList.add(name);
    selectedNonAllottedClientIdList.add(id);

    callServiceListForNonAllotted(id,name);

    update();
  }
  onNonAllottedClientName(String val){
    nonAllottedSelectedClientName = val; update();
  }
  ///service
  addNonAllottedServiceNameAndId(String id, String name,String clientId,String clientServiceId){
    selectedNonAllottedServiceNameList.add(name);
    selectedNonAllottedServiceIdList.add(id);
    selectedNonAllottedClientIdServiceIdList.add(clientServiceId);

    callTaskListForNonAllotted(id,clientId);
    update();
  }
  onNonAllottedServiceName(String val){
    nonAllottedSelectedServiceName = val; update();
  }
  ///task
  addNonAllottedTaskNameAndId(String id, String name){
    selectedNonAllottedTaskNameList.add(name);
    selectedNonAllottedTaskIdList.add(id);
    print("non allotted task");
    print(name);
    print(id);
    update();
  }
  onNonAllottedTaskName(String val){
    nonAllottedSelectedTaskName = val; update();
  }

  checkValidationForNonAllotted(BuildContext context){
    if(nonAllottedSelectedClientName==""){
      Utils.showErrorSnackBar("Please select client!"); update();
    }
    else if(nonAllottedSelectedServiceName==""){
      Utils.showErrorSnackBar("Please select service!"); update();
    }
    else if(nonAllottedSelectedTaskName==""){
      Utils.showErrorSnackBar("Please select task!"); update();
    }
    else if(nonAllottedDetailsController.text.isEmpty){
      Utils.showErrorSnackBar("Please add details!"); update();
    }
    else if(selectedNonAllottedTime==""){
      Utils.showErrorSnackBar("Please select time!"); update();
    }
    else{
      showConfirmationDialogForNonAllotted(context); update();
    }
  }

  showConfirmationDialogForNonAllotted(BuildContext context){
    showDialog(
      barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return StatefulBuilder(builder: (context,setter){
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 100.0,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    buildTextRegularWidget("Do you want to add more ?", blackColor, context, 16.0,align: TextAlign.left),
                    const Divider(color: Colors.grey,),
                    const SizedBox(height: 10.0,),

                    Row(
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: (){
                              setter((){
                                Navigator.of(context).pop();
                                saveCurrentNonAllottedList();
                              });
                            },
                            child: buildButtonWidget(context, "Yes",height: 40.0,buttonColor: approveColor),
                          ),
                        ),const SizedBox(width: 5.0,),
                        Flexible(
                          child: GestureDetector(
                            onTap: (){
                              setter((){
                                Navigator.of(context).pop();
                                cbNonAllotted = false;
                                nextFromNonAllottedOrOffice();
                                update();
                              });
                            },
                            child: buildButtonWidget(context, "No",height: 40.0,buttonColor: errorColor),
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

  saveCurrentNonAllottedList(){
    updateLoader(true);

    nonAllottedDetailsList.add(nonAllottedDetailsController.text);
    nonAllottedTimeList.add(selectedNonAllottedTime);

    nonAllottedDetailsController.clear();
    selectedNonAllottedTime="";

    prevIndex = hrList.length;
    print("allotted prevIndex");
    print(prevIndex);
    update();

    print("nonAllottedDetailsList");
    print(nonAllottedDetailsList);

    removeFirstNonAllottedDetailsListBracket = nonAllottedDetailsList.toString().replaceAll("[", "");
    removeSecondNonAllottedDetailsListBracket = removeFirstNonAllottedDetailsListBracket.replaceAll("]", "");

    removeFirstNonAllottedTimeListBracket = nonAllottedTimeList.toString().replaceAll("[", "");
    removeSecondNonAllottedTimeListBracket = removeFirstNonAllottedTimeListBracket.replaceAll("]", "");

    removeFirstNonAllottedClientIdListBracket = selectedNonAllottedClientIdList.toString().replaceAll("[", "");
    removeSecondNonAllottedClientIdListBracket = removeFirstNonAllottedClientIdListBracket.replaceAll("]", "");

    removeFirstNonAllottedServiceIdListBracket = selectedNonAllottedServiceIdList.toString().replaceAll("[", "");
    removeSecondNonAllottedServiceIdListBracket = removeFirstNonAllottedServiceIdListBracket.replaceAll("]", "");

    removeFirstNonAllottedClientServiceIdListBracket = selectedNonAllottedClientIdServiceIdList.toString().replaceAll("[", "");
    removeSecondNonAllottedClientServiceIdListBracket = removeFirstNonAllottedClientServiceIdListBracket.replaceAll("]", "");

    removeFirstNonAllottedTaskIdBracket = selectedNonAllottedTaskIdList.toString().replaceAll("[", "");
    removeSecondNonAllottedTaskIdBracket = removeFirstNonAllottedTaskIdBracket.replaceAll("]", "");

    print("removeSecondNonAllottedDetailsListBracket");
    print(removeSecondNonAllottedDetailsListBracket);
    print("removeSecondNonAllottedTimeListBracket");
    print(removeSecondNonAllottedTimeListBracket);
    print("removeSecondNonAllottedClientIdListBracket");
    print(removeSecondNonAllottedClientIdListBracket);
    print("removeSecondNonAllottedServiceIdListBracket");
    print(removeSecondNonAllottedServiceIdListBracket);
    print("removeSecondNonAllottedClientServiceIdListBracket");
    print(removeSecondNonAllottedClientServiceIdListBracket);
    print("removeSecondNonAllottedTaskIdBracket");
    print(removeSecondNonAllottedTaskIdBracket);
    clearNonAllotted();
    update();
  }

  clearNonAllotted(){
    allottedEmployeeList.clear();
    allottedServiceList.clear();
    nonAllottedTaskList.clear();
    nonAllottedDetailsController.clear();
    nonAllottedSelectedClientName = "";
    nonAllottedSelectedServiceName = "";
    nonAllottedSelectedTaskName = "";
    selectedNonAllottedTime="";

    if(cbNonAllotted == true && cbOffice == true){
      currentService = "nonAllotted";callEmployeeList(); update();
    }
    else if(cbNonAllotted == true && cbOffice == false){
      currentService = "nonAllotted";callEmployeeList(); update();
    }
    else if(cbNonAllotted == false && cbOffice == true){
      currentService = "office"; showOffice = true; callTimesheetTypeOfWork(); update();
    }
    else if(cbNonAllotted == false && cbOffice == false){
      currentService = ""; continued(); update();
    }

    updateLoader(false);
    update();
  }

  callSaveNonAllotted() async{
    try {
      ApiResponse? response = (await repository.getTimesheetAddAllotted(selectedDateToSend,
        removeSecondBracket.replaceAll(", ", ",") + removeSecondNonAllottedClientIdListBracket.replaceAll(", ", ","),
        removeSecondBracketForService.replaceAll(", ", ",") + removeSecondNonAllottedServiceIdListBracket.replaceAll(", ", ","),
        removeSecondBracketForClientApplicableService.replaceAll(", ", ",")+ removeSecondNonAllottedClientServiceIdListBracket.replaceAll(", ", ","),
        removeSecondTaskIdListBracket.replaceAll(", ", ",") + removeSecondNonAllottedTaskIdBracket.replaceAll(", ", ","),
        allottedStatusRemarkText.text??"",
        //"${hrSum.toString()}: ${minSum.toString()}"
        removeSecondTimeSpentBracket.replaceAll(", ", ",") + removeSecondNonAllottedTimeListBracket.replaceAll(", ", ","),));
      if (response.success!) {
        callSaveOffice();
        Utils.showSuccessSnackBar(response.message);
        updateLoader(false);
      }
      else{
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);
      }
      print("non allotted response");
      print(response);
    }
    on CustomException catch (e) {
      print("non allotted exception");
      print(e.getMsg());
      Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      print("non allotted exception");
      print(error);
      Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }
  }

  nextFromNonAllottedOrOffice(){
    if(currentService == "nonAllotted"){
      saveCurrentNonAllottedList();
    }
    else {
      saveOfficeRelated();
    }
    update();
  }

  nextFromOffice(){
    cbOffice = false;
    saveOfficeRelated();
    currentService = ""; continued(); update();
    update();
  }

  /// service non allotted
  void callServiceListForNonAllotted(String selectedClientId,String selectedClient) async {
    allottedServiceList.clear();
    try {
      TimesheetServiceListModel? response = (await repository.getTimesheetNonAllottedServicesList(selectedClientId));

      if (response.success!) {
        if (response.data!.isEmpty) {
        }
        else{
          for (var element in response.data!) {
            allottedServiceList.add(TimesheetServicesListData(
                id: element.id,
                serviceId: element.serviceId,
                selectedClientId: selectedClientId,
                serviceName: element.serviceName,
                selectedClientName: selectedClient,
                period: element.period,
                serviceDueDatePeriodicity: element.serviceDueDatePeriodicity
            ));
          }

          serviceItems = allottedServiceList
              .map((value) => MultiSelectItem<TimesheetServicesListData>(value, value.serviceName!))
              .toList();
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

  List<TimesheetTaskDetailsData> nonAllottedTaskList = [];
  /// task non allotted
  void callTaskListForNonAllotted(String selectedServiceId,String clientApplicableServiceId) async {
    nonAllottedTaskList.clear();
    try {
      TimesheetTaskListData? response = (await repository.getTimesheetNonAllottedNewTaskList(selectedServiceId,
          clientApplicableServiceId));

      if (response.success!) {
        if (response.timesheetTaskDetailsData!.isEmpty) {
        }
        else {
          nonAllottedTaskList.addAll(response.timesheetTaskDetailsData!);
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
        if(response.typeOfWorkList!.isNotEmpty){
          workList.addAll(response.typeOfWorkList!);
        }
        update();
      } else {
        updateLoader(false);update();
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
  addOfficeWorkNameAndId(String id, String name){
    selectedOfficeWorkId = id;
    selectedOfficeWorkName = name;
    officeWorkIdList.add(id);
    officeWorkNameList.add(name);
    update();
  }
  onOfficeWorkType(String val){
    selectedOfficeWorkName = val; update();
  }

  checkValidationForOffice(BuildContext context){
    if(selectedOfficeWorkName == ""){
      Utils.showErrorSnackBar("Please select work type!"); update();
    }
    else if(officeDetailsController.text.isEmpty){
      Utils.showErrorSnackBar("Please add details!"); update();
    }
    else if(selectedOfficeTime==""){
      Utils.showErrorSnackBar("Please select time!"); update();
    }
    else{
      showConfirmationDialogForOffice(context); update();
    }
  }

  showConfirmationDialogForOffice(BuildContext context){
    showDialog(
      barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return StatefulBuilder(builder: (context,setter){
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 100.0,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    buildTextRegularWidget("Do you want to add more ?", blackColor, context, 16.0,align: TextAlign.left),
                    const Divider(color: Colors.grey,),
                    const SizedBox(height: 10.0,),

                    Row(
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: (){
                              setter((){
                                Navigator.of(context).pop();
                                cbOffice = true;
                                callTimesheetTypeOfWork();
                                saveOfficeRelated();
                              });
                            },
                            child: buildButtonWidget(context, "Yes",height: 40.0,buttonColor: approveColor),
                          ),
                        ),const SizedBox(width: 5.0,),
                        Flexible(
                          child: GestureDetector(
                            onTap: (){
                              setter((){
                                Navigator.of(context).pop();
                                cbOffice = false;
                                //nextFromNonAllottedOrOffice();
                                nextFromOffice();
                                update();
                              });
                            },
                            child: buildButtonWidget(context, "No",height: 40.0,buttonColor: errorColor),
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

  saveOfficeRelated(){
    officeDetailsList.add(officeDetailsController.text);
    officeTimeList.add(selectedOfficeTime);

    removeFirstOfficeDetailsListBracket = officeDetailsList.toString().replaceAll("[", "");
    removeSecondOfficeDetailsListBracket = removeFirstOfficeDetailsListBracket.replaceAll("]", "");

    removeFirstOfficeTimeListBracket = officeTimeList.toString().replaceAll("[", "");
    removeSecondOfficeTimeListBracket = removeFirstOfficeTimeListBracket.replaceAll("]", "");

    removeFirstOfficeWorkIdListBracket = officeWorkIdList.toString().replaceAll("[", "");
    removeSecondOfficeWorkIdListBracket = removeFirstOfficeWorkIdListBracket.replaceAll("]", "");

    removeFirstOfficeWorkNameListBracket = officeWorkNameList.toString().replaceAll("[", "");
    removeSecondOfficeWorkNameListBracket = removeFirstOfficeWorkNameListBracket.replaceAll("]", "");

    print("removeSecondOfficeWorkIdListBracket");
    print(removeSecondOfficeWorkIdListBracket);
    print("removeSecondOfficeWorkNameListBracket");
    print(removeSecondOfficeWorkNameListBracket);
    update();
  }

  clearOfficeRelated(){
    selectedOfficeWorkId = "";
    selectedOfficeWorkName = "";
    officeDetailsController.clear();
    selectedOfficeTime="";

    if(cbOffice == false){
      currentService = ""; continued(); update();
    }
    else {

    }

    updateLoader(false);
    update();
  }

  void callSaveOffice() async {
    try {
      ApiResponse? response = (await repository.getTimesheetAddOfficeRelated(selectedDateToSend,
          removeSecondOfficeWorkIdListBracket,removeSecondOfficeWorkNameListBracket,totalTimeToShow,"save"));
      if (response.success!) {
        Utils.showSuccessSnackBar(response.message);
        updateLoader(false);
        Get.offNamed(AppRoutes.bottomNav);
        update();
      } else {
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      print("office response");
      print(response);
      updateLoader(false);
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

  ///previous click
  goToPreviousFromStepper3(){
    if(stepsList.contains("Office")){
      showOffice = true; cancel(); update();
    }
    else if(stepsList.contains("Non Allotted")){
      currentService = "nonAllotted"; cancel(); update();
    }
    else if(stepsList.contains("Allotted")){
      // print("allottedTimesheetSelectedEmpList on prev click from office");
      // print(allottedTimesheetSelectedEmpList.length);
      // print(allottedTimesheetSelectedEmpList[0].firmClientFirmName);
      // onSelectionForMultipleEmployee(allottedTimesheetSelectedEmpList);
      // onSelectionForMultipleService(allottedTimesheetSelectedServiceList);
      currentService = "allotted"; cancel(); update();
    }
    else{
      currentStep = 1 ;
      cancel();
      update();
    }
    update();
  }

  goToPreviousFromOffice(){
    if(stepsList.contains("Non Allotted")){
      showOffice = false;
      currentService = "nonAllotted";
      currentStep = 1 ;
      update();
    }
    else if(stepsList.contains("Allotted")){
      showOffice = false;
      currentService = "allotted";
      currentStep = 1 ;
      update();
    }
    else{
      cancel(); update();
    }
    update();
  }

  goToPreviousFromNonAllotted(){
    if(stepsList.contains("Allotted")){
      currentService = "allotted"; update();
    }
    else{
      cancel();
    }
    update();
  }

  goToPreviousFromAllotted(){
    cancel();
    update();
  }

  ///common

  onWillPopBackTimesheetList(){
    Get.offAllNamed(AppRoutes.bottomNav);
    update();
  }

  calculateTimesheetHrMin(){

    var format = DateFormat("HH:mm");
    // ignore: prefer_typing_uninitialized_variables
    var two;
    // var one = format.parse(stepper1InTime.text);
    // var two = format.parse(stepper1OutTime.text);
    // difference = two.difference(one);
    // totalTimeToShow = "${difference!.inHours}:${difference!.inMinutes.remainder(60)}";
    // timesheetTotalTime.text = totalTimeToShow;

    for (var element in timeSpentList) {
      var one = format.parse(element);

      one = two.difference(one);

    }

    update();
  }

  continued(){
    currentStep < 2 ? currentStep += 1: null;
    update();
  }

  cancel(){
    currentStep > 0 ? currentStep -= 1 : null;
    update();
  }

  tapped(int step){
    currentStep = step;
    update();
  }

  updateLoader(bool val) { loader = val; update(); }

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