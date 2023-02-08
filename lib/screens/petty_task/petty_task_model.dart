class BranchNameModel {
  String? message;
  bool? success;
  List<Branchlist>? branchListDetails;

  BranchNameModel({this.message, this.success, this.branchListDetails});

  BranchNameModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['branchlist'] != null) {
      branchListDetails = <Branchlist>[];
      json['branchlist'].forEach((v) {
        branchListDetails!.add(Branchlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message??"";
    data['Success'] = success??"";
    if (branchListDetails != null) {
      data['branchlist'] = branchListDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Branchlist {
  String? id;
  String? name;

  Branchlist({this.id, this.name});

  Branchlist.fromJson(Map<String, dynamic> json) {
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

class BranchClientListModel {
  String? message;
  bool? success;
  List<Clientslist>? clientListDetails;

  BranchClientListModel({this.message, this.success, this.clientListDetails});

  BranchClientListModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['clientslist'] != null) {
      clientListDetails = <Clientslist>[];
      json['clientslist'].forEach((v) {
        clientListDetails!.add(Clientslist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (clientListDetails != null) {
      data['clientslist'] = clientListDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Clientslist {
  String? firmClientId;
  String? firmClientClientCode;
  String? firmClientStatus;
  String? firmClientFirmName;
  String? tradeName;

  Clientslist(
      {this.firmClientId,
        this.firmClientClientCode,
        this.firmClientStatus,
        this.firmClientFirmName,
        this.tradeName});

  Clientslist.fromJson(Map<String, dynamic> json) {
    firmClientId = json['firm_client_id']??"";
    firmClientClientCode = json['firm_client_client_code']??"";
    firmClientStatus = json['firm_client_status']??"";
    firmClientFirmName = json['firm_client_firm_name']??"";
    tradeName = json['trade_name']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firm_client_id'] = firmClientId;
    data['firm_client_client_code'] = firmClientClientCode;
    data['firm_client_status'] = firmClientStatus;
    data['firm_client_firm_name'] = firmClientFirmName;
    data['trade_name'] = tradeName;
    return data;
  }
}

class BranchEmpModel {
  String? message;
  bool? success;
  List<EmplyeeList>? empListDetails;

  BranchEmpModel({this.message, this.success, this.empListDetails});

  BranchEmpModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['emplyeeList'] != null) {
      empListDetails = <EmplyeeList>[];
      json['emplyeeList'].forEach((v) {
        empListDetails!.add(EmplyeeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (empListDetails != null) {
      data['emplyeeList'] = empListDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmplyeeList {
  String? firmEmployeeName;
  String? mastId;

  EmplyeeList({this.firmEmployeeName, this.mastId});

  EmplyeeList.fromJson(Map<String, dynamic> json) {
    firmEmployeeName = json['firm_employee_name']??"";
    mastId = json['mast_id']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firm_employee_name'] = firmEmployeeName;
    data['mast_id'] = mastId;
    return data;
  }
}