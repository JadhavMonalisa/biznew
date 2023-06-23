import 'package:intl/intl.dart';

class NotificationModel {
  String? message;
  bool? success;
  List<NotificationList>? notificationList;

  NotificationModel({this.message, this.success, this.notificationList});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['notifications'] != null) {
      notificationList = <NotificationList>[];
      json['notifications'].forEach((v) {
        notificationList!.add(NotificationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (notificationList != null) {
      data['notifications'] =
          notificationList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationList {
  String? id;
  String? empId;
  String? mtitle;
  String? message;
  String? link;
  String? status;
  String? firmId;
  String? mastId;
  String? type;
  String? addedBy;
  String? addedDate;
  String? notifiAssign;

  NotificationList(
      {this.id,
        this.empId,
        this.mtitle,
        this.message,
        this.link,
        this.status,
        this.firmId,
        this.mastId,
        this.type,
        this.addedBy,
        this.addedDate,
        this.notifiAssign});

  NotificationList.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    empId = json['emp_id']??'';
    mtitle = json['mtitle']??"";
    message = json['message']??"";
    link = json['link']??'';
    status = json['status']??'';
    firmId = json['firm_id']??'';
    mastId = json['mast_id']??'';
    type = json['type']??'';
    addedBy = json['added_by']??'';
    addedDate = json['added_date']??"";
    notifiAssign = json['Notifi_assign']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['emp_id'] = empId;
    data['mtitle'] = mtitle;
    data['message'] = message;
    data['link'] = link;
    data['status'] = status;
    data['firm_id'] = firmId;
    data['mast_id'] = mastId;
    data['type'] = type;
    data['added_by'] = addedBy;
    data['added_date'] = addedDate;
    data['Notifi_assign'] = notifiAssign;
    return data;
  }
}

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
  String? satDateToShow;
  String? priorityToShow;
  DateTime? triggerDateTimeFormat;
  DateTime? targetDateTimeFormat;
  DateTime? staDateTimeFormat;

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
        this.satDateToShow,
        this.priorityToShow,
        this.triggerDateTimeFormat,
        this.targetDateTimeFormat,
        this.staDateTimeFormat,
      });

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
    satDateToShow = json['sat_date'] ==null || json['sat_date'] == "" ? "" :
    DateFormat("dd-MM-yyyy").format(DateTime.parse(json["sat_date"]));
    priorityToShow = json['priority']=="1" ? "High" : json['priority'] == "2" ? "Medium": "Low";
    triggerDateTimeFormat = DateTime.parse(json['trigger_date']);
    targetDateTimeFormat = DateTime.parse(json['target_date']);
    staDateTimeFormat = DateTime.parse(json['sat_date']);
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

class StartedButCompletedPieModel {
  String? message;
  bool? success;
  List<StartedNotCompletedPieList>? startedNotCompletedList;

  StartedButCompletedPieModel({this.message, this.success, this.startedNotCompletedList});

  StartedButCompletedPieModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['data'] != null) {
      startedNotCompletedList = <StartedNotCompletedPieList>[];
      json['data'].forEach((v) {
        startedNotCompletedList!.add(StartedNotCompletedPieList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (startedNotCompletedList != null) {
      data['data'] = startedNotCompletedList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StartedNotCompletedPieList {
  String? id;
  String? clientCode;
  String? client;
  String? servicename;
  String? triggerDate;
  String? targetDate;
  String? satDate;
  String? priority;
  String? allottedTo;
  String? tasks;
  String? completionPercentage;
  String? status;
  String? targetDateToShow;
  String? triggerDateToShow;
  String? satDateToShow;
  String? priorityToShow;
  String? statusName;
  DateTime? triggerDateTimeFormat;
  DateTime? targetDateTimeFormat;
  DateTime? staDateTimeFormat;


  StartedNotCompletedPieList(
      {this.id,
        this.clientCode,
        this.client,
        this.servicename,
        this.triggerDate,
        this.targetDate,
        this.satDate,
        this.priority,
        this.allottedTo,
        this.tasks,
        this.completionPercentage,
        this.status,
        this.targetDateToShow,
        this.triggerDateToShow,
        this.satDateToShow,
        this.priorityToShow,
        this.statusName,
        this.triggerDateTimeFormat,
        this.targetDateTimeFormat,
        this.staDateTimeFormat,
      });

  StartedNotCompletedPieList.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    clientCode = json['client_code']??"";
    client = json['client']??"";
    servicename = json['servicename']??"";
    triggerDate = json['trigger_date']??"";
    targetDate = json['target_date']??"";
    satDate = json['sat_date']??"";
    priority = json['priority']??"";
    allottedTo = json['Allotted To']??"";
    tasks = json['Tasks']??"";
    completionPercentage = json['Completion_Percentage'].toString()??"";
    status = json['Status']??"";
    targetDateToShow = json['target_date'] ==null || json['target_date'] == "" ? "" :
    DateFormat("dd-MM-yyyy").format(DateTime.parse(json["target_date"]));
    triggerDateToShow = json['trigger_date'] ==null || json['trigger_date'] == "" ? "" :
    DateFormat("dd-MM-yyyy").format(DateTime.parse(json["trigger_date"]));
    satDateToShow = json['sat_date'] ==null || json['sat_date'] == "" ? "" :
    DateFormat("dd-MM-yyyy").format(DateTime.parse(json["sat_date"]));
    priorityToShow = json['priority']=="1" ? "High" : json['priority'] == "2" ? "Medium": "Low";
    statusName = json['Status']=="1" ? "Inprocess": json["Status"]=="2" ? "Hold": "Complete";

    triggerDateTimeFormat = DateTime.parse(json["trigger_date"]);
    targetDateTimeFormat = DateTime.parse(json["target_date"]);
    staDateTimeFormat = DateTime.parse(json["sat_date"]);
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
    data['Tasks'] = tasks;
    data['Completion_Percentage'] = completionPercentage;
    data['Status'] = status;
    return data;
  }
}

class CompletedUdinPendingPieModel {
  String? message;
  bool? success;
  List<CompletedUdinPendingPieList>? completedUdinPendingPieList;

  CompletedUdinPendingPieModel({this.message, this.success, this.completedUdinPendingPieList});

  CompletedUdinPendingPieModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['data'] != null) {
      completedUdinPendingPieList = <CompletedUdinPendingPieList>[];
      json['data'].forEach((v) {
        completedUdinPendingPieList!.add(CompletedUdinPendingPieList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (completedUdinPendingPieList != null) {
      data['data'] = completedUdinPendingPieList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompletedUdinPendingPieList {
  String? id;
  String? clientCode;
  String? client;
  String? servicename;
  String? allottedTo;

  CompletedUdinPendingPieList(
      {this.id,
        this.clientCode,
        this.client,
        this.servicename,
        this.allottedTo});

  CompletedUdinPendingPieList.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    clientCode = json['client_code']??"";
    client = json['client']??"";
    servicename = json['servicename']??"";
    allottedTo = json['Allotted To']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client_code'] = clientCode;
    data['client'] = client;
    data['servicename'] = servicename;
    data['Allotted To'] = allottedTo;
    return data;
  }
}

class CompletedNotBilledPieModel {
  String? message;
  bool? success;
  List<CompletedNotBilledPieList>? completedNotBilledPieList;

  CompletedNotBilledPieModel({this.message, this.success, this.completedNotBilledPieList});

  CompletedNotBilledPieModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['data'] != null) {
      completedNotBilledPieList = <CompletedNotBilledPieList>[];
      json['data'].forEach((v) {
        completedNotBilledPieList!.add(CompletedNotBilledPieList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (completedNotBilledPieList != null) {
      data['data'] = completedNotBilledPieList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompletedNotBilledPieList {
  String? id;
  String? clientCode;
  String? client;
  String? servicename;
  String? amountOfServicePeriod;
  String? claimAmount;

  CompletedNotBilledPieList(
      {this.id,
        this.clientCode,
        this.client,
        this.servicename,
        this.amountOfServicePeriod,
        this.claimAmount});

  CompletedNotBilledPieList.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    clientCode = json['client_code']??"";
    client = json['client']??"";
    servicename = json['servicename']??"";
    amountOfServicePeriod = json['Amount of Service Period']??"";
    claimAmount = json['Claim Amount']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client_code'] = clientCode;
    data['client'] = client;
    data['servicename'] = servicename;
    data['Amount of Service Period'] = amountOfServicePeriod;
    data['Claim Amount'] = claimAmount;
    return data;
  }
}

class SubmittedForCheckingPieModel {
  String? message;
  bool? success;
  List<SubmittedForCheckingPieList>? submittedForCheckingPieList;

  SubmittedForCheckingPieModel({this.message, this.success, this.submittedForCheckingPieList});

  SubmittedForCheckingPieModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['data'] != null) {
      submittedForCheckingPieList = <SubmittedForCheckingPieList>[];
      json['data'].forEach((v) {
        submittedForCheckingPieList!.add(SubmittedForCheckingPieList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (submittedForCheckingPieList != null) {
      data['data'] = submittedForCheckingPieList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubmittedForCheckingPieList {
  String? id;
  String? clientCode;
  String? client;
  String? servicename;
  String? triggerDate;
  String? targetDate;
  String? satDate;
  String? priority;
  String? priorityToShow;
  String? allottedTo;
  String? tasks;
  int? completionPercentage;
  String? status;
  String? statusName;
  String? targetDateToShow;
  String? triggerDateToShow;
  String? satDateToShow;
  DateTime? triggerDateTimeFormat;
  DateTime? targetDateTimeFormat;

  SubmittedForCheckingPieList(
      {this.id,
        this.clientCode,
        this.client,
        this.servicename,
        this.triggerDate,
        this.targetDate,
        this.satDate,
        this.priority,
        this.priorityToShow,
        this.allottedTo,
        this.tasks,
        this.completionPercentage,
        this.status,
        this.statusName,
        this.targetDateToShow,
        this.triggerDateToShow,
        this.satDateToShow,
        this.triggerDateTimeFormat,
        this.targetDateTimeFormat,
      });

  SubmittedForCheckingPieList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientCode = json['client_code'];
    client = json['client'];
    servicename = json['servicename'];
    triggerDate = json['trigger_date'];
    targetDate = json['target_date'];
    satDate = json['sat_date'];
    priority = json['priority'];
    priorityToShow = json['priority']=="1" ? "High" : json['priority'] == "2" ? "Medium": "Low";
    allottedTo = json['Allotted To'];
    tasks = json['Tasks'];
    completionPercentage = json['Completion_Percentage'];
    status = json['Status'];
    statusName = json['Status']=="1" ? "Inprocess" : json['Status']=="2" ? "Hold" : "Complete";

    targetDateToShow = json['target_date'] ==null || json['target_date'] == "" ? "" :
    DateFormat("dd-MM-yyyy").format(DateTime.parse(json["target_date"]));
    triggerDateToShow = json['trigger_date'] ==null || json['trigger_date'] == "" ? "" :
    DateFormat("dd-MM-yyyy").format(DateTime.parse(json["trigger_date"]));
    satDateToShow = json['sat_date'] ==null || json['sat_date'] == "" ? "" :
    DateFormat("dd-MM-yyyy").format(DateTime.parse(json["sat_date"]));

    triggerDateTimeFormat = DateTime.parse(json["trigger_date"]);
    targetDateTimeFormat = DateTime.parse(json["target_date"]);
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
    data['Tasks'] = tasks;
    data['Completion_Percentage'] = completionPercentage;
    data['Status'] = status;
    return data;
  }
}

class WorkOnHoldPieModel {
  String? message;
  bool? success;
  List<WorkOnHoldPieList>? workOnHoldPieList;

  WorkOnHoldPieModel({this.message, this.success, this.workOnHoldPieList});

  WorkOnHoldPieModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['data'] != null) {
      workOnHoldPieList = <WorkOnHoldPieList>[];
      json['data'].forEach((v) {
        workOnHoldPieList!.add(WorkOnHoldPieList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (workOnHoldPieList != null) {
      data['data'] = workOnHoldPieList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkOnHoldPieList {
  String? id;
  String? clientCode;
  String? client;
  String? servicename;
  String? triggerDate;
  String? targetDate;
  String? satDate;
  String? priority;
  String? allottedTo;
  String? tasks;
  int? completionPercentage;
  String? status;
  DateTime? triggerDateTimeFormat;
  DateTime? targetDateTimeFormat;

  WorkOnHoldPieList(
      {this.id,
        this.clientCode,
        this.client,
        this.servicename,
        this.triggerDate,
        this.targetDate,
        this.satDate,
        this.priority,
        this.allottedTo,
        this.tasks,
        this.completionPercentage,
        this.status,
        this.triggerDateTimeFormat,
        this.targetDateTimeFormat,
      });

  WorkOnHoldPieList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientCode = json['client_code'];
    client = json['client'];
    servicename = json['servicename'];
    triggerDate = json['trigger_date'];
    targetDate = json['target_date'];
    satDate = json['sat_date'];
    priority = json['priority'];
    allottedTo = json['Allotted To'];
    tasks = json['Tasks'];
    completionPercentage = json['Completion_Percentage'];
    status = json['Status'];
    triggerDateTimeFormat = DateTime.parse(json["trigger_date"]);
    targetDateTimeFormat = DateTime.parse(json["target_date"]);
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
    data['Tasks'] = tasks;
    data['Completion_Percentage'] = completionPercentage;
    data['Status'] = status;
    return data;
  }
}

class AllTasksPieModel {
  String? message;
  bool? success;
  List<AllTasksPieList>? allTasksPieList;

  AllTasksPieModel({this.message, this.success, this.allTasksPieList});

  AllTasksPieModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['data'] != null) {
      allTasksPieList = <AllTasksPieList>[];
      json['data'].forEach((v) {
        allTasksPieList!.add(AllTasksPieList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (allTasksPieList != null) {
      data['data'] = allTasksPieList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllTasksPieList {
  String? id;
  String? clientCode;
  String? client;
  String? servicename;
  String? triggerDate;
  String? targetDate;
  String? satDate;
  String? priority;
  String? allottedTo;
  String? tasks;
  int? completionPercentage;
  String? status;
  DateTime? triggerDateTimeFormat;
  DateTime? targetDateTimeFormat;
  DateTime? staDateTimeFormat;

  AllTasksPieList(
      {this.id,
        this.clientCode,
        this.client,
        this.servicename,
        this.triggerDate,
        this.targetDate,
        this.satDate,
        this.priority,
        this.allottedTo,
        this.tasks,
        this.completionPercentage,
        this.status,
        this.triggerDateTimeFormat,
        this.targetDateTimeFormat,
        this.staDateTimeFormat,
      });

  AllTasksPieList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientCode = json['client_code'];
    client = json['client'];
    servicename = json['servicename'];
    triggerDate = json['trigger_date'];
    targetDate = json['target_date'];
    satDate = json['sat_date'];
    priority = json['priority'];
    allottedTo = json['Allotted To'];
    tasks = json['Tasks'];
    completionPercentage = json['Completion_Percentage'];
    status = json['Status'];
    triggerDateTimeFormat = DateTime.parse(json["trigger_date"]);
    targetDateTimeFormat = DateTime.parse(json["target_date"]);
    staDateTimeFormat = DateTime.parse(json["sat_date"]);
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
    data['Tasks'] = tasks;
    data['Completion_Percentage'] = completionPercentage;
    data['Status'] = status;
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

class TriggeredNotAllottedModel {
  String? message;
  bool? success;
  List<TriggeredNotAllottedPieChartList>? triggeredNotAllottedPieChartList;

  TriggeredNotAllottedModel({this.message, this.success, this.triggeredNotAllottedPieChartList});

  TriggeredNotAllottedModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['data'] != null) {
      triggeredNotAllottedPieChartList = <TriggeredNotAllottedPieChartList>[];
      json['data'].forEach((v) {
        triggeredNotAllottedPieChartList!.add(TriggeredNotAllottedPieChartList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (triggeredNotAllottedPieChartList != null) {
      data['data'] = triggeredNotAllottedPieChartList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TriggeredNotAllottedPieChartList {
  String? id;
  String? clientCode;
  String? client;
  String? servicename;
  String? triggerDate;
  String? triggerDateToShow;
  String? targetDate;
  String? targetDateToShow;
  String? satDate;
  String? satDateToShow;
  String? periodicity;
  DateTime? triggerDateTimeFormat;
  DateTime? targetDateTimeFormat;
  DateTime? staDateTimeFormat;

  TriggeredNotAllottedPieChartList(
      {this.id,
        this.clientCode,
        this.client,
        this.servicename,
        this.triggerDate,
        this.triggerDateToShow,
        this.targetDate,
        this.targetDateToShow,
        this.satDate,
        this.satDateToShow,
        this.periodicity,
        this.triggerDateTimeFormat,
        this.targetDateTimeFormat,
        this.staDateTimeFormat,
      });

  TriggeredNotAllottedPieChartList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientCode = json['client_code'];
    client = json['client'];
    servicename = json['servicename'];
    triggerDate = json['trigger_date'];

    triggerDateToShow = json['trigger_date'] ==null || json['trigger_date'] == "" ? "" :
    DateFormat("dd-MM-yyyy").format(DateTime.parse(json["trigger_date"]));

    targetDate = json['target_date'];
    targetDateToShow = json['target_date'] ==null || json['target_date'] == "" ? "" :
    DateFormat("dd-MM-yyyy").format(DateTime.parse(json["target_date"]));

    satDate = json['sat_date'];
    satDateToShow = json['sat_date'] ==null || json['sat_date'] == "" ? "" :
    DateFormat("dd-MM-yyyy").format(DateTime.parse(json["sat_date"]));

    periodicity = json['periodicity'];

    triggerDateTimeFormat = DateTime.parse(json['trigger_date']);
    targetDateTimeFormat = DateTime.parse(json['target_date']);
    staDateTimeFormat = DateTime.parse(json['sat_date']);
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
    data['periodicity'] = periodicity;
    return data;
  }
}

class TriggeredNotAllottedLoadAllModel {
  String? message;
  bool? success;
  List<TriggeredNotAllottedLoadAllList>? triggeredNotAllottedLoadAllList;

  TriggeredNotAllottedLoadAllModel({this.message, this.success, this.triggeredNotAllottedLoadAllList});

  TriggeredNotAllottedLoadAllModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['data'] != null) {
      triggeredNotAllottedLoadAllList = <TriggeredNotAllottedLoadAllList>[];
      json['data'].forEach((v) {
        triggeredNotAllottedLoadAllList!.add(TriggeredNotAllottedLoadAllList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (triggeredNotAllottedLoadAllList != null) {
      data['data'] = triggeredNotAllottedLoadAllList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TriggeredNotAllottedLoadAllList {
  String? taskId;
  String? sortno;
  String? taskName;
  String? taskServiceMainCategoryId;
  String? taskServiceId;
  String? completion;
  String? taskOndate;
  String? days;
  String? hours;
  String? minutes;
  String? firmId;
  String? mastId;
  String? bizAdminId;
  String? addOnDate;
  String? addedBy;
  String? modifiedOnDate;
  String? modifiedBy;

  TriggeredNotAllottedLoadAllList({this.taskId,
    this.sortno,
    this.taskName,
    this.taskServiceMainCategoryId,
    this.taskServiceId,
    this.completion,
    this.taskOndate,
    this.days,
    this.hours,
    this.minutes,
    this.firmId,
    this.mastId,
    this.bizAdminId,
    this.addOnDate,
    this.addedBy,
    this.modifiedOnDate,
    this.modifiedBy});

  TriggeredNotAllottedLoadAllList.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    sortno = json['sortno'];
    taskName = json['task_name'];
    taskServiceMainCategoryId = json['task_service_main_category_id'];
    taskServiceId = json['task_service_id'];
    completion = json['completion'];
    taskOndate = json['task_ondate'];
    days = json['days'];
    hours = json['hours'];
    minutes = json['minutes'];
    firmId = json['firm_id'];
    mastId = json['mast_id'];
    bizAdminId = json['biz_admin_id'];
    addOnDate = json['add_on_date'];
    addedBy = json['added_by'];
    modifiedOnDate = json['modified_on_date'];
    modifiedBy = json['modified_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task_id'] = taskId;
    data['sortno'] = sortno;
    data['task_name'] = taskName;
    data['task_service_main_category_id'] = taskServiceMainCategoryId;
    data['task_service_id'] = taskServiceId;
    data['completion'] = completion;
    data['task_ondate'] = taskOndate;
    data['days'] = days;
    data['hours'] = hours;
    data['minutes'] = minutes;
    data['firm_id'] = firmId;
    data['mast_id'] = mastId;
    data['biz_admin_id'] = bizAdminId;
    data['add_on_date'] = addOnDate;
    data['added_by'] = addedBy;
    data['modified_on_date'] = modifiedOnDate;
    data['modified_by'] = modifiedBy;
    return data;
  }
}