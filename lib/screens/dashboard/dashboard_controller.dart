import 'dart:ui' as pie_chart_color;

import 'package:biznew/common_widget/error_text.dart';
import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/constant/provider/custom_exception.dart';
import 'package:biznew/constant/repository/api_repository.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/claim_form/claim_model.dart';
import 'package:biznew/screens/dashboard/dashboard_model.dart';
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

class DashboardController extends GetxController {
  final ApiRepository repository;

  // ignore: unnecessary_null_comparison
  DashboardController({required this.repository}) : assert(repository != null);

  ///common
  String userId="";
  String userName="";
  String name="";
  int selectedFlag = 0;
  bool loader = false;
  int currentPos = 0;

  List chartDetails = ["Triggered In Last 7 Days","More Than 7 Days","Past Due","Probable Overdue","High",];
  //List chartColors = [Colors.blue,Colors.brown,Colors.orangeAccent.shade100,Colors.indigo,Colors.red];
  List chartColors = [Colors.blue,Colors.brown,Color(0xffFFEE58),Color(0xff0000FF),Color(0xffFF0000)];

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
    Color(0xffFFEE58)
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
    Color(0xffFFEE58),Color(0xff0000FF),Color(0xffFF0000),Color(0xffFFA500),Color(0xff008000)
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
    Color(0xffFFEE58),Color(0xff0000FF),Color(0xffFF0000),Color(0xffFFA500),Color(0xff008000)
  ];
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
  String selectedAllPriority = "";
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
  List<String> addedPriorityListForCurrent = [];
  List<String> addedDateListForCurrent = [];
  List<String> addedPriorityListForAll = [];
  List<String> addedDateListForAll = [];

  ///cancel leave
  int selectedCancelType = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userId = GetStorage().read("userId")??"";
    userName = GetStorage().read("userName")??"";
    name = GetStorage().read("name")??"";
    repository.getData();

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
    updateLoader(true);
    selectedPieChartTitle = title;
    selectedType = type ; selectedCount = count ;
    if(title == "Past Due"){
      type == "Own" ?  callAllottedNotStartedOwn() :  callAllottedNotStartedTeam();
    }
    else if(title == "Probable Overdue"){
      type == "Own" ?  callAllottedNotStartedOwn() :  callAllottedNotStartedTeam();
    }
    else if(title == "High"){
      type == "Own" ?  callAllottedNotStartedOwn() :  callAllottedNotStartedTeam();
    }
    else if(title == "Medium"){
      type == "Own" ?  callAllottedNotStartedOwn() :  callAllottedNotStartedTeam();
    }
    else if(title == "Low"){
      type == "Own" ?  callAllottedNotStartedOwn() :  callAllottedNotStartedTeam();
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
  Future<void> selectTargetDateForCurrent(BuildContext context,String id) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateForCurrent,
        firstDate: DateTime(1700, 1),
        lastDate: DateTime(2100, 1));
    if (picked != null && picked != selectedDateForCurrent) {
      selectedDateForCurrent = picked;
    }
    selectedDateToShowForCurrent = "${selectedDateForCurrent.day}-${selectedDateForCurrent.month}-${selectedDateForCurrent.year}";
    selectedDateToSendForCurrent = "${selectedDateForCurrent.year}-${selectedDateForCurrent.month}-${selectedDateForCurrent.day}";

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

  onPasDueSelected(){
    isPastDueSelected = true; isPortableOverdueSelected = false; isHighSelected = false;
    isMediumSelected = false; isLowSelected = false;
    update();
  }
  onPortableOverdueSelected(){
    isPastDueSelected = false; isPortableOverdueSelected = true; isHighSelected = false;
    isMediumSelected = false; isLowSelected = false;
    update();
  }
  onHighSelected(){
    isPastDueSelected = false; isPortableOverdueSelected = false; isHighSelected = true;
    isMediumSelected = false; isLowSelected = false;
    update();
  }
  onHMediumSelected(){
    isPastDueSelected = false; isPortableOverdueSelected = false; isHighSelected = false;
    isMediumSelected = true; isLowSelected = false;
    update();
  }
  onLowSelected(){
    isPastDueSelected = false; isPortableOverdueSelected = false; isHighSelected = false;
    isMediumSelected = false; isLowSelected = true;
    update();
  }

  navigateToBottom(){
    currentPos = 1;
    updateSlider(1);
    carouselController.jumpToPage(1);
    Get.toNamed(AppRoutes.bottomNav);
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

    selectedPieChartTitle == "Past Due" ? onPasDueSelected() :
    selectedPieChartTitle == "Probable Overdue" ? onPortableOverdueSelected() :
    selectedPieChartTitle == "High" ? onHighSelected() :
    selectedPieChartTitle == "Medium" ? onHMediumSelected() :
    onLowSelected();

    Get.toNamed(AppRoutes.serviceDashboardNext);
  }
  ///allotted not started past due -> team
  void callAllottedNotStartedTeam() async {
    allottedNotStartedPastDueList.clear();
    try {
      AllottedNotStartedPastDueTeam? response =
      selectedPieChartTitle == "Past Due" ? (await repository.getAllottedNotStartedPastDueTeam()) :
      selectedPieChartTitle == "Probable Overdue" ? (await repository.getAllottedNotStartedProbableTeam()) :
      selectedPieChartTitle == "High" ? (await repository.getAllottedNotStartedHighTeam()) :
      selectedPieChartTitle == "Medium" ? (await repository.getAllottedNotStartedMediumTeam()) :
      (await repository.getAllottedNotStartedLowTeam());

      if (response.success!) {
        allottedNotStartedPastDueList.addAll(response.allottedNotStartedPastDueData!);
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

    selectedPastDue = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[0]}";
    selectedProbable = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[1]}";
    selectedHigh = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[2]}";
    selectedMedium = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[3]}";
    selectedLow = "${teamAllottedNotStarted.isEmpty?"":teamAllottedNotStarted[4]}";

    selectedPieChartTitle == "Past Due" ? onPasDueSelected() :
    selectedPieChartTitle == "Probable Overdue" ? onPortableOverdueSelected() :
    selectedPieChartTitle == "High" ? onHighSelected() :
    selectedPieChartTitle == "Medium" ? onHMediumSelected() :
    onLowSelected();

    Get.toNamed(AppRoutes.serviceDashboardNext);
  }

  ///start service
  void callStartService(String id) async {
    updateLoader(true);
    try {
      ApiResponse? response = (await repository.getStartService(id));

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
  ///load all tasks
  void callLoadAllTaskService(String cliId) async {
    loadAllTaskList.clear();
    updateLoader(true);
    try {
      LoadAllTaskModel? response = (await repository.getLoadAllTaskService(cliId));

      if (response.success!) {
        loadAllTaskList.addAll(response.loadAllTaskData!);
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

  navigateToDetails(String cliId,String clientName,String serviceName){
    selectedClientName = clientName; selectedServiceName = serviceName;
    update();
    callLoadAllTaskService(cliId);
    Get.toNamed(AppRoutes.serviceDashboardNextDetails);
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