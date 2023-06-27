import 'package:intl/intl.dart';

class ClaimTypeModel {
  String? message;
  bool? success;
  List<NatureOfClaimList>? natureOfClaim;

  ClaimTypeModel({this.message, this.success, this.natureOfClaim});

  ClaimTypeModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['natureOfClaimList'] != null) {
      natureOfClaim = <NatureOfClaimList>[];
      json['natureOfClaimList'].forEach((v) {
        natureOfClaim!.add(NatureOfClaimList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (natureOfClaim != null) {
      data['natureOfClaimList'] =
          natureOfClaim!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NatureOfClaimList {
  String? id;
  String? name;

  NatureOfClaimList({this.id, this.name});

  NatureOfClaimList.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class ClientNameModel {
  String? message;
  bool? success;
  List<NameList>? nameList;

  ClientNameModel({this.message, this.success, this.nameList});

  ClientNameModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['clientslist'] != null) {
      nameList = <NameList>[];
      json['clientslist'].forEach((v) {
        nameList!.add(NameList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (nameList != null) {
      data['clientslist'] = nameList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NameList {
  String? firmClientId;
  String? firmClientClientCode;
  String? clientType;
  String? firmClientFirmName;
  String? firmClientStatus;

  NameList(
      {this.firmClientId,
      this.firmClientClientCode,
      this.clientType,
      this.firmClientFirmName,
      this.firmClientStatus});

  NameList.fromJson(Map<String, dynamic> json) {
    firmClientId = json['firm_client_id'] ?? "";
    firmClientClientCode = json['firm_client_client_code'] ?? "";
    clientType = json['client_type'] ?? "";
    firmClientFirmName = json['firm_client_firm_name'] ?? "";
    firmClientStatus = json['firm_client_status'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firm_client_id'] = firmClientId;
    data['firm_client_client_code'] = firmClientClientCode;
    data['client_type'] = clientType;
    data['firm_client_firm_name'] = firmClientFirmName;
    data['firm_client_status'] = firmClientStatus;
    return data;
  }
}

class ClaimYearModel {
  String? message;
  bool? success;
  List<YearList>? yearList;

  ClaimYearModel({this.message, this.success, this.yearList});

  ClaimYearModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['yearlist'] != null) {
      yearList = <YearList>[];
      json['yearlist'].forEach((v) {
        yearList!.add(YearList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (yearList != null) {
      data['yearlist'] = yearList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class YearList {
  String? finanacialYearStartDate;
  String? finanacialYearEndDate;
  String? financialYearId;

  YearList({
    this.finanacialYearStartDate,
    this.finanacialYearEndDate,
    this.financialYearId,
  });

  YearList.fromJson(Map<String, dynamic> json) {
    finanacialYearStartDate = json['finanacial_year_start_date'] == "" ||
            json['finanacial_year_start_date'] == null
        ? ""
        : json['finanacial_year_start_date'].toString().replaceAll("-", "/");
    finanacialYearEndDate = json['finanacial_year_end_date'] == "" ||
            json['finanacial_year_end_date'] == null
        ? ""
        : json['finanacial_year_end_date'].toString().replaceAll("-", "/");
    financialYearId = json['financial_year_id'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['finanacial_year_start_date'] = finanacialYearStartDate;
    data['finanacial_year_end_date'] = finanacialYearEndDate;
    data['financial_year_id'] = financialYearId;
    return data;
  }
}

class ClaimSubmittedByResponse {
  String? message;
  bool? success;
  List<ClaimSubmittedByList>? claimSubmittedByListDetails;

  ClaimSubmittedByResponse(
      {this.message, this.success, this.claimSubmittedByListDetails});

  ClaimSubmittedByResponse.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['emplyeeList'] != null) {
      claimSubmittedByListDetails = <ClaimSubmittedByList>[];
      json['emplyeeList'].forEach((v) {
        claimSubmittedByListDetails!.add(ClaimSubmittedByList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (claimSubmittedByListDetails != null) {
      data['emplyeeList'] =
          claimSubmittedByListDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClaimSubmittedByList {
  String? firmEmployeeName;
  String? mastId;
  String? firmEmployeeId;
  String? roleId;

  ClaimSubmittedByList(
      {this.firmEmployeeName, this.mastId, this.firmEmployeeId, this.roleId});

  ClaimSubmittedByList.fromJson(Map<String, dynamic> json) {
    firmEmployeeName = json['firm_employee_name'] ?? "";
    mastId = json['mast_id'] ?? "";
    firmEmployeeId = json['firm_employee_id'] ?? "";
    roleId = json['role_id'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firm_employee_name'] = firmEmployeeName;
    data['mast_id'] = mastId;
    data['firm_employee_id'] = firmEmployeeId;
    data['role_id'] = roleId;
    return data;
  }
}

class ClaimServiceResponse {
  String? message;
  bool? success;
  List<ClaimServiceList>? serviceList;

  ClaimServiceResponse({this.message, this.success, this.serviceList});

  ClaimServiceResponse.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['servicesList'] != null) {
      serviceList = <ClaimServiceList>[];
      json['servicesList'].forEach((v) {
        serviceList!.add(ClaimServiceList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (serviceList != null) {
      data['servicesList'] = serviceList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClaimServiceList {
  String? serviceId;
  String? id;
  String? serviceName;
  String? serviceDueDatePeriodicity;
  String? year;
  String? period;

  ClaimServiceList(
      {this.serviceId,
      this.id,
      this.serviceName,
      this.serviceDueDatePeriodicity,
      this.year,
      this.period});

  ClaimServiceList.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'] ?? "";
    id = json['id'] ?? "";
    serviceName = json['service_name'] ?? "";
    serviceDueDatePeriodicity = json['service_due_date_periodicity'] ?? "";
    year = json['year'] ?? "";
    period = json['period'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_id'] = serviceId;
    data['id'] = id;
    data['service_name'] = serviceName;
    data['service_due_date_periodicity'] = serviceDueDatePeriodicity;
    data['year'] = year;
    data['period'] = period;
    return data;
  }
}

class ClaimTaskResponse {
  String? message;
  bool? success;
  List<ClaimTaskList>? taskList;

  ClaimTaskResponse({this.message, this.success, this.taskList});

  ClaimTaskResponse.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['tasks'] != null) {
      taskList = <ClaimTaskList>[];
      json['tasks'].forEach((v) {
        taskList!.add(ClaimTaskList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (taskList != null) {
      data['tasks'] = taskList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClaimTaskList {
  String? taskId;
  String? taskName;

  ClaimTaskList({this.taskId, this.taskName});

  ClaimTaskList.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'] ?? "";
    taskName = json['task_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task_id'] = taskId;
    data['task_name'] = taskName;
    return data;
  }
}

class ClaimClientListResponse {
  String? message;
  bool? success;
  List<ClaimClientListDetails>? claimClientListDetails;

  ClaimClientListResponse(
      {this.message, this.success, this.claimClientListDetails});

  ClaimClientListResponse.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['ClaimList'] != null) {
      claimClientListDetails = <ClaimClientListDetails>[];
      json['ClaimList'].forEach((v) {
        claimClientListDetails!.add(ClaimClientListDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (claimClientListDetails != null) {
      data['ClaimList'] =
          claimClientListDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClaimClientListDetails {
  String? claimId;
  String? clientName;
  String? service;
  String? task;
  String? typeOfClaim;
  String? particulars;
  String? claimFrom;
  String? claimTo;
  String? kms;
  String? billNo;
  String? billDate;
  String? challan;
  String? file;
  String? claimAmount;
  String? cliamBillable;
  String? includedBill;
  String? claimDate;
  String? claimStatus;
  String? mastId;
  String? firmId;
  String? addOnDate;
  String? addedBy;
  String? modifiedOnDate;
  String? modifiedBy;
  String? timesheet;
  String? office;
  String? cliamFinancialYearId;
  String? mytask;
  String? clientApplicableService;
  String? firmClientClientCode;
  String? firmClientFirmName;
  String? firmClientStatus;
  String? tradeName;
  String? taskName;
  String? serviceName;
  String? name;
  String? firmEmployeeName;

  ClaimClientListDetails(
      {this.claimId,
      this.clientName,
      this.service,
      this.task,
      this.typeOfClaim,
      this.particulars,
      this.claimFrom,
      this.claimTo,
      this.kms,
      this.billNo,
      this.billDate,
      this.challan,
      this.file,
      this.claimAmount,
      this.cliamBillable,
      this.includedBill,
      this.claimDate,
      this.claimStatus,
      this.mastId,
      this.firmId,
      this.addOnDate,
      this.addedBy,
      this.modifiedOnDate,
      this.modifiedBy,
      this.timesheet,
      this.office,
      this.cliamFinancialYearId,
      this.mytask,
      this.clientApplicableService,
      this.firmClientClientCode,
      this.firmClientFirmName,
      this.firmClientStatus,
      this.tradeName,
      this.taskName,
      this.serviceName,
      this.name,
      this.firmEmployeeName});

  ClaimClientListDetails.fromJson(Map<String, dynamic> json) {
    claimId = json['claim_id'] ?? "";
    clientName = json['client_name'] ?? "";
    service = json['service'] ?? "";
    task = json['task'] ?? "";
    typeOfClaim = json['type_of_claim'] ?? "";
    particulars = json['particulars'] ?? "";
    claimFrom = json['claim_from'] ?? "";
    claimTo = json['claim_to'] ?? "";
    kms = json['kms'] ?? "";
    billNo = json['bill_no'] ?? "";
    billDate = json['bill_date'] == null || json['bill_date'] == ""
        ? ""
        : DateFormat("dd-MM-yyyy").format(DateTime.parse(json['bill_date']));
    challan = json['challan'] ?? "";
    file = json['file'] ?? "";
    claimAmount = json['claim_amount'] ?? "";
    cliamBillable = json['cliam_billable'] ?? "";
    includedBill = json['included_bill'] ?? "";
    claimDate = json['claim_date'] == null || json['claim_date'] == ""
        ? ""
        : DateFormat("dd-MM-yyyy").format(DateTime.parse(json['claim_date']));
    claimStatus = json['claim_status'] ?? "";
    mastId = json['mast_id'] ?? "";
    firmId = json['firm_id'] ?? "";
    addOnDate = json['add_on_date'] ?? "";
    addedBy = json['added_by'] ?? "";
    modifiedOnDate = json['modified_on_date'] ?? "";
    modifiedBy = json['modified_by'] ?? "";
    timesheet = json['timesheet'] ?? "";
    office = json['office'] ?? "";
    cliamFinancialYearId = json['cliam_financial_year_id'] ?? "";
    mytask = json['mytask'] ?? "";
    clientApplicableService = json['client_applicable_service'] ?? "";
    firmClientClientCode = json['firm_client_client_code'] ?? "";
    firmClientFirmName = json['firm_client_firm_name'] ?? "";
    firmClientStatus = json['firm_client_status'] ?? "";
    tradeName = json['trade_name'] ?? "";
    taskName = json['task_name'] ?? "";
    serviceName = json['service_name'] ?? "";
    name = json['name'] ?? "";
    firmEmployeeName = json['firm_employee_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['claim_id'] = claimId;
    data['client_name'] = clientName;
    data['service'] = service;
    data['task'] = task;
    data['type_of_claim'] = typeOfClaim;
    data['particulars'] = particulars;
    data['claim_from'] = claimFrom;
    data['claim_to'] = claimTo;
    data['kms'] = kms;
    data['bill_no'] = billNo;
    data['bill_date'] = billDate;
    data['challan'] = challan;
    data['file'] = file;
    data['claim_amount'] = claimAmount;
    data['cliam_billable'] = cliamBillable;
    data['included_bill'] = includedBill;
    data['claim_date'] = claimDate;
    data['claim_status'] = claimStatus;
    data['mast_id'] = mastId;
    data['firm_id'] = firmId;
    data['add_on_date'] = addOnDate;
    data['added_by'] = addedBy;
    data['modified_on_date'] = modifiedOnDate;
    data['modified_by'] = modifiedBy;
    data['timesheet'] = timesheet;
    data['office'] = office;
    data['cliam_financial_year_id'] = cliamFinancialYearId;
    data['mytask'] = mytask;
    data['client_applicable_service'] = clientApplicableService;
    data['firm_client_client_code'] = firmClientClientCode;
    data['firm_client_firm_name'] = firmClientFirmName;
    data['firm_client_status'] = firmClientStatus;
    data['trade_name'] = tradeName;
    data['task_name'] = taskName;
    data['service_name'] = serviceName;
    data['name'] = name;
    data['firm_employee_name'] = firmEmployeeName;
    return data;
  }
}

class ClaimEditResponse {
  String? message;
  bool? success;
  List<ClaimDetails>? claimDetails;
  String? url;

  ClaimEditResponse({this.message, this.success, this.claimDetails, this.url});

  ClaimEditResponse.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['Claim Details'] != null) {
      claimDetails = <ClaimDetails>[];
      json['Claim Details'].forEach((v) {
        claimDetails!.add(ClaimDetails.fromJson(v));
      });
    }
    url = json['Url'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (claimDetails != null) {
      data['Claim Details'] = claimDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClaimDetails {
  String? claimId;
  String? clientName;
  String? service;
  String? task;
  String? typeOfClaim;
  String? particulars;
  String? claimFrom;
  String? claimTo;
  String? kms;
  String? billNo;
  String? billDate;
  String? challan;
  String? file;
  String? claimAmount;
  String? cliamBillable;
  String? includedBill;
  String? claimDate;
  String? claimStatus;
  String? mastId;
  String? firmId;
  String? addOnDate;
  String? addedBy;
  String? modifiedOnDate;
  String? modifiedBy;
  String? timesheet;
  String? office;
  String? cliamFinancialYearId;
  String? mytask;
  String? clientApplicableService;
  String? serviceName;
  String? name;
  String? firmEmployeeName;
  String? firmClientName;
  String? startYear;
  String? endYear;
  String? claimDateToSend;
  String? billDateToSend;
  String? taskName;

  ClaimDetails(
      {this.claimId,
      this.clientName,
      this.service,
      this.task,
      this.typeOfClaim,
      this.particulars,
      this.claimFrom,
      this.claimTo,
      this.kms,
      this.billNo,
      this.billDate,
      this.challan,
      this.file,
      this.claimAmount,
      this.cliamBillable,
      this.includedBill,
      this.claimDate,
      this.claimStatus,
      this.mastId,
      this.firmId,
      this.addOnDate,
      this.addedBy,
      this.modifiedOnDate,
      this.modifiedBy,
      this.timesheet,
      this.office,
      this.cliamFinancialYearId,
      this.mytask,
      this.clientApplicableService,
      this.serviceName,
      this.name,
      this.firmEmployeeName,
      this.firmClientName,
      this.startYear,
      this.endYear,
      this.claimDateToSend,
      this.billDateToSend,
      this.taskName});

  ClaimDetails.fromJson(Map<String, dynamic> json) {
    claimId = json['claim_id'] == null || json['claim_id'] == ""
        ? ""
        : json['claim_id'];
    clientName = json['client_name'] == null || json['client_name'] == ""
        ? ""
        : json['client_name'];
    service = json['service'] == null || json['service'] == ""
        ? ""
        : json['service'] ?? "";
    task = json['task'] == null || json['task'] == "" ? "" : json['task'] ?? "";
    typeOfClaim = json['type_of_claim'] == null || json['type_of_claim'] == ""
        ? ""
        : json['type_of_claim'] ?? "";
    particulars = json['particulars'] == null || json['particulars'] == ""
        ? ""
        : json['particulars'] ?? "";
    claimFrom = json['claim_from'] == null || json['claim_from'] == ""
        ? ""
        : json['claim_from'] ?? "";
    claimTo = json['claim_to'] == null || json['claim_to'] == ""
        ? ""
        : json['claim_to'] ?? "";
    kms = json['kms'] == null || json['kms'] == "" ? "" : json['kms'] ?? "";
    billNo = json['bill_no'] == null || json['bill_no'] == ""
        ? ""
        : json['bill_no'] ?? "";
    billDateToSend = json['bill_date'] == null || json['bill_date'] == ""
        ? ""
        : json['bill_date'] ?? "";
    billDate = json['bill_date'] == null || json['bill_date'] == ""
        ? ""
        : DateFormat("dd-MM-yyyy").format(DateTime.parse(json["bill_date"]));
    challan = json['challan'] == null || json['challan'] == ""
        ? ""
        : json['challan'] ?? "";
    file = json['file'] == null || json['file'] == "" ? "" : json['file'] ?? "";
    claimAmount = json['claim_amount'] == null || json['claim_amount'] == ""
        ? ""
        : json['claim_amount'] ?? "";
    cliamBillable =
        json['cliam_billable'] == null || json['cliam_billable'] == ""
            ? ""
            : json['cliam_billable'] ?? "";
    includedBill = json['included_bill'] == null || json['included_bill'] == ""
        ? ""
        : json['included_bill'] ?? "";
    claimDateToSend = json['claim_date'] == null || json['claim_date'] == ""
        ? ""
        : json['claim_date'] ?? "";
    claimDate = json['claim_date'] == null || json['claim_date'] == ""
        ? ""
        : DateFormat("dd-MM-yyyy").format(DateTime.parse(json["claim_date"]));
    claimStatus = json['claim_status'] == null || json['claim_status'] == ""
        ? ""
        : json['claim_status'] ?? "";
    mastId = json['mast_id'] == null || json['mast_id'] == ""
        ? ""
        : json['mast_id'] ?? "";
    firmId = json['firm_id'] == null || json['firm_id'] == ""
        ? ""
        : json['firm_id'] ?? "";
    addOnDate = json['add_on_date'] == null || json['add_on_date'] == ""
        ? ""
        : json['add_on_date'] ?? "";
    addedBy = json['added_by'] == null || json['added_by'] == ""
        ? ""
        : json['added_by'] ?? "";
    modifiedOnDate =
        json['modified_on_date'] == null || json['modified_on_date'] == ""
            ? ""
            : json['modified_on_date'] ?? "";
    modifiedBy = json['modified_by'] == null || json['modified_by'] == ""
        ? ""
        : json['modified_by'] ?? "";
    timesheet = json['timesheet'] == null || json['timesheet'] == ""
        ? ""
        : json['timesheet'] ?? "";
    office = json['office'] == null || json['office'] == ""
        ? ""
        : json['office'] ?? "";
    cliamFinancialYearId = json['cliam_financial_year_id'] == null ||
            json['cliam_financial_year_id'] == ""
        ? ""
        : json['cliam_financial_year_id'] ?? "";
    mytask = json['mytask'] == null || json['mytask'] == ""
        ? ""
        : json['mytask'] ?? "";
    clientApplicableService = json['client_applicable_service'] == null ||
            json['client_applicable_service'] == ""
        ? ""
        : json['client_applicable_service'] ?? "";
    serviceName = json['service_name'] == null || json['service_name'] == ""
        ? ""
        : json['service_name'] ?? "";
    name = json['name'] == null || json['name'] == "" ? "" : json['name'] ?? "";
    firmEmployeeName =
        json['firm_employee_name'] == null || json['firm_employee_name'] == ""
            ? ""
            : json['firm_employee_name'] ?? "";
    firmClientName = json['firm_client_firm_name'] == null ||
            json['firm_client_firm_name'] == ""
        ? ""
        : json['firm_client_firm_name'] ?? "";
    startYear = json['YEAR(y.finanacial_year_start_date)'] == null ||
            json['YEAR(y.finanacial_year_start_date)'] == ""
        ? ""
        : json['YEAR(y.finanacial_year_start_date)'] ?? "";
    endYear = json['YEAR(y.finanacial_year_end_date)'] == null ||
            json['YEAR(y.finanacial_year_end_date)'] == ""
        ? ""
        : json['YEAR(y.finanacial_year_end_date)'] ?? "";
    taskName = json['task_name'] == null || json['task_name'] == ""
        ? ""
        : json['task_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['claim_id'] = claimId;
    data['client_name'] = clientName;
    data['service'] = service;
    data['task'] = task;
    data['type_of_claim'] = typeOfClaim;
    data['particulars'] = particulars;
    data['claim_from'] = claimFrom;
    data['claim_to'] = claimTo;
    data['kms'] = kms;
    data['bill_no'] = billNo;
    data['bill_date'] = billDate;
    data['challan'] = challan;
    data['file'] = file;
    data['claim_amount'] = claimAmount;
    data['cliam_billable'] = cliamBillable;
    data['included_bill'] = includedBill;
    data['claim_date'] = claimDate;
    data['claim_status'] = claimStatus;
    data['mast_id'] = mastId;
    data['firm_id'] = firmId;
    data['add_on_date'] = addOnDate;
    data['added_by'] = addedBy;
    data['modified_on_date'] = modifiedOnDate;
    data['modified_by'] = modifiedBy;
    data['timesheet'] = timesheet;
    data['office'] = office;
    data['cliam_financial_year_id'] = cliamFinancialYearId;
    data['mytask'] = mytask;
    data['client_applicable_service'] = clientApplicableService;
    data['service_name'] = serviceName;
    data['name'] = name;
    data['firm_employee_name'] = firmEmployeeName;
    data['firm_client_firm_name'] = firmClientName;
    data['YEAR(y.finanacial_year_start_date)'] = startYear;
    data['YEAR(y.finanacial_year_end_date)'] = endYear;
    data['task_name'] = taskName;
    return data;
  }
}
