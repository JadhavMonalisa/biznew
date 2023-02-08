import 'package:biznew/constant/provider/custom_exception.dart';
import 'package:biznew/constant/repository/api_repository.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/petty_task/petty_task_model.dart';
import 'package:biznew/utils/custom_response.dart';
import 'package:biznew/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PettyTaskController extends GetxController {
  final ApiRepository repository;

  // ignore: unnecessary_null_comparison
  PettyTaskController({required this.repository}) : assert(repository != null);

  ///common
  String userId="";
  String userName="";
  String name="";
  bool loader = false;
  List<String> noDataList = ["No Data Found!"];
  bool validateBranchName = false;
  bool validateClientName = false;
  bool validateEmployeeName = false;
  List<Branchlist> branchNameList = [];
  List<Clientslist> clientNameList = [];
  List<EmplyeeList> employeeNameList = [];
  String selectedBranchName = "";
  String selectedClientName = "";
  String selectedEmployeeName = "";
  String selectedTriggerDate = "";
  String selectedTriggerDateToSend = "";
  bool validateTriggerDate = false;
  String selectedTargetDate = "";
  String selectedTargetDateToSend = "";
  bool validateTargetDate = false;
  DateTime selectedDate = DateTime.now();
  TextEditingController task = TextEditingController();
  bool validateTask = false;
  String selectedBranchId = "";
  String selectedClientId = "";
  String selectedEmpId = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userId = GetStorage().read("userId")??"";
    userName = GetStorage().read("userName")??"";
    name = GetStorage().read("name")??"";
    repository.getData();
    callBranchNameList();
  }

  updateLoader(bool val) { loader = val; update(); }

  clearAll(){
    selectedBranchId = ""; selectedClientId = ""; selectedEmpId = "";
    selectedBranchName = ""; selectedClientName = ""; selectedEmployeeName = "";
    selectedTriggerDate = "" ; selectedTargetDate = ""; selectedDate = DateTime.now(); task.clear();
    update();
  }

  onWillPopBack(){
    clearAll();
    Get.offNamedUntil(AppRoutes.bottomNav, (route) => false);
    update();
  }

  ///branch name
  updateSelectedBranchId(String val){
    if(branchNameList.isNotEmpty){
      selectedBranchId = val; callClientList(); callEmpList(); update();
    }
  }
  checkBranchNameValidation(String val){
    if(branchNameList.isNotEmpty){
      selectedBranchName = val;
      selectedClientId = ""; selectedClientName ="";
      selectedEmpId = ""; selectedEmployeeName = "";
      update();
      if(selectedBranchName==""){ validateBranchName = true; update(); }
      else{validateBranchName = false; update(); }
    }
  }
  ///client name
  updateSelectedClientId(String val,BuildContext context){
    if(clientNameList.isNotEmpty){
      selectedClientId = val;  update();
    }
  }
  checkClientNameValidation(String val, BuildContext context){
    if(clientNameList.isNotEmpty){
      selectedClientName = val; update();
      if(selectedClientName==""){ validateClientName = true; update(); }
      else{validateClientName = false; update(); }
    }
  }
  ///employee name
  updateSelectedEmpId(String val,BuildContext context){
    selectedEmpId = val; update();
  }
  checkEmployeeNameValidation(String val,BuildContext context){
    if(employeeNameList.isNotEmpty){
      selectedEmployeeName = val;update();
      if(selectedEmployeeName==""){ validateEmployeeName = true; update(); }
      else{validateEmployeeName = false; update(); }
    }
  }
  ///task
  checkTaskValidation(BuildContext context){
    if(task.text.isEmpty){ validateTask = true; update(); }
    else{validateTask = false; update(); }
  }
  ///all validations
  checkValidation(BuildContext context){
    updateLoader(true);
    if(selectedBranchName=="" || selectedClientName=="" || selectedEmployeeName=="" ||
    selectedTriggerDate=="" || selectedTargetDate=="" || task.text.isEmpty){

      selectedBranchName=="" ? validateBranchName = true: validateBranchName = false;
      selectedClientName=="" ? validateClientName = true: validateClientName = false;
      selectedEmployeeName=="" ? validateEmployeeName = true: validateEmployeeName = false;
      selectedTriggerDate=="" ? validateTriggerDate = true: validateTriggerDate = false;
      selectedTargetDate=="" ? validateTargetDate = true: validateTargetDate = false;
      task.text.isEmpty ? validateTask = true: validateTask = false;
      updateLoader(false);
      update();
    }

    else{
      callAddPettyTask(context);
    }
  }

  Future<void> selectDate(BuildContext context,String dateFor) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1700, 1),
        lastDate: DateTime(2100, 1));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
    if(dateFor=="triggerDate"){
      selectedTriggerDate = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      selectedTriggerDateToSend = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
      selectedTriggerDate=="" ? validateTriggerDate = true: validateTriggerDate = false;
      update();
    }
    else if(dateFor=="targetDate"){
      selectedTargetDate = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      selectedTargetDateToSend = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
      selectedTargetDate=="" ? validateTargetDate = true: validateTargetDate = false;
      update();
    }
    update();
  }
  /// branch name list
  void callBranchNameList() async {
    branchNameList.clear();
    try {
      BranchNameModel? response = (await repository.getBranchNameList());
      if (response.success!) {
        branchNameList.addAll(response.branchListDetails!);
        if(branchNameList.length==1){
          selectedBranchId = branchNameList[0].id!;
          selectedBranchName = branchNameList[0].name!;
          callClientList();callEmpList();
        }
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
  /// branch client list
  void callClientList() async {
    clientNameList.clear();
    try {
      BranchClientListModel? response = (await repository.getBranchClientList(selectedBranchId));
      if (response.success!) {
        clientNameList.addAll(response.clientListDetails!);

        if(clientNameList.length==1){
          selectedClientId = clientNameList[0].firmClientId!;
          selectedClientName = clientNameList[0].firmClientFirmName!;
        }
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
  /// branch employee list
  void callEmpList() async {
    employeeNameList.clear();
    try {
      BranchEmpModel? response = (await repository.getBranchEmpList(selectedBranchId));
      if (response.success!) {
        employeeNameList.addAll(response.empListDetails!);
        if(employeeNameList.length==1){
          selectedEmpId = employeeNameList[0].mastId!;
          selectedEmployeeName = employeeNameList[0].firmEmployeeName!;
        }
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
  /// add petty task
  void callAddPettyTask(BuildContext context) async {
    try {
      ApiResponse? response = (await repository.getAddPettyTask(selectedBranchId,selectedClientId,selectedEmpId,
        selectedTargetDateToSend,selectedTriggerDateToSend,task.text));
      if (response.success!) {
        Utils.showSuccessSnackBar(response.message);
        clearAll();
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