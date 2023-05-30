class EmployeeDashboardModel {
  String? message;
  bool? success;
  List<EmployeeDashboardData>? employeeDashboardData;

  EmployeeDashboardModel({this.message, this.success, this.employeeDashboardData});

  EmployeeDashboardModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['data'] != null) {
      employeeDashboardData = <EmployeeDashboardData>[];
      json['data'].forEach((v) {
        employeeDashboardData!.add(new EmployeeDashboardData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['Success'] = this.success;
    if (this.employeeDashboardData != null) {
      data['data'] = this.employeeDashboardData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeeDashboardData {
  String? leaveStatus;
  String? employee;
  String? totalCnt;
  String? allottedCnt;
  String? pastdueCnt;
  String? probableCnt;
  String? highCnt;
  String? mediumCnt;
  String? lowCnt;
  String? pendingClaims;

  EmployeeDashboardData(
      {this.leaveStatus,
        this.employee,
        this.totalCnt,
        this.allottedCnt,
        this.pastdueCnt,
        this.probableCnt,
        this.highCnt,
        this.mediumCnt,
        this.lowCnt,
        this.pendingClaims});

  EmployeeDashboardData.fromJson(Map<String, dynamic> json) {
    leaveStatus = json['leave_status'].toString() == "P" ? "Present" : "Absent" ;
    employee = json['employee'].toString();
    totalCnt = json['total_cnt'].toString();
    allottedCnt = json['allotted_cnt'].toString();
    pastdueCnt = json['pastdue_cnt'].toString();
    probableCnt = json['probable_cnt'].toString();
    highCnt = json['high_cnt'].toString();
    mediumCnt = json['medium_cnt'].toString();
    lowCnt = json['low_cnt'].toString();
    pendingClaims = json['pending_claims'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leave_status'] = this.leaveStatus;
    data['employee'] = this.employee;
    data['total_cnt'] = this.totalCnt;
    data['allotted_cnt'] = this.allottedCnt;
    data['pastdue_cnt'] = this.pastdueCnt;
    data['probable_cnt'] = this.probableCnt;
    data['high_cnt'] = this.highCnt;
    data['medium_cnt'] = this.mediumCnt;
    data['low_cnt'] = this.lowCnt;
    data['pending_claims'] = this.pendingClaims;
    return data;
  }
}