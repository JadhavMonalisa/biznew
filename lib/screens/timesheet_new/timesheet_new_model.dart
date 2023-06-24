import 'package:biznew/screens/timesheet_form/timesheet_model.dart';
import 'package:flutter/material.dart';

class TimesheetNewModel{
  String? clientListClientId;
  String? clientListClientStatus;
  String? clientListClientFirmName;
  String? clientListId;
  String? serviceListServiceId;
  String? serviceListServiceName;
  String? serviceListId;
  String? taskListTaskId;
  String? taskListTaskName;


  TimesheetNewModel(this.clientListClientId, this.clientListClientStatus, this.clientListClientFirmName,
      this.clientListId, this.serviceListServiceId, this.serviceListServiceName, this.serviceListId,
      this.taskListTaskId, this.taskListTaskName);
}

class TimesheetServicesListData {
  String? serviceDueDatePeriodicity;
  String? serviceName;
  String? period;
  String? serviceId;
  String? id;
  String? selectedClientId;
  String? selectedClientName;

  TimesheetServicesListData(
      {this.serviceDueDatePeriodicity,
        this.serviceName,
        this.period,
        this.serviceId,
        this.id,
        this.selectedClientId,
        this.selectedClientName,
      });

  TimesheetServicesListData.fromJson(Map<String, dynamic> json) {
    serviceDueDatePeriodicity = json['service_due_date_periodicity']??"";
    serviceName = json['service_name']??"";
    period = json['period']??"";
    serviceId = json['service_id']??"";
    id = json['id']??"";
    selectedClientId = "";
    selectedClientName = "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_due_date_periodicity'] = serviceDueDatePeriodicity;
    data['service_name'] = serviceName;
    data['period'] = period;
    data['service_id'] = serviceId;
    data['id'] = id;
    return data;
  }
}

// class TimesheetTaskListData {
//   String? taskId;
//   String? taskName;
//   String? selectedServiceId;
//   String? selectedServiceName;
//   String? selectedClientId;
//   String? selectedClientName;
//   List<String>? testTaskStatusList;
//
//   TimesheetTaskListData({this.taskId, this.taskName,this.selectedServiceId,this.selectedServiceName,
//     this.selectedClientId,this.selectedClientName,this.testTaskStatusList});
//
//   TimesheetTaskListData.fromJson(Map<String, dynamic> json) {
//     taskId = json['task_id']??"";
//     taskName = json['task_name']??"";
//     selectedServiceId = "";
//     selectedServiceName = "";
//     selectedClientId = "";
//     selectedClientName = "";
//     testTaskStatusList = [""];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['task_id'] = taskId;
//     data['task_name'] = taskName;
//     return data;
//   }
// }

class TimesheetTaskListData {
  String? message;
  bool? success;
  String? serviceId;
  String? serviceName;
  String? clientId;
  String? clientName;
  List<TimesheetTaskDetailsData>? timesheetTaskDetailsData;

  TimesheetTaskListData(
      {this.message,
        this.success,
        this.serviceId,
        this.serviceName,
        this.clientId,
        this.clientName,
        this.timesheetTaskDetailsData,
      });

  TimesheetTaskListData.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    serviceId = "";
    serviceName = "";
    clientId = "";
    clientName = "";
    if (json['Data'] != null) {
      timesheetTaskDetailsData = <TimesheetTaskDetailsData>[];
      json['Data'].forEach((v) {
        timesheetTaskDetailsData!.add(TimesheetTaskDetailsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    data['ServiceId'] = serviceId;
    data['ServiceName'] = serviceName;
    data['ClientId'] = clientId;
    data['ClientName'] = clientName;
    if (timesheetTaskDetailsData != null) {
      data['Data'] = timesheetTaskDetailsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimesheetTaskDetailsData {
  String? taskId;
  String? taskName;
  TextEditingController? testTaskDetails;
  String? timeSpent;

  TimesheetTaskDetailsData({this.taskId, this.taskName,this.testTaskDetails,this.timeSpent});

  TimesheetTaskDetailsData.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    taskName = json['task_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task_id'] = taskId;
    data['task_name'] = taskName;
    return data;
  }
}

class TestTextEditingController{
  TextEditingController? textEditingController;

  TestTextEditingController(this.textEditingController);

}