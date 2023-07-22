class CustomResponse {
  bool? status;
  String? message;

  CustomResponse({this.status, this.message});

  CustomResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class ApiResponse {
  bool? success;
  String? message;

  ApiResponse({this.success, this.message});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    success = json['Success'] ?? "";
    message = json['Message'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Success'] = success;
    data['Message'] = message;
    return data;
  }
}

class CheckTimesheetApiResponse {
  bool? success;
  String? message;
  String? flag;

  CheckTimesheetApiResponse({this.success, this.message});

  CheckTimesheetApiResponse.fromJson(Map<String, dynamic> json) {
    success = json['Success'] ?? "";
    message = json['Message'] ?? "";
    flag = json['Flag'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Success'] = success;
    data['Message'] = message;
    data['Flag'] = flag;
    return data;
  }
}

class CheckTimesheetTimeResponse {
  bool? success;
  String? message;
  String? totalTime;
  String? balanceTime;

  CheckTimesheetTimeResponse({this.success, this.message});

  CheckTimesheetTimeResponse.fromJson(Map<String, dynamic> json) {
    success = json['Success'] ?? "";
    message = json['Message'] ?? "";
    totalTime = json['total_time'] ?? "";
    balanceTime = json['balance_time'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Success'] = success;
    data['Message'] = message;
    data['total_time'] = totalTime;
    data['balance_time'] = balanceTime;
    return data;
  }
}

class TimesheetDateCountResponse {
  String? message;
  bool? success;
  List<TimesheetDateCountList>? data;

  TimesheetDateCountResponse({this.message, this.success, this.data});

  TimesheetDateCountResponse.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['data'] != null) {
      data = <TimesheetDateCountList>[];
      json['data'].forEach((v) {
        data!.add(TimesheetDateCountList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimesheetDateCountList {
  String? taskno;

  TimesheetDateCountList({this.taskno});

  TimesheetDateCountList.fromJson(Map<String, dynamic> json) {
    taskno = json['taskno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taskno'] = taskno;
    return data;
  }
}

class TotalLeaveCountResponse {
  bool? success;
  String? message;
  String? totalLeaves;

  TotalLeaveCountResponse({this.success, this.message, this.totalLeaves});

  TotalLeaveCountResponse.fromJson(Map<String, dynamic> json) {
    success = json['Success'] ?? "";
    message = json['Message'] ?? "";
    totalLeaves = json['Total leaves'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Success'] = success;
    data['Message'] = message;
    data['Total leaves'] = totalLeaves;
    return data;
  }
}

class LoginResponse {
  String? message;
  bool? success;
  List<UserDetails>? userDetails;
  String? isReportingHead;
  String? roleId;

  LoginResponse(
      {this.message,
      this.success,
      this.userDetails,
      this.isReportingHead,
      this.roleId});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['UserDetails'] != null) {
      userDetails = <UserDetails>[];
      json['UserDetails'].forEach((v) {
        userDetails!.add(UserDetails.fromJson(v));
      });
    }
    isReportingHead = json["is_reporting_head"];
    roleId = json["role_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (userDetails != null) {
      data['UserDetails'] = userDetails!.map((v) => v.toJson()).toList();
    }
    data["is_reporting_head"] = isReportingHead;
    data["role_id"] = roleId;
    return data;
  }
}

class UserDetails {
  String? id;
  String? name;
  String? username;
  String? password;
  String? firmId;
  String? mastStatus;
  String? payStatus;
  String? userType;
  String? addOnDate;
  String? addedBy;
  String? modifiedOnDate;
  String? modifiedBy;
  String? parent;
  String? loginAttempt;
  String? isEntry;
  String? employeeId;
  String? bizEmpStaffId;
  String? distributorId;
  String? expDate;
  String? mail;
  String? partnerId;

  UserDetails(
      {this.id,
      this.name,
      this.username,
      this.password,
      this.firmId,
      this.mastStatus,
      this.payStatus,
      this.userType,
      this.addOnDate,
      this.addedBy,
      this.modifiedOnDate,
      this.modifiedBy,
      this.parent,
      this.loginAttempt,
      this.isEntry,
      this.employeeId,
      this.bizEmpStaffId,
      this.distributorId,
      this.expDate,
      this.mail,
      this.partnerId});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
    username = json['username'] ?? "";
    password = json['password'] ?? "";
    firmId = json['firm_id'] ?? "";
    mastStatus = json['mast_status'] ?? '';
    payStatus = json['pay_status'] ?? '';
    userType = json['user_type'] ?? '';
    addOnDate = json['add_on_date'] ?? '';
    addedBy = json['added_by'] ?? '';
    modifiedOnDate = json['modified_on_date'] ?? '';
    modifiedBy = json['modified_by'] ?? '';
    parent = json['parent'] ?? '';
    loginAttempt = json['login_attempt'] ?? '';
    isEntry = json['is_entry'] ?? '';
    employeeId = json['employee_id'] ?? '';
    bizEmpStaffId = json['biz_emp_staff_id'] ?? '';
    distributorId = json['distributor_id'] ?? '';
    expDate = json['exp_date'] ?? '';
    mail = json['mail'] ?? '';
    partnerId = json['partner_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['password'] = password;
    data['firm_id'] = firmId;
    data['mast_status'] = mastStatus;
    data['pay_status'] = payStatus;
    data['user_type'] = userType;
    data['add_on_date'] = addOnDate;
    data['added_by'] = addedBy;
    data['modified_on_date'] = modifiedOnDate;
    data['modified_by'] = modifiedBy;
    data['parent'] = parent;
    data['login_attempt'] = loginAttempt;
    data['is_entry'] = isEntry;
    data['employee_id'] = employeeId;
    data['biz_emp_staff_id'] = bizEmpStaffId;
    data['distributor_id'] = distributorId;
    data['exp_date'] = expDate;
    data['mail'] = mail;
    data['partner_id'] = partnerId;
    return data;
  }
}

class AccessRightResponse {
  String? message;
  bool? success;
  List<AccessRightDetails>? accessRightDetails;

  AccessRightResponse({this.message, this.success, this.accessRightDetails});

  AccessRightResponse.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['data'] != null) {
      accessRightDetails = <AccessRightDetails>[];
      json['data'].forEach((v) {
        accessRightDetails!.add(AccessRightDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (accessRightDetails != null) {
      data['data'] = accessRightDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AccessRightDetails {
  String? moduleName;
  String? addAccess;

  AccessRightDetails({this.moduleName, this.addAccess});

  AccessRightDetails.fromJson(Map<String, dynamic> json) {
    moduleName = json['module_name'];
    addAccess = json['add_access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['module_name'] = moduleName;
    data['add_access'] = addAccess;
    return data;
  }
}
