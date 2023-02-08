import 'package:intl/intl.dart';

class OwnChartModel {
  String? message;
  bool? success;
  OwnChartData? ownChartData;

  OwnChartModel({this.message, this.success, this.ownChartData});

  OwnChartModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    ownChartData =
    json['owndata'] != null ? OwnChartData.fromJson(json['owndata']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (ownChartData != null) {
      data['owndata'] = ownChartData!.toJson();
    }
    return data;
  }
}

class OwnChartData {
  List<int>? allottedButNotStarted;
  List<int>? startedButNotCompleted;
  List<int>? completedButUdinPending;

  OwnChartData(
      {
        //this.allottedButNotStarted,
        this.startedButNotCompleted,
        this.completedButUdinPending,
      });

  OwnChartData.fromJson(Map<String, dynamic> json) {
    //allottedButNotStarted = json['Allotted_but_not_started'].cast<int>();
    startedButNotCompleted = json['Started_but_not_completed'].cast<int>();
    completedButUdinPending = json['Completed_but_udin_pending'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //data['Allotted_but_not_started'] = allottedButNotStarted;
    data['Started_but_not_completed'] = startedButNotCompleted;
    data['Completed_but_udin_pending'] = completedButUdinPending;
    return data;
  }
}

class TriggerNotAllottedModel {
  String? message;
  bool? success;
  TriggeredNotAllottedData? triggeredNotAllottedData;

  TriggerNotAllottedModel({this.message, this.success, this.triggeredNotAllottedData});

  TriggerNotAllottedModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    triggeredNotAllottedData = json['data'] != null ? TriggeredNotAllottedData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (triggeredNotAllottedData != null) {
      data['data'] = triggeredNotAllottedData!.toJson();
    }
    return data;
  }
}

class TriggeredNotAllottedData {
  List<int>? serviceTriggeredButNotAllotted;

  TriggeredNotAllottedData({this.serviceTriggeredButNotAllotted});

  TriggeredNotAllottedData.fromJson(Map<String, dynamic> json) {
    serviceTriggeredButNotAllotted = json['service_triggered_but_not_allotted'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_triggered_but_not_allotted'] = serviceTriggeredButNotAllotted;
    return data;
  }
}

class AllottedNotStartedModel {
  String? message;
  bool? success;
  AllottedNotStartedData? allottedNotStartedData;

  AllottedNotStartedModel({this.message, this.success, this.allottedNotStartedData});

  AllottedNotStartedModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    allottedNotStartedData = json['data'] != null ? AllottedNotStartedData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (allottedNotStartedData != null) {
      data['data'] = allottedNotStartedData!.toJson();
    }
    return data;
  }
}

class AllottedNotStartedData {
  List<int>? allottedButNotStarted;
  List<int>? team = [];
  List? own = [];
  List<String>? isReportingHead;

  AllottedNotStartedData({this.allottedButNotStarted, this.team, this.own, this.isReportingHead});

  AllottedNotStartedData.fromJson(Map<String, dynamic> json) {
    allottedButNotStarted = json['Allotted_but_not_started'].cast<int>();
    team = json["Team"].cast<int>();
    own = json['Own'];
    isReportingHead = json['is_reporting_head'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Allotted_but_not_started'] = allottedButNotStarted;
    data['Team'] = team;
    data['Own'] = own;
    data['is_reporting_head'] = isReportingHead;
    return data;
  }
}

class StartedNotCompletedModel {
  String? message;
  bool? success;
  StartedNotCompletedData? startedNotCompletedData;

  StartedNotCompletedModel({this.message, this.success, this.startedNotCompletedData});

  StartedNotCompletedModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    startedNotCompletedData = json['data'] != null ? StartedNotCompletedData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (startedNotCompletedData != null) {
      data['data'] = startedNotCompletedData!.toJson();
    }
    return data;
  }
}

class StartedNotCompletedData {
  List<int>? startedButNotCompleted;
  List<int>? team;
  List<int>? own;
  List<String>? isReportingHead;

  StartedNotCompletedData(
      {this.startedButNotCompleted, this.team, this.own, this.isReportingHead});

  StartedNotCompletedData.fromJson(Map<String, dynamic> json) {
    startedButNotCompleted = json['Started_but_not_completed'].cast<int>();
    team = json['Team'].cast<int>();
    own = json['Own'].cast<int>();
    isReportingHead = json['is_reporting_head'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Started_but_not_completed'] = startedButNotCompleted;
    data['Team'] = team;
    data['Own'] = own;
    data['is_reporting_head'] = isReportingHead;
    return data;
  }
}

class CompletedUdinPendingModel {
  String? message;
  bool? success;
  CompletedUdinPendingData? completedUdinPendingData;

  CompletedUdinPendingModel({this.message, this.success, this.completedUdinPendingData});

  CompletedUdinPendingModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    completedUdinPendingData = json['data'] != null ? CompletedUdinPendingData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (completedUdinPendingData != null) {
      data['data'] = completedUdinPendingData!.toJson();
    }
    return data;
  }
}

class CompletedUdinPendingData {
  List<int>? completedButUdinPending;
  List<int>? team;
  List<int>? own;
  List<String>? isReportingHead;

  CompletedUdinPendingData(
      {this.completedButUdinPending,
        this.team,
        this.own,
        this.isReportingHead});

  CompletedUdinPendingData.fromJson(Map<String, dynamic> json) {
    completedButUdinPending = json['Completed_but_udin_pending'].cast<int>();
    team = json['Team'].cast<int>();
    own = json['Own'].cast<int>();
    isReportingHead = json['is_reporting_head'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Completed_but_udin_pending'] = completedButUdinPending;
    data['Team'] = team;
    data['Own'] = own;
    data['is_reporting_head'] = isReportingHead;
    return data;
  }
}
class CompletedNotBilledModel {
  String? message;
  bool? success;
  CompletedNotBilledData? completedNotBilledData;

  CompletedNotBilledModel({this.message, this.success, this.completedNotBilledData});

  CompletedNotBilledModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    completedNotBilledData = json['data'] != null ? CompletedNotBilledData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (completedNotBilledData != null) {
      data['data'] = completedNotBilledData!.toJson();
    }
    return data;
  }
}
class CompletedNotBilledData {
  List<int>? completedButNotBilled;

  CompletedNotBilledData({this.completedButNotBilled});

  CompletedNotBilledData.fromJson(Map<String, dynamic> json) {
    completedButNotBilled = json['Completed_but_not_billed'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Completed_but_not_billed'] = completedButNotBilled;
    return data;
  }
}

class WorkOnHoldModel {
  String? message;
  bool? success;
  WorkOnHoldData? workOnHoldData;

  WorkOnHoldModel({this.message, this.success, this.workOnHoldData});

  WorkOnHoldModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    workOnHoldData = json['data'] != null ? WorkOnHoldData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (workOnHoldData != null) {
      data['data'] = workOnHoldData!.toJson();
    }
    return data;
  }
}

class WorkOnHoldData {
  List<int>? workOnHold;
  List<int>? team;
  List<int>? own;
  List<String>? isReportingHead;

  WorkOnHoldData({this.workOnHold, this.team, this.own, this.isReportingHead});

  WorkOnHoldData.fromJson(Map<String, dynamic> json) {
    workOnHold = json['work_on_hold_'].cast<int>();
    team = json['Team'].cast<int>();
    own = json['Own'].cast<int>();
    isReportingHead = json['is_reporting_head'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['work_on_hold_'] = workOnHold;
    data['Team'] = team;
    data['Own'] = own;
    data['is_reporting_head'] = isReportingHead;
    return data;
  }
}
class SubmittedForCheckingModel {
  String? message;
  bool? success;
  SubmittedForCheckingData? submittedForCheckingData;

  SubmittedForCheckingModel({this.message, this.success, this.submittedForCheckingData});

  SubmittedForCheckingModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    submittedForCheckingData = json['data'] != null ? SubmittedForCheckingData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (submittedForCheckingData != null) {
      data['data'] = submittedForCheckingData!.toJson();
    }
    return data;
  }
}

class SubmittedForCheckingData {
  List<int>? submittedForChecking;
  List<int>? team;
  List<int>? own;
  List<String>? isReportingHead;

  SubmittedForCheckingData({this.submittedForChecking, this.team, this.own, this.isReportingHead});

  SubmittedForCheckingData.fromJson(Map<String, dynamic> json) {
    submittedForChecking = json['submitted_for_checking'].cast<int>();
    team = json['Team'].cast<int>();
    own = json['Own'].cast<int>();
    isReportingHead = json['is_reporting_head'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['submitted_for_checking'] = submittedForChecking;
    data['Team'] = team;
    data['Own'] = own;
    data['is_reporting_head'] = isReportingHead;
    return data;
  }
}

class AllTaskCompletedModel {
  String? message;
  bool? success;
  AllTaskCompletedData? allTaskCompletedData;

  AllTaskCompletedModel({this.message, this.success, this.allTaskCompletedData});

  AllTaskCompletedModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    allTaskCompletedData = json['data'] != null ? AllTaskCompletedData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (allTaskCompletedData != null) {
      data['data'] = allTaskCompletedData!.toJson();
    }
    return data;
  }
}

class AllTaskCompletedData {
  List<int>? alltasksCompleteChart;
  List<int>? team;
  List<int>? own;
  List<String>? isReportingHead;

  AllTaskCompletedData({this.alltasksCompleteChart, this.team, this.own, this.isReportingHead});

  AllTaskCompletedData.fromJson(Map<String, dynamic> json) {
    alltasksCompleteChart = json['alltasks_complete_chart'].cast<int>();
    team = json['Team'].cast<int>();
    own = json['Own'].cast<int>();
    isReportingHead = json['is_reporting_head'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['alltasks_complete_chart'] = alltasksCompleteChart;
    data['Team'] = team;
    data['Own'] = own;
    data['is_reporting_head'] = isReportingHead;
    return data;
  }
}

// class AllottedNotStartedPastDueTeam {
//   String? message;
//   bool? success;
//   List<AllottedNotStartedPastDueData>? allottedNotStartedPastDueData;
//
//   AllottedNotStartedPastDueTeam({this.message, this.success, this.allottedNotStartedPastDueData});
//
//   AllottedNotStartedPastDueTeam.fromJson(Map<String, dynamic> json) {
//     message = json['Message'];
//     success = json['Success'];
//     if (json['data'] != null) {
//       allottedNotStartedPastDueData = <AllottedNotStartedPastDueData>[];
//       json['data'].forEach((v) {
//         allottedNotStartedPastDueData!.add(AllottedNotStartedPastDueData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['Message'] = message;
//     data['Success'] = success;
//     if (allottedNotStartedPastDueData != null) {
//       data['data'] = allottedNotStartedPastDueData!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class AllottedNotStartedPastDueData {
//   String? id;
//   String? clientCode;
//   String? client;
//   String? servicename;
//   String? triggerDate;
//   String? targetDate;
//   String? satDate;
//   String? priority;
//   String? allottedTo;
//
//   AllottedNotStartedPastDueData(
//       {this.id,
//         this.clientCode,
//         this.client,
//         this.servicename,
//         this.triggerDate,
//         this.targetDate,
//         this.satDate,
//         this.priority,
//         this.allottedTo});
//
//   AllottedNotStartedPastDueData.fromJson(Map<String, dynamic> json) {
//     id = json['id']??"";
//     clientCode = json['client_code']??"";
//     client = json['client']??"";
//     servicename = json['servicename']??"";
//     triggerDate = json['trigger_date']??"";
//     targetDate = json['target_date']??"";
//     satDate = json['sat_date']??"";
//     priority = json['priority']??"";
//     allottedTo = json['Allotted To']??"";
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['client_code'] = clientCode;
//     data['client'] = client;
//     data['servicename'] = servicename;
//     data['trigger_date'] = triggerDate;
//     data['target_date'] = targetDate;
//     data['sat_date'] = satDate;
//     data['priority'] = priority;
//     data['Allotted To'] = allottedTo;
//     return data;
//   }
// }

class AllottedNotStartedPastDueTeam {
  String? message;
  bool? success;
  List<AllottedNotStartedPastDueData>? allottedNotStartedPastDueData;

  AllottedNotStartedPastDueTeam({this.message, this.success, this.allottedNotStartedPastDueData});

  AllottedNotStartedPastDueTeam.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['data'] != null) {
      allottedNotStartedPastDueData = <AllottedNotStartedPastDueData>[];
      json['data'].forEach((v) {
        allottedNotStartedPastDueData!.add(AllottedNotStartedPastDueData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (allottedNotStartedPastDueData != null) {
      data['data'] = allottedNotStartedPastDueData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllottedNotStartedPastDueData {
  String? id;
  String? clientCode;
  String? client;
  String? servicename;
  String? triggerDate;
  String? targetDate;
  String? satDate;
  String? priority;
  String? allottedTo;
  String? targetDateToShow;
  String? triggerDateToShow;
  String? priorityToShow;

  AllottedNotStartedPastDueData(
      {this.id,
        this.clientCode,
        this.client,
        this.servicename,
        this.triggerDate,
        this.targetDate,
        this.satDate,
        this.priority,
        this.allottedTo,
        this.targetDateToShow,
        this.triggerDateToShow,
        this.priorityToShow});

  AllottedNotStartedPastDueData.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    clientCode = json['client_code']??"";
    client = json['client']??"";
    servicename = json['servicename']??"";
    triggerDate = json['trigger_date']??"";
    targetDate = json['target_date']??"";
    satDate = json['sat_date']??"";
    priority = json['priority']??"";
    allottedTo = json['Allotted To']??"";
    targetDateToShow = json['target_date'] ==null || json['target_date'] == "" ? "" :
    DateFormat("dd-MM-yyyy").format(DateTime.parse(json["target_date"]));
    triggerDateToShow = json['trigger_date'] ==null || json['trigger_date'] == "" ? "" :
    DateFormat("dd-MM-yyyy").format(DateTime.parse(json["trigger_date"]));
    priorityToShow = json['priority']=="1" ? "High" : json['priority'] == "2" ? "Medium": "Low";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client_code'] = clientCode;
    data['client'] = client;
    data['servicename'] = servicename;
    data['trigger_date'] = triggerDate;
    data['target_date'] = targetDate;
    data['sat_date'] = satDate;
    data['priority'] = priority;
    data['Allotted To'] = allottedTo;
    return data;
  }
}
class LoadAllTaskModel {
  String? message;
  bool? success;
  List<LoadAllTaskData>? loadAllTaskData;

  LoadAllTaskModel({this.message, this.success, this.loadAllTaskData});

  LoadAllTaskModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['data'] != null) {
      loadAllTaskData = <LoadAllTaskData>[];
      json['data'].forEach((v) {
        loadAllTaskData!.add(LoadAllTaskData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (loadAllTaskData != null) {
      data['data'] = loadAllTaskData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoadAllTaskData {
  String? firmEmployeeName;
  String? id;
  String? targetDate;
  String? taskId;
  String? taskName;
  String? taskEmp;
  String? srno;
  String? completion;
  String? days;
  String? hours;
  String? mins;
  String? start;
  String? status;

  LoadAllTaskData(
      {this.firmEmployeeName,
        this.id,
        this.targetDate,
        this.taskId,
        this.taskName,
        this.taskEmp,
        this.srno,
        this.completion,
        this.days,
        this.hours,
        this.mins,
        this.start,
        this.status});

  LoadAllTaskData.fromJson(Map<String, dynamic> json) {
    firmEmployeeName = json['firm_employee_name']??"";
    id = json['id']??"";
    targetDate = json['target_date']??"";
    taskId = json['task_id']??"";
    taskName = json['task_name']??"";
    taskEmp = json['task_emp']??"";
    srno = json['srno']??"";
    completion = json['completion']??"";
    days = json['days']??"";
    hours = json['hours']??"";
    mins = json['mins']??"";
    start = json['start']??"";
    status = json['status']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firm_employee_name'] = firmEmployeeName;
    data['id'] = id;
    data['target_date'] = targetDate;
    data['task_id'] = taskId;
    data['task_name'] = taskName;
    data['task_emp'] = taskEmp;
    data['srno'] = srno;
    data['completion'] = completion;
    data['days'] = days;
    data['hours'] = hours;
    data['mins'] = mins;
    data['start'] = start;
    data['status'] = status;
    return data;
  }
}