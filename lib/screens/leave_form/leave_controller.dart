import 'package:age_calculator/age_calculator.dart';
import 'package:biznew/constant/provider/custom_exception.dart';
import 'package:biznew/constant/repository/api_repository.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/claim_form/claim_model.dart';
import 'package:biznew/screens/leave_form/leave_model.dart';
import 'package:biznew/utils/custom_response.dart';
import 'package:biznew/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LeaveController extends GetxController {
  final ApiRepository repository;

  // ignore: unnecessary_null_comparison
  LeaveController({required this.repository}) : assert(repository != null);

  ///common
  String userId="";
  String userName="";
  String name="";
  String reportingHead="";
  ///form
  DateTime selectedDate = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String selectedStartDateToShow = "";
  String selectedStartDateToSend = "";
  String selectedEndDateToShow = "";
  String selectedEndDateToSend = "";
  TextEditingController leaveReason = TextEditingController();
  int year = 0;
  int month = 0;
  int days = 0;
  int totalDays = 0;
  List<LeaveTypeList> leaveTypeList = [];
  List<String> noDataList = ["No Data Found!"];
  String selectedLeaveType = "";
  String selectedLeaveTypeId = "";
  String? selectedLeave;
  String? selectedLeaveForExam;
  String nameOfLeaveFor = "";
  String nameOfLeaveForExam = "";
  String firmEmployeeName = "";
  int selectedLeaveIndex =0;
  int selectedLeaveForExamIndex =0;
  final leaveForList = ["Full Day", "First Half", "Second Half"];
  final leaveForExamList = ["1st group", "2nd group", "Both"];
  TextEditingController noOfAttempt = TextEditingController();
  bool edit = true;
  bool loader = false;
  bool validateLeaveType = false;
  bool validateStartDate = false;
  bool validateEndDate = false;
  bool validateReason = false;
  bool validateLeaveFor = false;
  bool validateNoOfAttempt = false;
  bool validateLeaveForExam = false;
  ///leave list
  int selectedLeaveFlag = 0;
  List<LeaveListData> leaveList = [];
  String selectedLeaveId = "";
  String selectedEmployee = "";
  String selectedLeaveStatus = "";
  List<String> leaveStatusList = ["Approved","Pending for approval","Cancelled","Apply For Cancel"];
  ///leave edit
  String selectedLeaveIdForEdit = "";
  List<LeaveEditDetails> leaveEditList = [];
  ///leave update status
  String statusAction = "";
  String idForStatusUpdate = "";
  TextEditingController remark = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    userId = GetStorage().read("userId")??"";
    userName = GetStorage().read("userName")??"";
    name = GetStorage().read("name")??"";
    reportingHead = GetStorage().read("reportingHead")??"";
    repository.getData();
    callEmployeeList();
    callLeaveCountList();
    callLeaveTypeList();
    callLeaveList();
  }

  onWillPopBack(){
    clearForm();
    Get.offNamedUntil(AppRoutes.bottomNav, (route) => false);
    update();
  }

  onBackPressToLeaveList(){
    clearForm();
    Get.toNamed(AppRoutes.leaveList);
    update();
  }

  functionCall(String screenName){
    if(screenName=="add"){
      checkLeaveFormValidation();
    }
    else if(screenName=="edit"){
      callLeaveUpdate();
    }
  }

  navigateToLeaveEdit(String leaveId,String screenFrom){
    selectedLeaveId = leaveId;
    callLeaveEditList();

    screenFrom == "form" ? Get.toNamed(AppRoutes.leaveForm,arguments: ["edit"])
        : Get.toNamed(AppRoutes.leaveDetails);

    update();
  }

  updateSelectedClaimStatus(String val){ selectedEmployee = val;callLeaveList(); update();}

  updateSelectedLeaveStatus(String val){ selectedLeaveStatus = val;
  updateLoader(true);
  callLeaveList(); update();}

  updateSelectedLeaveFlag(int val,BuildContext context){
    selectedEmployee = "";selectedLeaveStatus="";
    updateLoader(true); selectedLeaveFlag = val;

    callLeaveList(); update();}

  List<ClaimSubmittedByList> employeeList = [];
  ///update emp list
  updateSelectedEmployee(String val){
    if(employeeList.isNotEmpty){
      selectedEmployee = val; updateLoader(true); callLeaveList();update();
    }
  }
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

  /// leave list
  void callLeaveList() async {
    leaveList.clear();
    try {
      LeaveListModel? response = (await repository.getLeaveList(
        selectedLeaveFlag==0?"own":"team", selectedLeaveStatus,));

      if (response.success!) {
        if (response.leaveListDetails!.isEmpty) {
        }
        else{
          leaveList.addAll(response.leaveListDetails!);update();
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

  Future<void> selectDate(BuildContext context,String forWhat) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1700, 1),
        lastDate: DateTime(2100, 1));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
    if(forWhat=="start")
    {
      startDate = selectedDate;
      selectedStartDateToSend = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
      selectedStartDateToShow = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";

      if(endDate.isAfter(startDate)){
        DateDuration duration;
        duration = AgeCalculator.dateDifference(fromDate: startDate, toDate: endDate);

        year = duration.years; month = duration.months;
        days = duration.days == 0 ? 1 :
               duration.days == 1 ? 2 : duration.days;
      }
      checkStartDateValidation();
      update();
    }
    else if(forWhat=="end"){
      endDate = selectedDate;
      selectedEndDateToSend = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
      selectedEndDateToShow = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";

      DateDuration duration;
      duration = AgeCalculator.dateDifference(fromDate: startDate, toDate: endDate);

      year = duration.years; month = duration.months;
      days = duration.days == 0 ? 1 :
             duration.days == 1 ? 2 : duration.days;

      checkEndDateValidation();
      update();
    }
    update();
  }

  changeSelectedIndex(v,String leaveName) {
    selectedLeave = v;
    nameOfLeaveFor = leaveName;
    print(nameOfLeaveFor);
    if(selectedStartDateToShow!=selectedEndDateToShow){

    }
    else{
      checkLeaveForValidation();
      update();
    }
    update();
  }

  changeSelectedIndexForExam(v,String nameForExam) {
    selectedLeaveForExam = v;
    nameOfLeaveForExam = nameForExam;
    if(selectedLeaveType=="Exam Leave"){
      checkLeaveForExamValidation();
      update();
    }
    else{

    }
    update();
  }

  updateSelectedLeaveTypeId(String val,String leaveType){
    if(leaveTypeList.isNotEmpty){
      selectedLeaveTypeId = val; selectedLeaveType = leaveType;
      if(selectedLeaveType == "Exam Leave"){
        leaveReason.text = "Examination Attempt"; edit = false; update();
      }
      else{
        leaveReason.clear();
        edit = true; update();
      }
      checkLeaveTypeValidation();
      callLeaveTypeList(); update();
    }
  }

  updateSelectedLeave(String val,BuildContext context){
    if(leaveTypeList.isNotEmpty){
      selectedLeaveType = val;
      if(selectedLeaveType == "Exam Leave"){
        leaveReason.text = "Examination Attempt"; edit = false; update();
      }
      else{
        leaveReason.clear();
        edit = true; update();
      }
      checkLeaveTypeValidation();
      update();
    }
  }

  checkLeaveTypeValidation(){
    if(leaveTypeList.isEmpty){ validateLeaveType = true; update(); }
    else{validateLeaveType = false; update(); }
  }
  checkStartDateValidation(){
    if(selectedStartDateToShow.isEmpty){ validateStartDate = true; update(); }
    else if(endDate.isBefore(startDate)){validateEndDate = true; update();}
    else{validateStartDate = false; update(); }
  }
  checkEndDateValidation(){
    if(selectedEndDateToShow.isEmpty){ validateEndDate = true; update(); }
    else{validateEndDate = false; update(); }
  }
  checkReasonValidation(BuildContext context){
    if(selectedLeaveType == "Exam Leave"){}
    else{
      if(leaveReason.text.isEmpty){ validateReason = true; update(); }
      else{validateReason = false; update(); }
    }
    update();
  }
  checkLeaveForValidation(){
    if(nameOfLeaveFor==""){ validateLeaveFor = true; update(); }
    else{validateLeaveFor = false; update(); }
  }
  checkNoOfThisAttemptValidation(BuildContext context){
    if(noOfAttempt.text.isEmpty){ validateNoOfAttempt = true; update(); }
    else{validateNoOfAttempt = false; update(); }
  }
  checkLeaveForExamValidation(){
    if(nameOfLeaveForExam==""){ validateLeaveForExam = true; update(); }
    else{validateLeaveForExam = false; update(); }
  }
  updateLoader(bool val) { loader = val; update(); }
  checkLeaveFormValidation(){
    updateLoader(true);
    if(selectedLeaveType == "" ||  selectedStartDateToShow == "" || selectedEndDateToShow == ""
        || (selectedLeaveType!="Exam Leave" && leaveReason.text.isEmpty)
        || (selectedEndDateToShow == selectedStartDateToShow && nameOfLeaveFor == "")
        || (selectedLeaveType=="Exam Leave" && noOfAttempt.text.isEmpty)
        || (selectedLeaveType=="Exam Leave" && nameOfLeaveForExam == "")
    ){
      selectedLeaveType == ""  ? validateLeaveType = true : validateLeaveType = false;
      selectedStartDateToShow == ""  ? validateStartDate = true : validateStartDate = false;
      selectedEndDateToShow == ""  ? validateEndDate = true : validateEndDate = false;
      (selectedLeaveType!="Exam Leave" && leaveReason.text.isEmpty) ? validateReason = true : validateReason = false;
      (selectedEndDateToShow == selectedStartDateToShow && nameOfLeaveFor == "")   ? validateLeaveFor = true : validateLeaveFor = false;
      (selectedLeaveType=="Exam Leave" && noOfAttempt.text.isEmpty)  ? validateNoOfAttempt = true : validateNoOfAttempt = false;
      (selectedLeaveType=="Exam Leave" && nameOfLeaveForExam == "")   ? validateLeaveForExam = true : validateLeaveForExam = false;
      updateLoader(false);
      update();
    }else{
      updateLoader(false);
      callLeaveAdd();
    }
    update();
  }

  ///leave count
  void callLeaveCountList() async {
    try {
      TotalLeaveCountResponse? response = (await repository.getLeaveCountList());

      if (response.success!) {
        if(response.totalLeaves==null || response.totalLeaves==""){}
        else{
          totalDays = int.parse(response.totalLeaves!);
        }
        updateLoader(false);
        update();
      } else {
        updateLoader(false);
        update();
      }
    } on CustomException {
      update();
    } catch (error) {
      update();
    }
  }
  ///leave type api
  void callLeaveTypeList() async {
    leaveTypeList.clear();
    try {
      LeaveTypeModel? response = (await repository.getLeaveTypeList());

      if (response.success!) {
        if (response.leaveTypeDetailsList!.isEmpty) {
        }
        else{
          leaveTypeList.addAll(response.leaveTypeDetailsList!);
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
  ///leave add
  void callLeaveAdd() async {
    updateLoader(true);
    try {
      ApiResponse? response = (await repository.getAddLeave(
          selectedLeaveTypeId, days.toString(), selectedStartDateToSend, selectedEndDateToSend,
          leaveReason.text, nameOfLeaveFor??"",noOfAttempt.text??"",nameOfLeaveForExam??""));

      if (response.success!) {
        clearForm();
        Utils.showSuccessSnackBar(response.message);
        callLeaveList();
        Get.toNamed(AppRoutes.leaveList);
        updateLoader(false);
        update();
      } else {
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);
        update();
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
  ///clear all fields
  clearForm(){
    selectedLeaveTypeId = "";
    selectedLeaveFlag = 0; selectedEmployee = "";selectedLeave="";
    year=0; month=0; days=0; leaveReason.clear(); selectedLeaveType = "";
    nameOfLeaveFor="";selectedLeaveStatus = "";
    selectedStartDateToShow = ""; selectedEndDateToShow = "";
    update();
  }
  ///leave edit list
  void callLeaveEditList() async {
    leaveEditList.clear();
    updateLoader(true);
    try {
      LeaveEditModel? response = (await repository.getLeaveEditList(selectedLeaveId));

      if (response.success!) {
        if (response.leaveEditDetails!.isEmpty) {
        }
        else{
          leaveEditList.addAll(response.leaveEditDetails!);
          selectedLeaveTypeId = leaveEditList[0].leaveType!;

          selectedStartDateToShow = leaveEditList[0].startDateToShow!;
          selectedStartDateToSend = leaveEditList[0].startDate!;

          selectedEndDateToShow = leaveEditList[0].endDateToShow!;
          selectedEndDateToSend = leaveEditList[0].endDate!;

          leaveReason.text = leaveEditList[0].reason!;
          days = int.parse(leaveEditList[0].dayLeave!);
          totalDays = int.parse(leaveEditList[0].totalDays!);
          noOfAttempt.text = leaveEditList[0].attempts!;
          selectedLeaveType = leaveEditList[0].leaveTypeName!;

          firmEmployeeName = leaveEditList[0].firmEmployeeName!;
        }
        updateLoader(false);
        update();
      } else {
        updateLoader(false);
        update();
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
  ///leave update
  void callLeaveUpdate() async {
    updateLoader(true);
    try {
      ApiResponse? response = (await repository.getUpdateLeave(
          selectedLeaveTypeId, days.toString(), selectedStartDateToSend, selectedEndDateToSend,
          leaveReason.text, nameOfLeaveFor,noOfAttempt.text.isEmpty?"":noOfAttempt.text,
          nameOfLeaveForExam??"",selectedLeaveId??""));

      if (response.success!) {
        clearForm();
        Utils.showSuccessSnackBar(response.message);
        callLeaveList();
        Get.toNamed(AppRoutes.leaveList);
        updateLoader(false);
        update();
      } else {
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);
        update();
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
  ///update selected status
  updateStatus(String action,String leaveId){
    if(action == "Cancel" && remark.text.isEmpty){
      Utils.showErrorSnackBar("Please add remark!");update();
    }
    else{
      idForStatusUpdate = leaveId;
      statusAction = action;
      callLeaveUpdateStatus(); update();
    }
  }
  /// update status
  void callLeaveUpdateStatus() async {
    updateLoader(true);
    try {
      ApiResponse? response = (await repository.getLeaveUpdateStatus(idForStatusUpdate,statusAction,remark.text));

      if (response.success!) {
        Utils.showSuccessSnackBar(response.message);
        updateLoader(false);
        update();
      } else {
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);
        update();
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