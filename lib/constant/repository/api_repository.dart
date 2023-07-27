import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:biznew/screens/calender/calender_model.dart';
import 'package:biznew/screens/claim_form/claim_model.dart';
import 'package:biznew/screens/dashboard/client/client_dashboard_model.dart';
import 'package:biznew/screens/dashboard/dashboard_model.dart';
import 'package:biznew/screens/dashboard/employee/employee_model.dart';
import 'package:biznew/screens/leave_form/leave_model.dart';
import 'package:biznew/screens/manual_assignment/manual_assignment_model.dart';
import 'package:biznew/screens/petty_task/petty_task_model.dart';
import 'package:biznew/screens/timesheet_form/timesheet_model.dart';
import 'package:biznew/screens/timesheet_new/timesheet_new_model.dart';
import 'package:biznew/utils/custom_response.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../api_endpoint.dart';
import '../provider/api.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ApiRepository {
  final ApiClient apiClient;

  ApiRepository({required this.apiClient});
  Map<String, String> headers = {"Content-Type": "text/html;charset=UTF-8"};
  Map<String, String> multipartHeaders = {
    "Content-Type": "multipart/form-data"
  };

  String firmId = "";
  String userId = "";

  ///get firm id,
  getData() {
    firmId = GetStorage().read("firmId") ?? "";
    userId = GetStorage().read("userId") ?? "";
  }

  ///login api
  Future<LoginResponse> doLogin(
      {String? type, String? username, String? password}) async {
    final FormData formData = FormData.fromMap(
      {
        "type": type,
        'username': username,
        "password": password,
      },
    );
    final response = await apiClient.post(ApiEndpoint.loginUrl,
        body: formData, headers: headers);
    // var body = response;
    // var decodedResponse = jsonDecode(body);

    return LoginResponse.fromJson(response);
  }

  ///forgot password
  Future<ApiResponse> doForgotPassword(String email) async {
    final FormData formData = FormData.fromMap(
      {
        "email": email,
      },
    );
    final response = await apiClient.post(ApiEndpoint.forgotPasswordUrl,
        body: formData, headers: headers);
    return ApiResponse.fromJson(response);
  }

  ///access right
  Future<AccessRightResponse> getAccessList() async {
    getData();
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(ApiEndpoint.accessRightUrl,
        body: formData, headers: headers);
    return AccessRightResponse.fromJson(response);
  }

  ///client dashboard
  Future<ClientDashboardModel> getClientDashboardList() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId, "branchid": ""},
    );
    final response = await apiClient.post(
      ApiEndpoint.clientDashboardUrl,
      body: formData,
      headers: headers,
    );
    return ClientDashboardModel.fromJson(response);
  }

  ///employee dashboard
  Future<EmployeeDashboardModel> getEmployeeDashboardList() async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "mast_id": userId,
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.employeeDashboardUrl,
      body: formData,
      headers: headers,
    );
    return EmployeeDashboardModel.fromJson(response);
  }

  ///notification
  Future<NotificationModel> getNotificationList() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.notificationUrl,
      body: formData,
      headers: headers,
    );
    return NotificationModel.fromJson(response);
  }

  ///notification read for mark all
  Future<ApiResponse> getNotificationMarkAllRead() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.notificationMarkAllReadUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///notification read selected
  Future<ApiResponse> getNotificationMarkSelectedRead(
      String notificationId) async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId, "notification_id": notificationId},
    );
    final response = await apiClient.post(
      ApiEndpoint.notificationMarkSelectedReadUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///nature of claim
  Future<ClaimTypeModel> getNatureOfClaimList() async {
    final response =
        await apiClient.post(ApiEndpoint.claimTypeListUrl, headers: headers);
    return ClaimTypeModel.fromJson(response);
  }

  ///client name
  Future<ClientNameModel> getClientNameList() async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.clientNameListUrl,
      body: formData,
      headers: headers,
    );
    return ClientNameModel.fromJson(response);
  }

  ///claim year
  Future<ClaimYearModel> getClaimYearList() async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
      },
    );
    final response = await apiClient.post(ApiEndpoint.claimYearListUrl,
        body: formData, headers: headers);
    return ClaimYearModel.fromJson(response);
  }

  ///claim service list
  Future<ClaimServiceResponse> getClaimServicesList(
      String selectedClientId, String selectedClaimYearId) async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "client_id": selectedClientId,
        "year_id": selectedClaimYearId
      },
    );
    final response = await apiClient.post(ApiEndpoint.claimServicesListUrl,
        body: formData, headers: headers);
    return ClaimServiceResponse.fromJson(response);
  }

  ///claim task list
  Future<ClaimTaskResponse> getClaimTaskList(String serviceId) async {
    final FormData formData = FormData.fromMap(
      {
        "service_id": serviceId,
      },
    );
    final response = await apiClient.post(ApiEndpoint.claimTaskListUrl,
        body: formData, headers: headers);
    return ClaimTaskResponse.fromJson(response);
  }

  ///claim submitted by list
  Future<ClaimSubmittedByResponse> getClaimSubmittedByList() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(ApiEndpoint.claimSubmittedByListUrl,
        body: formData, headers: headers);
    return ClaimSubmittedByResponse.fromJson(response);
  }

  ///add claim
  Future<Stream<String>> getAddClaimForm(
      {String? taskName,
      String? claimDate,
      String? claimType,
      String? natureOfClaim,
      String? particulars,
      String? clientName,
      String? year,
      String? service,
      String? task,
      String? date,
      String? amount,
      String? claimSubmittedBy,
      String? claimImage,
      String? billable,
      String? travelFrom,
      String? travelTo,
      String? kms,
      String? challanNo,
      String? clientServiceId,
      String? billNo}) async {
    var uri = Uri.parse(ApiEndpoint.claimAddUrl);
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(multipartHeaders);

    request.fields['task_name'] = taskName!;
    request.fields['firm_id'] = firmId;
    request.fields['mast_id'] = userId;
    request.fields['claimdate'] = claimDate!;
    request.fields['claimType'] = claimType!;
    request.fields['natureOfClaim'] = natureOfClaim!;
    request.fields['particulars'] = particulars!;
    request.fields['clientName'] = clientName!;
    request.fields['year'] = year!;
    request.fields['service'] = service!;
    request.fields['task'] = task!;
    request.fields['billdate'] = date!;
    request.fields['claimAmount'] = amount!;
    request.fields['claimSubmittedBy'] = claimSubmittedBy!;
    request.fields['billable'] = billable!;
    request.fields['travelFrom'] = travelFrom!;
    request.fields['travelTo'] = travelTo!;
    request.fields['kms'] = kms!;
    request.fields['challanNo'] = challanNo!;
    request.fields['client_applicabe_service_id'] = clientServiceId!;
    request.fields['billNo'] = billNo!;

    var length = await File(claimImage!).length();
    var stream = http.ByteStream(Stream.castFrom(File(claimImage).openRead()));
    var multipartFileSign = http.MultipartFile('claimImage', stream, length,
        filename: basename(File(claimImage).path));
    request.files.add(multipartFileSign);
    var response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  ///claim list
  Future<ClaimClientListResponse> getClaimList(
      String flag, String status, String empId) async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "mast_id": userId,
        "flag": flag,
        "status": status,
        "employee": empId
      },
    );
    final response = await apiClient.post(ApiEndpoint.claimListUrl,
        body: formData, headers: headers);
    return ClaimClientListResponse.fromJson(response);
  }

  ///claim edit
  Future<ClaimEditResponse> getClaimEditList(String claimId) async {
    final FormData formData = FormData.fromMap(
      {
        "claim_id": claimId,
      },
    );
    final response = await apiClient.post(ApiEndpoint.claimEditUrl,
        body: formData, headers: headers);
    return ClaimEditResponse.fromJson(response);
  }

  ///claim update
  Future<Stream<String>> getUpdateClaimForm(
      {String? taskName,
      String? claimDate,
      String? claimType,
      String? natureOfClaim,
      String? particulars,
      String? clientName,
      String? year,
      String? service,
      String? task,
      String? date,
      String? amount,
      String? claimSubmittedBy,
      String? claimImage,
      String? billable,
      String? travelFrom,
      String? travelTo,
      String? kms,
      String? challanNo,
      String? clientServiceId,
      String? billNo,
      String? claimId}) async {
    var uri = Uri.parse(ApiEndpoint.claimUpdateUrl);
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(multipartHeaders);
    request.fields['task_name'] = taskName!;
    request.fields['firm_id'] = firmId;
    request.fields['mast_id'] = userId;
    request.fields['claimdate'] = claimDate!;
    request.fields['claimType'] = claimType!;
    request.fields['natureOfClaim'] = natureOfClaim!;
    request.fields['particulars'] = particulars!;
    request.fields['clientName'] = clientName!;
    request.fields['year'] = year!;
    request.fields['service'] = service!;
    request.fields['task'] = task!;
    request.fields['billdate'] = date!;
    request.fields['claimAmount'] = amount!;
    request.fields['claimSubmittedBy'] = claimSubmittedBy!;
    request.fields['billable'] = billable!;
    request.fields['travelFrom'] = travelFrom!;
    request.fields['travelTo'] = travelTo!;
    request.fields['kms'] = kms!;
    request.fields['challanNo'] = challanNo ?? "";
    request.fields['client_applicabe_service_id'] = clientServiceId ?? "";
    request.fields['billNo'] = billNo ?? "";
    request.fields['claim_id'] = claimId ?? "";
    request.fields['pastfile'] = "";

    // if(claimImage==""){
    // }
    // else{
    var length = await File(claimImage!).length();
    var stream = http.ByteStream(Stream.castFrom(File(claimImage).openRead()));
    var multipartFileSign = http.MultipartFile('claimImage', stream, length,
        filename: basename(File(claimImage).path));
    request.files.add(multipartFileSign);
    //}
    var response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  ///claim status update
  Future<ApiResponse> getUpdateStatus(
      String claimId, String action, String remark) async {
    final FormData formData = FormData.fromMap(
      {
        "mast_id": userId,
        "firm_id": firmId,
        "claim_id": claimId,
        "action": action,
        "remark": remark
      },
    );
    final response = await apiClient.post(ApiEndpoint.claimUpdateStatusUrl,
        body: formData, headers: headers);
    return ApiResponse.fromJson(response);
  }

  ///leave count
  Future<TotalLeaveCountResponse> getLeaveCountList() async {
    final FormData formData = FormData.fromMap(
      {
        "mast_id": userId,
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.leaveCountUrl,
      body: formData,
      headers: headers,
    );
    return TotalLeaveCountResponse.fromJson(response);
  }

  ///leave type
  Future<LeaveTypeModel> getLeaveTypeList() async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.leaveTypeUrl,
      body: formData,
      headers: headers,
    );
    return LeaveTypeModel.fromJson(response);
  }

  ///leave add
  Future<ApiResponse> getAddLeave(
      String leaveTypeId,
      String noOfDaysLeave,
      String startDate,
      String endDate,
      String reason,
      String leaveFor,
      String noOfAttempt,
      String group) async {
    final FormData formData = FormData.fromMap(
      {
        "leaveType": leaveTypeId,
        "mast_id": userId,
        "firm_id": firmId,
        "ndays": noOfDaysLeave,
        "startdate": startDate,
        "enddate": endDate,
        "reason": reason,
        "leavefor": leaveFor,
        "attempts": noOfAttempt,
        "group": group
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.leaveAddUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///leave list
  Future<LeaveListModel> getLeaveList(
      String flag, String status, String idList) async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "mast_id": userId,
        "flag": flag,
        "status": status,
        "emp": idList.isEmpty ? "" : idList
      },
    );
    final response = await apiClient.post(ApiEndpoint.leaveListUrl,
        body: formData, headers: headers);
    return LeaveListModel.fromJson(response);
  }

  ///leave edit
  Future<LeaveEditModel> getLeaveEditList(String leaveId) async {
    final FormData formData = FormData.fromMap(
      {
        "leave_id": leaveId,
      },
    );
    final response = await apiClient.post(ApiEndpoint.leaveEditListUrl,
        body: formData, headers: headers);
    return LeaveEditModel.fromJson(response);
  }

  ///leave update
  Future<ApiResponse> getUpdateLeave(
      String leaveTypeId,
      String noOfDaysLeave,
      String startDate,
      String endDate,
      String reason,
      String leaveFor,
      String attempt,
      String group,
      String leaveId) async {
    final FormData formData = FormData.fromMap(
      {
        "leaveType": leaveTypeId,
        "mast_id": userId,
        "firm_id": firmId,
        "ndays": noOfDaysLeave,
        "startdate": startDate,
        "enddate": endDate,
        "reason": reason,
        "leaveFor": leaveFor,
        "attempts": attempt,
        "group": group,
        "leave_id": leaveId
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.leaveUpdateListUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///leave update status
  Future<ApiResponse> getLeaveUpdateStatus(
      String leaveId, String action, String remark) async {
    final FormData formData = FormData.fromMap(
      {
        "mast_id": userId,
        "firm_id": firmId,
        "leave_id": leaveId,
        "action": action,
        "remark": remark
      },
    );
    final response = await apiClient.post(ApiEndpoint.leaveUpdateStatusUrl,
        body: formData, headers: headers);
    return ApiResponse.fromJson(response);
  }

  ///timesheet action
  Future<ApiResponse> getTimesheetAction(
      String sid, String timesheetId, String action) async {
    final FormData formData = FormData.fromMap(
      {
        "mast_id": userId,
        "firm_id": firmId,
        "sid": sid,
        "timesheet_id": timesheetId,
        "action": action
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.timesheetActionUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  Future<TimesheetDateCountResponse> getTimesheetBackdateCount() async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
      },
    );
    final response = await apiClient.post(ApiEndpoint.timesheetBackDateAllowedUrl,
        body: formData, headers: headers);
    return TimesheetDateCountResponse.fromJson(response);
  }

  ///Timesheet check
  Future<CheckTimesheetApiResponse> getTimesheetCheck(String date) async {
    final FormData formData = FormData.fromMap(
      {
        "mast_id": userId,
        "timesheet_date": date,
      },
    );
    final response = await apiClient.post(ApiEndpoint.timesheetCheckUrl,
        body: formData, headers: headers);
    return CheckTimesheetApiResponse.fromJson(response);
  }

  ///timesheet add
  Future<ApiResponse> getTimesheetAdd(String date, String inTime,
      String outTime, String totalTime, String workAt) async {
    final FormData formData = FormData.fromMap(
      {
        "mast_id": userId,
        "firm_id": firmId,
        "timesheet_date": date,
        "in_time": inTime,
        "out_time": outTime,
        "total_time": totalTime,
        "workat": workAt
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.timesheetAddUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///timesheet total time
  Future<CheckTimesheetTimeResponse> getTimesheetTotalTime(String date) async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "mast_id": userId,
        "timesheet_date": date,
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.timesheetTotalTimeUrl,
      body: formData,
      headers: headers,
    );
    return CheckTimesheetTimeResponse.fromJson(response);
  }

  ///timesheet client allotted
  Future<TimesheetClientListModel> getTimesheetClientNameList() async {
    final FormData formData = FormData.fromMap(
      {
        "mast_id": userId,
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.timesheetClientListUrl,
      body: formData,
      headers: headers,
    );
    return TimesheetClientListModel.fromJson(response);
  }
  ///timesheet client non allotted
  Future<TimesheetClientListModel> getTimesheetClientNameNonAllottedList() async {
    final FormData formData = FormData.fromMap(
      {
        "mast_id": userId,
      },
    );
    print("formData.fields client");
    print(formData.fields);
    final response = await apiClient.post(
      ApiEndpoint.timesheetClientListNonAllottedUrl,
      body: formData,
      headers: headers,
    );
    return TimesheetClientListModel.fromJson(response);
  }

  ///timesheet services
  Future<TimesheetServiceListModel> getTimesheetServicesList(
      String clientId) async {
    final FormData formData = FormData.fromMap(
      {"mast_id": userId, "client_id": clientId},
    );
    final response = await apiClient.post(
      ApiEndpoint.timesheetServicesListUrl,
      body: formData,
      headers: headers,
    );
    return TimesheetServiceListModel.fromJson(response);
  }

  Future<TimesheetServiceListModel> getTimesheetNonAllottedServicesList(
      String clientId) async {
    final FormData formData = FormData.fromMap(
      {"mast_id": userId, "client_id": clientId},
    );
    final response = await apiClient.post(
      ApiEndpoint.timesheetGetNonAllottedServicesUrl,
      body: formData,
      headers: headers,
    );
    return TimesheetServiceListModel.fromJson(response);
  }

  ///timesheet task
  Future<TimesheetTaskModel> getTimesheetTaskList(
      String serviceId, String clientApplicableServiceId) async {
    final FormData formData = FormData.fromMap(
      {
        "mast_id": userId,
        "service_id": serviceId,
        "client_applicable_service_id": clientApplicableServiceId
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.timesheetTaskListUrl,
      body: formData,
      headers: headers,
    );
    return TimesheetTaskModel.fromJson(response);
  }

  Future<TimesheetTaskListData> getTimesheetNewTaskList(
      String serviceId, String clientApplicableServiceId) async {
    final FormData formData = FormData.fromMap(
      {
        "mast_id": userId,
        "service_id": serviceId,
        "client_applicable_service_id": clientApplicableServiceId
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.timesheetTaskListUrl,
      body: formData,
      headers: headers,
    );
    return TimesheetTaskListData.fromJson(response);
  }

  ///timesheet non allotted task
  Future<TimesheetTaskModel> getTimesheetNonAllottedTaskList(
      String serviceId, String clientApplicableServiceId) async {
    final FormData formData = FormData.fromMap(
      {
        "mast_id": userId,
        "service_id": serviceId,
        "client_applicable_service_id": clientApplicableServiceId
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.timesheetGetNonAllottedTaskUrl,
      body: formData,
      headers: headers,
    );
    return TimesheetTaskModel.fromJson(response);
  }

  Future<TimesheetTaskListData> getTimesheetNonAllottedNewTaskList(
      String serviceId, String clientApplicableServiceId) async {
    final FormData formData = FormData.fromMap(
      {
        "mast_id": userId,
        "service_id": serviceId,
        "client_applicable_service_id": clientApplicableServiceId
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.timesheetGetNonAllottedTaskUrl,
      body: formData,
      headers: headers,
    );
    return TimesheetTaskListData.fromJson(response);
  }

  ///timesheet status
  Future<TimesheetStatusModel> getTimesheetStatusList(
      String clientServiceId, String taskId) async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "mast_id": userId,
        "client_applicable_service_id": clientServiceId,
        "task_id": taskId
      },
    );
    print("formData.fields status list");
    print(formData.fields);
    final response = await apiClient.post(
      ApiEndpoint.timesheetStatusListUrl,
      body: formData,
      headers: headers,
    );
    return TimesheetStatusModel.fromJson(response);
  }

  ///timesheet status update
  Future<ApiResponse> getTimesheetStatusUpdate(
      String clientServiceId, String taskId, String remark, String sid) async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "mast_id": userId,
        "client_applicable_service_id": clientServiceId,
        "task_id": taskId,
        "remark": remark,
        "sid": sid
      },
    );
    print("formData.fields");
    print(formData.fields);
    final response = await apiClient.post(
      ApiEndpoint.timesheetStatusUpdateUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///timesheet start
  Future<ApiResponse> getTimesheetStart(
      String clientServiceId, String taskId) async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "mast_id": userId,
        "client_applicable_service_id": clientServiceId,
        "task_id": taskId,
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.timesheetStartStatusUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///timesheet add allotted
  Future<ApiResponse> getTimesheetAddAllotted(
      String date,
      String clientId,
      String serviceId,
      String clientApplicableServiceId,
      String taskId,
      String remark,
      String noOfHours) async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "mast_id": userId,
        "timesheet_date": date,
        "client_id": clientId,
        "service_id": serviceId,
        "client_applicable_service_id": clientApplicableServiceId,
        "task_id": taskId,
        "remark": remark,
        "nohours": noOfHours,
      },
    );

    print("allotted save");
    print(formData.fields);
    final response = await apiClient.post(
      ApiEndpoint.timesheetAddAllottedUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///timesheet add non allotted
  Future<ApiResponse> getTimesheetAddNonAllotted(
      String date,
      String clientId,
      String serviceId,
      String clientApplicableServiceId,
      String taskId,
      String remark,
      String noOfHours) async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "mast_id": userId,
        "timesheet_date": date,
        "client_id": clientId,
        "service_id": serviceId,
        "client_applicable_service_id": clientApplicableServiceId,
        "task_id": taskId,
        "remark": remark,
        "nohours": noOfHours,
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.timesheetAddNonAllottedUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///timesheet type of work
  Future<TypeOfWorkModel> getTimesheetTypeOfWork() async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.timesheetTypeOfWorkUrl,
      body: formData,
      headers: headers,
    );
    return TypeOfWorkModel.fromJson(response);
  }

  ///timesheet add office related
  Future<ApiResponse> getTimesheetAddOfficeRelated(String date,
      String typeWorkId, String remark, String noOfHours, String action) async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "mast_id": userId,
        "timesheet_date": date,
        "type_work": typeWorkId,
        "remark": remark,
        "nohours": noOfHours,
        "action": action
      },
    );

    print("office formData.fields");
    print(formData.fields);
    final response = await apiClient.post(
      ApiEndpoint.timesheetAddOfficeRelatedUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///timesheet list
  Future<TimesheetListModel> getTimesheetList(
      String action, String flag) async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId, "status": action, "flag": flag},
    );
    final response = await apiClient.post(
      ApiEndpoint.timesheetListUrl,
      body: formData,
      headers: headers,
    );
    return TimesheetListModel.fromJson(response);
  }

  ///timesheet edit
  Future<TimesheetEditData> getTimesheetEdit(String date, String empId) async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "mast_id": userId,
        "timesheet_date": date,
        "emp_id": empId,
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.timesheetEditUrl,
      body: formData,
      headers: headers,
    );
    return TimesheetEditData.fromJson(response);
  }

  ///timesheet log
  Future<TimesheetLogModel> getTimesheetLog(String date, String id) async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "mast_id": userId,
        "timesheet_date": date,
        "id": id,
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.timesheetLogUrl,
      body: formData,
      headers: headers,
    );
    return TimesheetLogModel.fromJson(response);
  }

  ///branch firm list
  Future<BranchNameModel> getBranchNameList() async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.branchNameListUrl,
      body: formData,
      headers: headers,
    );
    return BranchNameModel.fromJson(response);
  }

  ///branch client list
  Future<BranchClientListModel> getBranchClientList(String branchId) async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "branch_id": branchId},
    );
    final response = await apiClient.post(
      ApiEndpoint.branchClientListUrl,
      body: formData,
      headers: headers,
    );
    return BranchClientListModel.fromJson(response);
  }

  ///branch emp list
  Future<BranchEmpModel> getBranchEmpList(String branchId) async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "branch_id": branchId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.branchEmpListUrl,
      body: formData,
      headers: headers,
    );
    return BranchEmpModel.fromJson(response);
  }

  ///add petty task
  Future<ApiResponse> getAddPettyTask(
      String branchId,
      String clientId,
      String empId,
      String targetDate,
      String triggerDate,
      String task,
      String fees,
      String hrs,
      String min) async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "mast_id": userId,
        "branch_id": branchId,
        "client_id": clientId,
        "employee_id": empId,
        "target_date": targetDate,
        "trigger_date": triggerDate,
        "tasks": task,
        "fees": fees,
        "estimated_hrs": hrs,
        "estimated_mins": min
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.addPettyTaskUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///own chart
  Future<OwnChartModel> getOwnPieChart() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.ownPieChartUrl,
      body: formData,
      headers: headers,
    );
    return OwnChartModel.fromJson(response);
  }

  ///trigger but not allotted
  Future<TriggerNotAllottedModel> getServiceTriggerNotAllottedPieChart() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.serviceTriggerButNotAllottedUrl,
      body: formData,
      headers: headers,
    );
    return TriggerNotAllottedModel.fromJson(response);
  }

  ///allotted not started
  Future<AllottedNotStartedModel> getAllottedNotStartedPieChart() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.allottedNotStartedUrl,
      body: formData,
      headers: headers,
    );
    return AllottedNotStartedModel.fromJson(response);
  }

  ///started not completed
  Future<StartedNotCompletedModel> getStartedNotCompletedPieChart() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.startedNotCompletedUrl,
      body: formData,
      headers: headers,
    );
    return StartedNotCompletedModel.fromJson(response);
  }

  ///completed UDIN pending
  Future<CompletedUdinPendingModel> getCompletedUDINPendingPieChart() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.completedUDINPendingUrl,
      body: formData,
      headers: headers,
    );
    return CompletedUdinPendingModel.fromJson(response);
  }

  ///completed not billed
  Future<CompletedNotBilledModel> getCompletedNotBilledPieChart() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.completedNotBilledUrl,
      body: formData,
      headers: headers,
    );
    return CompletedNotBilledModel.fromJson(response);
  }

  ///work on hold
  Future<WorkOnHoldModel> getWorkOnHoldPieChart() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.workOnHoldUrl,
      body: formData,
      headers: headers,
    );
    return WorkOnHoldModel.fromJson(response);
  }

  ///submitted for checking
  Future<SubmittedForCheckingModel> getSubmittedForCheckingPieChart() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.submittedForCheckingUrl,
      body: formData,
      headers: headers,
    );
    return SubmittedForCheckingModel.fromJson(response);
  }

  ///all tasks completed
  Future<AllTaskCompletedModel> getAllTaskCompletedPieChart() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.allTaskCompletedUrl,
      body: formData,
      headers: headers,
    );
    return AllTaskCompletedModel.fromJson(response);
  }

  ///calender
  Future<CalenderModel> getCalender(String year) async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId, "year": year},
    );
    final response = await apiClient.post(
      ApiEndpoint.calenderUrl,
      body: formData,
      headers: headers,
    );
    return CalenderModel.fromJson(response);
  }

  ///calender due date
  Future<CalendarDueDateModel> getCalenderDueDate(
      String date, String type) async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId, "date": date, "type": type},
    );
    final response = await apiClient.post(
      ApiEndpoint.calenderDueDateUrl,
      body: formData,
      headers: headers,
    );
    return CalendarDueDateModel.fromJson(response);
  }

  ///allotted not started past due team
  Future<AllottedNotStartedPastDueTeam>
      getAllottedNotStartedPastDueTeam() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.allottedNotStartedPastDueTeamUrl,
      body: formData,
      headers: headers,
    );
    return AllottedNotStartedPastDueTeam.fromJson(response);
  }

  ///allotted not started past due own
  Future<AllottedNotStartedPastDueTeam> getAllottedNotStartedPastDueOwn(String search) async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId, "search" : search},
    );
    final response = await apiClient.post(
      ApiEndpoint.allottedNotStartedPastDueOwnUrl,
      body: formData,
      headers: headers,
    );
    return AllottedNotStartedPastDueTeam.fromJson(response);
  }

  ///allotted not started probable overdue team
  Future<AllottedNotStartedPastDueTeam>
      getAllottedNotStartedProbableTeam() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.allottedNotStartedProbableOverdueTeamUrl,
      body: formData,
      headers: headers,
    );
    return AllottedNotStartedPastDueTeam.fromJson(response);
  }

  ///allotted not started probable overdue own
  Future<AllottedNotStartedPastDueTeam>
      getAllottedNotStartedProbableOwn() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.allottedNotStartedProbableOverdueOwnUrl,
      body: formData,
      headers: headers,
    );
    return AllottedNotStartedPastDueTeam.fromJson(response);
  }

  ///allotted not started high team
  Future<AllottedNotStartedPastDueTeam> getAllottedNotStartedHighTeam() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.allottedNotStartedHighTeamUrl,
      body: formData,
      headers: headers,
    );
    return AllottedNotStartedPastDueTeam.fromJson(response);
  }

  ///allotted not started high own
  Future<AllottedNotStartedPastDueTeam> getAllottedNotStartedHighOwn() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.allottedNotStartedHighOwnUrl,
      body: formData,
      headers: headers,
    );
    return AllottedNotStartedPastDueTeam.fromJson(response);
  }

  ///allotted not started medium team
  Future<AllottedNotStartedPastDueTeam>
      getAllottedNotStartedMediumTeam() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.allottedNotStartedMediumTeamUrl,
      body: formData,
      headers: headers,
    );
    return AllottedNotStartedPastDueTeam.fromJson(response);
  }

  ///allotted not started medium own
  Future<AllottedNotStartedPastDueTeam> getAllottedNotStartedMediumOwn() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.allottedNotStartedMediumOwnUrl,
      body: formData,
      headers: headers,
    );
    return AllottedNotStartedPastDueTeam.fromJson(response);
  }

  ///allotted not started low team
  Future<AllottedNotStartedPastDueTeam> getAllottedNotStartedLowTeam() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.allottedNotStartedLowTeamUrl,
      body: formData,
      headers: headers,
    );
    return AllottedNotStartedPastDueTeam.fromJson(response);
  }

  ///allotted not started low own
  Future<AllottedNotStartedPastDueTeam> getAllottedNotStartedLowOwn() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.allottedNotStartedLowOwnUrl,
      body: formData,
      headers: headers,
    );
    return AllottedNotStartedPastDueTeam.fromJson(response);
  }

  ///started not completed past due team
  Future<StartedButCompletedPieModel>
      getStartedNotCompletedPastDueTeam() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.startedNotCompletedPastDueTeamUrl,
      body: formData,
      headers: headers,
    );
    return StartedButCompletedPieModel.fromJson(response);
  }

  ///started not completed past due own
  Future<StartedButCompletedPieModel> getStartedNotCompletedPastDueOwn() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.startedNotCompletedPastDueOwnUrl,
      body: formData,
      headers: headers,
    );
    return StartedButCompletedPieModel.fromJson(response);
  }

  ///started not completed probable team
  Future<StartedButCompletedPieModel>
      getStartedNotCompletedProbableTeam() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.startedNotCompletedProbableTeamUrl,
      body: formData,
      headers: headers,
    );
    return StartedButCompletedPieModel.fromJson(response);
  }

  ///started not completed probable own
  Future<StartedButCompletedPieModel>
      getStartedNotCompletedProbableOwn() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.startedNotCompletedProbableOwnUrl,
      body: formData,
      headers: headers,
    );
    return StartedButCompletedPieModel.fromJson(response);
  }

  ///started not completed high team
  Future<StartedButCompletedPieModel> getStartedNotCompletedHighTeam() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.startedNotCompletedHighTeamUrl,
      body: formData,
      headers: headers,
    );
    return StartedButCompletedPieModel.fromJson(response);
  }

  ///started not completed high own
  Future<StartedButCompletedPieModel> getStartedNotCompletedHighOwn() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.startedNotCompletedHighOwnUrl,
      body: formData,
      headers: headers,
    );
    return StartedButCompletedPieModel.fromJson(response);
  }

  ///started not completed medium team
  Future<StartedButCompletedPieModel> getStartedNotCompletedMediumTeam() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.startedNotCompletedMediumTeamUrl,
      body: formData,
      headers: headers,
    );
    return StartedButCompletedPieModel.fromJson(response);
  }

  ///started not completed medium own
  Future<StartedButCompletedPieModel> getStartedNotCompletedMediumOwn() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.startedNotCompletedMediumOwnUrl,
      body: formData,
      headers: headers,
    );
    return StartedButCompletedPieModel.fromJson(response);
  }

  ///started not completed low team
  Future<StartedButCompletedPieModel> getStartedNotCompletedLowTeam() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.startedNotCompletedLowTeamUrl,
      body: formData,
      headers: headers,
    );
    return StartedButCompletedPieModel.fromJson(response);
  }

  ///started not completed low own
  Future<StartedButCompletedPieModel> getStartedNotCompletedLowOwn() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.startedNotCompletedLowOwnUrl,
      body: formData,
      headers: headers,
    );
    return StartedButCompletedPieModel.fromJson(response);
  }

  ///completed udin pending team
  Future<CompletedUdinPendingPieModel> getCompletedUdinPendingTeam() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.completedUdinPendingTeamUrl,
      body: formData,
      headers: headers,
    );
    return CompletedUdinPendingPieModel.fromJson(response);
  }

  ///completed udin pending own
  Future<CompletedUdinPendingPieModel> getCompletedUdinPendingOwn() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.completedUdinPendingOwnUrl,
      body: formData,
      headers: headers,
    );
    return CompletedUdinPendingPieModel.fromJson(response);
  }

  ///completed not billed
  Future<CompletedNotBilledPieModel> getCompletedNotBilled() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.completedNotBilledOwnUrl,
      body: formData,
      headers: headers,
    );
    return CompletedNotBilledPieModel.fromJson(response);
  }

  ///submitted for checking team
  Future<SubmittedForCheckingPieModel> getSubmittedForCheckingTeam() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.submittedForCheckingTeamUrl,
      body: formData,
      headers: headers,
    );
    return SubmittedForCheckingPieModel.fromJson(response);
  }

  ///submitted for checking own
  Future<SubmittedForCheckingPieModel> getSubmittedForCheckingOwn() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.submittedForCheckingOwnUrl,
      body: formData,
      headers: headers,
    );
    return SubmittedForCheckingPieModel.fromJson(response);
  }

  ///work on hold team
  Future<WorkOnHoldPieModel> getWorkOnHoldTeam() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.workOnHoldTeamUrl,
      body: formData,
      headers: headers,
    );
    return WorkOnHoldPieModel.fromJson(response);
  }

  ///work on hold own
  Future<WorkOnHoldPieModel> getWorkOnHoldOwn() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.workOnHoldOwnUrl,
      body: formData,
      headers: headers,
    );
    return WorkOnHoldPieModel.fromJson(response);
  }

  ///all tasks team
  Future<AllTasksPieModel> getAllTasksTeam() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.allTaskCompletedTeamUrl,
      body: formData,
      headers: headers,
    );
    return AllTasksPieModel.fromJson(response);
  }

  ///all tasks own
  Future<AllTasksPieModel> getAllTasksOwn() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.allTaskCompletedOwnUrl,
      body: formData,
      headers: headers,
    );
    return AllTasksPieModel.fromJson(response);
  }

  ///triggered not allotted past due
  Future<TriggeredNotAllottedModel> getTriggeredNotAllottedPastDue() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.triggeredNotAllottedPastDueUrl,
      body: formData,
      headers: headers,
    );
    return TriggeredNotAllottedModel.fromJson(response);
  }

  ///triggered not allotted last 7 days
  Future<TriggeredNotAllottedModel> getTriggeredNotAllottedLast7Days() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.triggeredNotAllottedLast7DaysUrl,
      body: formData,
      headers: headers,
    );
    return TriggeredNotAllottedModel.fromJson(response);
  }

  ///triggered not allotted more 7 days
  Future<TriggeredNotAllottedModel> getTriggeredNotAllottedMore7Days() async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId},
    );
    final response = await apiClient.post(
      ApiEndpoint.triggeredNotAllottedMoreThan7DaysUrl,
      body: formData,
      headers: headers,
    );
    return TriggeredNotAllottedModel.fromJson(response);
  }

  ///triggered not allotted load all
  Future<TriggeredNotAllottedLoadAllModel> getTriggeredNotAllottedLoadAll(
      String cliId) async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId, "cli_id": cliId},
    );
    final response = await apiClient.post(
      ApiEndpoint.triggeredNotAllottedLoadAllUrl,
      body: formData,
      headers: headers,
    );
    return TriggeredNotAllottedLoadAllModel.fromJson(response);
  }

  ///update priority
  Future<ApiResponse> getUpdatePriority(String priority, String id) async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId, "priority": priority, "id": id},
    );
    final response = await apiClient.post(
      ApiEndpoint.updatePriorityUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///update target date
  Future<ApiResponse> getUpdateTargetDate(String date, String id) async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId, "target_date": date, "id": id},
    );
    final response = await apiClient.post(
      ApiEndpoint.updateTargetDateUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///start service
  Future<ApiResponse> getStartService(String id) async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId, "cli_id": id},
    );
    final response = await apiClient.post(
      ApiEndpoint.startServiceUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///load all tasks
  Future<LoadAllTaskModel> getLoadAllTaskService(String id) async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId, "cli_id": id},
    );
    final response = await apiClient.post(
      ApiEndpoint.loadAllTaskUrl,
      body: formData,
      headers: headers,
    );
    return LoadAllTaskModel.fromJson(response);
  }

  ///start task
  Future<ApiResponse> getStartTask(String cliId, String id) async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId, "cli_id": cliId, "id": id},
    );
    final response = await apiClient.post(
      ApiEndpoint.startTaskUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///check password
  Future<ApiResponse> getCheckPassword(String pass) async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId, "password": pass},
    );
    final response = await apiClient.post(
      ApiEndpoint.checkPasswordUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///cancel service
  Future<ApiResponse> getCancelCurrentPeriodService(
      String cliId, String reason, String nextPeriod) async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "mast_id": userId,
        "cli_id": cliId,
        "reason": reason,
        "next_period": nextPeriod
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.cancelCurrentPeriodServiceUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///confirm cancel service
  Future<ApiResponse> getConfirmCancelService(
      String cliId, String reason) async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "mast_id": userId,
        "cli_ids": cliId,
        "reason": reason,
        "next_period": "2"
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.confirmCancelServiceUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///check complete task service
  Future<ApiResponse> getCheckCompletedTaskService(
      String id, String status) async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "mast_id": userId, "id": id, "status": status},
    );
    final response = await apiClient.post(
      ApiEndpoint.checkCompletedTaskServiceUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///update task service
  Future<ApiResponse> getUpdateTaskService(
      String id, String status, String statusName, String remark) async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "mast_id": userId,
        "id": id,
        "status": status,
        "statusname": statusName,
        "remark": remark
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.updateServiceStatusUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///update task status
  Future<ApiResponse> getUpdateTaskStatus(String assignId, String id,
      String statusId, String status, String remark, String taskName) async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "mast_id": userId,
        "assign_id": assignId,
        "id": id,
        "status_id": statusId,
        "status": status,
        "remark": remark,
        "task_name": taskName
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.updateServiceTaskStatusUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///reassign services
  Future<ApiResponse> getReassignServices(
      String taskName,
      String id,
      String completion,
      String days,
      String hours,
      String mins,
      String emp,
      String taskID,
      String srno) async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "mast_id": userId,
        "task_name": taskName,
        "id": id,
        "completion": completion,
        "days": days,
        "hours": hours,
        "mins": mins,
        "emp": emp,
        "taskID": taskID,
        "srno": srno
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.reassignServicesUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///reassign triggered not allotted
  Future<ApiResponse> getReassignTriggeredNotAllotted(
      String taskName,
      String id,
      String completion,
      String days,
      String hours,
      String mins,
      String emp,
      String taskID,
      String srno,
      String priority,
      String applyPeriod) async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "mast_id": userId,
        "id": id,
        "task_name": taskName,
        "completion": completion,
        "days": days,
        "hours": hours,
        "mins": mins,
        "emp": emp,
        "taskID": taskID,
        "srno": srno,
        "priority": priority,
        "apply_period": applyPeriod
      },
    );
    final response = await apiClient.post(
      ApiEndpoint.reassignTriggeredNotAllottedUrl,
      body: formData,
      headers: headers,
    );
    return ApiResponse.fromJson(response);
  }

  ///main category list
  Future<MainCategoryModel> getMainCategoryList() async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
      },
    );
    final response = await apiClient.post(ApiEndpoint.mainCategoryUrl,
        body: formData, headers: headers);
    return MainCategoryModel.fromJson(response);
  }

  ///services from main category
  Future<ServicesFromMainCategoryModel> getServicesFromMainCategoryList(
      String mainCategoryId) async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "main_category_id": mainCategoryId},
    );
    final response = await apiClient.post(
        ApiEndpoint.servicesFromMainCategoryUrl,
        body: formData,
        headers: headers);
    return ServicesFromMainCategoryModel.fromJson(response);
  }

  ///tasks list
  Future<ManualAssignmentTaskModel> getManualAssignmentTaskList(
      String serviceId) async {
    final FormData formData = FormData.fromMap(
      {"firm_id": firmId, "service_id": serviceId},
    );
    final response = await apiClient.post(ApiEndpoint.taskListUrl,
        body: formData, headers: headers);
    return ManualAssignmentTaskModel.fromJson(response);
  }

  ///manual assignment
  Future<ApiResponse> getManualAssignment(
      String completionList,
      String taskNameList,
      String daysList,
      String hrList,
      String minList,
      String empIdList,
      String taskIdList,
      String srList,
      String priority,
      String selectedYearId,
      String selectedYear,
      String mainCategoryId,
      String serviceId,
      String clientId,
      String triggerDate,
      String targetDate,
      String fees,
      String remark) async {
    final FormData formData = FormData.fromMap(
      {
        "firm_id": firmId,
        "mast_id": userId,
        "completion": completionList,
        "task_name": taskNameList,
        "days": daysList,
        "hours": hrList,
        "mins": minList,
        "emp": empIdList,
        "task_id": taskIdList,
        "srno": srList,
        "priority": priority,
        "year_id": selectedYearId,
        "year": selectedYear,
        "main_category_id": mainCategoryId,
        "service_id": serviceId,
        "client_id": clientId,
        "trigger_date": triggerDate,
        "target_date": targetDate,
        "fees": fees,
        "remark": remark
      },
    );
    final response = await apiClient.post(ApiEndpoint.manualAssignmentUrl,
        body: formData, headers: headers);
    return ApiResponse.fromJson(response);
  }
}
