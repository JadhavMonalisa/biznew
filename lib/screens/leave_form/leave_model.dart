import 'package:intl/intl.dart';

class LeaveTypeModel {
  String? message;
  bool? success;
  List<LeaveTypeList>? leaveTypeDetailsList;

  LeaveTypeModel({this.message, this.success, this.leaveTypeDetailsList});

  LeaveTypeModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['LeaveTypeList'] != null) {
      leaveTypeDetailsList = <LeaveTypeList>[];
      json['LeaveTypeList'].forEach((v) {
        leaveTypeDetailsList!.add(LeaveTypeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (leaveTypeDetailsList != null) {
      data['LeaveTypeList'] =
          leaveTypeDetailsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveTypeList {
  String? id;
  String? leaveType;

  LeaveTypeList({this.id, this.leaveType});

  LeaveTypeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaveType = json['leave_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['leave_type'] = leaveType;
    return data;
  }
}

class LeaveListModel {
  String? message;
  bool? success;
  List<LeaveListData>? leaveListDetails;

  LeaveListModel({this.message, this.success, this.leaveListDetails});

  LeaveListModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['LeaveList'] != null) {
      leaveListDetails = <LeaveListData>[];
      json['LeaveList'].forEach((v) {
        leaveListDetails!.add(LeaveListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (leaveListDetails != null) {
      data['LeaveList'] = leaveListDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

var inputFormat = DateFormat('dd/MM/yyyy HH:mm');

class LeaveListData {
  String? id;
  String? totalDays;
  String? leaveType;
  String? startDate;
  String? endDate;
  String? dayLeave;
  String? reason;
  String? firmId;
  String? mastId;
  String? addedOn;
  String? addedBy;
  String? modifiedOn;
  String? modifiedBy;
  String? leaveStatus;
  String? remark;
  String? groupg;
  String? attempts;
  String? isDelete;
  String? reportTo;
  String? firmEmployeeName;
  String? startDateToShow;
  String? endDateToShow;

  LeaveListData(
      {this.id,
      this.totalDays,
      this.leaveType,
      this.startDate,
      this.endDate,
      this.dayLeave,
      this.reason,
      this.firmId,
      this.mastId,
      this.addedOn,
      this.addedBy,
      this.modifiedOn,
      this.modifiedBy,
      this.leaveStatus,
      this.remark,
      this.groupg,
      this.attempts,
      this.isDelete,
      this.reportTo,
      this.firmEmployeeName,
      this.startDateToShow,
      this.endDateToShow});

  LeaveListData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    totalDays = json['total_days'] ?? "";
    leaveType = json['leave_type'] ?? "";
    startDate = json['start_date'] ?? "";
    endDate = json['end_date'] ?? "";
    dayLeave = json['day_leave'] ?? "";
    reason = json['reason'] ?? "";
    firmId = json['firm_id'] ?? "";
    mastId = json['mast_id'] ?? "";
    addedOn = json['added_on'] ?? "";
    addedBy = json['added_by'] ?? "";
    modifiedOn = json['modified_on'] == null || json['modified_on'] == ""
        ? ""
        : DateFormat("dd-MM-yyyy").format(DateTime.parse(json['modified_on']));
    modifiedBy = json['modified_by'] ?? "";
    leaveStatus = json['leave_status'] ?? "";
    remark = json['remark'] ?? "";
    groupg = json['groupg'] ?? "";
    attempts = json['attempts'] ?? "";
    isDelete = json['isDelete'] ?? "";
    reportTo = json['report_to'] ?? "";
    firmEmployeeName = json['firm_employee_name'] ?? "";
    startDateToShow = json['start_date'] == null || json['start_date'] == ""
        ? ""
        : DateFormat("dd-MM-yyyy").format(DateTime.parse(json['start_date']));
    endDateToShow = json['end_date'] == null || json['start_date'] == ""
        ? ""
        : DateFormat("dd-MM-yyyy").format(DateTime.parse(json['end_date']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['total_days'] = totalDays;
    data['leave_type'] = leaveType;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['day_leave'] = dayLeave;
    data['reason'] = reason;
    data['firm_id'] = firmId;
    data['mast_id'] = mastId;
    data['added_on'] = addedOn;
    data['added_by'] = addedBy;
    data['modified_on'] = modifiedOn;
    data['modified_by'] = modifiedBy;
    data['leave_status'] = leaveStatus;
    data['remark'] = remark;
    data['groupg'] = groupg;
    data['attempts'] = attempts;
    data['isDelete'] = isDelete;
    data['report_to'] = reportTo;
    data['firm_employee_name'] = firmEmployeeName;
    return data;
  }
}

class LeaveEditModel {
  String? message;
  bool? success;
  List<LeaveEditDetails>? leaveEditDetails;

  LeaveEditModel({this.message, this.success, this.leaveEditDetails});

  LeaveEditModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['Leave Details'] != null) {
      leaveEditDetails = <LeaveEditDetails>[];
      json['Leave Details'].forEach((v) {
        leaveEditDetails!.add(LeaveEditDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (leaveEditDetails != null) {
      data['Leave Details'] = leaveEditDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveEditDetails {
  String? id;
  String? totalDays;
  String? leaveType;
  String? startDate;
  String? endDate;
  String? dayLeave;
  String? reason;
  String? firmId;
  String? mastId;
  String? addedOn;
  String? addedBy;
  String? modifiedOn;
  String? modifiedBy;
  String? leaveStatus;
  String? remark;
  String? groupg;
  String? attempts;
  String? isDelete;
  String? reportTo;
  String? firmEmployeeName;
  String? leaveTypeName;
  String? startDateToShow;
  String? endDateToShow;

  LeaveEditDetails({
    this.id,
    this.totalDays,
    this.leaveType,
    this.startDate,
    this.endDate,
    this.dayLeave,
    this.reason,
    this.firmId,
    this.mastId,
    this.addedOn,
    this.addedBy,
    this.modifiedOn,
    this.modifiedBy,
    this.leaveStatus,
    this.remark,
    this.groupg,
    this.attempts,
    this.isDelete,
    this.reportTo,
    this.firmEmployeeName,
    this.leaveTypeName,
    this.startDateToShow,
    this.endDateToShow,
  });

  LeaveEditDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    totalDays = json['total_days'] ?? "";
    leaveType = json['leave_type'] ?? "";
    startDate = json['start_date'] ?? "";
    endDate = json['end_date'] ?? "";
    dayLeave = json['day_leave'] ?? "";
    reason = json['reason'] ?? "";
    firmId = json['firm_id'] ?? "";
    mastId = json['mast_id'] ?? "";
    addedOn = json['added_on'] ?? "";
    addedBy = json['added_by'] ?? "";
    modifiedOn = json['modified_on'] ?? "";
    modifiedBy = json['modified_by'] ?? "";
    leaveStatus = json['leave_status'] ?? "";
    remark = json['remark'] ?? "";
    groupg = json['groupg'] ?? "";
    attempts = json['attempts'] ?? "";
    isDelete = json['isDelete'] ?? "";
    reportTo = json['report_to'] ?? "";
    firmEmployeeName = json['firm_employee_name'] ?? "";
    leaveTypeName = json['leave_type_name'] ?? "";
    startDateToShow = json['start_date'] == null || json['start_date'] == ""
        ? ""
        : DateFormat("dd-MM-yyyy").format(DateTime.parse(json['start_date']));
    endDateToShow = json['end_date'] == null || json['end_date'] == ""
        ? ""
        : DateFormat("dd-MM-yyyy").format(DateTime.parse(json['end_date']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['total_days'] = totalDays;
    data['leave_type'] = leaveType;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['day_leave'] = dayLeave;
    data['reason'] = reason;
    data['firm_id'] = firmId;
    data['mast_id'] = mastId;
    data['added_on'] = addedOn;
    data['added_by'] = addedBy;
    data['modified_on'] = modifiedOn;
    data['modified_by'] = modifiedBy;
    data['leave_status'] = leaveStatus;
    data['remark'] = remark;
    data['groupg'] = groupg;
    data['attempts'] = attempts;
    data['isDelete'] = isDelete;
    data['report_to'] = reportTo;
    data['firm_employee_name'] = firmEmployeeName;
    data['leave_type_name'] = leaveTypeName;
    return data;
  }
}
