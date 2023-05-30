import 'package:biznew/constant/provider/custom_exception.dart';
import 'package:biznew/constant/repository/api_repository.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/claim_form/claim_model.dart';
import 'package:biznew/screens/dashboard/dashboard_model.dart';
import 'package:biznew/screens/manual_assignment/manual_assignment_model.dart';
import 'package:biznew/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ManualAssignmentController extends GetxController {
  final ApiRepository repository;

  // ignore: unnecessary_null_comparison
  ManualAssignmentController({required this.repository}) : assert(repository != null);

  ///common
  String userId="";
  String userName="";
  String name="";
  bool loader = false;
  List<String> noDataList = ["No Data Found!"];
  bool validateClientYear = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userId = GetStorage().read("userId")??"";
    userName = GetStorage().read("userName")??"";
    name = GetStorage().read("name")??"";
    repository.getData();

    callClientNameList();
    callYearList();
    callEmployeeList();
    callMainCategoryList();
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

  List<YearList> yearList = [];
  String selectedYear = "";
  String selectedYearId = "";

  ///dropdown for year
  updateSelectedYear(String val,BuildContext context){
    if(yearList.isNotEmpty){selectedYear= val; checkClientYearValidation(context); update();}
  }

  updateSelectedYearId(String valId){
    if(yearList.isNotEmpty){
      selectedYearId = valId;
      callServicesList();
      update();
    }
  }

  checkClientYearValidation(BuildContext context){
    if(selectedYear.isEmpty){ validateClientYear = true; update(); }
    else{validateClientYear = false; update(); }
  }

  /// year list
  void callYearList() async {
    yearList.clear();
    try {
      ClaimYearModel? response = (await repository.getClaimYearList());

      if (response.success!) {
        if (response.yearList!.isEmpty) {
        }
        else{
          yearList.addAll(response.yearList!);
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

  List<NameList> clientNameList = [];
  String selectedClientName = "";
  String selectedClientId = "";
  String clientFirmId = "";
  bool validateClientName = false;

  ///dropdown for client name
  updateSelectedClientName(String val,BuildContext context){
    if(clientNameList.isNotEmpty){
      selectedClientName= val;checkClientNameValidation(context); update();
    }
  }
  updateSelectedClientId(String valId,String id){
    if(clientNameList.isNotEmpty){
      clientFirmId = id;selectedClientId = valId;update();
    }
  }

  checkClientNameValidation(BuildContext context){
    if(selectedClientName.isEmpty){ validateClientName = true; update(); }
    else{validateClientName = false; update(); }
  }

  /// client name list
  void callClientNameList() async {
    clientNameList.clear();
    try {
      ClientNameModel? response = (await repository.getClientNameList());

      if (response.success!) {
        if (response.nameList!.isEmpty) {
        }
        else{
          clientNameList.addAll(response.nameList!);
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

  List<ClaimServiceList> serviceList = [];
  String selectedService = "";
  String selectedServiceId = "";
  String clientServiceId = "";
  bool validateClientService = false;

  /// services list
  void callServicesList() async {
    serviceList.clear();
    try {
      print("in api clientFirmId");
      print(clientFirmId);
      print(selectedYearId);
      ClaimServiceResponse? response = (await repository.getClaimServicesList(clientFirmId,selectedYearId));
      print("response");
      print(response);
      if (response.success!) {
        if (response.serviceList!.isEmpty) {
        }
        else{
          serviceList.addAll(response.serviceList!);
        }
        print("serviceList.length");
        print(serviceList.length);
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
  ///dropdown for service
  updateSelectedService(String val,BuildContext context){
    if(serviceList.isNotEmpty){selectedService= val; checkClientServiceValidation(context); update();}
  }
  updateSelectedServiceId(String valId,String id){
    if(serviceList.isNotEmpty){
      clientServiceId = id;selectedServiceId = valId;
      //callTaskList();

      callLoadAllTaskService(id);
      update();
    }
  }
  checkClientServiceValidation(BuildContext context){
    if(selectedService.isEmpty){ validateClientService = true; update(); }
    else{validateClientService = false; update(); }
  }

  List<ClaimSubmittedByList> employeeList = [];
  String selectedEmployee = "";
  String selectedEmployeeId = "";
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
  updateSelectedEmployee(String empName,String empMastId){
    selectedEmployee = empName;
    selectedEmployeeId = empMastId;
    update();
  }

  ///main category list
  List<ServicesMainCategoryList> mainCategoryList = [];
  String selectedMainCategory = "";
  String selectedMainCategoryId = "";
  bool validateMainCategory = false;
  void callMainCategoryList() async {
    mainCategoryList.clear();
    try {
      MainCategoryModel? response = (await repository.getMainCategoryList());

      if (response.success!) {
        if (response.servicesMainCategoryList!.isEmpty) {
        }
        else{
          mainCategoryList.addAll(response.servicesMainCategoryList!);
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
  updateSelectedMainCategory(String val,BuildContext context){
    if(mainCategoryList.isNotEmpty){selectedMainCategory= val; checkClientServiceValidation(context); update();}
  }
  updateSelectedMainCategoryId(String id,){
    if(mainCategoryList.isNotEmpty){
      selectedMainCategoryId = id;
      update();
    }
  }

  List<ClaimTaskList> taskList = [];
  ///task list
  void callTaskList() async {
    taskList.clear();
    try {
      ClaimTaskResponse? response = (await repository.getClaimTaskList(selectedServiceId));

      if (response.success!) {
        if (response.taskList!.isEmpty) {
        }
        else{
          taskList.addAll(response.taskList!);
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

  updateLoader(bool val) { loader = val; update(); }

  DateTime selectedDate = DateTime.now();
  String selectedTriggerDate = "";
  String selectedTriggerDateToSend = "";
  String selectedTargetDate = "";
  String selectedTargetDateToSend = "";
  bool validateTriggerDate = false;
  bool validateTargetDate = false;

  Future<void> selectDate(BuildContext context,String dateFor) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: dateFor=="triggerDate" ? DateTime.now() : selectedDate,
        lastDate: DateTime(2100, 1));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }

    String formattedMonth = "";
    String formattedDay = "";

    if(dateFor=="triggerDate"){

      ///format month
      if(selectedDate.month.toString().length==1){
        formattedMonth = selectedDate.month.toString().padLeft(2, '0');
      }
      else{
        formattedMonth = selectedDate.month.toString();
      }

      ///format date
      if(selectedDate.day.toString().length==1){
        formattedDay = selectedDate.day.toString().padLeft(2, '0');
      }
      else{
        formattedDay = selectedDate.day.toString();
      }

      selectedTriggerDate = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      selectedTriggerDateToSend = "${selectedDate.year}-$formattedMonth-$formattedDay";
      selectedTargetDate = selectedTriggerDate;
      selectedTriggerDate=="" ? validateTriggerDate = true: validateTriggerDate = false;

      selectedTargetDateToSend = selectedTriggerDateToSend;
      update();
    }
    else if(dateFor=="targetDate"){
      selectedTargetDate = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      update();
    }
    update();
  }

  navigateToHomeScreen(){
    selectedYear = "" ; selectedYearId = "";
    Get.toNamed(AppRoutes.bottomNav);
    update();
  }

  List<String> priorityList = ["High", "Medium", "Low"];
  String selectedPriority = "";
  bool validatePriority = false;

  updateSelectedPriority(String value,BuildContext context){
    selectedPriority = value; checkPriorityValidation(context);
    update();
  }

  checkPriorityValidation(BuildContext context){
    if(selectedPriority.isEmpty){ validatePriority = true; update(); }
    else{validatePriority = false; update(); }
  }

  TextEditingController feesController = TextEditingController();
  bool validateFees = false;
  TextEditingController remarkController = TextEditingController();

  ///fees
  checkFeesValidation(BuildContext context){
    if(feesController.text.isEmpty){ validateFees = true; update(); }
    else{validateFees = false; update(); }
  }

  List<TextEditingController> taskNameList = [];
  List<LoadAllTaskData> loadAllTaskList = [];
  String selectedReassignId = "";

  void callLoadAllTaskService(String cliId) async {
    loadAllTaskList.clear();
    updateLoader(true);
    try {
      LoadAllTaskModel? response = (await repository.getLoadAllTaskService(cliId));

      print("load all response");
      print(response);
      if (response.success!) {
        loadAllTaskList.addAll(response.loadAllTaskData!);

        selectedReassignId = cliId;
        for (var element in loadAllTaskList) {
          taskNameList.add(TextEditingController(text: element.taskName));
        }
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
}