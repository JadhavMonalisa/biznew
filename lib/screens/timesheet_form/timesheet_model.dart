import 'package:intl/intl.dart';

class TimesheetClientListModel {
  String? message;
  bool? success;
  List<ClientListData>? data;

  TimesheetClientListModel({this.message, this.success, this.data});

  TimesheetClientListModel.fromJson(Map<String, dynamic> json) {
    message = json['Message']??"";
    success = json['Success']??"";
    if (json['Data'] != null) {
      data = <ClientListData>[];
      json['Data'].forEach((v) {
        data!.add(ClientListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClientListData {
  String? firmClientId;
  String? firmClientStatus;
  String? tradeName;
  String? firmClientFirmName;
  String? firmClientClientCode;
  String? id;

  ClientListData(
      {this.firmClientId,
        this.firmClientStatus,
        this.tradeName,
        this.firmClientFirmName,
        this.firmClientClientCode,
        this.id});

  ClientListData.fromJson(Map<String, dynamic> json) {
    firmClientId = json['firm_client_id']??'';
    firmClientStatus = json['firm_client_status']??"";
    tradeName = json['trade_name']??"";
    firmClientFirmName = json['firm_client_firm_name']??"";
    firmClientClientCode = json['firm_client_client_code']??"";
    id = json['id']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firm_client_id'] = firmClientId;
    data['firm_client_status'] = firmClientStatus;
    data['trade_name'] = tradeName;
    data['firm_client_firm_name'] = firmClientFirmName;
    data['firm_client_client_code'] = firmClientClientCode;
    data['id'] = id;
    return data;
  }
}

class TimesheetServiceListModel {
  String? message;
  bool? success;
  List<TimesheetServicesData>? data;

  TimesheetServiceListModel({this.message, this.success, this.data});

  TimesheetServiceListModel.fromJson(Map<String, dynamic> json) {
    message = json['Message']??"";
    success = json['Success']??"";
    if (json['Data'] != null) {
      data = <TimesheetServicesData>[];
      json['Data'].forEach((v) {
        data!.add(TimesheetServicesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimesheetServicesData {
  String? serviceDueDatePeriodicity;
  String? serviceName;
  String? period;
  String? serviceId;
  String? id;

  TimesheetServicesData(
      {this.serviceDueDatePeriodicity,
        this.serviceName,
        this.period,
        this.serviceId,
        this.id});

  TimesheetServicesData.fromJson(Map<String, dynamic> json) {
    serviceDueDatePeriodicity = json['service_due_date_periodicity']??"";
    serviceName = json['service_name']??"";
    period = json['period']??"";
    serviceId = json['service_id']??"";
    id = json['id']??"";
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

class TimesheetTaskModel {
  String? message;
  bool? success;
  List<TimesheetTaskData>? data;

  TimesheetTaskModel({this.message, this.success, this.data});

  TimesheetTaskModel.fromJson(Map<String, dynamic> json) {
    message = json['Message']??"";
    success = json['Success']??"";
    if (json['Data'] != null) {
      data = <TimesheetTaskData>[];
      json['Data'].forEach((v) {
        data!.add(TimesheetTaskData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimesheetTaskData {
  String? taskId;
  String? taskName;
  List<String>? testTaskStatusList;


  TimesheetTaskData({this.taskId, this.taskName,this.testTaskStatusList});

  TimesheetTaskData.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id']??"";
    taskName = json['task_name']??"";
    testTaskStatusList = [""];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task_id'] = taskId;
    data['task_name'] = taskName;
    return data;
  }
}
class TimesheetStatusModel {
  String? message;
  bool? success;
  List<StatusList>? list;
  String? status;
  String? start;

  TimesheetStatusModel(
      {this.message, this.success, this.list, this.status, this.start});

  TimesheetStatusModel.fromJson(Map<String, dynamic> json) {
    message = json['Message']??"";
    success = json['Success']??"";
    if (json['List'] != null) {
      list = <StatusList>[];
      json['List'].forEach((v) {
        list!.add(StatusList.fromJson(v));
      });
    }
    status = json['Status']??"";
    start = json['Start']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (list != null) {
      data['List'] = list!.map((v) => v.toJson()).toList();
    }
    data['Status'] = status;
    data['Start'] = start;
    return data;
  }
}

class StatusList {
  String? id;
  String? name;

  StatusList({this.id, this.name});

  StatusList.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    name = json['name']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class TypeOfWorkModel {
  String? message;
  bool? success;
  List<TypeOfWorkList>? typeOfWorkList;

  TypeOfWorkModel({this.message, this.success, this.typeOfWorkList});

  TypeOfWorkModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['List'] != null) {
      typeOfWorkList = <TypeOfWorkList>[];
      json['List'].forEach((v) {
        typeOfWorkList!.add(TypeOfWorkList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (typeOfWorkList != null) {
      data['List'] = typeOfWorkList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TypeOfWorkList {
  String? id;
  String? name;

  TypeOfWorkList({this.id, this.name});

  TypeOfWorkList.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    name = json['name']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class TimesheetListModel {
  String? message;
  bool? success;
  List<TimesheetListData>? timesheetListDetails;

  TimesheetListModel({this.message, this.success, this.timesheetListDetails});

  TimesheetListModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['TimesheetList'] != null) {
      timesheetListDetails = <TimesheetListData>[];
      json['TimesheetList'].forEach((v) {
        timesheetListDetails!.add(TimesheetListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (timesheetListDetails != null) {
      data['TimesheetList'] = timesheetListDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimesheetListData {
  String? firmEmployeeName;
  String? id;
  String? tfor;
  String? tDate;
  String? inTime;
  String? outTime;
  String? timeHours;
  String? timeMins;
  String? mastId;
  String? firmId;
  String? addedDate;
  String? addedDateToShow;
  String? addedBy;
  String? modifyDate;
  String? modifyBy;
  String? workat;
  String? day;
  String? reportingHead;
  String? status;

  TimesheetListData(
      {this.firmEmployeeName,
        this.id,
        this.tfor,
        this.tDate,
        this.inTime,
        this.outTime,
        this.timeHours,
        this.timeMins,
        this.mastId,
        this.firmId,
        this.addedDate,
        this.addedDateToShow,
        this.addedBy,
        this.modifyDate,
        this.modifyBy,
        this.workat,
        this.day,
        this.reportingHead,
        this.status});

  TimesheetListData.fromJson(Map<String, dynamic> json) {
    firmEmployeeName = json['firm_employee_name']??"";
    id = json['id']??"";
    tfor = json['tfor']??"";
    tDate = json['t_date']??"";
    inTime = json['in_time']??"";
    outTime = json['out_time']??"";
    timeHours = json['time_hours']??"";
    timeMins = json['time_mins']??"";
    mastId = json['mast_id']??"";
    firmId = json['firm_id']??"";
    addedDate = json['added_date']??"";
    addedDateToShow =  json['added_date'] == null || json['added_date'] == "" ? ""
        : DateFormat("dd-MM-yyyy").format(DateTime.parse(json['added_date']));
    addedBy = json['added_by']??"";
    modifyDate = json['modify_date']??"";
    modifyBy = json['modify_by']??"";
    workat = json['workat']??"";
    day = json['day']??"";
    reportingHead = json['reporting_head']??"";
    status = json['status']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firm_employee_name'] = firmEmployeeName;
    data['id'] = id;
    data['tfor'] = tfor;
    data['t_date'] = tDate;
    data['in_time'] = inTime;
    data['out_time'] = outTime;
    data['time_hours'] = timeHours;
    data['time_mins'] = timeMins;
    data['mast_id'] = mastId;
    data['firm_id'] = firmId;
    data['added_date'] = addedDate;
    data['added_by'] = addedBy;
    data['modify_date'] = modifyDate;
    data['modify_by'] = modifyBy;
    data['workat'] = workat;
    data['day'] = day;
    data['reporting_head'] = reportingHead;
    data['status'] = status;
    return data;
  }
}

///edit model
class TimesheetEditData {
  String? message;
  bool? success;
  List<TimesheetData>? timesheetData;
  List<NonAllottedData>? nonAllottedData;
  List<OfficeRelatedData>? officeRelatedData;

  TimesheetEditData(
      {this.message,
        this.success,
        this.timesheetData,
        this.nonAllottedData,
        this.officeRelatedData});

  TimesheetEditData.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['timesheet_data'] != null) {
      timesheetData = <TimesheetData>[];
      json['timesheet_data'].forEach((v) {
        timesheetData!.add(TimesheetData.fromJson(v));
      });
    }
    if (json['non_allotted_data'] != null) {
      nonAllottedData = <NonAllottedData>[];
      json['non_allotted_data'].forEach((v) {
        nonAllottedData!.add(NonAllottedData.fromJson(v));
      });
    }
    if (json['office_related_data'] != null) {
      officeRelatedData = <OfficeRelatedData>[];
      json['office_related_data'].forEach((v) {
        officeRelatedData!.add(OfficeRelatedData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (timesheetData != null) {
      data['timesheet_data'] = timesheetData!.map((v) => v.toJson()).toList();
    }
    if (nonAllottedData != null) {
      data['non_allotted_data'] = nonAllottedData!.map((v) => v.toJson()).toList();
    }
    if (officeRelatedData != null) {
      data['office_related_data'] = officeRelatedData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimesheetData {
  String? id;
  String? tDate;
  String? inTime;
  String? outTime;
  String? timeHours;
  String? timeMins;
  String? mastId;
  String? firmId;
  String? addedDate;
  String? addedBy;
  String? modifyDate;
  String? modifyBy;
  String? workat;
  String? randomno;
  String? tfor;
  String? formattedDate;

  TimesheetData(
      {this.id,
        this.tDate,
        this.inTime,
        this.outTime,
        this.timeHours,
        this.timeMins,
        this.mastId,
        this.firmId,
        this.addedDate,
        this.addedBy,
        this.modifyDate,
        this.modifyBy,
        this.workat,
        this.randomno,
        this.tfor,
        this.formattedDate});

  TimesheetData.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    tDate = json['t_date']??"";
    inTime = json['in_time']??"";
    outTime = json['out_time']??"";
    timeHours = json['time_hours']??"";
    timeMins = json['time_mins']??"";
    mastId = json['mast_id']??"";
    firmId = json['firm_id']??"";
    addedDate = json['added_date']??"";
    addedBy = json['added_by']??"";
    modifyDate = json['modify_date']??"";
    modifyBy = json['modify_by']??"";
    workat = json['workat']??"";
    randomno = json['randomno']??"";
    tfor = json['tfor']??"";
    formattedDate = json['added_date'] == null || json['added_date'] == "" ? ""
        : DateFormat("dd-MM-yyyy").format(DateTime.parse(json['added_date']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['t_date'] = tDate;
    data['in_time'] = inTime;
    data['out_time'] = outTime;
    data['time_hours'] = timeHours;
    data['time_mins'] = timeMins;
    data['mast_id'] = mastId;
    data['firm_id'] = firmId;
    data['added_date'] = addedDate;
    data['added_by'] = addedBy;
    data['modify_date'] = modifyDate;
    data['modify_by'] = modifyBy;
    data['workat'] = workat;
    data['randomno'] = randomno;
    data['tfor'] = tfor;
    return data;
  }
}

class NonAllottedData {
  String? id;
  String? tId;
  String? client;
  String? clientId;
  String? serviceId;
  String? taskId;
  String? remark;
  String? nohours;
  String? claimId;
  String? typeWork;
  String? mastId;
  String? firmId;
  String? addedBy;
  String? addedDate;
  String? modifyDate;
  String? modifyBy;
  String? status;
  String? clientApplicableService;
  String? filledType;
  String? serviceName;
  String? serviceDueDatePeriodicity;
  String? period;
  String? taskName;

  NonAllottedData(
      {this.id,
        this.tId,
        this.client,
        this.clientId,
        this.serviceId,
        this.taskId,
        this.remark,
        this.nohours,
        this.claimId,
        this.typeWork,
        this.mastId,
        this.firmId,
        this.addedBy,
        this.addedDate,
        this.modifyDate,
        this.modifyBy,
        this.status,
        this.clientApplicableService,
        this.filledType,
        this.serviceName,
        this.serviceDueDatePeriodicity,
        this.period,
        this.taskName});

  NonAllottedData.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    tId = json['t_id']??"";
    client = json['client']??"";
    clientId = json['client_id']??"";
    serviceId = json['service_id']??"";
    taskId = json['task_id']??"";
    remark = json['remark']??"";
    nohours = json['nohours']??"";
    claimId = json['claim_id']??"";
    typeWork = json['type_work']??"";
    mastId = json['mast_id']??"";
    firmId = json['firm_id']??"";
    addedBy = json['added_by']??"";
    addedDate = json['added_date']??"";
    modifyDate = json['modify_date']??"";
    modifyBy = json['modify_by']??"";
    status = json['status']??"";
    clientApplicableService = json['client_applicable_service']??"";
    filledType = json['filled_type']??"";
    serviceName = json['service_name']??"";
    serviceDueDatePeriodicity = json['service_due_date_periodicity']??"";
    period = json['period']??"";
    taskName = json['task_name']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['t_id'] = tId;
    data['client'] = client;
    data['client_id'] = clientId;
    data['service_id'] = serviceId;
    data['task_id'] = taskId;
    data['remark'] = remark;
    data['nohours'] = nohours;
    data['claim_id'] = claimId;
    data['type_work'] = typeWork;
    data['mast_id'] = mastId;
    data['firm_id'] = firmId;
    data['added_by'] = addedBy;
    data['added_date'] = addedDate;
    data['modify_date'] = modifyDate;
    data['modify_by'] = modifyBy;
    data['status'] = status;
    data['client_applicable_service'] = clientApplicableService;
    data['filled_type'] = filledType;
    data['service_name'] = serviceName;
    data['service_due_date_periodicity'] = serviceDueDatePeriodicity;
    data['period'] = period;
    data['task_name'] = taskName;
    return data;
  }
}

class OfficeRelatedData {
  String? id;
  String? tId;
  String? client;
  String? clientId;
  String? serviceId;
  String? taskId;
  String? remark;
  String? nohours;
  String? claimId;
  String? typeWork;
  String? mastId;
  String? firmId;
  String? addedBy;
  String? addedDate;
  String? modifyDate;
  String? modifyBy;
  String? status;
  String? clientApplicableService;
  String? filledType;
  String? name;

  OfficeRelatedData(
      {this.id,
        this.tId,
        this.client,
        this.clientId,
        this.serviceId,
        this.taskId,
        this.remark,
        this.nohours,
        this.claimId,
        this.typeWork,
        this.mastId,
        this.firmId,
        this.addedBy,
        this.addedDate,
        this.modifyDate,
        this.modifyBy,
        this.status,
        this.clientApplicableService,
        this.filledType,
        this.name});

  OfficeRelatedData.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    tId = json['t_id']??"";
    client = json['client']??"";
    clientId = json['client_id']??"";
    serviceId = json['service_id']??"";
    taskId = json['task_id']??"";
    remark = json['remark']??"";
    nohours = json['nohours']??"";
    claimId = json['claim_id']??"";
    typeWork = json['type_work']??"";
    mastId = json['mast_id']??"";
    firmId = json['firm_id']??"";
    addedBy = json['added_by']??"";
    addedDate = json['added_date']??"";
    modifyDate = json['modify_date']??"";
    modifyBy = json['modify_by']??"";
    status = json['status']??"";
    clientApplicableService = json['client_applicable_service']??"";
    filledType = json['filled_type']??"";
    name = json['name']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['t_id'] = tId;
    data['client'] = client;
    data['client_id'] = clientId;
    data['service_id'] = serviceId;
    data['task_id'] = taskId;
    data['remark'] = remark;
    data['nohours'] = nohours;
    data['claim_id'] = claimId;
    data['type_work'] = typeWork;
    data['mast_id'] = mastId;
    data['firm_id'] = firmId;
    data['added_by'] = addedBy;
    data['added_date'] = addedDate;
    data['modify_date'] = modifyDate;
    data['modify_by'] = modifyBy;
    data['status'] = status;
    data['client_applicable_service'] = clientApplicableService;
    data['filled_type'] = filledType;
    data['name'] = name;
    return data;
  }
}
class TimesheetLogModel {
  String? message;
  bool? success;
  List<TimesheetLog>? timesheetLogDetails;

  TimesheetLogModel({this.message, this.success, this.timesheetLogDetails});

  TimesheetLogModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['TimesheetLog'] != null) {
      timesheetLogDetails = <TimesheetLog>[];
      json['TimesheetLog'].forEach((v) {
        timesheetLogDetails!.add(TimesheetLog.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (timesheetLogDetails != null) {
      data['TimesheetLog'] = timesheetLogDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimesheetLog {
  String? id;
  String? tdId;
  String? statusId;
  String? status;
  String? statusDate;
  String? remark;
  String? addedBy;
  String? addedDate;
  String? mastId;
  String? firmId;
  String? tDate;
  String? empId;
  String? firmEmployeeName;

  TimesheetLog(
      {this.id,
        this.tdId,
        this.statusId,
        this.status,
        this.statusDate,
        this.remark,
        this.addedBy,
        this.addedDate,
        this.mastId,
        this.firmId,
        this.tDate,
        this.empId,
        this.firmEmployeeName});

  TimesheetLog.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    tdId = json['td_id']??"";
    statusId = json['status_id']??"";
    status = json['status']??"";
    statusDate = json['status_date']??"";
    remark = json['remark']??"";
    addedBy = json['added_by']??"";
    addedDate = json['added_date']??"";
    mastId = json['mast_id']??"";
    firmId = json['firm_id']??"";
    tDate = json['t_date']??"";
    empId = json['emp_id']??"";
    firmEmployeeName = json['firm_employee_name']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['td_id'] = tdId;
    data['status_id'] = statusId;
    data['status'] = status;
    data['status_date'] = statusDate;
    data['remark'] = remark;
    data['added_by'] = addedBy;
    data['added_date'] = addedDate;
    data['mast_id'] = mastId;
    data['firm_id'] = firmId;
    data['t_date'] = tDate;
    data['emp_id'] = empId;
    data['firm_employee_name'] = firmEmployeeName;
    return data;
  }
}
