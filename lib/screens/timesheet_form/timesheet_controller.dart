import 'dart:async';
import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/constant/provider/custom_exception.dart';
import 'package:biznew/constant/repository/api_repository.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/claim_form/claim_model.dart';
import 'package:biznew/screens/timesheet_form/timesheet_model.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:biznew/utils/custom_response.dart';
import 'package:biznew/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class TimesheetFormController extends GetxController {
  final ApiRepository repository;

  // ignore: unnecessary_null_comparison
  TimesheetFormController({required this.repository}) : assert(repository != null);

  ///common
  String userId="";
  String userName="";
  String name="";
  bool loader = false;
  ///timesheet form
  int currentStep = 0;
  StepperType stepperType = StepperType.horizontal;

  ///stepper 1
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  //String selectedDateToShow = "";
  String selectedDateToSend = "";
  String selectedDateToShow = "";
  String selectedStartTimeToShow = "";
  String selectedEndTimeToShow = "";
  String selectedWorkAt = "";
  String selectedStartTime = "";
  String selectedEndTime = "";
  String totalTimeToShow = "";
  String balanceTimeToShow = "";
  TextEditingController stepper1InTime = TextEditingController();
  TextEditingController stepper1OutTime = TextEditingController();
  TextEditingController timesheetTotalTime = TextEditingController();
  List<String> noDataList = ["No Data Found!"];
  List<String> workAtList = ["Office","Client Location","Work From Home","Govt. Department"];
  bool validateStartDate = false;
  bool validateWorkAt = false;
  bool validateInTime = false;
  bool validateOutTime = false;
  bool validateTotalTime = false;

  ///stepper 2
  String selectedClient = "";
  String selectedService = "";
  String selectedServiceId = "";
  String selectedTask = "";
  String selectedTaskId = "";
  String selectedStatus = "";
  String selectedStatusId = "";
  TextEditingController details = TextEditingController();
  TextEditingController remark = TextEditingController();
  TextEditingController stepper2TimeSpent = TextEditingController();
  String selectedTimeSpentToShow = "";
  String selectedTimeSpent1ToShow = "";
  bool validateClientName = false;
  bool validateServiceName = false;
  bool validateTaskName = false;
  bool validateStatusName = false;
  bool validateDetailsStepper2 = false;
  bool validateRemarkStepper2 = false;
  bool validateTimeSpentStepper2 = false;
  List<ClientListData> clientNameList = [];
  String selectedClientId = "";
  String clientApplicableServiceId = "";
  String clientFirmId = "";
  String statusStart = "";
  List<TimesheetServicesData> serviceList = [];
  List<TimesheetTaskData> taskList = [];
  List<StatusList> statusList = [];
  DateTime todayDate = DateTime.now();
  String currentService = "office";
  List<TypeOfWorkList> workList = [];

  ///stepper 3
  TextEditingController details1 = TextEditingController();
  String selectedTimeSpent2ToShow = "";
  TextEditingController details2 = TextEditingController();
  String selectedTimeSpent3ToShow = "";
  TextEditingController details3 = TextEditingController();
  String selectedTimeSpent4ToShow = "";
  TextEditingController details4 = TextEditingController();
  String selectedTimeSpent5ToShow = "";
  TextEditingController details5 = TextEditingController();
  String selectedTimeSpent6ToShow = "";
  TextEditingController details6 = TextEditingController();
  String selectedTimeSpent7ToShow = "";
  TextEditingController details7 = TextEditingController();

  final List<TextEditingController> detailsStepper3List = [];
  List<TextEditingController> timeStepper3List = [];
  int numberOfTextFields = 1;
  List<String> workTypeNameList = [];
  List<String> workTypeIdList = [];
  List<String> workTypeTimeList = [];
  List<String> workTypeDetailsList = [];
  String selectedFlag = "own";
  int selectedTimesheetFlag = 0;
  List<TimesheetListData> timesheetList = [];
  String selectedEmployee = "";
  String selectedTimesheetStatus = "Saved";
  List<String> timesheetStatusList = ["Saved","Approved","Sent for Resubmission","Submit for Approval"];
  List<TimesheetLog> timesheetLog = [];
  //List<TimesheetData> viewTimesheet = [];
  TimesheetData? viewTimesheet;
  List<NonAllottedData> viewNonAllottedTimesheet = [];
  List<OfficeRelatedData> viewOfficeRelatedTimesheet = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userId = GetStorage().read("userId")??"";
    userName = GetStorage().read("userName")??"";
    name = GetStorage().read("name")??"";
    repository.getData();
    callClientNameList();
    callTimesheetList();
    selectedDateToShow = "${todayDate.day}-${todayDate.month}-${todayDate.year}";
    selectedDateToSend = "${todayDate.year}-${todayDate.month}-${todayDate.day}";
    // callTimesheetTotal();
    callEmployeeList();
  }

  onWillPopBack(){
    clearStepper1();
    Get.offNamedUntil(AppRoutes.bottomNav, (route) => false);
    update();
  }

  onWillPopBackTimesheetList(){
    clearStepper1();
    Get.toNamed(AppRoutes.timesheetList);
    update();
  }

  clearStepper1(){
    currentStep=0; statusStart="";
    ///stepper 1
    selectedDateToShow="";selectedDateToSend = "";selectedWorkAt="";
    stepper1InTime.clear();stepper1OutTime.clear();
    timesheetTotalTime.clear();
    // ///stepper 2
    // selectedClient="";selectedClientId="";
    // selectedService="";selectedServiceId="";
    // selectedTask="";selectedTaskId="";
    // selectedStatus = ""; selectedStatusId="";
    // details.clear(); stepper2TimeSpent.clear(); remark.clear();
    update();
  }

  clearStepper2(){
    selectedClient = "" ; selectedClientId = "";
    selectedService = "" ;selectedServiceId="";
    selectedTask = "" ; selectedTaskId="";
    selectedStatus = ""; selectedStatusId="";
    details.clear(); stepper2TimeSpent.clear(); remark.clear(); update();
  }

  updateSelectedTimesheetFlag(int val,String flag,BuildContext context){
    selectedTimesheetFlag = val; selectedFlag = flag;
    callTimesheetList(); update();
  }

  updateSelectedWorkAt(String value){
    selectedWorkAt = value;
    if(selectedWorkAt==""){validateWorkAt=true;update();}
    else{validateWorkAt=false;update();}
  }

  checkValidateInTime(String inTime){
    if(inTime==""){}
    // else if(inTime.length==2){
    //   inTime = ":$inTime";
    //   stepper1InTime.text = inTime;
    //   update();
    // }
    else {
     // stepper1InTime.text = "${inTime.substring(0, 4)} ${inTime.substring(4, 8)} ${inTime.substring(8, inTime.length)}";
      String s = "";
      //s = StringUtils.addCharAtPosition(stepper1InTime.text, ":", 2);
      //stepper1InTime.text = s;
      update();
    }
    update();
  }

  checkTotalTimeValidation(){
    if(timesheetTotalTime.text.isEmpty){validateTotalTime=true;update();}
    else{validateTotalTime=false;update();}
  }

  checkValidationForStepper1(){
    if(selectedDateToShow=="" || selectedWorkAt=="" ||  stepper1InTime.text.isEmpty
        || stepper1OutTime.text.isEmpty || timesheetTotalTime.text.isEmpty){

      selectedDateToShow=="" ? validateStartDate=true: validateStartDate=false;
      selectedWorkAt=="" ? validateWorkAt=true: validateWorkAt=false;
      stepper1InTime.text.isEmpty ? validateInTime=true: validateInTime=false;
      stepper1OutTime.text.isEmpty ? validateOutTime=true: validateOutTime=false;

      updateLoader(false);
      update();
    }
    else{
      callTimesheetCheck();
      update();
    }
  }

  ///loading
  updateLoader(bool val) { loader = val; update(); }

  updateSelectedTimesheetStatus(String val){
    selectedTimesheetStatus = val;callTimesheetList(); update();
  }

  checkStepperValidation(String buttonName){
    if(currentStep==0){
       updateLoader(true);
       callTimesheetTotal();
       checkValidationForStepper1();

       // updateLoader(false);
       //continued();
       update();
    }
    else if(currentStep==1){
      updateLoader(true);
      callTimesheetTypeOfWork();
      //checkValidationForStepper2(buttonName);

      // updateLoader(false);

      //continued();

      if(buttonName=="next"){
        continued();
      }
      else if(buttonName=="save&add" || buttonName=="save&goToNonAllotted"){
        checkValidationForStepper2(buttonName);
      }

      update();
    }
    else if(currentStep==2){
      updateLoader(false);
      callTimesheetAddOfficeRelated(buttonName);
      update();
    }
  }

  checkDetailsValidationStepper2(){
    if(details.text.isEmpty){validateDetailsStepper2=true;update()  ;}
    else{validateDetailsStepper2=false;update();}
  }

  checkRemarkValidationStepper2(){
    if(remark.text.isEmpty){validateRemarkStepper2=true;update();}
    else{validateRemarkStepper2=false;update();}
  }

  checkClientNameValidation(String value){
    if(clientNameList.isNotEmpty){
      selectedClient = value;
      if(selectedClient==""){validateClientName=true;update();}
      else{validateClientName=false;update();}
      update();
    }
  }

  updateSelectedClientId(String valId){
    if(clientNameList.isNotEmpty){
      selectedClientId = valId;
      currentService == "office" ? callServiceList() : callNonAllottedServiceList();
      update();
    }
  }

  updateSelectedServiceId(String valId,String id){
    if(serviceList.isNotEmpty){
      selectedServiceId = valId;clientApplicableServiceId=id;
      currentService == "office" ? callTaskList() : callNonAllottedTaskList(); update();
    }
  }

  checkServiceValidation(String value){
    if(serviceList.isNotEmpty){
      selectedService=value;
      if(selectedService==""){validateServiceName=true;update();}
      else{validateServiceName=false;update();}
      update();
    }
  }

  checkTaskValidation(String value){
    if(taskList.isNotEmpty){
      selectedTask = value;
      if(selectedTask==""){validateTaskName=true;update();}
      else{validateTaskName=false;update();}
      update();
    }
  }

  updateSelectedTaskId(String valId){
    if(taskList.isNotEmpty){
      selectedTaskId = valId;callStatusList();update();
    }
  }

  checkStatusValidation(String value,BuildContext context){
    if(statusList.isNotEmpty){
      selectedStatus = value;
      if(selectedStatus==""){validateStatusName=true;update();}
      else{validateStatusName=false;update();}
      update();
    }
  }

  updateSelectedStatusId(String valId,){
    if(statusList.isNotEmpty){
      selectedStatusId = valId; update();
    }
  }

  checkValidationForStepper2(String btnName){
    if(selectedClient=="" || selectedService=="" || selectedTask==""
    || details.text.isEmpty || stepper2TimeSpent.text.isEmpty){

      selectedClient=="" ? validateClientName=true: validateClientName=false;
      selectedService=="" ? validateServiceName=true: validateServiceName=false;
      selectedTask=="" ? validateTaskName=true: validateTaskName=false;
      details.text.isEmpty ? validateDetailsStepper2=true: validateDetailsStepper2=false;
      stepper2TimeSpent.text.isEmpty ? validateTimeSpentStepper2=true: validateTimeSpentStepper2=false;
      update();
    }
    else{
      // currentService == "office" ? callTimesheetAddAllotted(btnName)
      //     : Utils.showSuccessSnackBar("Coming soon");
      callTimesheetAddAllotted(btnName);
      update();
    }
  }

  tapped(int step){
    currentStep = step;
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


  List<ClaimSubmittedByList> employeeList = [];

  ///employee list
  void callEmployeeList() async {
    employeeList.clear();
    updateLoader(true);
    try {
      ClaimSubmittedByResponse? response = (await repository.getClaimSubmittedByList());

      if (response.success!) {
        if (response.claimSubmittedByListDetails!.isEmpty) {
        }
        else{
          employeeList.addAll(response.claimSubmittedByListDetails!);
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
  ///update emp list
  updateSelectedEmployee(String val){
    if(employeeList.isNotEmpty){
      selectedEmployee = val; callTimesheetList();update();
    }
  }
  ///calender date view
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
  Duration? difference;
  ///time view
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
      selectedTime = picked;update();
    }
    if(timeFor == "start"){
      selectedStartTimeToShow = "${selectedTime.hour}:${selectedTime.minute}";
      stepper1InTime.text = selectedStartTimeToShow;
      stepper1InTime.text.isEmpty ? validateInTime = true : validateInTime = false;
      update();
    }
    else if(timeFor=="end"){
      selectedEndTimeToShow = "${selectedTime.hour}:${selectedTime.minute}";
      stepper1OutTime.text = selectedEndTimeToShow;
      stepper1OutTime.text.isEmpty ? validateOutTime = true : validateOutTime = false; update();

      ///difference
      calculateTotalTime();
      update();
    }
    else if(timeFor=="timeSpent"){
      selectedTimeSpentToShow = "${selectedTime.hour}:${selectedTime.minute}";
      stepper2TimeSpent.text = selectedTimeSpentToShow;
      selectedTimeSpentToShow == ""? validateTimeSpentStepper2 = true : validateTimeSpentStepper2 = false;
      update();
    }
    // else if(timeFor=="stepper3TimeSpent1"){
    //   selectedTimeSpent1ToShow = "${selectedTime.hour}:${selectedTime.minute}";
    //   update();
    // }
    // else if(timeFor=="stepper3TimeSpent2"){
    //   selectedTimeSpent2ToShow = "${selectedTime.hour}:${selectedTime.minute}";
    //   update();
    // }
    else{
      selectedTimeSpent1ToShow = "${selectedTime.hour}:${selectedTime.minute}";update();
    }
    update();
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

  /// check timesheet
  void callTimesheetCheck() async {
    try {
      CheckTimesheetApiResponse? response = (await repository.getTimesheetCheck(selectedDateToSend));

      if (response.success!) {
        callTimesheetAdd();
        //Utils.showSuccessSnackBar(response.flag);
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
        //Utils.showSuccessSnackBar(response.message);
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
  /// total time timesheet
  void callTimesheetTotal() async {
    try {
      CheckTimesheetTimeResponse? response = (await repository.getTimesheetTotalTime(selectedDateToSend));
      if (response.success!) {
        totalTimeToShow = response.totalTime!;
        balanceTimeToShow = response.balanceTime!;
        updateLoader(false);
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
  /// client name list
  void callClientNameList() async {
    clientNameList.clear();
    try {
      TimesheetClientListModel? response = (await repository.getTimesheetClientNameList());

      if (response.success!) {
        if (response.data!.isEmpty) {
        }
        else{
          clientNameList.addAll(response.data!);
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
  /// service list
  void callServiceList() async {
    serviceList.clear();
    try {
      TimesheetServiceListModel? response = (await repository.getTimesheetServicesList(selectedClientId));

      if (response.success!) {
        if (response.data!.isEmpty) {
        }
        else{
          serviceList.addAll(response.data!);
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
  /// service non allotted
  void callNonAllottedServiceList() async {
    serviceList.clear();
    try {
      TimesheetServiceListModel? response = (await repository.getTimesheetNonAllottedServicesList(selectedClientId));

      if (response.success!) {
        if (response.data!.isEmpty) {
        }
        else{
          serviceList.addAll(response.data!);
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
  /// task list
  void callTaskList() async {
    taskList.clear();
    try {
      TimesheetTaskModel? response = (await repository.getTimesheetTaskList(selectedServiceId,clientApplicableServiceId));

      if (response.success!) {
        if (response.data!.isEmpty) {
        }
        else{
          taskList.addAll(response.data!);
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
  /// task list non allotted
  void callNonAllottedTaskList() async {
    taskList.clear();
    try {
      TimesheetTaskModel? response = (await repository.getTimesheetNonAllottedTaskList(selectedServiceId,clientApplicableServiceId));

      if (response.success!) {
        if (response.data!.isEmpty) {
        }
        else{
          taskList.addAll(response.data!);
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
  /// status list
  void callStatusList() async {
    statusList.clear();
    try {
      TimesheetStatusModel? response = (await repository.getTimesheetStatusList(clientApplicableServiceId,selectedTaskId));

      if (response.success!) {
        if (response.list!.isEmpty) {
        }
        else{
          statusStart = response.start!;
          statusList.addAll(response.list!);
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
  void callTimesheetStart(BuildContext context) async {
    try {
      ApiResponse? response = (await repository.getTimesheetStart(clientApplicableServiceId,selectedTaskId));
      if (response.success!) {
        Navigator.pop(context);
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
  /// update timesheet
  void callTimesheetUpdate(BuildContext context) async {
    try {
      ApiResponse? response = (await repository.getTimesheetStatusUpdate(clientApplicableServiceId,selectedTaskId,remark.text,statusStart));
      if (response.success!) {
        Navigator.pop(context);
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
  ///type of work
  void callTimesheetTypeOfWork() async {
    workList.clear();
    try {
      TypeOfWorkModel? response = (await repository.getTimesheetTypeOfWork());
      if (response.success!) {
        updateLoader(false);
        if(response.typeOfWorkList!.isNotEmpty){
          workList.addAll(response.typeOfWorkList!);

          for(var i =0;i < response.typeOfWorkList!.length; i++){
            detailsStepper3List.add(TextEditingController());
            timeStepper3List.add(TextEditingController());
          }
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

  List<int> addedIndex = [];
  addDetails(int index,TextEditingController value){
    if(addedIndex.contains(index)){
      addedIndex.add(index);
      workTypeDetailsList.insert(index, value.text);
    }
  }

  List<int> addedTimeIndex = [];
  addTime(int index,TextEditingController text,String value){
    // if(addedTimeIndex.contains(index)){
    //   addedTimeIndex.add(index);
    //   workTypeTimeList.insert(index, value);
    //   timeStepper3List.add(text);
    // }
    if(value.isEmpty){}
    else if (value.isNotEmpty){
      if(value.length >= 2 && !value.contains(":")) {
        value = '$value:';
        timeStepper3List[index].value = TextEditingValue(text:
        value,selection: TextSelection.collapsed(offset: value.length),);
        update();
      }
    }
    update();
  }

  Future<void> selectTimeForStepper3(BuildContext context,String timeFor,int index) async {
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
      selectedTime = picked;update();
    }
    timeStepper3List[index].text = "${selectedTime.hour}:${selectedTime.minute}";
    update();
  }

  /// add timesheet allotted
  void callTimesheetAddAllotted(String btnName) async {
    try {
      ApiResponse? response = (await repository.getTimesheetAddAllotted(selectedDateToSend,selectedClientId,
          selectedServiceId,clientApplicableServiceId,selectedTaskId,remark.text??"",totalTimeToShow));
      if (response.success!) {
        Utils.showSuccessSnackBar(response.message);
        updateLoader(false);
        clearStepper2();
        if(btnName =="save&goToNonAllotted"){
          currentService == "office" ? currentService = "nonAllotted": currentService ="office";
          update();
        }
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
  /// clear stepper 3
  clearStepper3(){
    addedIndex.clear(); workTypeIdList.clear(); workTypeDetailsList.clear(); update();
  }
  /// add timesheet office related
  void callTimesheetAddOfficeRelated(String action) async {
    try {
      ApiResponse? response = (await repository.getTimesheetAddOfficeRelated(selectedDateToSend,workTypeIdList.toString(),
          workTypeDetailsList.toString(),totalTimeToShow,action));
      if (response.success!) {
        Utils.showSuccessSnackBar(response.message);
        updateLoader(false);
        clearStepper1();clearStepper2();clearStepper3();update();
        Get.toNamed(AppRoutes.timesheetList);
      } else {
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
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
  /// timesheet log
  void callTimesheetLog(BuildContext context,String date,String id) async {
    timesheetLog.clear();
    try {
      TimesheetLogModel? response = (await repository.getTimesheetLog(date,id));
      if (response.success!) {
        timesheetLog = response.timesheetLogDetails!;
        openLog(context);
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
  openLog(BuildContext context){
    return showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return StatefulBuilder(
            builder: (BuildContext context,StateSetter state){
              return Align(
                alignment: Alignment.topCenter,
                child: SafeArea(
                    child: Container(
                      height: 270.0,
                      color: Colors.transparent,
                      child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: timesheetLog.length,
                                itemBuilder: (context,index){
                                  final item = timesheetLog[index];
                              return Column(
                                children: [
                                  const SizedBox(height: 10.0,),
                                  buildTextBoldWidget("Timesheet log by ${item.firmEmployeeName}", blackColor, context, 16.0),
                                  const SizedBox(height: 10.0,),
                                  const Divider(thickness: 2,),
                                  const SizedBox(height: 10.0,),
                                  Table(
                                    children: [
                                      buildTableTwoByTwoTitle(context,title1: "Date",title2: "Status",fontSize: 14.0),
                                      buildContentTwoByTwoSubTitle(context,contentTitle1: item.tDate!,contentTitle2: item.status!,fontSize: 14.0),
                                      const TableRow(children: [SizedBox(height: 15.0,),SizedBox(height: 15.0,),],),

                                      buildTableTwoByTwoTitle(context,title1: "Remark",title2: "Done By",fontSize: 14.0),
                                      buildContentTwoByTwoSubTitle(context,contentTitle1: "",contentTitle2: item.firmEmployeeName!,fontSize: 14.0),
                                      const TableRow(children: [SizedBox(height: 15.0,),SizedBox(height: 15.0,),],),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0,),
                                  GestureDetector(
                                    onTap: (){Navigator.pop(context);},
                                    child: buildButtonWidget(context, "Close",buttonColor: errorColor,),
                                  ),
                                  const SizedBox(height: 20.0,),
                                ],
                              );
                            })
                          )),
                    )
                ),
              );
            }
        );},
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim1),
          child: child,
        );},
    );
  }
  /// timesheet edit click data
  void callTimesheetEdit(String empId,String dateToSendApi,String screenFrom) async {
    updateLoader(true);
    try {
      workList.clear(); workTypeIdList.clear(); workTypeTimeList.clear();
      workTypeDetailsList.clear();
      TimesheetEditData? response = (await repository.getTimesheetEdit(dateToSendApi,empId));
      if (response.success!) {
        ///for view all
        viewTimesheet = response.timesheetData![0];
        viewNonAllottedTimesheet.addAll(response.nonAllottedData!);
        viewOfficeRelatedTimesheet.addAll(response.officeRelatedData!);
        ///stepper 1
        selectedDateToShow = response.timesheetData![0].formattedDate!;
        selectedDateToSend = response.timesheetData![0].addedDate!;
        selectedWorkAt = response.timesheetData![0].workat!;
        stepper1InTime.text = response.timesheetData![0].inTime!;
        stepper1OutTime.text = response.timesheetData![0].outTime!;
        timesheetTotalTime.text = "${response.timesheetData![0].timeHours} : ${response.timesheetData![0].timeMins}";
        ///stepper 2
        selectedClient = response.nonAllottedData![0].client!;
        selectedClientId = response.nonAllottedData![0].clientId!;
        selectedService = response.nonAllottedData![0].serviceName!;
        selectedServiceId = response.nonAllottedData![0].serviceId!;
        selectedTask = response.nonAllottedData![0].taskName!;
        selectedTaskId = response.nonAllottedData![0].taskId!;
        remark.text = response.nonAllottedData![0].remark!;
        stepper2TimeSpent.text = response.nonAllottedData![0].nohours!;
        ///stepper 3
        for (var element in response.officeRelatedData!) {
          workList.add(TypeOfWorkList(
              name: element.name, id: element.typeWork
          ));
          workTypeIdList.add(element.typeWork!);
          workTypeTimeList.add(element.nohours!);
          detailsStepper3List.add(TextEditingController(text: element.remark));update();
          timeStepper3List.add(TextEditingController(text: element.nohours));update();
        }
        screenFrom == "form" ? Get.toNamed(AppRoutes.timesheetForm): Get.toNamed(AppRoutes.timesheetDetails);
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
  /// timesheet list
  void callTimesheetList() async {
    timesheetList.clear();
    try {
      TimesheetListModel? response = (await repository.getTimesheetList(selectedTimesheetStatus,selectedFlag));
      if (response.success!) {
        timesheetList.addAll(response.timesheetListDetails!);
        updateLoader(false);
        update();
      } else {
        updateLoader(false);update();
      }
      updateLoader(false);
      update();
    } on CustomException {
      updateLoader(false);
      update();
    } catch (error) {
      updateLoader(false);
      update();
    }
  }
  String selectedActionId = "";
  String selectedAction = "";
  List<String> timesheetActionList = ["Send for Resubmission","Approve"];

  updateSelectedActionId(String id){selectedActionId = id ; update();}

  updateSelectedAction(String actionName){ selectedAction = actionName; update();}

  showActionDialog(BuildContext context,String id){
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
                    buildTextRegularWidget("Select action to perform", blackColor, context, 20,align: TextAlign.left),const SizedBox(height: 10.0,),
                    const SizedBox(height: 20.0,),
                    Container(
                        height: 40.0,width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: grey),),
                        child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                              child: DropdownButton(
                                hint: buildTextRegularWidget(selectedAction==""?"Select action":selectedAction, blackColor, context, 15.0),
                                isExpanded: true,
                                underline: Container(),
                                items: timesheetActionList.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                    onTap: (){
                                      setter((){
                                        updateSelectedActionId(value == "Approve" ? "4" : "5");
                                      });
                                    },
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setter((){
                                    updateSelectedAction(val!);
                                  });
                                },
                              ),
                            )
                        )
                    ),
                    const SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: (){
                              checkTimesheetAction(context,id);
                            },
                            child: buildButtonWidget(context, "Send"),
                          ),
                        ),const SizedBox(width: 5.0,),
                        Flexible(
                          child: GestureDetector(
                            onTap: (){
                              clearForTimesheetAction();
                              Navigator.pop(context);
                            },
                            child: buildButtonWidget(context, "Cancel"),
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

  clearForTimesheetAction(){
    selectedActionId=""; selectedAction="";update();
  }

  checkTimesheetAction(BuildContext context,String timesheetId){
    if(selectedAction == ""){
      Utils.showErrorSnackBar("Please select action to perform!");update();
    }
    else{
      callTimesheetAction(context, timesheetId);
      update();
    }
  }

  ///timesheet action
  void callTimesheetAction(BuildContext context,String timesheetId) async {
    updateLoader(true);
    try {
      ApiResponse? response = (await repository.getTimesheetAction(selectedActionId,timesheetId,selectedAction));
      if (response.success!) {
        clearForTimesheetAction();
        Navigator.pop(context);
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
