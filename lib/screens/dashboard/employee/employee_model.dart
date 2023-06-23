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
        employeeDashboardData!.add(EmployeeDashboardData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (employeeDashboardData != null) {
      data['data'] = employeeDashboardData!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['leave_status'] = leaveStatus;
    data['employee'] = employee;
    data['total_cnt'] = totalCnt;
    data['allotted_cnt'] = allottedCnt;
    data['pastdue_cnt'] = pastdueCnt;
    data['probable_cnt'] = probableCnt;
    data['high_cnt'] = highCnt;
    data['medium_cnt'] = mediumCnt;
    data['low_cnt'] = lowCnt;
    data['pending_claims'] = pendingClaims;
    return data;
  }
}