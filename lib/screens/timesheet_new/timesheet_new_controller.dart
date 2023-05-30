import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/constant/provider/custom_exception.dart';
import 'package:biznew/constant/repository/api_repository.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/claim_form/claim_model.dart';
import 'package:biznew/screens/timesheet_form/timesheet_model.dart';
import 'package:biznew/screens/timesheet_new/timesheet_new_model.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:biznew/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  String removeSecondBracket = "";
  String removeSecondBracketForService = "";

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
  }

  onDeleteMultipleWorkAt(String value){
    updateLoader(true);
    timesheetSelectedWorkAt.remove(value);
    removeFirstBracketFromWorkAt = timesheetSelectedWorkAt.toString().replaceAll("[", "");
    removeSecondBracketFromWorkAt = removeFirstBracketFromWorkAt.replaceAll("]", "");
    update();

    print("removeSecondBracket");
    print(removeSecondBracket);
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
    validateStartDate = false;
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
      update();
    }
    if(timeFor == "start"){
      //selectedStartTime24 = selectedTime;
      selectedStartTimeToShow = "${selectedStartTime24.hour}:${selectedStartTime24.minute}";
      stepper1InTime.text = selectedStartTimeToShow;
      stepper1InTime.text.isEmpty ? validateInTime = true : validateInTime = false;update();

      ///difference
      calculateTotalTime();
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
      print(hrOfficeSum);
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
      print(hrNonAllottedSum);
    }
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
    allottedTimesheetSelectedEmpList = selectedEmpListFromDesign;

    print(allottedTimesheetSelectedEmpList.length);
    for (var element in allottedTimesheetSelectedEmpList) {
      callServiceListForAllotted(element.firmClientId!,element.firmClientFirmName!);
    }

    for (var element in selectedEmpListFromDesign) {
      allottedTimesheetSelectedMultipleEmpIdList.add(element.id!);
      removeFirstBracket = allottedTimesheetSelectedMultipleEmpIdList.toString().replaceAll("[", "");
      removeSecondBracket = removeFirstBracket.replaceAll("]", "");
      update();
    }
  }

  onDeleteMultipleEmployee(ClientListData value){
    updateLoader(true);
    allottedServiceList.clear();
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
  /// allotted service list
  void callServiceListForAllotted(String selectedClientId,String selectedClient) async {
    allottedServiceList.clear();
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

        print("serviceList.length");
        print(allottedServiceList.length);
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

  List<TimesheetTaskListData> timesheetTaskListData = [];
  int totalTaskLength = 0;

  void callTaskListForAllotted(String selectedServiceId,String clientApplicableServiceId,
      String serviceName,String clientId,String clientName) async {
    taskList.clear();
    print("task list called");
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
            success: response.success
          ));

          totalTaskLength = response.timesheetTaskDetailsData!.length;

          print("totalTaskLength in api ");
          print(totalTaskLength);
          for (var element in response.timesheetTaskDetailsData!) {
            detailsControllerList.add(TextEditingController(text: ""));
            timeSpentControllerList.add(TextEditingController(text: ""));
            timeSpentList.add("");
          }}

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

  onSelectionForMultipleService(List<TimesheetServicesListData> selectedServiceListFromDesign){
    updateLoader(true);

    allottedTimesheetSelectedServiceList = selectedServiceListFromDesign;

    for (var element in allottedTimesheetSelectedServiceList) {
      callTaskListForAllotted(element.serviceId!,element.id!,element.serviceName!,
          element.selectedClientId!,element.selectedClientName!);
    }

    for (var element in selectedServiceListFromDesign) {
      allottedTimesheetSelectedMultipleServiceIdList.add(element.id!);
      removeFirstBracketForService = allottedTimesheetSelectedMultipleServiceIdList.toString().replaceAll("[", "");
      removeSecondBracketForService = removeFirstBracketForService.replaceAll("]", "");
      update();
    }
  }

  onDeleteMultipleService(TimesheetServicesListData value){
    updateLoader(true);
    allottedTimesheetSelectedServiceList.remove(value);
    allottedTimesheetSelectedMultipleServiceIdList.remove(value.id!);
    removeFirstBracketForService = allottedTimesheetSelectedMultipleServiceIdList.toString().replaceAll("[", "");
    removeSecondBracketForService = removeFirstBracketForService.replaceAll("]", "");

    taskList.removeWhere((element) => value.serviceId==element.serviceId);
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

      hrList.add(selectedTime.hour);
      minList.add(selectedTime.minute);

      hrSum = hrList.reduce((a, b) => a + b);
      minSum = minList.reduce((a, b) => a + b);

      if(minSum>=60){
        remainingFromMin = minSum ~/ 60;
        minSum = minSum % 60;
      }

      hrSum = hrSum + remainingFromMin;

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
                                 //currentService = "allotted";
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

  saveCurrentAllottedList(){
    updateLoader(true);
    print("----Allotted Data----");
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

    for (var element in timeSpentControllerList) {
      if(element.text==""){

      }
      else{
        allottedLocalStoreTimeSpentList.add(element.text);
      }
    }
    clearAllotted();
    update();
  }

  clearAllotted(){
    timesheetTaskListData.clear();
    detailsControllerList.clear();
    timeSpentControllerList.clear();
    timeSpentList.clear();

    allottedEmployeeList.clear();
    allottedTimesheetSelectedEmpList.clear();
    items.clear();
    allottedServiceList.clear();
    allottedTimesheetSelectedServiceList.clear();
    serviceItems.clear();

    if(currentService == "allotted"){
      print("Current service is allotted");
      callEmployeeList();
    }
    else if(cbNonAllotted == true && cbOffice == true){
      print("non allotted");
      currentService = "nonAllotted";
      callEmployeeList();
      update();
    }
    else if(cbNonAllotted == true && cbOffice == false){
      print("non allotted");
      currentService = "nonAllotted";callEmployeeList(); update();
    }
    else if(cbNonAllotted == false && cbOffice == true){
      print("office");
      currentService = "office"; callTimesheetTypeOfWork(); showOffice = true; update();
    }
    else if(cbNonAllotted == false && cbOffice == false){
      print("next step");
      currentService = ""; continued(); update();
    }

    updateLoader(false);
    update();
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
  addNonAllottedServiceNameAndId(String id, String name,String clientId){
    selectedNonAllottedServiceNameList.add(name);
    selectedNonAllottedServiceIdList.add(id);

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

  saveCurrentNonAllottedList(){
    updateLoader(true);
    print("----Non Allotted Data----");

    nonAllottedDetailsList.add(nonAllottedDetailsController.text);
    nonAllottedTimeList.add(selectedNonAllottedTime);

    nonAllottedDetailsController.clear();
    selectedNonAllottedTime="";
    update();

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
      print("non allotted");
     currentService = "nonAllotted";callEmployeeList(); update();
    }
    else if(cbNonAllotted == true && cbOffice == false){
      print("non allotted");
      currentService = "nonAllotted";callEmployeeList(); update();
    }
    else if(cbNonAllotted == false && cbOffice == true){
      print("office -> next step");
      currentService = "office"; showOffice = true; callTimesheetTypeOfWork(); update();
    }
    else if(cbNonAllotted == false && cbOffice == false){
      print("office -> next step");
      currentService = ""; continued(); update();
    }

    updateLoader(false);
    update();
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

        print("serviceList.length");
        print(allottedServiceList.length);
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

  saveOfficeRelated(){
    officeDetailsList.add(officeDetailsController.text);
    officeTimeList.add(selectedOfficeTime);

    clearOfficeRelated();
    update();
  }

  clearOfficeRelated(){
    selectedOfficeWorkId = "";
    selectedOfficeWorkName = "";
    officeDetailsController.clear();
    selectedOfficeTime="";

    if(cbOffice == false){
      print("office -> next step");
      currentService = ""; continued(); update();
    }
    else {

    }

    updateLoader(false);
    update();
  }

  ///previous click
  goToPreviousFromStepper3(){
    if(stepsList.contains("Office")){
      print("prev office");
      showOffice = true; cancel(); update();
    }
    else if(stepsList.contains("Non Allotted")){
      print("prev non allotted");
      currentService = "nonAllotted"; cancel(); update();
    }
    else if(stepsList.contains("Allotted")){
      // print("allottedTimesheetSelectedEmpList on prev click from office");
      // print(allottedTimesheetSelectedEmpList.length);
      // print(allottedTimesheetSelectedEmpList[0].firmClientFirmName);
      // onSelectionForMultipleEmployee(allottedTimesheetSelectedEmpList);
      // onSelectionForMultipleService(allottedTimesheetSelectedServiceList);
      print("prev allotted");
      currentService = "allotted"; cancel(); update();
    }
    else{
      print("stepper 1");
      print("b4 currentStep");
      print(currentStep);
      currentStep = 1 ;
      print("after currentStep");
      print(currentStep);
      cancel();
      update();
    }
    update();
  }

  goToPreviousFromOffice(){
    if(stepsList.contains("Non Allotted")){
      print("prev non allotted");
      showOffice = false;
      currentService = "nonAllotted";
      currentStep = 1 ;
      update();
    }
    else if(stepsList.contains("Allotted")){
      print("prev allotted");
      showOffice = false;
      currentService = "allotted";
      currentStep = 1 ;
      update();
    }
    else{
      print("stepper 1");
      cancel(); update();
    }
    update();
  }

  goToPreviousFromNonAllotted(){
    if(stepsList.contains("Allotted")){
      print("prev allotted");
      currentService = "allotted"; update();
    }
    else{
      print("stepper 1");
      cancel();
    }
    update();
  }

  goToPreviousFromAllotted(){
      print("stepper 1");
      cancel();
      update();
  }

  ///common

  calculateTimesheetHrMin(){
      print("timeSpentList.toString()");
      print(timeSpentList.toString());

      var format = DateFormat("HH:mm");
      var two;
      // var one = format.parse(stepper1InTime.text);
      // var two = format.parse(stepper1OutTime.text);
      // difference = two.difference(one);
      // totalTimeToShow = "${difference!.inHours}:${difference!.inMinutes.remainder(60)}";
      // timesheetTotalTime.text = totalTimeToShow;

      timeSpentList.forEach((element) {
        var one = format.parse(element);

        one = two.difference(one);

        print("one");
        print(one);
      });

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