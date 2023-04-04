import 'dart:ui' as pie_chart_color;

import 'package:biznew/common_widget/error_text.dart';
import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/constant/provider/custom_exception.dart';
import 'package:biznew/constant/repository/api_repository.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/claim_form/claim_model.dart';
import 'package:biznew/screens/dashboard/dashboard_model.dart';
import 'package:biznew/screens/dashboard/triggered_not_allotted_load_all.dart';
import 'package:biznew/screens/petty_task/petty_task_model.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:biznew/utils/custom_response.dart';
import 'package:biznew/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';

class DashboardController extends GetxController {
  final ApiRepository repository;

  // ignore: unnecessary_null_comparison
  DashboardController({required this.repository}) : assert(repository != null);

  ///common
  String userId="";
  String userName="";
  String name="";
  String reportingHead="";
  String userType="";
  int selectedFlag = 0;
  bool loader = false;
  int currentPos = 0;

  List chartDetails = ["Triggered In Last 7 Days","More Than 7 Days","Past Due","Probable Overdue","High",];
  //List chartColors = [Colors.blue,Colors.brown,Colors.orangeAccent.shade100,Colors.indigo,Colors.red];
  List chartColors = [Colors.blue,Colors.brown,const Color(0xffFFEE58),const Color(0xff0000FF),const Color(0xffFF0000)];

  final allColors = <pie_chart_color.Color>[
    Colors.grey,Colors.brown,Colors.orangeAccent.shade100,Colors.indigo,Colors.red
  ];

  /// 1. trigger not allotted
  String triggerNotAllottedTotal = "";
  Map<String, double> triggerNotAllottedValues = {
    "Triggered In Last 7 Days": 0.0,
    "More Than 7 Days": 0.0,
    "Past Due": 0.0,
    //"Probable Overdue":0.0,
  };
  final triggerNotAllottedColors = <pie_chart_color.Color>[
    Colors.blue,Colors.brown,
    const Color(0xffFFEE58)
    //Color(0xffFFFF99),
    //Colors.indigo,
  ];
  List<int> triggeredNotAllotted = [];
  /// 2. allotted not started
  List allottedNotStartedDetails = ["Past Due","Probable Overdue","High","Medium","Low"];
  //List allottedNotStartedColors = [Colors.grey,Colors.brown,Colors.orangeAccent.shade100,Colors.indigo,Colors.red];

  List<int> ownAllottedNotStarted = [];
  List<int> teamAllottedNotStarted = [];
  String allottedNotStartedRH = "0";
  String allottedNotStartedTotal = "";
  // Map<String, double> allottedNotStartedValues = {
  //   "Triggered In Last 7 Days": 0.0,
  //   "More Than 7 Days": 0.0,
  //   "Past Due": 0.0,
  //   "Probable Overdue":0.0,
  //   "High":0.0,
  // };
  Map<String, double> allottedNotStartedValues = {
    "Past Due": 0.0,
    "Probable Overdue":0.0,
    "High":0.0,
    "Medium":0.0,
    "Low":0.0
  };
  // final allottedNotStartedColors = <pie_chart_color.Color>[
  //   Colors.blue,Colors.brown,Colors.orangeAccent.shade100,Colors.indigo,Colors.red,Colors.black
  // ];
  // final allottedNotStartedColors = <pie_chart_color.Color>[
  // Colors.orangeAccent.shade100,Colors.brown,Colors.red,Colors.orange,Colors.green
  // ];
  final allottedNotStartedColors = <pie_chart_color.Color>[
    const Color(0xffFFEE58),const Color(0xff0000FF),const Color(0xffFF0000),const Color(0xffFFA500),const Color(0xff008000)
  ];
  List<AllottedNotStartedPastDueData> allottedNotStartedPastDueList = [];

  /// 3. started not completed
  List startedNotCompletedDetails = ["Past Due","Probable Overdue","High","Medium","Low"];
  List<int> ownStartedNotCompleted = [];
  List<int> teamStartedNotCompleted = [];
  String startedNotCompletedRH = "0";
  String startedNotCompletedTotal = "";
  Map<String, double> startedNotCompletedValues = {
    "Past Due": 0.0,
    "Probable Overdue":0.0,
    "High":0.0,
    "Medium":0.0,
    "Low":0.0
  };
  final startedNotCompletedColors = <pie_chart_color.Color>[
   // Colors.blue,Colors.brown,Colors.orangeAccent.shade100,Colors.indigo,Colors.red,
   // Colors.orangeAccent.shade100,Colors.brown,Colors.red,Colors.orange,Colors.green
    const Color(0xffFFEE58),const Color(0xff0000FF),const Color(0xffFF0000),const Color(0xffFFA500),const Color(0xff008000)
  ];
  List<StartedNotCompletedPieList> startedNotCompletedPastDueList = [];

  /// 4. completed UDIN pending
  List<int> ownCompletedUdinPending = [];
  List<int> teamCompletedUdinPending = [];
  String completedIdPendingTotal = "";
  String completedIdPendingRH = "0";
  Map<String, double> completedIdPendingValues = {
    "Triggered In Last 7 Days": 0.0,
  };
  // final completedIdPendingColors = <pie_chart_color.Color>[
  //   Colors.grey,
  // ];
  final completedIdPendingColors = <pie_chart_color.Color>[ const Color(0xff6f42c1),];
  List<CompletedUdinPendingPieList> completedUdinPendingDataList = [];
  /// 5. completed not billed
  List<int> completedNotBilled = [];
  String completedNotBilledTotal = "";
  Map<String, double> completedNotBilledValues = {
    "Triggered In Last 7 Days": 0.0,
  };
  // final completedNotBilledColors = <pie_chart_color.Color>[
  //   Colors.grey,
  // ];
  final completedNotBilledColors = <pie_chart_color.Color>[ const Color(0xff00c4ff),];
  List<CompletedNotBilledPieList> completedNotBilledDataList= [];

  ///work on hold
  List<int> ownWorkOnHold = [];
  List<int> teamWorkOnHold = [];
  String workOnHoldTotal = "0";
  String workOnHoldRH = "";
  Map<String, double> workOnHoldValues = {
    "Own": 0.0,"Team":0.0
  };
  final workOnHoldColors = <pie_chart_color.Color>[Colors.red,Colors.black];

  ///submitted for checking
  List<int> ownSubmittedForChecking = [];
  List<int> teamSubmittedForChecking = [];
  String submittedForCheckingRH = "0";
  String submittedForCheckingTotal = "";
  Map<String, double> submittedForCheckingValues = {
    "Own": 0.0,"Team":0.0
  };
  final submittedForCheckingColors = <pie_chart_color.Color>[ Colors.orange,Colors.black];

  ///all tasks submitted
  List<int> ownAllTaskCompleted = [];
  List<int> teamAllTaskCompleted = [];
  String allTasksCompletedRH = "";
  String allTasksCompletedTotal = "";
  // Map<String, double> allTasksCompletedValues = {
  //   "Triggered In Last 7 Days": 0.0,
  // };
  Map<String, double> allTasksCompletedValues = {
    "Own": 0.0,"Team":0.0
  };
  final allTasksCompletedColors = <pie_chart_color.Color>[ Colors.green, Colors.black ];

  String selectedMainType = "";
  bool validateBranchName = false;
  String selectedBranchId = "";
  String selectedBranchName = "";
  List<String> noDataList = ["No Data Found!"];
  List<Branchlist> branchNameList = [];

  CarouselController carouselController = CarouselController();
  TextEditingController searchController = TextEditingController();

  bool isPastDueSelected = false;
  bool isPortableOverdueSelected = false;
  bool isHighSelected = false;
  bool isMediumSelected = false;
  bool isLowSelected = false;

  String selectedPastDue = "";
  String selectedProbable = "";
  String selectedHigh = "";
  String selectedMedium = "";
  String selectedLow = "";

  ///allotted -> past due -> own
  String selectedPieChartTitle = "" ;
  String selectedType = "" ;
  String selectedCount = "" ;
  DateTime selectedDateForCurrent = DateTime.now();
  DateTime selectedDateForAll = DateTime.now();
  String selectedDateToShowForCurrent = ""; String selectedDateToSendForCurrent = "";
  String selectedDateToShowForAll = ""; String selectedDateToSendForAll = "";
  String selectedCurrentPriority = "";
  String selectedServiceStatus = "";
  String selectedCurrentStatusId = "";
  String selectedCurrentPriorityId = "";
  String selectedAllPriority = "";
  List<String> changeStatusList = ["Inprocess","Hold","Complete"];
  List<String> priorityList = ["Low","Medium","High"];

  ///check password and reason dialog
  TextEditingController checkPassword = TextEditingController();
  TextEditingController reason = TextEditingController();
  bool validatePassword = false;bool showPass = true;
  bool hideReasonContent = true;
  bool validateReason = false;

  ///load all task
  String selectedClientName = "";
  String selectedServiceName = "";
  List<LoadAllTaskData> loadAllTaskList = [];
  List<String> addedStatusListForCurrent = [];
  List<String> addedPriorityListForCurrent = [];
  List<String> addedDateListForCurrent = [];
  List<String> addedPriorityListForAll = [];
  List<String> addedDateListForAll = [];

  ///cancel leave
  int selectedCancelType = 0;
  int initialIndex = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userId = GetStorage().read("userId")??"";
    userName = GetStorage().read("userName")??"";
    name = GetStorage().read("name")??"";
    reportingHead = GetStorage().read("reportingHead")??"";
    userType = GetStorage().read("userType")??"";
    repository.getData();

    callNotificationList();
    callBranchNameList();

    callServiceTriggerNotAllotted();
    callAllottedNotStarted();
    callStartedNotCompleted();
    callCompletedUDINPending();
    callCompletedNotBilled();
    callWorkOnHold();
    callSubmittedForChecking();
    callAllTasksCompleted();
    callEmployeeList();
  }
  List<ClaimSubmittedByList> employeeList = [];

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
  List<NotificationList> notificationListData = [];

  void callNotificationList() async {
    notificationListData.clear();
    try {
      NotificationModel? response = (await repository.getNotificationList());

      if (response.success!) {
        if (response.notificationList!.isEmpty) {
        }
        else{
          notificationListData.addAll(response.notificationList!);
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
  /// branch name list
  void callBranchNameList() async {
    branchNameList.clear();
    try {
      BranchNameModel? response = (await repository.getBranchNameList());
      if (response.success!) {
        branchNameList.addAll(response.branchListDetails!);
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
  ///branch name
  updateSelectedBranchId(String val){
    if(branchNameList.isNotEmpty){
      selectedBranchId = val; update();
    }
  }
  checkBranchNameValidation(String val){
    if(branchNameList.isNotEmpty){
      selectedBranchName = val; update();
      if(selectedBranchName==""){ validateBranchName = true; update(); }
      else{validateBranchName = false; update(); }
    }
  }

  onWillPopBack(){
    Get.offNamedUntil(AppRoutes.bottomNav, (route) => false);
    update();
  }

  updateSlider(int index){ currentPos = index;update();}

  goToNextSlider(){carouselController.nextPage(); update();}

  goToPrevSlider(){carouselController.previousPage(); update();}

  updateSelectedFlag(int val,BuildContext context){ selectedFlag = val; update();}

  updateLoader(bool val) { loader = val; update(); }

  ///service trigger not allotted
  void callServiceTriggerNotAllotted() async {
    triggeredNotAllotted.clear();
    try {
      TriggerNotAllottedModel? response = (await repository.getServiceTriggerNotAllottedPieChart());
      if (response.success!) {
        triggerNotAllottedTotal = response.triggeredNotAllottedData!.serviceTriggeredButNotAllotted![4].toString();
        triggerNotAllottedValues.update("Triggered In Last 7 Days", (value) => value + response.triggeredNotAllottedData!.serviceTriggeredButNotAllotted![0].toDouble());
        triggerNotAllottedValues.update("More Than 7 Days", (value) => value + response.triggeredNotAllottedData!.serviceTriggeredButNotAllotted![1].toDouble());
        triggerNotAllottedValues.update("Past Due", (value) => value + response.triggeredNotAllottedData!.serviceTriggeredButNotAllotted![2].toDouble());
        //triggerNotAllottedValues.update("Probable Overdue", (value) => value + response.triggeredNotAllottedData!.serviceTriggeredButNotAllotted![3].toDouble());

        for(int i = 0; i<response.triggeredNotAllottedData!.serviceTriggeredButNotAllotted!.length - 1; i ++){
         triggeredNotAllotted.add(response.triggeredNotAllottedData!.serviceTriggeredButNotAllotted![i]);
        }

        updateLoader(false);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }
  }
  ///allotted not started
  void callAllottedNotStarted() async {
    ownAllottedNotStarted.clear(); teamAllottedNotStarted.clear();
    try {
      AllottedNotStartedModel? response = (await repository.getAllottedNotStartedPieChart());
      if (response.success!) {
        allottedNotStartedTotal = response.allottedNotStartedData!.allottedButNotStarted![5].toString();
        // allottedNotStartedValues.update("Triggered In Last 7 Days", (value) => value + response.allottedNotStartedData!.allottedButNotStarted![0].toDouble());
        // allottedNotStartedValues.update("More Than 7 Days", (value) => value + response.allottedNotStartedData!.allottedButNotStarted![1].toDouble());
        allottedNotStartedValues.update("Past Due", (value) => value + response.allottedNotStartedData!.allottedButNotStarted![0].toDouble());
        allottedNotStartedValues.update("Probable Overdue", (value) => value + response.allottedNotStartedData!.allottedButNotStarted![1].toDouble());
        allottedNotStartedValues.update("High", (value) => value + response.allottedNotStartedData!.allottedButNotStarted![2].toDouble());
        allottedNotStartedValues.update("Medium", (value) => value + response.allottedNotStartedData!.allottedButNotStarted![3].toDouble());
        allottedNotStartedValues.update("Low", (value) => value + response.allottedNotStartedData!.allottedButNotStarted![4].toDouble());
        allottedNotStartedRH = response.allottedNotStartedData!.isReportingHead![0];

        for (var element in response.allottedNotStartedData!.own!) {
          ownAllottedNotStarted.add(element);
        }
        for (var element in response.allottedNotStartedData!.team!) {
          teamAllottedNotStarted.add(element);
        }

        print("new selectedType");
        print(selectedType);
        if(selectedType == "Own"){
          selectedPastDue = ownAllottedNotStarted[0].toString();
          selectedProbable = ownAllottedNotStarted[1].toString();
          selectedHigh = ownAllottedNotStarted[2].toString();
          selectedMedium = ownAllottedNotStarted[3].toString();
          selectedLow = ownAllottedNotStarted[4].toString();
        }
        else{
          selectedPastDue = teamAllottedNotStarted[0].toString();
          selectedProbable = teamAllottedNotStarted[1].toString();
          selectedHigh = teamAllottedNotStarted[2].toString();
          selectedMedium = teamAllottedNotStarted[3].toString();
          selectedLow = teamAllottedNotStarted[4].toString();
        }
        updateLoader(false);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }
  }
  ///started not completed
  void callStartedNotCompleted() async {
    ownStartedNotCompleted.clear(); teamStartedNotCompleted.clear();
    try {
      StartedNotCompletedModel? response = (await repository.getStartedNotCompletedPieChart());
      if (response.success!) {
        startedNotCompletedTotal = response.startedNotCompletedData!.startedButNotCompleted![5].toString();
        // startedNotCompletedValues.update("Triggered In Last 7 Days", (value) => value + response.startedNotCompletedData!.startedButNotCompleted![0].toDouble());
        // startedNotCompletedValues.update("More Than 7 Days", (value) => value + response.startedNotCompletedData!.startedButNotCompleted![1].toDouble());
        startedNotCompletedValues.update("Past Due", (value) => value + response.startedNotCompletedData!.startedButNotCompleted![0].toDouble());
        startedNotCompletedValues.update("Probable Overdue", (value) => value + response.startedNotCompletedData!.startedButNotCompleted![1].toDouble());
        startedNotCompletedValues.update("High", (value) => value + response.startedNotCompletedData!.startedButNotCompleted![2].toDouble());
        startedNotCompletedValues.update("Medium", (value) => value + response.startedNotCompletedData!.startedButNotCompleted![3].toDouble());
        startedNotCompletedValues.update("Low", (value) => value + response.startedNotCompletedData!.startedButNotCompleted![4].toDouble());

        startedNotCompletedRH = response.startedNotCompletedData!.isReportingHead![0];

        for (var element in response.startedNotCompletedData!.own!) {
          ownStartedNotCompleted.add(element);
        }
        for (var element in response.startedNotCompletedData!.team!) {
          teamStartedNotCompleted.add(element);
        }


        if(selectedType == "Own"){
          selectedPastDue = ownStartedNotCompleted[0].toString();
          selectedProbable = ownStartedNotCompleted[1].toString();
          selectedHigh = ownStartedNotCompleted[2].toString();
          selectedMedium = ownStartedNotCompleted[3].toString();
          selectedLow = ownStartedNotCompleted[4].toString();
        }
        else{
          selectedPastDue = teamStartedNotCompleted[0].toString();
          selectedProbable = teamStartedNotCompleted[1].toString();
          selectedHigh = teamStartedNotCompleted[2].toString();
          selectedMedium = teamStartedNotCompleted[3].toString();
          selectedLow = teamStartedNotCompleted[4].toString();
        }

        updateLoader(false);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }
  }
  ///completed but UDIN pending
  void callCompletedUDINPending() async {
    ownCompletedUdinPending.clear(); teamCompletedUdinPending.clear();
    try {
      CompletedUdinPendingModel? response = (await repository.getCompletedUDINPendingPieChart());
      if (response.success!) {
        completedIdPendingTotal = response.completedUdinPendingData!.completedButUdinPending![1].toString();
        completedIdPendingValues.update("Triggered In Last 7 Days", (value) => value + response.completedUdinPendingData!.completedButUdinPending![0].toDouble());

        completedIdPendingRH = response.completedUdinPendingData!.isReportingHead![0];

        for (var element in response.completedUdinPendingData!.own!) {
          ownCompletedUdinPending.add(element);
        }
        for (var element in response.completedUdinPendingData!.team!) {
          teamCompletedUdinPending.add(element);
        }
        updateLoader(false);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }
  }
  ///completed not billed
  void callCompletedNotBilled() async {
    completedNotBilled.clear();
    try {
      CompletedNotBilledModel? response = (await repository.getCompletedNotBilledPieChart());

      if (response.success!) {
        completedNotBilledTotal = response.completedNotBilledData!.completedButNotBilled![1].toString();
        completedNotBilledValues.update("Triggered In Last 7 Days", (value) => value + response.completedNotBilledData!.completedButNotBilled![0].toDouble());

        for(int i = 0; i<response.completedNotBilledData!.completedButNotBilled!.length-1; i ++){
          completedNotBilled.add(response.completedNotBilledData!.completedButNotBilled![i]);
        }
        updateLoader(false);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }
  }
  ///work on hold
  void callWorkOnHold() async {
    try {
      WorkOnHoldModel? response = (await repository.getWorkOnHoldPieChart());

      if (response.success!) {
        workOnHoldTotal = response.workOnHoldData!.workOnHold![0].toString();
        //workOnHoldValues.update("Triggered In Last 7 Days", (value) => value + response.workOnHoldData!.workOnHold![0].toDouble());
        workOnHoldValues.update("Own", (value) => value + response.workOnHoldData!.own![0].toDouble());
        workOnHoldValues.update("Team", (value) => value + response.workOnHoldData!.team![0].toDouble());

        workOnHoldRH = response.workOnHoldData!.isReportingHead![0];

        for (var element in response.workOnHoldData!.own!) {
          ownWorkOnHold.add(element);
        }
        for (var element in response.workOnHoldData!.team!) {
          teamWorkOnHold.add(element);
        }
        updateLoader(false);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }
  }
  ///submitted for checking
  void callSubmittedForChecking() async {
    try {
      SubmittedForCheckingModel? response = (await repository.getSubmittedForCheckingPieChart());

      if (response.success==true) {
        submittedForCheckingTotal = response.submittedForCheckingData!.submittedForChecking![0].toString();
        //submittedForCheckingValues.update("Triggered In Last 7 Days", (value) => value + response.submittedForCheckingData!.submittedForChecking![0].toDouble());
        submittedForCheckingValues.update("Own", (value) => value + response.submittedForCheckingData!.own![0].toDouble());
        submittedForCheckingValues.update("Team", (value) => value + response.submittedForCheckingData!.team![0].toDouble());

        submittedForCheckingRH = response.submittedForCheckingData!.isReportingHead![0];

        for (var element in response.submittedForCheckingData!.own!) {
          ownSubmittedForChecking.add(element);
        }
        for (var element in response.submittedForCheckingData!.team!) {
          teamSubmittedForChecking.add(element);
        }
        updateLoader(false);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }
  }
  ///all tasks completed
  void callAllTasksCompleted() async {
    try {
      AllTaskCompletedModel? response = (await repository.getAllTaskCompletedPieChart());

      if (response.success!) {
        allTasksCompletedTotal = response.allTaskCompletedData!.alltasksCompleteChart![0].toString();
        //allTasksCompletedValues.update("Triggered In Last 7 Days", (value) => value + response.allTaskCompletedData!.alltasksCompleteChart![0].toDouble());
        allTasksCompletedValues.update("Own", (value) => value + response.allTaskCompletedData!.own![0].toDouble());
        allTasksCompletedValues.update("Team", (value) => value + response.allTaskCompletedData!.team![0].toDouble());

        allTasksCompletedRH = response.allTaskCompletedData!.isReportingHead![0];

        for (var element in response.allTaskCompletedData!.own!) {
          ownAllTaskCompleted.add(element);
        }
        for (var element in response.allTaskCompletedData!.team!) {
          teamAllTaskCompleted.add(element);
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

  ///due data api
  callDueDataApi(String title,String type, String count){
    print("selectedMainType");
    print(selectedMainType);
    updateLoader(true);
    selectedPieChartTitle = title;
    selectedType = type ; selectedCount = count ;
    selectedMainType = "AllottedNotStarted";
    if(title == "Past Due"){
      // if(selectedMainType == "AllottedNotStarted")
      //   {
      //    type == "Own" ? callAllottedNotStartedPastDueOwn() : callAllottedNotStartedPastDueTeam();
      //   }
      // else{
      //     type == "Own" ? callStartedNotCompletedPastOwn() : callStartedNotCompletedPastTeam();
      // }
      onPasDueSelected();
    }
    else if(title == "Probable Overdue"){
      // if(selectedMainType == "AllottedNotStarted")
      // {
      //  type == "Own" ?  callAllottedNotStartedProbableOwn() :  callAllottedNotStartedPortableDueTeam();
      // }
      // else{
      //   type == "Own" ? callStartedNotCompletedProbableOwn() : callStartedNotCompletedProbableTeam();
      // }
      onPortableOverdueSelected();
    }
    else if(title == "High"){
      // if(selectedMainType == "AllottedNotStarted")
      // {
      //  type == "Own" ?  callAllottedNotStartedHighOwn() :  callAllottedNotStartedHighDueTeam();
      // }
      // else{
      //   type == "Own" ? callStartedNotCompletedHighOwn() : callStartedNotCompletedHighTeam();
      // }
      onHighSelected();
    }
    else if(title == "Medium"){
      // if(selectedMainType == "AllottedNotStarted")
      // {
      //  type == "Own" ?  callAllottedNotStartedMediumOwn() :  callAllottedNotStartedMediumDueTeam();
      // }
      // else{
      //   type == "Own" ? callStartedNotCompletedMediumOwn() : callStartedNotCompletedMediumTeam();
      // }
      onHMediumSelected();
    }
    else if(title == "Low"){
      // if(selectedMainType == "AllottedNotStarted")
      // {
      //  type == "Own" ?  callAllottedNotStartedLowOwn() :  callAllottedNotStartedLowDueTeam();
      // }
      // else{
      //   type == "Own" ? callStartedNotCompletedLowOwn() : callStartedNotCompletedLowTeam();
      // }
      onLowSelected();
    }
    update();
  }
  ///due data started but nor completed
  callDueDataForStartedNotCompletedApi(String title,String type, String count){
    updateLoader(true);
    selectedPieChartTitle = title;
    selectedType = type ; selectedCount = count ;
    selectedMainType = "StartedNotCompleted";
    if(title == "Past Due"){
      //type == "Own" ?  callStartedNotCompletedPastOwn() :  callStartedNotCompletedPastTeam();
      onPasDueSelected();
    }
    else if(title == "Probable Overdue"){
      //type == "Own" ?  callStartedNotCompletedProbableOwn() :  callStartedNotCompletedProbableTeam();
      onPortableOverdueSelected();
    }
    else if(title == "High"){
      //type == "Own" ?  callStartedNotCompletedHighOwn() :  callStartedNotCompletedHighTeam();
      onHighSelected();
    }
    else if(title == "Medium"){
      //type == "Own" ?  callStartedNotCompletedMediumOwn() :  callStartedNotCompletedMediumTeam();
      onHMediumSelected();
    }
    else if(title == "Low"){
      //type == "Own" ?  callStartedNotCompletedLowOwn() :  callStartedNotCompletedLowTeam();
      onLowSelected();
    }
    // if(type == "Own"){
    //   callStartedNotCompletedOwn();
    // }
    // else{
    //   callStartedNotCompletedTeam();
    // }

    update();
  }
  ///due data completed but udin pending
  callDueDataForCompletedUdinPendingApi(String title,String type, String count){
    updateLoader(true);
    selectedPieChartTitle = title;
    selectedType = type ; selectedCount = count ;
    selectedMainType = "CompletedUdinPending";
    if(type == "Own"){
      callCompletedUdinPendingOwn();
    }
    else{
      callCompletedUdinPendingTeam();
    }

    update();
  }
  ///due data completed not billed
  callDueDataForCompletedNotBilled(String title,String count){
    updateLoader(true);
    selectedPieChartTitle = title;
    selectedCount = count ;
    selectedMainType = "CompletedNotBilled";

    callCompletedNotBilledDueData();

    update();
  }
  ///due data submitted for checking
  callDueDataForSubmittedForChecking(String title,String type,String count){
    updateLoader(true);
    selectedPieChartTitle = title;
    selectedType = type ; selectedCount = count ;
    selectedMainType = "SubmittedForChecking";

    if(type == "Own"){
      callSubmittedForCheckingOwnData();
    }
    else{
      callSubmittedForCheckingTeamData();
    }

    update();
  }
  ///due data work on hold
  callDueDataForWorkOnHold(String title,String type,String count){
    updateLoader(true);
    selectedPieChartTitle = title;
    selectedType = type ; selectedCount = count ;
    selectedMainType = "WorkOnHold";

    if(type == "Own"){
      callWorkOnHoldOwnData();
    }
    else{
      callWorkOnHoldTeamData();
    }

    update();
  }
  ///due data all tasks
  callDueDataForAllTasks(String title,String type,String count){
    updateLoader(true);
    selectedPieChartTitle = title;
    selectedType = type ; selectedCount = count ;
    selectedMainType = "AllTasks";

    if(type == "Own"){
      callAllTasksOwnData();
    }
    else{
      callAllTasksTeamData();
    }

    update();
  }

  ///cancel service => check password dialog
  String selectedCliId = "";
  showCheckPasswordOrReasonDialog(String serviceName,BuildContext context){
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
                height: selectedCancelType==1 ? 200.0:hideReasonContent ? 200.0 : 300.0,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildTextRegularWidget(serviceName, blackColor, context, 16.0,align: TextAlign.left),
                    const Divider(color: Colors.grey,),
                    const SizedBox(height: 10.0,),

                    hideReasonContent
                        ? Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        color: textFormBgColor,
                        border: Border.all(color: textFormBgColor),),
                      child: TextFormField(
                        controller: checkPassword,
                        obscureText: showPass,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.left,
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.done,
                        onTap: () {},
                        style:const TextStyle(fontSize: 15.0),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: "Enter password",
                          hintStyle: GoogleFonts.rubik(textStyle: TextStyle(
                            color: subTitleTextColor, fontSize: 15,),),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setter((){
                                onPassChange();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: showPass ? const Icon(
                                  Icons.visibility_off) : const Icon(
                                Icons.visibility, color: primaryColor,),
                            ),
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        onChanged: (text) {
                          setter((){
                            checkPasswordValidation();
                          });
                        },
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        color: textFormBgColor,
                        border: Border.all(color: textFormBgColor),),
                      child: TextFormField(
                        controller: reason,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.left,
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.done,
                        onTap: () {},
                        style:const TextStyle(fontSize: 15.0),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: "Enter reason",
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
                            checkReasonValidation();
                          });
                        },
                      ),
                    ),

                    hideReasonContent
                      ? validatePassword == true
                          ? ErrorText(errorMessage: "Please enter valid password",)
                          : const Opacity(opacity: 0.0)
                      : validateReason == true
                          ? ErrorText(errorMessage: "Please enter valid reason",)
                          : const Opacity(opacity: 0.0),

                    const SizedBox(height: 10.0,),

                    selectedCancelType == 1 ? const Opacity(opacity: 0.0):
                    hideReasonContent
                        ? const Opacity(opacity: 0.0)
                        : Column(
                      children: [
                        Row(
                          children: [
                            Radio<int>(
                              value: 0,
                              groupValue: selectedCancelType,
                              activeColor: primaryColor,
                              onChanged: (int? value) {
                                updateSelectedCancelType(value!,context);
                              },
                            ),
                            buildTextRegularWidget("Current period", blackColor, context, 15.0),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<int>(
                              value: 1,
                              groupValue: selectedCancelType,
                              activeColor: primaryColor,
                              onChanged: (int? value) {
                                updateSelectedCancelType(value!,context);
                              },
                            ),
                            buildTextRegularWidget("All", blackColor, context, 15.0),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: (){
                              setter((){
                                hideReasonContent
                                ? checkPasswordNextClickValidation(context)
                                : checkReasonNextClickValidation(context);
                              });
                            },
                            child: buildButtonWidget(context, "Next",height: 40.0,buttonColor: approveColor),
                          ),
                        ),const SizedBox(width: 5.0,),
                        Flexible(
                          child: GestureDetector(
                            onTap: (){
                              clearDialog();
                              Navigator.pop(context);
                            },
                            child: buildButtonWidget(context, "Cancel",height: 40.0,buttonColor: errorColor),
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
  updateSelectedCancelType(int val,BuildContext context){
     selectedCancelType = val;
     if(selectedCancelType==1){
       Get.toNamed(AppRoutes.serviceCancelAll);
     }
     update();
  }

  ///show hide password
  void onPassChange(){ showPass = !showPass; update();}
  ///clear check password dialog
  clearDialog(){
    showPass = true; validatePassword=false;
    checkPassword.clear();
    validateReason =false;
    reason.clear();
    hideReasonContent = true;
    update();
  }
  ///password validation
  checkPasswordValidation(){
    if(checkPassword.text.isEmpty){ validatePassword = true; update(); }
    else{ validatePassword = false; update(); }
  }
  ///reason validation
  checkReasonValidation(){
    if(reason.text.isEmpty){ validateReason = true; update(); }
    else{ validateReason = false; update(); }
  }
  ///password next click validation
  checkPasswordNextClickValidation(BuildContext context){
    updateLoader(true);
    if(checkPassword.text.isEmpty){
      checkPassword.text.isEmpty ? validatePassword = true : validatePassword = false;
      updateLoader(false);
      update();
    }else{
     callCheckPassword(context);
   }
    update();
  }
  ///reason next click validation
  checkReasonNextClickValidation(BuildContext context){
    if(reason.text.isEmpty){
      reason.text.isEmpty ? validateReason = true : validateReason = false;
      updateLoader(true);
      update();
    }else{
      selectedCancelType == 1 ? callConfirmCancelService(context) :callCancelService(context);
   }
    update();
  }

  ///change date from current
  Future<void> selectTargetDateForCurrent(BuildContext context,String id,DateTime firstDate,DateTime targetDate) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: firstDate,
        firstDate: firstDate,
        currentDate: targetDate,
        lastDate: DateTime(2100, 1),
    );

    if (picked != null && picked != selectedDateForCurrent) {
      selectedDateForCurrent = picked;
      selectedDateToShowForCurrent = "${selectedDateForCurrent.day}-${selectedDateForCurrent.month}-${selectedDateForCurrent.year}";
      selectedDateToSendForCurrent = "${selectedDateForCurrent.year}-${selectedDateForCurrent.month}-${selectedDateForCurrent.day}";
    }

    if(addedDateListForCurrent.contains(id)){
      addedDateListForCurrent.remove(id);
      update();
    }
    else{
      addedDateListForCurrent.add(id);
      update();
    }

    if(picked==null){}
    else{
      callUpdateTargetDate();
    }
    update();
  }
  ///change date from all
  Future<void> selectTargetDateForAll(BuildContext context,String id) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateForAll,
        firstDate: DateTime(1700, 1),
        lastDate: DateTime(2100, 1));
    if (picked != null && picked != selectedDateForAll) {
      selectedDateForAll = picked;
    }
    selectedDateToShowForAll = "${selectedDateForAll.day}-${selectedDateForAll.month}-${selectedDateForAll.year}";
    selectedDateToSendForAll = "${selectedDateForAll.year}-${selectedDateForAll.month}-${selectedDateForAll.day}";

    if(addedDateListForCurrent.contains(id)){
      addedDateListForCurrent.remove(id);
      update();
    }
    else{
      addedDateListForCurrent.add(id);
      update();
    }
    update();
  }

  /// priority change for current
  updatePriorityForCurrent(String priority,String id){
    selectedCurrentPriority = priority;
    selectedCurrentPriorityId = id;
    if(addedPriorityListForCurrent.contains(id)){
      addedPriorityListForCurrent.remove(id);
      update();
    }
    else{
      addedPriorityListForCurrent.add(id);
      update();
    }
    callUpdatePriority();
    update();
  }
  ///status change for current
  updateStatusForCurrent(String status,String id,BuildContext context){
    selectedServiceStatus = status;
    selectedCurrentStatusId = id;

    if(addedStatusListForCurrent.contains(id)){
      addedStatusListForCurrent.remove(id);
      update();
    }
    else{
      addedStatusListForCurrent.add(id);
      update();
    }
    callCheckCompletedTaskService(context);
    update();
  }

  TextEditingController remarkController = TextEditingController();
  bool validateRemark = false;
  String addedRemark = "";

  showRemarkDialogForHoldStatus(String serviceName,BuildContext context){
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
                height: 300.0,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildTextRegularWidget(serviceName, blackColor, context, 16.0,align: TextAlign.left),
                    const Divider(color: Colors.grey,),
                    const SizedBox(height: 10.0,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        color: textFormBgColor,
                        border: Border.all(color: textFormBgColor),),
                      child: TextFormField(
                        controller: remarkController,
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

                    const SizedBox(height: 10.0,),

                    Row(
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: (){
                              setter((){
                                callUpdateTaskServiceStatus(context);
                              });
                            },
                            child: buildButtonWidget(context, "Add",height: 40.0,buttonColor: approveColor),
                          ),
                        ),const SizedBox(width: 5.0,),
                        Flexible(
                          child: GestureDetector(
                            onTap: (){
                              clearRemarkDialog();
                              Navigator.pop(context);
                            },
                            child: buildButtonWidget(context, "Close",height: 40.0,buttonColor: errorColor),
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
    if(remarkController.text.isEmpty){
      validateRemark = true;update();
    }
    else{
      validateRemark = false;update();
    }
  }

  addRemark(){
    addedRemark = remarkController.text;update();
  }

  clearRemarkDialog(){
    remarkController.clear();update();
  }

  ///priority change for all
  updatePriorityForAll(String priority,String id){
    selectedAllPriority = priority;
    if(addedPriorityListForCurrent.contains(id)){
      addedPriorityListForCurrent.remove(id);
      update();
    }
    else{
      addedPriorityListForCurrent.add(id);
      update();
    }
    update();
  }

  onTabIndexSelect(int index){
    print("index");
    print(index);
    if(index == 0){
      onPasDueSelected();
    }
    else if(index == 1){
      onPortableOverdueSelected();
    }
    else if(index == 2){
      onHighSelected();
    }
    else if(index == 3){
      onHMediumSelected();
    }
    else if(index == 4){
      onLowSelected();
    }
    update();
  }

  onPasDueSelected(){
    selectedPieChartTitle == "Past Due";
    updateLoader(true);
    initialIndex = 0;
    print("selectedType");
    print(selectedType);
    print("selectedMainType");
    print(selectedMainType);
    if(selectedMainType == "AllottedNotStarted")
      {
        selectedType == "Own" ? callAllottedNotStartedPastDueOwn() : callAllottedNotStartedPastDueTeam();
      }
    else{
        selectedType == "Own" ? callStartedNotCompletedPastOwn() : callStartedNotCompletedPastTeam();
    }

    isPastDueSelected = true; isPortableOverdueSelected = false; isHighSelected = false;
    isMediumSelected = false; isLowSelected = false;
    update();
  }
  onPortableOverdueSelected(){
    initialIndex = 1;
    selectedPieChartTitle == "Probable Overdue";
    updateLoader(true);
    if(selectedMainType == "AllottedNotStarted")
    {
      selectedType == "Own" ? callAllottedNotStartedPortableDueTeam() : callAllottedNotStartedPortableDueTeam();
    }
    else{
      selectedType == "Own" ? callStartedNotCompletedProbableOwn() : callStartedNotCompletedProbableTeam();
    }

    isPastDueSelected = false; isPortableOverdueSelected = true; isHighSelected = false;
    isMediumSelected = false; isLowSelected = false;
    update();
  }
  onHighSelected(){
    initialIndex = 2;
    selectedPieChartTitle == "High";
    updateLoader(true);
    //callAllottedNotStartedHighDueTeam();
    if(selectedMainType == "AllottedNotStarted")
    {
      selectedType == "Own" ? callAllottedNotStartedHighOwn() : callAllottedNotStartedHighDueTeam();
    }
    else{
      selectedType == "Own" ? callStartedNotCompletedHighOwn() : callStartedNotCompletedHighTeam();
    }
    isPastDueSelected = false; isPortableOverdueSelected = false; isHighSelected = true;
    isMediumSelected = false; isLowSelected = false;
    update();
  }
  onHMediumSelected(){
    initialIndex = 3;
    selectedPieChartTitle == "Medium";
    updateLoader(true);
    //callAllottedNotStartedMediumDueTeam();
    if(selectedMainType == "AllottedNotStarted")
    {
      selectedType == "Own" ? callAllottedNotStartedMediumOwn() : callAllottedNotStartedMediumDueTeam();
    }
    else{
      selectedType == "Own" ? callStartedNotCompletedMediumOwn() : callStartedNotCompletedMediumTeam();
    }
    isPastDueSelected = false; isPortableOverdueSelected = false; isHighSelected = false;
    isMediumSelected = true; isLowSelected = false;
    update();
  }
  onLowSelected(){
    initialIndex = 4;
    selectedPieChartTitle == "Low";
    updateLoader(true);
    //callAllottedNotStartedLowDueTeam();
    if(selectedMainType == "AllottedNotStarted")
    {
      selectedType == "Own" ? callAllottedNotStartedLowOwn() : callAllottedNotStartedLowDueTeam();
    }
    else{
      selectedType == "Own" ? callStartedNotCompletedLowOwn() : callStartedNotCompletedLowTeam();
    }
    isPastDueSelected = false; isPortableOverdueSelected = false; isHighSelected = false;
    isMediumSelected = false; isLowSelected = true;
    update();
  }

  navigateToBottom(){
    //currentPos = 1;
    // currentPos = position;
    selectedServiceStatus = ""; selectedCurrentPriority="";
    //updateSlider(1);

    //carouselController.jumpToPage(1);
    Get.toNamed(AppRoutes.bottomNav);

    reportingHead == "0"
        ?
    selectedMainType == "AllottedNotStarted"? currentPos = 0 :
    selectedMainType == "StartedNotCompleted" ? currentPos = 1 :
    selectedMainType == "CompletedUdinPending"? currentPos = 2 :
    selectedMainType == "WorkOnHold"? currentPos = 3 : currentPos = 4
        :
    selectedMainType == "AllottedNotStarted"? currentPos = 1 :
    selectedMainType == "StartedNotCompleted" ? currentPos = 2 :
    selectedMainType == "CompletedUdinPending"? currentPos = 3 :
    selectedMainType == "CompletedNotBilled"? currentPos = 4 :
    selectedMainType == "WorkOnHold"? currentPos = 5 :
    selectedMainType == "SubmittedForChecking"? currentPos = 6 :
    selectedMainType == "AllTasks"? currentPos = 7 : currentPos = 0;

    updateSlider(currentPos);
    carouselController.jumpToPage(currentPos);

    update();
  }
  ///allotted not started past due -> own
  void callAllottedNotStartedOwn() async {
    allottedNotStartedPastDueList.clear();
    try {

      AllottedNotStartedPastDueTeam? response =
      selectedPieChartTitle == "Past Due" ? (await repository.getAllottedNotStartedPastDueOwn()) :
      selectedPieChartTitle == "Probable Overdue" ? (await repository.getAllottedNotStartedProbableOwn()) :
      selectedPieChartTitle == "High" ? (await repository.getAllottedNotStartedHighOwn()) :
      selectedPieChartTitle == "Medium" ? (await repository.getAllottedNotStartedMediumOwn()) :
       (await repository.getAllottedNotStartedLowOwn());

      if (response.success!) {
        allottedNotStartedPastDueList.addAll(response.allottedNotStartedPastDueData!);
        updateLoader(false);
        // isPastDueSelected = true;
        //Get.toNamed(AppRoutes.serviceDashboardNext);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }

    selectedPastDue = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[0]}";
    selectedProbable = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[1]}";
    selectedHigh = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[2]}";
    selectedMedium = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[3]}";
    selectedLow = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[4]}";

    Get.toNamed(AppRoutes.serviceDashboardNext);
  }
  void callAllottedNotStartedPastDueOwn() async {
    allottedNotStartedPastDueList.clear();
    try {

      AllottedNotStartedPastDueTeam? response = await repository.getAllottedNotStartedPastDueOwn();

      if (response.success!) {
        allottedNotStartedPastDueList.addAll(response.allottedNotStartedPastDueData!);
        updateLoader(false);
        Utils.dismissLoadingDialog();
        update();
      } else {
        Utils.dismissLoadingDialog();
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    } catch (error) {
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    }

    selectedPastDue = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[0]}";
    selectedProbable = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[1]}";
    selectedHigh = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[2]}";
    selectedMedium = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[3]}";
    selectedLow = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[4]}";

    print("selectedPastDue");
    print(selectedPastDue);
    update();

    Get.toNamed(AppRoutes.serviceDashboardNext);
  }
  void callAllottedNotStartedProbableOwn() async {
    allottedNotStartedPastDueList.clear();
    try {

      AllottedNotStartedPastDueTeam? response = await repository.getAllottedNotStartedProbableOwn();

      if (response.success!) {
        allottedNotStartedPastDueList.addAll(response.allottedNotStartedPastDueData!);
        updateLoader(false);
        Utils.dismissLoadingDialog();
        // isPastDueSelected = true;
        //Get.toNamed(AppRoutes.serviceDashboardNext);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        Utils.dismissLoadingDialog();
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    }

    selectedPastDue = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[0]}";
    selectedProbable = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[1]}";
    selectedHigh = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[2]}";
    selectedMedium = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[3]}";
    selectedLow = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[4]}";

    update();
    Get.toNamed(AppRoutes.serviceDashboardNext);
  }
  void callAllottedNotStartedHighOwn() async {
    allottedNotStartedPastDueList.clear();
    try {

      AllottedNotStartedPastDueTeam? response = await repository.getAllottedNotStartedHighOwn();

      if (response.success!) {
        allottedNotStartedPastDueList.addAll(response.allottedNotStartedPastDueData!);
        updateLoader(false);
        Utils.dismissLoadingDialog();
        // isPastDueSelected = true;
        //Get.toNamed(AppRoutes.serviceDashboardNext);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        Utils.dismissLoadingDialog();
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    }

    selectedPastDue = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[0]}";
    selectedProbable = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[1]}";
    selectedHigh = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[2]}";
    selectedMedium = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[3]}";
    selectedLow = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[4]}";

    update();

    Get.toNamed(AppRoutes.serviceDashboardNext);
  }
  void callAllottedNotStartedMediumOwn() async {
    allottedNotStartedPastDueList.clear();
    try {

      AllottedNotStartedPastDueTeam? response = await repository.getAllottedNotStartedMediumOwn();

      if (response.success!) {
        allottedNotStartedPastDueList.addAll(response.allottedNotStartedPastDueData!);
        updateLoader(false);
        Utils.dismissLoadingDialog();
        // isPastDueSelected = true;
        //Get.toNamed(AppRoutes.serviceDashboardNext);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        Utils.dismissLoadingDialog();
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    }

    selectedPastDue = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[0]}";
    selectedProbable = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[1]}";
    selectedHigh = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[2]}";
    selectedMedium = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[3]}";
    selectedLow = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[4]}";
    update();
    Get.toNamed(AppRoutes.serviceDashboardNext);
  }
  void callAllottedNotStartedLowOwn() async {
    allottedNotStartedPastDueList.clear();
    try {

      AllottedNotStartedPastDueTeam? response = await repository.getAllottedNotStartedLowOwn();

      if (response.success!) {
        allottedNotStartedPastDueList.addAll(response.allottedNotStartedPastDueData!);
        updateLoader(false);
        Utils.dismissLoadingDialog();
        // isPastDueSelected = true;
        //Get.toNamed(AppRoutes.serviceDashboardNext);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        Utils.dismissLoadingDialog();
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    }

    selectedPastDue = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[0]}";
    selectedProbable = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[1]}";
    selectedHigh = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[2]}";
    selectedMedium = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[3]}";
    selectedLow = "${ownAllottedNotStarted.isEmpty?"":ownAllottedNotStarted[4]}";
    update();
    Get.toNamed(AppRoutes.serviceDashboardNext);
  }
  ///allotted not started past due -> team
  void callAllottedNotStartedPastDueTeam() async {
    allottedNotStartedPastDueList.clear();
    try {
      AllottedNotStartedPastDueTeam? response = await repository.getAllottedNotStartedPastDueTeam();
      // selectedPieChartTitle == "Past Due" ? (await repository.getAllottedNotStartedPastDueTeam()) :
      // selectedPieChartTitle == "Probable Overdue" ? (await repository.getAllottedNotStartedProbableTeam()) :
      // selectedPieChartTitle == "High" ? (await repository.getAllottedNotStartedHighTeam()) :
      // selectedPieChartTitle == "Medium" ? (await repository.getAllottedNotStartedMediumTeam()) :
      // (await repository.getAllottedNotStartedLowTeam());

      if (response.success!) {
        allottedNotStartedPastDueList.addAll(response.allottedNotStartedPastDueData!);
        updateLoader(false);  Utils.dismissLoadingDialog();
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        Utils.dismissLoadingDialog();
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);  Utils.dismissLoadingDialog();
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    }

    selectedPastDue = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[0]}";
    selectedProbable = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[1]}";
    selectedHigh = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[2]}";
    selectedMedium = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[3]}";
    selectedLow = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[4]}";
    update();
    Get.toNamed(AppRoutes.serviceDashboardNext);
  }
  void callAllottedNotStartedPortableDueTeam() async {
    allottedNotStartedPastDueList.clear();
    try {
      AllottedNotStartedPastDueTeam? response = (await repository.getAllottedNotStartedProbableTeam()) ;

      if (response!.success!) {
        allottedNotStartedPastDueList.addAll(response.allottedNotStartedPastDueData!);
        updateLoader(false);  Utils.dismissLoadingDialog();
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        Utils.dismissLoadingDialog();
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    }

    selectedPastDue = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[0]}";
    selectedProbable = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[1]}";
    selectedHigh = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[2]}";
    selectedMedium = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[3]}";
    selectedLow = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[4]}";
    update();
    Get.toNamed(AppRoutes.serviceDashboardNext);
  }
  void callAllottedNotStartedHighDueTeam() async {
    allottedNotStartedPastDueList.clear();
    try {

      AllottedNotStartedPastDueTeam? response = (await repository.getAllottedNotStartedHighTeam()) ;

      if (response.success!) {
        allottedNotStartedPastDueList.addAll(response.allottedNotStartedPastDueData!);
        updateLoader(false);  Utils.dismissLoadingDialog();
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        Utils.dismissLoadingDialog();
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    }

    selectedPastDue = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[0]}";
    selectedProbable = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[1]}";
    selectedHigh = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[2]}";
    selectedMedium = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[3]}";
    selectedLow = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[4]}";
    update();
    Get.toNamed(AppRoutes.serviceDashboardNext);
  }
  void callAllottedNotStartedMediumDueTeam() async {
    allottedNotStartedPastDueList.clear();
    try {

      AllottedNotStartedPastDueTeam? response = (await repository.getAllottedNotStartedMediumTeam()) ;

      if (response.success!) {
        allottedNotStartedPastDueList.addAll(response.allottedNotStartedPastDueData!);
        updateLoader(false);  Utils.dismissLoadingDialog();
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        Utils.dismissLoadingDialog();
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    }

    selectedPastDue = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[0]}";
    selectedProbable = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[1]}";
    selectedHigh = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[2]}";
    selectedMedium = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[3]}";
    selectedLow = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[4]}";
    update();
    Get.toNamed(AppRoutes.serviceDashboardNext);
  }
  void callAllottedNotStartedLowDueTeam() async {
    allottedNotStartedPastDueList.clear();
    try {

      AllottedNotStartedPastDueTeam? response = (await repository.getAllottedNotStartedLowTeam()) ;

      if (response.success!) {
        allottedNotStartedPastDueList.addAll(response.allottedNotStartedPastDueData!);
        updateLoader(false);  Utils.dismissLoadingDialog();
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        Utils.dismissLoadingDialog();
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    }

    selectedPastDue = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[0]}";
    selectedProbable = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[1]}";
    selectedHigh = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[2]}";
    selectedMedium = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[3]}";
    selectedLow = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[4]}";
    update();
    Get.toNamed(AppRoutes.serviceDashboardNext);
  }

  ///started not completed team
  void callStartedNotCompletedPastTeam() async {
    startedNotCompletedPastDueList.clear();
    try {
      StartedButCompletedPieModel? response = await repository.getStartedNotCompletedPastDueTeam();

      if (response.success!) {
        startedNotCompletedPastDueList.addAll(response.startedNotCompletedList!);
        updateLoader(false);  Utils.dismissLoadingDialog();
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        Utils.dismissLoadingDialog();
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    }

    selectedPastDue = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[0]}";
    selectedProbable = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[1]}";
    selectedHigh = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[2]}";
    selectedMedium = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[3]}";
    selectedLow = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[4]}";
    update();
    Get.toNamed(AppRoutes.serviceDashboardNext);
  }
  void callStartedNotCompletedProbableTeam() async {
    startedNotCompletedPastDueList.clear();
    try {
      StartedButCompletedPieModel? response = await repository.getStartedNotCompletedProbableTeam();

      if (response.success!) {
        startedNotCompletedPastDueList.addAll(response.startedNotCompletedList!);
        updateLoader(false);  Utils.dismissLoadingDialog();
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        Utils.dismissLoadingDialog();
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    }

    selectedPastDue = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[0]}";
    selectedProbable = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[1]}";
    selectedHigh = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[2]}";
    selectedMedium = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[3]}";
    selectedLow = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[4]}";
    update();
    Get.toNamed(AppRoutes.serviceDashboardNext);
  }
  void callStartedNotCompletedHighTeam() async {
    startedNotCompletedPastDueList.clear();
    try {
      StartedButCompletedPieModel? response = await repository.getStartedNotCompletedHighTeam();

      if (response.success!) {
        startedNotCompletedPastDueList.addAll(response.startedNotCompletedList!);
        updateLoader(false);  Utils.dismissLoadingDialog();
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        Utils.dismissLoadingDialog();
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    }

    selectedPastDue = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[0]}";
    selectedProbable = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[1]}";
    selectedHigh = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[2]}";
    selectedMedium = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[3]}";
    selectedLow = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[4]}";
    update();
    Get.toNamed(AppRoutes.serviceDashboardNext);
  }
  void callStartedNotCompletedMediumTeam() async {
    startedNotCompletedPastDueList.clear();
    try {
      StartedButCompletedPieModel? response = await repository.getStartedNotCompletedMediumTeam();

      if (response.success!) {
        startedNotCompletedPastDueList.addAll(response.startedNotCompletedList!);
        updateLoader(false);  Utils.dismissLoadingDialog();
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        Utils.dismissLoadingDialog();
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    }

    selectedPastDue = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[0]}";
    selectedProbable = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[1]}";
    selectedHigh = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[2]}";
    selectedMedium = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[3]}";
    selectedLow = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[4]}";
    update();
    Get.toNamed(AppRoutes.serviceDashboardNext);
  }
  void callStartedNotCompletedLowTeam() async {
    startedNotCompletedPastDueList.clear();
    try {
      StartedButCompletedPieModel? response = await repository.getStartedNotCompletedLowTeam();

      if (response.success!) {
        startedNotCompletedPastDueList.addAll(response.startedNotCompletedList!);
        updateLoader(false);  Utils.dismissLoadingDialog();
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        Utils.dismissLoadingDialog();
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    }

    selectedPastDue = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[0]}";
    selectedProbable = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[1]}";
    selectedHigh = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[2]}";
    selectedMedium = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[3]}";
    selectedLow = "${teamStartedNotCompleted.isEmpty?"":teamStartedNotCompleted[4]}";
    update();
    Get.toNamed(AppRoutes.serviceDashboardNext);
  }
  ///started not completed own
  void callStartedNotCompletedPastOwn() async {
    startedNotCompletedPastDueList.clear();
    try {
      StartedButCompletedPieModel? response = await repository.getStartedNotCompletedPastDueOwn();

      if (response.success!) {
        startedNotCompletedPastDueList.addAll(response.startedNotCompletedList!);
        updateLoader(false);  Utils.dismissLoadingDialog();
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        Utils.dismissLoadingDialog();
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    }

    selectedPastDue = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[0]}";
    selectedProbable = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[1]}";
    selectedHigh = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[2]}";
    selectedMedium = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[3]}";
    selectedLow = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[4]}";
    update();
    Get.toNamed(AppRoutes.serviceDashboardNext);
  }
  void callStartedNotCompletedProbableOwn() async {
    startedNotCompletedPastDueList.clear();
    try {
      StartedButCompletedPieModel? response = await repository.getStartedNotCompletedProbableOwn();

      if (response.success!) {
        startedNotCompletedPastDueList.addAll(response.startedNotCompletedList!);
        updateLoader(false);  Utils.dismissLoadingDialog();
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        Utils.dismissLoadingDialog();
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    }

    selectedPastDue = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[0]}";
    selectedProbable = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[1]}";
    selectedHigh = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[2]}";
    selectedMedium = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[3]}";
    selectedLow = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[4]}";
    update();
    Get.toNamed(AppRoutes.serviceDashboardNext);
  }
  void callStartedNotCompletedHighOwn() async {
    startedNotCompletedPastDueList.clear();
    try {
      StartedButCompletedPieModel? response = await repository.getStartedNotCompletedHighOwn();

      if (response.success!) {
        startedNotCompletedPastDueList.addAll(response.startedNotCompletedList!);
        updateLoader(false);  Utils.dismissLoadingDialog();
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        Utils.dismissLoadingDialog();
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    }

    selectedPastDue = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[0]}";
    selectedProbable = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[1]}";
    selectedHigh = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[2]}";
    selectedMedium = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[3]}";
    selectedLow = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[4]}";
    update();
    Get.toNamed(AppRoutes.serviceDashboardNext);
  }
  void callStartedNotCompletedMediumOwn() async {
    startedNotCompletedPastDueList.clear();
    try {
      StartedButCompletedPieModel? response = await repository.getStartedNotCompletedMediumOwn();

      if (response.success!) {
        startedNotCompletedPastDueList.addAll(response.startedNotCompletedList!);
        updateLoader(false);  Utils.dismissLoadingDialog();
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        Utils.dismissLoadingDialog();
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    }

    selectedPastDue = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[0]}";
    selectedProbable = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[1]}";
    selectedHigh = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[2]}";
    selectedMedium = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[3]}";
    selectedLow = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[4]}";
    update();
    Get.toNamed(AppRoutes.serviceDashboardNext);
  }
  void callStartedNotCompletedLowOwn() async {
    startedNotCompletedPastDueList.clear();
    try {
      StartedButCompletedPieModel? response = await repository.getStartedNotCompletedLowOwn();

      if (response.success!) {
        startedNotCompletedPastDueList.addAll(response.startedNotCompletedList!);
        updateLoader(false);  Utils.dismissLoadingDialog();
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        Utils.dismissLoadingDialog();
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      Utils.dismissLoadingDialog();
      updateLoader(false);
      update();
    }

    selectedPastDue = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[0]}";
    selectedProbable = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[1]}";
    selectedHigh = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[2]}";
    selectedMedium = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[3]}";
    selectedLow = "${ownStartedNotCompleted.isEmpty?"":ownStartedNotCompleted[4]}";
    update();
    Get.toNamed(AppRoutes.serviceDashboardNext);
  }

  /// completed udin pending team
  void callCompletedUdinPendingTeam() async {
    completedUdinPendingDataList.clear();
    try {
      CompletedUdinPendingPieModel? response = await repository.getCompletedUdinPendingTeam();
      if (response.success!) {
        completedUdinPendingDataList.addAll(response.completedUdinPendingPieList!);
        updateLoader(false);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }
    update();
    Get.toNamed(AppRoutes.serviceDashboardNextOther);
  }
  /// completed udin pending own
  void callCompletedUdinPendingOwn() async {
    completedUdinPendingDataList.clear();
    try {
      CompletedUdinPendingPieModel? response = await repository.getCompletedUdinPendingOwn();

      if (response.success!) {
        completedUdinPendingDataList.addAll(response.completedUdinPendingPieList!);
        updateLoader(false);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }

    Get.toNamed(AppRoutes.serviceDashboardNextOther);
  }

  ///completed not billed
  void callCompletedNotBilledDueData() async {
    completedNotBilledDataList.clear();
    try {
      CompletedNotBilledPieModel? response = await repository.getCompletedNotBilled();

      if (response.success!) {
        completedNotBilledDataList.addAll(response.completedNotBilledPieList!);
        updateLoader(false);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }

    Get.toNamed(AppRoutes.serviceDashboardNextOther);
  }

  List<SubmittedForCheckingPieList> submittedForCheckingPieDataList = [];
  ///submitted for checking team
  void callSubmittedForCheckingTeamData() async {
    submittedForCheckingPieDataList.clear();
    try {
      SubmittedForCheckingPieModel? response = await repository.getSubmittedForCheckingTeam();

      if (response.success!) {
        submittedForCheckingPieDataList.addAll(response.submittedForCheckingPieList!);
        updateLoader(false);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }

    Get.toNamed(AppRoutes.serviceDashboardNextOther);
  }
  ///submitted for checking own
  void callSubmittedForCheckingOwnData() async {
    submittedForCheckingPieDataList.clear();
    try {
      SubmittedForCheckingPieModel? response = await repository.getSubmittedForCheckingOwn();

      if (response.success!) {
        submittedForCheckingPieDataList.addAll(response.submittedForCheckingPieList!);
        updateLoader(false);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }

    Get.toNamed(AppRoutes.serviceDashboardNextOther);
  }

  List<WorkOnHoldPieList> workOnHoldPieDataList = [];
  ///work on hold team
  void callWorkOnHoldTeamData() async {
    workOnHoldPieDataList.clear();
    try {
      WorkOnHoldPieModel? response = await repository.getWorkOnHoldTeam();

      if (response.success!) {
        workOnHoldPieDataList.addAll(response.workOnHoldPieList!);
        updateLoader(false);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }

    Get.toNamed(AppRoutes.serviceDashboardNextOther);
  }
  ///work on hold own
  void callWorkOnHoldOwnData() async {
    workOnHoldPieDataList.clear();
    try {
      WorkOnHoldPieModel? response = await repository.getWorkOnHoldOwn();

      if (response.success!) {
        workOnHoldPieDataList.addAll(response.workOnHoldPieList!);
        updateLoader(false);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }

    Get.toNamed(AppRoutes.serviceDashboardNextOther);
  }

  List<AllTasksPieList> allTasksDataList = [];
  ///all tasks team
  void callAllTasksTeamData() async {
    allTasksDataList.clear();
    try {
      AllTasksPieModel? response = await repository.getAllTasksTeam();

      if (response.success!) {
        allTasksDataList.addAll(response.allTasksPieList!);
        updateLoader(false);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }

    Get.toNamed(AppRoutes.serviceDashboardNextOther);
  }
  ///all tasks own
  void callAllTasksOwnData() async {
    allTasksDataList.clear();
    try {
      AllTasksPieModel? response = await repository.getAllTasksOwn();

      if (response.success!) {
        allTasksDataList.addAll(response.allTasksPieList!);
        updateLoader(false);
        update();
      } else {
        //Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      //Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      //Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }

    Get.toNamed(AppRoutes.serviceDashboardNextOther);
  }

  navigateToTriggeredNotAllottedNext(String type,String count){
    updateLoader(true);
    selectedType = type;
    selectedCount = count;
    update();
    if(selectedType == "Triggered In Last 7 Days"){
      callTriggeredNotAllottedLast7Days();
    }
    else if(selectedType == "More Than 7 Days"){
      callTriggeredNotAllottedMoreThan7Days();
    }
    else{
      callTriggeredNotAllottedPastDue();
    }
    update();
  }

  List<TriggeredNotAllottedPieChartList> triggeredNotAllottedPieChartDetails = [];

  ///services triggered not allotted past due
  void callTriggeredNotAllottedPastDue() async {
    triggeredNotAllottedPieChartDetails.clear();
    try {
      TriggeredNotAllottedModel? response = await repository.getTriggeredNotAllottedPastDue();

      if (response.success!) {
        triggeredNotAllottedPieChartDetails.addAll(response.triggeredNotAllottedPieChartList!);
        updateLoader(false);
        update();
      } else {
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      updateLoader(false);
      update();
    } catch (error) {
      updateLoader(false);
      update();
    }

    Get.toNamed(AppRoutes.triggeredNotAllottedPieChartList);
  }
  ///services triggered not allotted more than 7 days
  void callTriggeredNotAllottedMoreThan7Days() async {
    triggeredNotAllottedPieChartDetails.clear();
    try {
      TriggeredNotAllottedModel? response = await repository.getTriggeredNotAllottedMore7Days();

      if (response.success!) {
        triggeredNotAllottedPieChartDetails.addAll(response.triggeredNotAllottedPieChartList!);
        updateLoader(false);
        update();
      } else {
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      updateLoader(false);
      update();
    } catch (error) {
      updateLoader(false);
      update();
    }

    Get.toNamed(AppRoutes.triggeredNotAllottedPieChartList);
  }
  ///services triggered not allotted last 7 days
  void callTriggeredNotAllottedLast7Days() async {
    triggeredNotAllottedPieChartDetails.clear();
    try {
      TriggeredNotAllottedModel? response = await repository.getTriggeredNotAllottedLast7Days();

      if (response.success!) {
        triggeredNotAllottedPieChartDetails.addAll(response.triggeredNotAllottedPieChartList!);
        updateLoader(false);
        update();
      } else {
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      updateLoader(false);
      update();
    } catch (error) {
      updateLoader(false);
      update();
    }

    Get.toNamed(AppRoutes.triggeredNotAllottedPieChartList);
  }
  ///services triggered not allotted load all
  List<TriggeredNotAllottedLoadAllList> triggeredNotAllottedLoadAll= [];
  void callTriggeredNotAllottedLoadAll(String cliId,String clientName,String serviceName) async {
    updateLoader(true);
    selectedCliId = cliId;
    selectedClientName = clientName; selectedServiceName = serviceName;

    triggeredNotAllottedLoadAll.clear();
    try {
      TriggeredNotAllottedLoadAllModel? response = await repository.getTriggeredNotAllottedLoadAll(cliId);

      if (response.success!) {
        triggeredNotAllottedLoadAll.addAll(response.triggeredNotAllottedLoadAllList!);

        for (var element in triggeredNotAllottedLoadAll) {
          taskNameList.add(TextEditingController(text: element.taskName));
          completionList.add(TextEditingController(text: element.completion));
          daysList.add(TextEditingController(text: element.days));
          hoursList.add(TextEditingController(text: element.hours));
          minuteList.add(TextEditingController(text: element.minutes));
          taskEmp.add(element.mastId!);
          taskId.add(element.taskId!);
          srNo.add(element.sortno!);
          triggerSelectedEmpList.add("");

          totalCompletion = totalCompletion + int.parse(element.completion!);
          totalDays = totalDays + int.parse(element.days!);
          totalHours = totalHours + int.parse(element.hours!);
          totalMins = totalMins + int.parse(element.minutes!);

          forTaskNames.add(element.taskName!);
          forCompletionCalculation.add(int.parse(element.completion!));
          forDaysCalculation.add(int.parse(element.days!));
          forHrCalculation.add(int.parse(element.hours!));
          forMinCalculation.add(int.parse(element.minutes!));
          update();
        }
        updateLoader(false);
        update();
      } else {
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      updateLoader(false);
      update();
    } catch (error) {
      updateLoader(false);
      update();
    }
    Get.toNamed(AppRoutes.triggeredNotAllottedLoadAll);
  }

  int selectedPeriod = 0;
  updateSelectedPeriod(int val,BuildContext context){ selectedPeriod = val; update();}

  saveTriggeredNotAllottedLoadAll(){
    if(selectedEmployee == ""){
      Utils.showErrorSnackBar("Please select employee");update();
    }
    else if(selectedCurrentPriority==""){
      Utils.showErrorSnackBar("Please select priority");update();
    }
    else{
    for(var element in forTaskNames){
      taskNameListToSendApi.add(element.toString());
    }
    for(var element in forCompletionCalculation){
      completionListToSendApi.add(element.toString());
    }
    for(var element in forDaysCalculation){
      daysListToSendApi.add(element.toString());
    }
    for(var element in forHrCalculation){
      hoursListToSendApi.add(element.toString());
    }
    for(var element in forMinCalculation){
      minuteListToSendApi.add(element.toString());
    }

    taskNameFirstBracketRemove =  taskNameListToSendApi.toString().replaceAll("[", "");
    taskNameSecondBracketRemove = taskNameFirstBracketRemove.toString().replaceAll("]", "");
    print("task names : $taskNameSecondBracketRemove");

    completionFirstBracketRemove =  completionListToSendApi.toString().replaceAll("[", "");
    completionSecondBracketRemove = completionFirstBracketRemove.toString().replaceAll("]", "");
    print("completions : $completionSecondBracketRemove");

    daysFirstBracketRemove =  daysListToSendApi.toString().replaceAll("[", "");
    daysSecondBracketRemove = daysFirstBracketRemove.toString().replaceAll("]", "");
    print("days : $daysSecondBracketRemove");

    hoursFirstBracketRemove =  hoursListToSendApi.toString().replaceAll("[", "");
    hoursSecondBracketRemove = hoursFirstBracketRemove.toString().replaceAll("]", "");
    print("hours : $hoursSecondBracketRemove");

    minuteFirstBracketRemove =  minuteListToSendApi.toString().replaceAll("[", "");
    minuteSecondBracketRemove = minuteFirstBracketRemove.toString().replaceAll("]", "");
    print("minutes : $minuteSecondBracketRemove");

    taskEmpFirstBracketRemove =  taskEmp.toString().replaceAll("[", "");
    taskEmpSecondBracketRemove = taskEmpFirstBracketRemove.toString().replaceAll("]", "");
    print("task emp : $taskEmpSecondBracketRemove");

    taskIdFirstBracketRemove =  triggerSelectedEmpIdList.toString().replaceAll("[", "");
    taskIdSecondBracketRemove = taskIdFirstBracketRemove.toString().replaceAll("]", "");
    print("task emp id : $taskIdSecondBracketRemove");

    srNoFirstBracketRemove =  srNo.toString().replaceAll("[", "");
    srNoSecondBracketRemove = srNoFirstBracketRemove.toString().replaceAll("]", "");
    print("srno : $srNoSecondBracketRemove");
    callReassignTriggeredNotAllotted();
    }
  }

  removeFromSelectedTriggered(int index){
    totalCompletion = totalCompletion - int.parse(completionList[index].text);
    totalDays = totalDays - int.parse(daysList[index].text);
    totalHours = totalHours - int.parse(hoursList[index].text);
    totalMins = totalMins - int.parse(minuteList[index].text);

    triggeredNotAllottedLoadAll.removeAt(index);
    taskNameList.removeAt(index);
    completionList.removeAt(index);
    daysList.removeAt(index);
    hoursList.removeAt(index);
    minuteList.removeAt(index);
    //addedAssignedTo.removeAt(index);
    //assignedToFromApi.removeAt(index);

    taskNameListToSendApi.clear();
    completionListToSendApi.clear();
    hoursListToSendApi.clear();
    minuteListToSendApi.clear();
    daysListToSendApi.clear();

    forTaskNames.removeAt(index);
    forCompletionCalculation.removeAt(index);
    forDaysCalculation.removeAt(index);
    forHrCalculation.removeAt(index);
    forMinCalculation.removeAt(index);
    taskEmp.removeAt(index);
    taskId.removeAt(index);
    srNo.removeAt(index);
    update();
  }
  removeFromSelectedAllotted(int index){
    allottedTotalCompletion = allottedTotalCompletion - int.parse(allottedCompletionList[index].text);
    allottedTotalDays = allottedTotalDays - int.parse(allottedDaysList[index].text);
    allottedTotalHours = allottedTotalHours - int.parse(allottedHoursList[index].text);
    allottedTotalMins = allottedTotalMins - int.parse(allottedMinuteList[index].text);

    loadAllTaskList.removeAt(index);
    allottedTaskNameList.removeAt(index);
    allottedCompletionList.removeAt(index);
    allottedDaysList.removeAt(index);
    allottedHoursList.removeAt(index);
    allottedMinuteList.removeAt(index);
    //addedAssignedTo.removeAt(index);
    //assignedToFromApi.removeAt(index);

    allottedTaskNameListToSendApi.clear();
    allottedCompletionListToSendApi.clear();
    allottedHoursListToSendApi.clear();
    allottedMinuteListToSendApi.clear();
    allottedDaysListToSendApi.clear();

    forTaskNamesAllotted.removeAt(index);
    forCompletionCalculationAllotted.removeAt(index);
    forDaysCalculationAllotted.removeAt(index);
    forHrCalculationAllotted.removeAt(index);
    forMinCalculationAllotted.removeAt(index);
    allottedTaskEmp.removeAt(index);
    allottedTaskId.removeAt(index);
    allottedSrNo.removeAt(index);
    update();
  }

  ///update priority
  void callUpdatePriority() async {
    updateLoader(true);
    try {
      ApiResponse? response = (await repository.getUpdatePriority(
          selectedCurrentPriority == "High" ? "1" :
          selectedCurrentPriority == "Medium" ? "2" : "3",
          selectedCurrentPriorityId));

      if (response.success!) {
        Utils.showSuccessSnackBar(response.message);
        callAllottedNotStartedOwn();
        callAllottedNotStarted();
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

  ///update target date
  void callUpdateTargetDate() async {
    updateLoader(true);
    try {
      ApiResponse? response = (await repository.getUpdateTargetDate(selectedDateToSendForCurrent, selectedCurrentPriorityId));

      if (response.success!) {
        Utils.showSuccessSnackBar(response.message);
        callAllottedNotStartedOwn();
        callAllottedNotStarted();
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
  ///start service
  void callStartService(String id,String serviceName) async {
    updateLoader(true);
    try {
      ApiResponse? response = (await repository.getStartService(id));

      if (response.success!) {

        print("serviceName");
        print(serviceName);

        // if(selectedPieChartTitle == "Past Due"){
        //   onPasDueSelected();
        // }
        // else if(selectedPieChartTitle == "Probable Overdue"){
        //   onPortableOverdueSelected();
        // }
        // else if(selectedPieChartTitle == "High"){
        //   onHighSelected();
        // }
        // else if(selectedPieChartTitle == "Medium"){
        //   onHMediumSelected();
        // }
        // else if(selectedPieChartTitle == "Low"){
        //   onLowSelected();
        // }

        if(serviceName == "AllottedNotStarted"){
          callAllottedNotStarted();
        }
        else{
          callStartedNotCompleted();
        }

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
  List<TextEditingController> allottedTaskNameList = [];
  List<TextEditingController> allottedCompletionList = [];
  List<TextEditingController> allottedDaysList = [];
  List<TextEditingController> allottedHoursList = [];
  List<TextEditingController> allottedMinuteList = [];
  List<String> allottedTaskEmp = [];
  List<String> allottedTaskId = [];
  List<String> allottedSrNo = [];

  List<String> allottedTaskNameListToSendApi = [];
  List<String> allottedCompletionListToSendApi = [];
  List<String> allottedDaysListToSendApi = [];
  List<String> allottedHoursListToSendApi = [];
  List<String> allottedMinuteListToSendApi = [];

  String allottedTaskNameFirstBracketRemove = "";
  String allottedTaskNameSecondBracketRemove = "";
  String allottedCompletionFirstBracketRemove = "";
  String allottedCompletionSecondBracketRemove = "";
  String allottedDaysFirstBracketRemove = "";
  String allottedDaysSecondBracketRemove = "";
  String allottedHoursFirstBracketRemove = "";
  String allottedHoursSecondBracketRemove = "";
  String allottedMinuteFirstBracketRemove = "";
  String allottedMinuteSecondBracketRemove = "";
  String allottedTaskEmpFirstBracketRemove = "";
  String allottedTaskEmpSecondBracketRemove = "";
  String allottedTaskIdFirstBracketRemove = "";
  String allottedTaskIdSecondBracketRemove = "";
  String allottedSrNoFirstBracketRemove = "";
  String allottedSrNoSecondBracketRemove = "";

  ///load all tasks for allotted
  List<TextEditingController> taskNameList = [];
  List<TextEditingController> completionList = [];
  List<TextEditingController> daysList = [];
  List<TextEditingController> hoursList = [];
  List<TextEditingController> minuteList = [];
  String selectedEmpFromDashboardNext = "";
  String selectedEmpIdFromDashboardNext = "";
  String selectedEmpFromDashboardNextAllotted = "";
  String selectedEmpIdFromDashboardNextAllotted = "";
  List<String> assignedToFromApi = [];
  List<String> addedAssignedTo = [];
  List<String> addedAssignedToAllotted = [];
  List<String> taskEmp = [];
  List<String> taskId = [];
  List<String> srNo = [];
  List<Container> buildButtonList = [];
  BuildContext? context;
  int totalCompletion = 0;
  int totalDays = 0;
  int totalHours = 0;
  int totalMins = 0;
  int allottedTotalCompletion = 0;
  int allottedTotalDays = 0;
  int allottedTotalHours = 0;
  int allottedTotalMins = 0;
  String selectedReassignId = "";

  void callLoadAllTaskService(String cliId) async {
    loadAllTaskList.clear();
    updateLoader(true);
    try {
      LoadAllTaskModel? response = (await repository.getLoadAllTaskService(cliId));

      if (response.success!) {
        loadAllTaskList.addAll(response.loadAllTaskData!);

        selectedReassignId = cliId;
        for (var element in loadAllTaskList) {
          allottedTaskNameList.add(TextEditingController(text: element.taskName));
          allottedCompletionList.add(TextEditingController(text: element.completion));
          allottedDaysList.add(TextEditingController(text: element.days));
          allottedHoursList.add(TextEditingController(text: element.hours));
          allottedMinuteList.add(TextEditingController(text: element.mins));
          //triggerSelectedEmpIdList.add("");

          assignedToFromApi.add(element.firmEmployeeName!);
          allottedSelectedEmpList.add("");
          allottedSelectedEmpIdList.add(element.taskId!);
          allottedSrNo.add(element.srno!);

          forTaskNamesAllotted.add(element.taskName!);
          forCompletionCalculationAllotted.add(int.parse(element.completion!));
          forDaysCalculationAllotted.add(int.parse(element.days!));
          forHrCalculationAllotted.add(int.parse(element.hours!));
          forMinCalculationAllotted.add(int.parse(element.mins!));

          allottedTotalCompletion = allottedTotalCompletion + int.parse(element.completion!);
          allottedTotalDays = allottedTotalDays + int.parse(element.days!);
          allottedTotalHours = allottedTotalHours + int.parse(element.hours!);
          allottedTotalMins = allottedTotalMins + int.parse(element.mins!);
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

  List<String> triggerSelectedEmpList = [];
  List<String> triggerSelectedEmpIdList = [];

  updateAssignedTo(int index,String assignTo,String id,String taskId){
    selectedEmpFromDashboardNext = assignTo;
    selectedEmpIdFromDashboardNext = taskId;

    if(addedAssignedTo.contains(taskId)){
      addedAssignedTo.remove(taskId);
      update();
    }
    else{
      addedAssignedTo.add(taskId);
      update();
    }

    if(triggerSelectedEmpIdList.asMap().containsKey(index)){
      triggerSelectedEmpIdList.removeAt(index);
      triggerSelectedEmpList.removeAt(index);
      triggerSelectedEmpIdList.insert(index, id);
      triggerSelectedEmpList.insert(index, assignTo);
      update();
    }
    else{
      //triggerSelectedEmpIdList.insert(index,id);
      triggerSelectedEmpIdList.add(id);
      triggerSelectedEmpList.add(assignTo);
      //triggerSelectedEmpList.insert(index,assignTo);
      update();
    }
    update();
  }

  List<String> allottedSelectedEmpIdList = [];
  List<String> allottedSelectedEmpList = [];

  updateAssignedToAllotted(int index,String assignTo,String id,String taskId){
    selectedEmpFromDashboardNextAllotted = assignTo;
    selectedEmpIdFromDashboardNextAllotted = id;

    // if(addedAssignedTo.contains(id)){
    //   addedAssignedTo.remove(id);
    //   update();
    // }
    // else{
    //   addedAssignedTo.add(id);
    //   update();
    // }
    //
    // if(allottedSelectedEmpIdList.asMap().containsKey(index)){
    //   allottedSelectedEmpIdList.removeAt(index);
    //   allottedSelectedEmpIdList.insert(index, id);
    //   update();
    // }
    // else{
    //   allottedSelectedEmpIdList.insert(index,id);
    //   update();
    // }

    if(addedAssignedToAllotted.contains(taskId)){
      addedAssignedToAllotted.remove(taskId);
      update();
    }
    else{
      addedAssignedToAllotted.add(taskId);
      update();
    }

    print("index");
    print(index);

    if(allottedSelectedEmpIdList.asMap().containsKey(index)){
      print("contains");
      allottedSelectedEmpIdList.removeAt(index);
      allottedSelectedEmpList.removeAt(index);
      allottedSelectedEmpIdList.insert(index, id);
      allottedSelectedEmpList.insert(index, assignTo);
      update();
    }
    else{
      print("not contains");
      allottedSelectedEmpIdList.add(id);
      allottedSelectedEmpList.add(assignTo);
     // allottedSelectedEmpIdList.insert(index,id);
      //allottedSelectedEmpList.insert(index,assignTo);
      update();
    }
    update();
  }

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

  List<String> taskNameListToSendApi = [];
  List<String> completionListToSendApi = [];
  List<String> daysListToSendApi = [];
  List<String> hoursListToSendApi = [];
  List<String> minuteListToSendApi = [];
  List<String> taskEmpListToSendApi = [];
  List<String> taskIdListToSendApi = [];
  List<String> srNoListToSendApi = [];

  bool showLoadingText = false;

  checkAll(){
    // if(totalCompletion != 100) {
    //   Utils.showErrorSnackBar("Not able to reassign, Task is not 100 % completed.");
    // }
    //else{
      for(var element in allottedTaskNameList){
        allottedTaskNameListToSendApi.add(element.text);
      }
      for(var element in allottedCompletionList){
        allottedCompletionListToSendApi.add(element.text);
      }
      for(var element in allottedDaysList){
        allottedDaysListToSendApi.add(element.text);
      }
      for(var element in allottedHoursList){
        allottedHoursListToSendApi.add(element.text);
      }
      for(var element in allottedMinuteList){
        allottedMinuteListToSendApi.add(element.text);
      }

      allottedTaskNameFirstBracketRemove =  allottedTaskNameListToSendApi.toString().replaceAll("[", "");
      allottedTaskNameSecondBracketRemove = allottedTaskNameFirstBracketRemove.toString().replaceAll("]", "");
      print("task names : $allottedTaskNameSecondBracketRemove");

      allottedCompletionFirstBracketRemove =  allottedCompletionListToSendApi.toString().replaceAll("[", "");
      allottedCompletionSecondBracketRemove = allottedCompletionFirstBracketRemove.toString().replaceAll("]", "");
      print("completions : $allottedCompletionSecondBracketRemove");

      allottedDaysFirstBracketRemove =  allottedDaysListToSendApi.toString().replaceAll("[", "");
      allottedDaysSecondBracketRemove = allottedDaysFirstBracketRemove.toString().replaceAll("]", "");
      print("days : $allottedDaysSecondBracketRemove");

      allottedHoursFirstBracketRemove =  allottedHoursListToSendApi.toString().replaceAll("[", "");
      allottedHoursSecondBracketRemove = allottedHoursFirstBracketRemove.toString().replaceAll("]", "");
      print("hours : $allottedHoursSecondBracketRemove");

      allottedMinuteFirstBracketRemove =  allottedMinuteListToSendApi.toString().replaceAll("[", "");
      allottedMinuteSecondBracketRemove = allottedMinuteFirstBracketRemove.toString().replaceAll("]", "");
      print("minutes : $minuteSecondBracketRemove");

      allottedTaskEmpFirstBracketRemove =  allottedSelectedEmpList.toString().replaceAll("[", "");
      allottedTaskEmpSecondBracketRemove = allottedTaskEmpFirstBracketRemove.toString().replaceAll("]", "");
      print("task emp : $allottedTaskEmpSecondBracketRemove");

      allottedTaskIdFirstBracketRemove =  allottedSelectedEmpIdList.toString().replaceAll("[", "");
      allottedTaskIdSecondBracketRemove = allottedTaskIdFirstBracketRemove.toString().replaceAll("]", "");
      print("task emp id : $allottedTaskIdSecondBracketRemove");

      allottedSrNoFirstBracketRemove =  allottedSrNo.toString().replaceAll("[", "");
      allottedSrNoSecondBracketRemove = allottedSrNoFirstBracketRemove.toString().replaceAll("]", "");
      print("srno : $allottedSrNoSecondBracketRemove");

      callReassignServices();
    //}
    //update();
  }

  addMoreForAllottedNotCompleted(){
    updateLoader(true);
    allottedTaskNameList.insert(allottedTaskNameList.length, TextEditingController(text: ""));
    allottedCompletionList.insert(allottedCompletionList.length, TextEditingController(text: ""));
    allottedDaysList.insert(allottedDaysList.length, TextEditingController(text: ""));
    allottedHoursList.insert(allottedHoursList.length, TextEditingController(text: ""));
    allottedMinuteList.insert(allottedMinuteList.length, TextEditingController(text: ""));
    allottedTaskEmp.insert(allottedTaskEmp.length, "0");
    allottedTaskId.insert(allottedTaskId.length, "0");
    allottedSrNo.insert(allottedSrNo.length, "0");
    allottedSelectedEmpIdList.insert(allottedSelectedEmpIdList.length, "0");


    loadAllTaskList.insert(loadAllTaskList.length, LoadAllTaskData(
      completion: "",days: "",firmEmployeeName: "",hours: "",
      id: "",mins: "",srno: "0",start: "0",status: "0",targetDate: "0",
      taskEmp: "0",taskId: "0",taskName: ""
    ));

    showToast("New entry added !");
    updateLoader(false);
    update();
  }

  addMoreForTriggeredNotAllotted(int index){
    updateLoader(true);
    taskNameList.insert(index, TextEditingController(text: ""));
    completionList.insert(index, TextEditingController(text: ""));
    daysList.insert(index, TextEditingController(text: ""));
    hoursList.insert(index, TextEditingController(text: ""));
    minuteList.insert(index, TextEditingController(text: ""));
    taskEmp.insert(index, "0");
    taskId.insert(index, "0");
    srNo.insert(index, "0");
    triggerSelectedEmpIdList.insert(triggerSelectedEmpIdList.length, "0");

    triggeredNotAllottedLoadAll.insert(index, TriggeredNotAllottedLoadAllList(
     taskName: "",taskId: "",hours: "",days: "",completion: "",addedBy: "",addOnDate: "",bizAdminId: "",
      firmId: "",mastId: "",minutes: "",modifiedBy: "",modifiedOnDate: "",sortno: "",taskOndate: "",
      taskServiceId: "",taskServiceMainCategoryId: "",
    ));

    showToast("New entry added !");
    updateLoader(false);
    update();
  }

  List<String> forTaskNames = [];
  List<int> forCompletionCalculation = [];
  List<int> forDaysCalculation = [];
  List<int> forHrCalculation = [];
  List<int> forMinCalculation = [];

  List<String> forTaskNamesAllotted = [];
  List<int> forCompletionCalculationAllotted = [];
  List<int> forDaysCalculationAllotted = [];
  List<int> forHrCalculationAllotted = [];
  List<int> forMinCalculationAllotted = [];

  checkAllAddedValues(int index){
    if(taskNameList[index].text=="" ||
        int.parse(completionList[index].text) == 0 ||
        int.parse(daysList[index].text) == 0 ||
        int.parse(hoursList[index].text) == 0 ||
        int.parse(minuteList[index].text) == 0){
      Utils.showAlertSnackBar("Please enter all details");
    }
    else{
      saveTasks(index,taskNameList[index].text);
      saveCompletion(index,int.parse(completionList[index].text));
      saveDays(index,int.parse(daysList[index].text));
      saveHours(index,int.parse(hoursList[index].text));
      saveMinute(index,int.parse(minuteList[index].text));
      showToast("Added !");
    }
    update();
  }

  checkAllAddedValuesForAllotted(int index){
    if(allottedTaskNameList[index].text=="" ||
        allottedCompletionList[index].text.isEmpty ||
        allottedDaysList[index].text.isEmpty ||
        allottedHoursList[index].text.isEmpty ||
        allottedMinuteList[index].text.isEmpty)
    {
      Utils.showAlertSnackBar("Please enter all details");
    }
    else{
      // allottedSaveTasks(index,allottedTaskNameList[index].text);
      // allottedSaveCompletion(index,int.parse(allottedCompletionList[index].text));
      // allottedSaveDays(index,int.parse(allottedDaysList[index].text));
      // allottedSaveHours(index,int.parse(allottedHoursList[index].text));
      // allottedSaveMinute(index,int.parse(allottedMinuteList[index].text));
      showToast("Added !");
    }
    update();
  }

  saveTasks(int index,String minutes){
    if(forTaskNames.asMap().containsKey(index)){
      forTaskNames.removeAt(index);
      forTaskNames.insert(index, minutes);
      update();
    }
    else{
      forTaskNames.add(minutes);
      update();
    }
    update();
  }
  allottedSaveTasks(int index,String minutes){
    if(forTaskNamesAllotted.asMap().containsKey(index)){
      forTaskNamesAllotted.removeAt(index);
      forTaskNamesAllotted.insert(index, minutes);
      update();
    }
    else{
      forTaskNamesAllotted.add(minutes);
      update();
    }
    update();
  }

  saveCompletion(int index,int minutes){
    if(forCompletionCalculation.asMap().containsKey(index)){
      forCompletionCalculation.removeAt(index);
      forCompletionCalculation.insert(index, minutes);
      update();
    }
    else{
      forCompletionCalculation.add(minutes);
      update();
    }
    int sum = forCompletionCalculation.fold(0, (p, c) => p + c);
    totalCompletion = sum;
    update();
  }
  allottedSaveCompletion(int index,int minutes){
    if(forCompletionCalculationAllotted.asMap().containsKey(index)){
      forCompletionCalculationAllotted.removeAt(index);
      forCompletionCalculationAllotted.insert(index, minutes);
      update();
    }
    else{
      forCompletionCalculationAllotted.add(minutes);
      update();
    }
    int sum = forCompletionCalculationAllotted.fold(0, (p, c) => p + c);
    allottedTotalCompletion = sum;
    update();
  }

  saveDays(int index,int minutes){
    if(forDaysCalculation.asMap().containsKey(index)){
      forDaysCalculation.removeAt(index);
      forDaysCalculation.insert(index, minutes);
      update();
    }
    else{
      forDaysCalculation.add(minutes);
      update();
    }
    int sum = forDaysCalculation.fold(0, (p, c) => p + c);
    totalDays = sum;
    update();
  }
  allottedSaveDays(int index,int minutes){
    if(forDaysCalculationAllotted.asMap().containsKey(index)){
      forDaysCalculationAllotted.removeAt(index);
      forDaysCalculationAllotted.insert(index, minutes);
      update();
    }
    else{
      forDaysCalculationAllotted.add(minutes);
      update();
    }
    int sum = forDaysCalculationAllotted.fold(0, (p, c) => p + c);
    allottedTotalDays = sum;
    update();
  }

  saveHours(int index,int minutes){
    if(forHrCalculation.asMap().containsKey(index)){
      forHrCalculation.removeAt(index);
      forHrCalculation.insert(index, minutes);
      update();
    }
    else{
      forHrCalculation.add(minutes);
      update();
    }
    int sum = forHrCalculation.fold(0, (p, c) => p + c);
    totalHours = sum;
    update();
  }
  allottedSaveHours(int index,int minutes){
    if(forHrCalculationAllotted.asMap().containsKey(index)){
      forHrCalculationAllotted.removeAt(index);
      forHrCalculationAllotted.insert(index, minutes);
      update();
    }
    else{
      forHrCalculationAllotted.add(minutes);
      update();
    }
    int sum = forHrCalculationAllotted.fold(0, (p, c) => p + c);
    allottedTotalHours = sum;
    update();
  }

  saveMinute(int index,int minutes){
      if(forMinCalculation.asMap().containsKey(index)){
        forMinCalculation.removeAt(index);
        forMinCalculation.insert(index, minutes);
        update();
      }
      else{
        forMinCalculation.add(minutes);
        update();
      }
      int sum = forMinCalculation.fold(0, (p, c) => p + c);
      totalMins = sum;
      update();
  }
  allottedSaveMinute(int index,int minutes){
      if(forMinCalculationAllotted.asMap().containsKey(index)){
        forMinCalculationAllotted.removeAt(index);
        forMinCalculationAllotted.insert(index, minutes);
        update();
      }
      else{
        forMinCalculationAllotted.add(minutes);
        update();
      }
      int sum = forMinCalculationAllotted.fold(0, (p, c) => p + c);
      allottedTotalMins = sum;
      update();
  }

  // addDetailsClickForTriggeredNotAllotted(int index,String taskName, String completion,
  //     String days, String hours,String minutes,String emp){
  //   updateLoader(true);
  //
  //   //totalCompletion = totalCompletion + int.parse(completion);
  //   totalDays = totalDays + int.parse(days);
  //   totalHours = totalHours + int.parse(hours);
  //   totalMins = totalMins + int.parse(minutes);
  //
  //   for(var element in taskNameList){
  //     taskNameListToSendApi.add(element.text);
  //   }
  //   for(var element in completionList){
  //     completionListToSendApi.add(element.text);
  //   }
  //   for(var element in daysList){
  //     daysListToSendApi.add(element.text);
  //   }
  //   for(var element in hoursList){
  //     hoursListToSendApi.add(element.text);
  //   }
  //   for(var element in minuteList){
  //     minuteListToSendApi.add(element.text);
  //   }
  //
  //   taskNameFirstBracketRemove =  taskNameListToSendApi.toString().replaceAll("[", "");
  //   taskNameSecondBracketRemove = taskNameFirstBracketRemove.toString().replaceAll("]", "");
  //
  //   completionFirstBracketRemove =  completionListToSendApi.toString().replaceAll("[", "");
  //   completionSecondBracketRemove = completionFirstBracketRemove.toString().replaceAll("]", "");
  //
  //   daysFirstBracketRemove =  daysListToSendApi.toString().replaceAll("[", "");
  //   daysSecondBracketRemove = daysFirstBracketRemove.toString().replaceAll("]", "");
  //
  //   hoursFirstBracketRemove =  hoursListToSendApi.toString().replaceAll("[", "");
  //   hoursSecondBracketRemove = hoursFirstBracketRemove.toString().replaceAll("]", "");
  //
  //   minuteFirstBracketRemove =  minuteListToSendApi.toString().replaceAll("[", "");
  //   minuteSecondBracketRemove = minuteFirstBracketRemove.toString().replaceAll("]", "");
  //
  //   taskEmpFirstBracketRemove =  taskEmp.toString().replaceAll("[", "");
  //   taskEmpSecondBracketRemove = taskEmpFirstBracketRemove.toString().replaceAll("]", "");
  //
  //   taskIdFirstBracketRemove =  taskId.toString().replaceAll("[", "");
  //   taskIdSecondBracketRemove = taskIdFirstBracketRemove.toString().replaceAll("]", "");
  //
  //   srNoFirstBracketRemove =  srNo.toString().replaceAll("[", "");
  //   srNoSecondBracketRemove = srNoFirstBracketRemove.toString().replaceAll("]", "");
  //
  //   print("taskNameSecondBracketRemove");
  //   print(taskNameSecondBracketRemove);
  //   print("selectedEmployeeId");
  //   print(selectedEmployeeId);
  //   print("completionSecondBracketRemove");
  //   print(completionSecondBracketRemove);
  //   print("daysSecondBracketRemove");
  //   print(daysSecondBracketRemove);
  //   print("hoursSecondBracketRemove");
  //   print(hoursSecondBracketRemove);
  //   print("minuteSecondBracketRemove");
  //   print(minuteSecondBracketRemove);
  //   print("taskEmpSecondBracketRemove");
  //   print(taskEmpSecondBracketRemove);
  //   print("taskIdSecondBracketRemove");
  //   print(taskIdSecondBracketRemove);
  //   print("srNoSecondBracketRemove");
  //   print(srNoSecondBracketRemove);
  //   print("selectedCurrentPriorityId");
  //   print(selectedCurrentPriorityId);
  //   print("selectedPeriod");
  //   print(selectedPeriod==0?"1":"2");
  //
  //   updateLoader(false);
  //   update();
  // }

  List<int> addedCompletion = [] ;
  List<int> addedDays = [] ;
  List<int> addedHours = [] ;
  List<int> addedMinute = [] ;

  int addedDaysValue = 0;
  int addedHoursValue = 0;
  int addedMinValue = 0;

  addCompletion(int index,String value){
    if(addedCompletion.contains(index)){
      addedCompletion.clear();
      addedCompletion.add(index);
      completionList.insert(index, TextEditingController(text: value));
      totalCompletion = totalCompletion + int.parse(value);
    }
    else{
      addedCompletion.add(index);
    }
    update();
  }

  addDays(int index,String value){
    addedDaysValue = int.parse(value);
    print("addedDaysValue");
    print(addedDaysValue);
    totalDays = totalDays + addedDaysValue;
    print("totalDays");
    print(totalDays);
    update();
  }

  minusDays(int index,String value){
    totalDays = totalDays - addedDaysValue;
    update();
  }

  addHours(int index,String value){
    addedHoursValue = int.parse(value);
    totalHours = totalHours + addedHoursValue;
    update();
  }

  addMinutes(int index,String value){
    addedMinValue = int.parse(value);
    totalMins = totalMins + addedMinValue;
    update();
  }

  clearAllFromReassign(){
    loadAllTaskList.clear();
    taskNameList.clear();
    completionList.clear();
    daysList.clear();
    hoursList.clear();
    minuteList.clear();
    assignedToFromApi.clear();
    taskEmp.clear();
    taskId.clear();
    srNo.clear();

    addedCompletion.clear();
    addedDays.clear();
    addedHours.clear();
    addedMinute.clear();

    totalCompletion=0;
    totalDays=0;
    totalHours=0;
    totalMins=0;
    update();
  }

  clearAllFromTriggeredNotAllottedReassign(){
    loadAllTaskList.clear();
    taskNameList.clear();
    completionList.clear();
    daysList.clear();
    hoursList.clear();
    minuteList.clear();
    assignedToFromApi.clear();
    taskEmp.clear();
    taskId.clear();
    srNo.clear();

    addedCompletion.clear();
    addedDays.clear();
    addedHours.clear();
    addedMinute.clear();

    totalCompletion=0;
    totalDays=0;
    totalHours=0;
    totalMins=0;
    selectedCurrentPriority ="";
    selectedCliId = "";
    update();
  }

  navigateFromReassign(){
    clearAllFromReassign();
    Get.toNamed(AppRoutes.serviceDashboardNext);
  }

  navigateFromLoadAll(){
    clearAllFromTriggeredNotAllottedReassign();
    Get.toNamed(AppRoutes.triggeredNotAllottedPieChartList);
  }

  ///reassign services
  void callReassignServices() async {
    updateLoader(true);
    try {
      ApiResponse? response = (await repository.getReassignServices(allottedTaskNameSecondBracketRemove,selectedReassignId,
          allottedCompletionSecondBracketRemove,allottedDaysSecondBracketRemove,allottedHoursSecondBracketRemove,
          allottedMinuteSecondBracketRemove, allottedTaskEmpSecondBracketRemove,allottedTaskIdSecondBracketRemove,
          allottedSrNoSecondBracketRemove));

      if (response.success!) {
        Utils.showSuccessSnackBar(response.message);
        clearAllFromReassign();
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

  String selectedPriority = "";

  ///reassign triggered not allotted services
  void callReassignTriggeredNotAllotted() async {
    updateLoader(true);
    print(taskNameSecondBracketRemove);
    print(selectedEmployeeId);
    print(completionSecondBracketRemove);
    print(daysSecondBracketRemove);
    print(hoursSecondBracketRemove);
    print(minuteSecondBracketRemove);
    print(taskEmpSecondBracketRemove);
    print(taskIdSecondBracketRemove);
    print(srNoSecondBracketRemove);
    print(selectedCurrentPriorityId);
    print(selectedPeriod==0?"1":"2");

    try {
      ApiResponse? response = (await repository.getReassignTriggeredNotAllotted(taskNameSecondBracketRemove,
          selectedEmployeeId, completionSecondBracketRemove,daysSecondBracketRemove,hoursSecondBracketRemove,
          minuteSecondBracketRemove, taskEmpSecondBracketRemove,taskIdSecondBracketRemove,srNoSecondBracketRemove,
          selectedCurrentPriorityId, selectedPeriod==0?"1":"2"));
      print(response);
      if (response.success!) {
        Utils.showSuccessSnackBar(response.message);
        clearAllFromReassign();
        updateLoader(false);
        update();
      } else {
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      update();
    } on CustomException catch (e) {
      print("exception error");
      print(e.getMsg());
      Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      print("catch error");
      print(error);
      Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }
  }

  navigateToDetails(String cliId,String clientName,String serviceName){
    selectedClientName = clientName; selectedServiceName = serviceName;
    update();
    callLoadAllTaskService(cliId);
    Get.toNamed(AppRoutes.serviceDashboardNextDetails);
  }

  navigateToServiceView(String cliId,String clientName,String serviceName){
    selectedClientName = clientName; selectedServiceName = serviceName;

    print("selected");
    print(selectedClientName);
    print(selectedServiceName);
    print(cliId);
    update();
    callLoadAllTaskService(cliId);

    selectedMainType == "AllottedNotStarted"
        ? Get.toNamed(AppRoutes.serviceNextViewScreen)
        : Get.toNamed(AppRoutes.startedNotCompletedViewScreen);
  }

  startSelectedTask(String cliId,String id){
    updateLoader(true);
    callStartTask(cliId, id);
    update();
  }

  ///start task
  void callStartTask(String cliId,String id) async {
    updateLoader(true);
    try {
      ApiResponse? response = (await repository.getStartTask(cliId,id));

      if (response.success!) {
        Utils.showSuccessSnackBar(response.message);
        callLoadAllTaskService(cliId);
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

  ///check password
  void callCheckPassword(BuildContext context) async {
    updateLoader(true);
    try {
      ApiResponse? response = (await repository.getCheckPassword(checkPassword.text));

      if (response.success!) {
        Utils.showSuccessSnackBar(response.message);
        updateLoader(false);
        Navigator.of(context).pop();
        hideReasonContent = false;
        showCheckPasswordOrReasonDialog("Reason for cancel",context);
        callAllottedNotStarted();
        callStartedNotCompleted();
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
  ///cancel current period
  void callCancelService(BuildContext context) async {
    updateLoader(true);
    try {
      ApiResponse? response = (await repository.getCancelCurrentPeriodService(selectedCliId,checkPassword.text,
          selectedCancelType == 0 ? "1":"2"));
      if (response.success!) {
        Utils.showSuccessSnackBar(response.message);
        updateLoader(false);
        clearDialog();
        Navigator.of(context).pop();
        callAllottedNotStartedOwn();
        callAllottedNotStarted();
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

  bool checkBoxValue = false;
  List<String> addedId= [];
  ///on checkbox click
  onCheckBoxSelect(BuildContext context,String id){
    checkBoxValue = !checkBoxValue;
    if(addedId.contains(id)){
      addedId.remove(id);
      update();
    }
    else{
      addedId.add(id);
      update();
    }
    update();
  }
  ///confirm cancel service
  void callConfirmCancelService(BuildContext context) async {
    updateLoader(true);
    try {
      ApiResponse? response = (await repository.getConfirmCancelService(addedId.toString(),checkPassword.text));
      if (response.success!) {
        Utils.showSuccessSnackBar(response.message);
        updateLoader(false);
        clearDialog();
        Navigator.of(context).pop();
        callAllottedNotStartedOwn();
        callAllottedNotStarted();
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

  bool showRemarkDialog = false;
  bool showAllTaskCompletedDialog = false;
  ///check complete task service
  void callCheckCompletedTaskService(BuildContext context) async {
    //updateLoader(true);
    try {
      ApiResponse? response = (await repository.getCheckCompletedTaskService(selectedCurrentStatusId,
          selectedServiceStatus=="Inprocess" ? "1" : selectedServiceStatus == "Hold" ? "2" : "4"));
      if (response.success!) {
        Utils.showSuccessSnackBar(response.message);
        updateLoader(false);
        // callAllottedNotStartedOwn();
        // callAllottedNotStarted();
        if(selectedServiceStatus=="Hold"){
          showRemarkDialog = true;
          showAllTaskCompletedDialog = false;
          showRemarkDialogForHoldStatus(selectedServiceName,context);
        }
        update();
      }
      else {
        print("in else msg");
        print(response.message);
        if(response.message == "All tasks are not marked as completed"){
          //updateLoader(false);
          showDialogToCompleteAllTask(context);
         // update();
          showRemarkDialog = false;
          showAllTaskCompletedDialog = true;
        }
        else{
          print("in else");
          print(response.message);
          Utils.showErrorSnackBar(response.message);
          updateLoader(false);
          update();
        }
      }
     // update();
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
  //BuildContext? context;

  showDialogToCompleteAllTask(BuildContext context){
    showDialog(
      barrierDismissible: false,
      context:context,
      builder:(context){
        return StatefulBuilder(builder: (context,setter){
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 150.0,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // buildTextRegularWidget("Confirm ?", blackColor, context, 16.0,align: TextAlign.left),
                    // const Divider(color: Colors.grey,),
                    const SizedBox(height: 10.0,),
                    buildTextRegularWidget("There are pending tasks and they will be marked complete. Do you want to proceed?",
                        blackColor, context, 16.0,align: TextAlign.left),
                    const SizedBox(height: 20.0,),
                    Row(
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: (){
                              setter((){
                                callUpdateTaskServiceStatus(context);
                              });
                            },
                            child: buildButtonWidget(context, "Confirm",height: 40.0,buttonColor: approveColor),
                          ),
                        ),const SizedBox(width: 5.0,),
                        Flexible(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                              updateLoader(false);
                            },
                            child: buildButtonWidget(context, "Cancel",height: 40.0,buttonColor: errorColor),
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

  ///update task service
  void callUpdateTaskServiceStatus(BuildContext context) async {
    updateLoader(true);
    try {
      ApiResponse? response = (await repository.getUpdateTaskService(selectedCurrentStatusId,
          selectedServiceStatus=="Inprocess" ? "1" : selectedServiceStatus == "Hold" ? "2" : "4",
          selectedServiceStatus,remarkController.text??""));
      print("response");
      print(response);
      if (response.success!) {
        Utils.showSuccessSnackBar(response.message);
        updateLoader(false);
        // callAllottedNotStartedOwn();
        // callAllottedNotStarted();
        update();
      } else {
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      Navigator.pop(context);
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

  List<String> taskStatusList = ["Inporgress","Awaiting for Client Input","Submitted for complete","Put on Hold","Completed"];
  List<String> addedTaskStatus = [];
  String selectedTaskStatus = "";
  String selectedTaskStatusId = "";

  // checkTaskStatus(BuildContext context,String assignId,String id, String taskName){
  //
  // }

  updateTaskStatus(String status,String id,BuildContext context,assignId,String taskName){
    selectedTaskStatus = status;
    selectedTaskStatusId = id;
    if(addedTaskStatus.contains(id)){
      addedTaskStatus.remove(id);
      update();
    }
    else{
      addedTaskStatus.add(id);
      update();
    }

    if(selectedTaskStatus == "Inprocess" || selectedTaskStatus == "Completed"){
    }
    else{
      showRemarkDialogForTaskStatus(context,assignId,id,selectedTaskStatusId,selectedTaskStatus,taskName);
    }
    update();
  }

  showRemarkDialogForTaskStatus(BuildContext context,String assignId,String id, String statusId, String status,
      String taskName){
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
                height: 200.0,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildTextRegularWidget(taskName, blackColor, context, 16.0,align: TextAlign.left),
                    const Divider(color: Colors.grey,),
                    const SizedBox(height: 10.0,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        color: textFormBgColor,
                        border: Border.all(color: textFormBgColor),),
                      child: TextFormField(
                        controller: remarkController,
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

                    const SizedBox(height: 10.0,),

                    Row(
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: (){
                              setter((){
                                //callUpdateTaskStatus(context,assignId,id,taskName);
                                selectedTaskStatus = status;
                                Navigator.pop(context);
                              });
                            },
                            child: buildButtonWidget(context, "Add",height: 40.0,buttonColor: approveColor),
                          ),
                        ),const SizedBox(width: 5.0,),
                        Flexible(
                          child: GestureDetector(
                            onTap: (){
                              clearRemarkDialog();
                              Navigator.pop(context);
                            },
                            child: buildButtonWidget(context, "Close",height: 40.0,buttonColor: errorColor),
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

  ///update task status
  void callUpdateTaskStatus(BuildContext context,String assignId,String id,String taskName) async {
    updateLoader(true);
    try {
      ApiResponse? response = (await repository.getUpdateTaskStatus(assignId,id,selectedTaskStatusId,selectedTaskStatus,
          remarkController.text,taskName));
      print("response");
      print(response);
      if (response.success!) {
        clearRemarkDialog();
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

  /// priority change for current
  updatePriorityForTriggeredNotAllotted(String priority){
    selectedCurrentPriority = priority;
    priority == "Low" ? selectedCurrentPriorityId = "3" : priority == "Medium" ? "2": "1" ;
    update();
  }

  String selectedEmployee="";
  String selectedEmployeeId="";

  updateEmployeeFromTriggered(String priority,String id){
    selectedEmployee = priority;
    selectedEmployeeId = id;
    print(selectedEmployee);
    print(selectedEmployeeId);
    update();
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