import 'package:biznew/constant/provider/custom_exception.dart';
import 'package:biznew/constant/repository/api_repository.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/claim_form/claim_model.dart';
import 'package:biznew/screens/manual_assignment/manual_assignment_model.dart';
import 'package:biznew/utils/custom_response.dart';
import 'package:biznew/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';

class ManualAssignmentController extends GetxController {
  final ApiRepository repository;

  // ignore: unnecessary_null_comparison
  ManualAssignmentController({required this.repository})
      : assert(repository != null);

  ///common
  String userId = "";
  String userName = "";
  String name = "";
  bool loader = false;
  List<String> noDataList = ["No Data Found!"];
  bool validateClientYear = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userId = GetStorage().read("userId") ?? "";
    userName = GetStorage().read("userName") ?? "";
    name = GetStorage().read("name") ?? "";
    repository.getData();

    callClientNameList();
    callYearList();
    callEmployeeList();
    callMainCategoryList();
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

  List<YearList> yearList = [];
  String selectedYear = "";
  String selectedYearId = "";

  ///dropdown for year
  updateSelectedYear(String val, BuildContext context) {
    if (yearList.isNotEmpty) {
      selectedYear = val;
      checkClientYearValidation(context);
      update();
    }
  }

  updateSelectedYearId(String valId) {
    if (yearList.isNotEmpty) {
      selectedYearId = valId;
      callServicesList();
      update();
    }
  }

  checkClientYearValidation(BuildContext context) {
    if (selectedYear.isEmpty) {
      validateClientYear = true;
      update();
    } else {
      validateClientYear = false;
      update();
    }
  }

  /// year list
  void callYearList() async {
    yearList.clear();
    try {
      ClaimYearModel? response = (await repository.getClaimYearList());

      if (response.success!) {
        if (response.yearList!.isEmpty) {
        } else {
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
  updateSelectedClientName(String val, BuildContext context) {
    if (clientNameList.isNotEmpty) {
      selectedClientName = val;
      checkClientNameValidation(context);
      update();
    }
  }

  updateSelectedClientId(String valId, String id) {
    if (clientNameList.isNotEmpty) {
      clientFirmId = valId;
      selectedClientId = id;
      update();
    }
  }

  checkClientNameValidation(BuildContext context) {
    if (selectedClientName.isEmpty) {
      validateClientName = true;
      update();
    } else {
      validateClientName = false;
      update();
    }
  }

  /// client name list
  void callClientNameList() async {
    clientNameList.clear();
    try {
      ClientNameModel? response = (await repository.getClientNameList());

      if (response.success!) {
        if (response.nameList!.isEmpty) {
        } else {
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
      ClaimServiceResponse? response =
          (await repository.getClaimServicesList(selectedClientId, selectedYearId));
      if (response.success!) {
        if (response.serviceList!.isEmpty) {
        } else {
          serviceList.addAll(response.serviceList!);
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

  ///dropdown for service
  updateSelectedService(String val, BuildContext context) {
    if (servicesFromCategoryList.isNotEmpty) {
      selectedService = val;
      checkClientServiceValidation(context);
      update();
    }
  }

  updateSelectedServiceId(String id, String serviceName) {
    if (servicesFromCategoryList.isNotEmpty) {
      selectedServiceId = id;
      selectedService = serviceName;
      callTasksList();
      update();
    }
  }

  checkClientServiceValidation(BuildContext context) {
    if (selectedService.isEmpty) {
      validateClientService = true;
      update();
    } else {
      validateClientService = false;
      update();
    }
  }

  List<ClaimSubmittedByList> employeeList = [];
  String selectedEmployee = "";
  String selectedEmployeeId = "";
  void callEmployeeList() async {
    employeeList.clear();
    updateLoader(true);
    try {
      ClaimSubmittedByResponse? response =
          (await repository.getClaimSubmittedByList());

      if (response.success!) {
        if (response.claimSubmittedByListDetails!.isEmpty) {
        } else {
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

  updateSelectedEmployee(String empName, String empMastId) {
    selectedEmployee = empName;
    selectedEmployeeId = empMastId;

    taskSelectedEmpList.clear();
    taskSelectedEmpIdList.clear();
    for (var element in tasksList) {
      taskSelectedEmpList.add(empName);
      taskSelectedEmpIdList.add(empMastId);
      update();
    }
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
        } else {
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

  updateSelectedMainCategory(String val, BuildContext context) {
    if (mainCategoryList.isNotEmpty) {
      selectedMainCategory = val;
      checkMainCategoryValidation(context);
      update();
    }
  }

  updateSelectedMainCategoryId(String id) {
    if (mainCategoryList.isNotEmpty) {
      selectedMainCategoryId = id;
      callServicesFromMainCategoryList();
      update();
    }
  }

  checkMainCategoryValidation(BuildContext context) {
    if (mainCategoryList.isEmpty) {
      validateMainCategory = true;
      update();
    } else {
      validateMainCategory = false;
      update();
    }
  }

  List<ServicesList> servicesFromCategoryList = [];
  void callServicesFromMainCategoryList() async {
    servicesFromCategoryList.clear();
    try {
      ServicesFromMainCategoryModel? response = (await repository
          .getServicesFromMainCategoryList(selectedMainCategoryId));

      if (response.success!) {
        if (response.servicesList!.isEmpty) {
        } else {
          servicesFromCategoryList.addAll(response.servicesList!);
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

  updateLoader(bool val) {
    loader = val;
    update();
  }

  DateTime selectedDate = DateTime.now();
  String selectedTriggerDate = "";
  String selectedTriggerDateToSend = "";
  String selectedTargetDate = "";
  String selectedTargetDateToSend = "";
  bool validateTriggerDate = false;
  bool validateTargetDate = false;

  Future<void> selectDate(BuildContext context, String dateFor) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: dateFor == "triggerDate" ? DateTime.now() : selectedDate,
        lastDate: DateTime(2100, 1));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }

    String formattedMonth = "";
    String formattedDay = "";

    if (dateFor == "triggerDate") {
      ///format month
      if (selectedDate.month.toString().length == 1) {
        formattedMonth = selectedDate.month.toString().padLeft(2, '0');
      } else {
        formattedMonth = selectedDate.month.toString();
      }

      ///format date
      if (selectedDate.day.toString().length == 1) {
        formattedDay = selectedDate.day.toString().padLeft(2, '0');
      } else {
        formattedDay = selectedDate.day.toString();
      }

      selectedTriggerDate = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      selectedTriggerDateToSend = "${selectedDate.year}-$formattedMonth-$formattedDay";
      selectedTriggerDate == ""
          ? validateTriggerDate = true
          : validateTriggerDate = false;

      print(selectedTriggerDateToSend);
      update();
    } else if (dateFor == "targetDate") {
      ///format month
      if (selectedDate.month.toString().length == 1) {
        formattedMonth = selectedDate.month.toString().padLeft(2, '0');
      } else {
        formattedMonth = selectedDate.month.toString();
      }

      ///format date
      if (selectedDate.day.toString().length == 1) {
        formattedDay = selectedDate.day.toString().padLeft(2, '0');
      } else {
        formattedDay = selectedDate.day.toString();
      }

      selectedTargetDate = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      selectedTargetDateToSend = "${selectedDate.year}-$formattedMonth-$formattedDay";
      selectedTargetDate == ""
          ? validateTargetDate = true
          : validateTargetDate = false;
      update();

      print(selectedTargetDateToSend);
    }
    update();
  }

  navigateToHomeScreen() {
    selectedYear = "";
    selectedYearId = "";
    Get.offNamed(AppRoutes.bottomNav);
    update();
  }

  List<String> priorityList = ["High", "Medium", "Low"];
  String selectedPriority = "";
  bool validatePriority = false;

  updateSelectedPriority(String value, BuildContext context) {
    selectedPriority = value;
    checkPriorityValidation(context);
    update();
  }

  checkPriorityValidation(BuildContext context) {
    if (selectedPriority.isEmpty) {
      validatePriority = true;
      update();
    } else {
      validatePriority = false;
      update();
    }
  }

  TextEditingController feesController = TextEditingController();
  //bool validateFees = false;
  TextEditingController remarkController = TextEditingController();

  // ///fees
  // checkFeesValidation(BuildContext context) {
  //   if (feesController.text.isEmpty) {
  //     validateFees = true;
  //     update();
  //   } else {
  //     validateFees = false;
  //     update();
  //   }
  // }

  List<TextEditingController> taskNameList = [];
  List<TextEditingController> taskCompletionList = [];
  List<TextEditingController> taskDaysList = [];
  List<TextEditingController> taskHoursList = [];
  List<TextEditingController> taskMinuteList = [];
  List<String> taskIdList = [];
  List<String> taskSelectedEmpList = [];
  List<String> taskSelectedEmpIdList = [];
  List<String> srNo = [];
  String selectedReassignId = "";
  List<ManualAssignmentTaskDetails> tasksList = [];
  int totalCompletion = 0;
  int totalDays = 0;
  int totalHours = 0;
  int totalMins = 0;

  List<String> forTaskNames = [];
  List<int> forCompletionCalculation = [];
  List<int> forDaysCalculation = [];
  List<int> forHrCalculation = [];
  List<int> forMinCalculation = [];

  List<String> taskNameListToSendApi = [];
  List<String> completionListToSendApi = [];
  List<String> daysListToSendApi = [];
  List<String> hoursListToSendApi = [];
  List<String> minuteListToSendApi = [];
  List<String> taskEmpListToSendApi = [];
  List<String> taskIdListToSendApi = [];
  List<String> srNoListToSendApi = [];

  String taskNameFirstBracketRemove = "";
  String taskNameSecondBracketRemove = "";
  String completionFirstBracketRemove = "";
  String completionSecondBracketRemove = "";
  String daysFirstBracketRemove = "";
  String daysSecondBracketRemove = "";
  String hoursFirstBracketRemove = "";
  String hoursSecondBracketRemove = "";
  String minuteFirstBracketRemove = "";
  String minuteSecondBracketRemove = "";
  String taskEmpFirstBracketRemove = "";
  String taskEmpSecondBracketRemove = "";
  String taskIdFirstBracketRemove = "";
  String taskIdSecondBracketRemove = "";
  String srNoFirstBracketRemove = "";
  String srNoSecondBracketRemove = "";

  void callTasksList() async {
    tasksList.clear();
    try {
      ManualAssignmentTaskModel? response =
          (await repository.getManualAssignmentTaskList(selectedServiceId));

      if (response.success!) {
        if (response.manualAssignmentTaskDetails!.isEmpty) {
        } else {
          tasksList.addAll(response.manualAssignmentTaskDetails!);

          for (var element in tasksList) {
            taskIdList.add(element.taskId!);
            taskNameList.add(TextEditingController(text: element.taskName));
            taskCompletionList
                .add(TextEditingController(text: element.completion));
            taskDaysList.add(TextEditingController(text: element.days));
            taskHoursList.add(TextEditingController(text: element.hours));
            taskMinuteList.add(TextEditingController(text: element.minutes));
            srNo.add(element.sortno!);
            taskSelectedEmpList.add("");
            taskSelectedEmpIdList.add("");

            forTaskNames.add(element.taskName!);
            forCompletionCalculation.add(int.parse(element.completion!));
            forDaysCalculation.add(int.parse(element.days!));
            forHrCalculation.add(int.parse(element.hours!));
            forMinCalculation.add(int.parse(element.minutes!));

            totalCompletion = totalCompletion + int.parse(element.completion!);
            totalDays = totalDays + int.parse(element.days!);
            totalHours = totalHours + int.parse(element.hours!);
            totalMins = totalMins + int.parse(element.minutes!);
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

  List<String> addedEmp = [];
  String selectedEmpId = "";

  updateEmployee(int index, String assignTo, String id, String taskId) {
    selectedEmpId = taskId;

    if (addedEmp.contains(taskId)) {
      addedEmp.remove(taskId);
      update();
    } else {
      addedEmp.add(taskId);
      update();
    }

    if (taskSelectedEmpIdList.asMap().containsKey(index)) {
      taskSelectedEmpIdList.removeAt(index);
      taskSelectedEmpList.removeAt(index);
      taskSelectedEmpIdList.insert(index, id);
      taskSelectedEmpList.insert(index, assignTo);
      update();
    } else {
      taskSelectedEmpIdList.add(id);
      taskSelectedEmpList.add(assignTo);
      update();
    }

    update();
  }

  removeFromSelected(int index) {
    if (taskCompletionList[index].text == "0" ||
        taskCompletionList[index].text.isEmpty ||
        totalCompletion == 0) {
    } else {
      totalCompletion =
          totalCompletion - int.parse(taskCompletionList[index].text);
    }

    if (taskDaysList[index].text == "0" ||
        taskDaysList[index].text.isEmpty ||
        totalDays == 0) {
    } else {
      totalDays = totalDays - int.parse(taskDaysList[index].text);
    }

    if (taskHoursList[index].text == "0" ||
        taskHoursList[index].text.isEmpty ||
        totalHours == 0) {
    } else {
      totalHours = totalHours - int.parse(taskHoursList[index].text);
    }

    if (taskMinuteList[index].text == "0" ||
        taskMinuteList[index].text.isEmpty ||
        totalMins == 0) {
    } else {
      totalMins = totalMins - int.parse(taskMinuteList[index].text);
    }

    tasksList.removeAt(index);
    taskNameList.removeAt(index);
    taskCompletionList.removeAt(index);
    taskDaysList.removeAt(index);
    taskHoursList.removeAt(index);
    taskMinuteList.removeAt(index);
    srNo.removeAt(index);
    taskIdList.removeAt(index);
    taskSelectedEmpList.removeAt(index);
    taskSelectedEmpIdList.removeAt(index);
    forTaskNames.removeAt(index);
    forCompletionCalculation.removeAt(index);
    forDaysCalculation.removeAt(index);
    forHrCalculation.removeAt(index);
    forMinCalculation.removeAt(index);
    taskNameListToSendApi.clear();
    completionListToSendApi.clear();
    hoursListToSendApi.clear();
    minuteListToSendApi.clear();
    daysListToSendApi.clear();
    update();
  }

  checkAllAddedValues(int index) {
    if (taskNameList[index].text == "" ||
        taskCompletionList[index].text.isEmpty ||
        taskDaysList[index].text.isEmpty ||
        taskHoursList[index].text.isEmpty ||
        taskMinuteList[index].text.isEmpty ||
        taskSelectedEmpList[index] == "") {
      Utils.showAlertSnackBar("Please enter all details");
    } else {
      saveTaskName(index, taskNameList[index].text);
      saveCompletion(index, int.parse(taskCompletionList[index].text));
      saveDays(index, int.parse(taskDaysList[index].text));
      saveHours(index, int.parse(taskHoursList[index].text));
      saveMinute(index, int.parse(taskMinuteList[index].text));
      showToast("Added !");
    }
    update();
  }

  saveTaskName(int index, String taskName) {
    if (forTaskNames.asMap().containsKey(index)) {
      forTaskNames.removeAt(index);
      forTaskNames.insert(index, taskName);
      update();
    } else {
      forTaskNames.add(taskName);
      update();
    }
    update();
  }

  saveCompletion(int index, int completion) {
    if (forCompletionCalculation.asMap().containsKey(index)) {
      forCompletionCalculation.removeAt(index);
      forCompletionCalculation.insert(index, completion);
      update();
    } else {
      forCompletionCalculation.add(completion);
      update();
    }
    int sum = forCompletionCalculation.fold(0, (p, c) => p + c);
    totalCompletion = sum;
    update();
  }

  saveDays(int index, int days) {
    if (forDaysCalculation.asMap().containsKey(index)) {
      forDaysCalculation.removeAt(index);
      forDaysCalculation.insert(index, days);
      update();
    } else {
      forDaysCalculation.add(days);
      update();
    }
    int sum = forDaysCalculation.fold(0, (p, c) => p + c);
    totalDays = sum;
    update();
  }

  saveHours(int index, int hours) {
    if (forHrCalculation.asMap().containsKey(index)) {
      forHrCalculation.removeAt(index);
      forHrCalculation.insert(index, hours);
      update();
    } else {
      forHrCalculation.add(hours);
      update();
    }
    int sum = forHrCalculation.fold(0, (p, c) => p + c);
    totalHours = sum;
    update();
  }

  saveMinute(int index, int minutes) {
    if (forMinCalculation.asMap().containsKey(index)) {
      forMinCalculation.removeAt(index);
      forMinCalculation.insert(index, minutes);
      update();
    } else {
      forMinCalculation.add(minutes);
      update();
    }
    int sum = forMinCalculation.fold(0, (p, c) => p + c);
    totalMins = sum;
    update();
  }

  addMoreForManualAssignment(int index) {
    updateLoader(true);

    taskNameList.insert(index, TextEditingController(text: ""));
    taskCompletionList.insert(index, TextEditingController(text: ""));
    taskDaysList.insert(index, TextEditingController(text: ""));
    taskHoursList.insert(index, TextEditingController(text: ""));
    taskMinuteList.insert(index, TextEditingController(text: ""));
    taskIdList.insert(index, "");
    srNo.insert(index, "0");

    taskSelectedEmpIdList.insert(taskSelectedEmpIdList.length, "0");
    taskSelectedEmpList.insert(taskSelectedEmpList.length, "");

    forTaskNames.add("");
    forCompletionCalculation.add(0);
    forDaysCalculation.add(0);
    forHrCalculation.add(0);
    forMinCalculation.add(0);

    tasksList.insert(
        index,
        ManualAssignmentTaskDetails(
            taskName: "",
            taskId: "",
            hours: "",
            days: "",
            completion: "",
            sortno: "",
            minutes: ""));

    showToast("New entry added !");
    updateLoader(false);
    update();
  }

  saveTasks() {
    if (totalCompletion != 100) {
      Utils.showErrorSnackBar("Completion should be 100 %");
      update();
    } else if (selectedEmployee == "") {
      Utils.showErrorSnackBar("Please select employee");
      update();
    } else {
      for (var element in forTaskNames) {
        taskNameListToSendApi.add(element.toString());
      }
      for (var element in forCompletionCalculation) {
        completionListToSendApi.add(element.toString());
      }
      for (var element in forDaysCalculation) {
        daysListToSendApi.add(element.toString());
      }
      for (var element in forHrCalculation) {
        hoursListToSendApi.add(element.toString());
      }
      for (var element in forMinCalculation) {
        minuteListToSendApi.add(element.toString());
      }

      taskNameFirstBracketRemove =
          taskNameListToSendApi.toString().replaceAll("[", "");
      taskNameSecondBracketRemove =
          taskNameFirstBracketRemove.toString().replaceAll("]", "");

      completionFirstBracketRemove =
          completionListToSendApi.toString().replaceAll("[", "");
      completionSecondBracketRemove =
          completionFirstBracketRemove.toString().replaceAll("]", "");

      daysFirstBracketRemove = daysListToSendApi.toString().replaceAll("[", "");
      daysSecondBracketRemove =
          daysFirstBracketRemove.toString().replaceAll("]", "");

      hoursFirstBracketRemove =
          hoursListToSendApi.toString().replaceAll("[", "");
      hoursSecondBracketRemove =
          hoursFirstBracketRemove.toString().replaceAll("]", "");

      minuteFirstBracketRemove =
          minuteListToSendApi.toString().replaceAll("[", "");
      minuteSecondBracketRemove =
          minuteFirstBracketRemove.toString().replaceAll("]", "");

      taskEmpFirstBracketRemove =
          taskSelectedEmpIdList.toString().replaceAll("[", "");
      taskEmpSecondBracketRemove =
          taskEmpFirstBracketRemove.toString().replaceAll("]", "");

      srNoFirstBracketRemove = srNo.toString().replaceAll("[", "");
      srNoSecondBracketRemove =
          srNoFirstBracketRemove.toString().replaceAll("]", "");

      taskIdFirstBracketRemove = taskIdList.toString().replaceAll("[", "");
      taskIdSecondBracketRemove =
          taskIdFirstBracketRemove.toString().replaceAll("]", "");

      callManualAssignment();
    }
  }

  void callManualAssignment() async {
    updateLoader(true);

    try {
      ApiResponse? response = (await repository.getManualAssignment(
          completionSecondBracketRemove.replaceAll(" ", ""),
          taskNameSecondBracketRemove.replaceAll(", ", ","),
          daysSecondBracketRemove.replaceAll(" ", ""),
          hoursSecondBracketRemove.replaceAll(" ", ""),
          minuteSecondBracketRemove.replaceAll(" ", ""),
          taskEmpSecondBracketRemove.replaceAll(" ", ""),
          taskIdSecondBracketRemove.replaceAll(" ", ""),
          srNoSecondBracketRemove.replaceAll(" ", ""),
          selectedPriority == "High"
              ? "1"
              : selectedPriority == "Medium"
                  ? "2"
                  : "3",
          selectedYearId,
          selectedYear,
          selectedMainCategoryId,
          selectedServiceId,
          selectedClientId,
          selectedTriggerDateToSend,
          selectedTargetDateToSend,
          feesController.text.isEmpty ? "" : feesController.text,
          remarkController.text.isEmpty ? "" : remarkController.text));
      if (response.success!) {
        Utils.showSuccessSnackBar(response.message);
        updateLoader(false);
        Get.offNamed(AppRoutes.bottomNav);
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
}
