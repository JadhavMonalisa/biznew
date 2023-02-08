class ApiEndpoint {
  static const String baseUrl = "https://dev.bizalys.com/api";
  //static const String baseUrl = "https://bizalys.com/api";
  static const String imageBaseUrl = "";

  ///Basic User
  //static const String loginUrl = "https://dev.bizalys.com/api/login.php";
  static const String loginUrl = "$baseUrl/apiController/login";

  ///Claim
  static const String claimTypeListUrl = "$baseUrl/ClaimController/claimtype";
  static const String clientNameListUrl = "$baseUrl/apiController/clientlist";
  static const String claimYearListUrl = "$baseUrl/apiController/yearlist";
  static const String claimSubmittedByListUrl = "$baseUrl/ApiController/employee_list";
  static const String claimServicesListUrl = "$baseUrl/ApiController/services";
  static const String claimTaskListUrl = "$baseUrl/ApiController/tasks";
  static const String claimAddUrl = "$baseUrl/ClaimController/claimsave";
  static const String claimListUrl = "$baseUrl/ClaimController/claimlist";
  static const String claimEditUrl = "$baseUrl/ClaimController/claimedit";
  static const String claimUpdateUrl = "$baseUrl/ClaimController/claimupdate";
  static const String claimUpdateStatusUrl = "$baseUrl/ClaimController/claim_status_update";

  ///Leave
  static const String leaveCountUrl = "$baseUrl/LeaveController/leavetotalcount";
  static const String leaveTypeUrl = "$baseUrl/LeaveController/leavetype";
  static const String leaveAddUrl = "$baseUrl/LeaveController/leavesave";
  static const String leaveListUrl = "$baseUrl/LeaveController/leavelist";
  static const String leaveEditListUrl = "$baseUrl/LeaveController/leaveedit";
  static const String leaveUpdateListUrl = "$baseUrl/LeaveController/leaveupdate";
  static const String leaveUpdateStatusUrl = "$baseUrl/LeaveController/leave_status_update";

  ///Timesheet
  static const String timesheetActionUrl = "$baseUrl/TimesheetController/timesheet_status_update";
  ///stepper 1
  static const String timesheetCheckUrl = "$baseUrl/TimesheetController/check_timesheet_add";
  static const String timesheetAddUrl = "$baseUrl/TimesheetController/timesheet_add";
  ///stepper 2
  static const String timesheetTotalTimeUrl = "$baseUrl/TimesheetController/getTimesheetTotalHrs";
  static const String timesheetClientListUrl = "$baseUrl/TimesheetController/getAllottedServicesClients";
  static const String timesheetServicesListUrl = "$baseUrl/TimesheetController/getAllottedServices";
  static const String timesheetTaskListUrl = "$baseUrl/TimesheetController/getAllottedServicesTasks";
  static const String timesheetStatusListUrl = "$baseUrl/TimesheetController/timesheet_services_status";
  static const String timesheetStartStatusUrl = "$baseUrl/TimesheetController/service_status_start";
  static const String timesheetStatusUpdateUrl = "$baseUrl/TimesheetController/service_status_update";
  static const String timesheetAddAllottedUrl = "$baseUrl/TimesheetController/timesheet_add_allotted";
  static const String timesheetGetNonAllottedServicesUrl = "$baseUrl/TimesheetController/getNonAllottedServices";
  static const String timesheetGetNonAllottedTaskUrl = "$baseUrl/TimesheetController/getNonAllottedServicesTasks";
  static const String timesheetAddNonAllottedUrl = "$baseUrl/";
  static const String timesheetTypeOfWorkUrl = "$baseUrl/TimesheetController/get_type_of_work";
  static const String timesheetAddOfficeRelatedUrl = "$baseUrl/TimesheetController/timesheet_add_officerealted";
  static const String timesheetListUrl = "$baseUrl/TimesheetController/timesheetlist";
  static const String timesheetEditUrl = "$baseUrl/TimesheetController/timesheet_edit";
  static const String timesheetLogUrl = "$baseUrl/TimesheetController/timesheet_log";

  ///branch
  static const String branchNameListUrl = "$baseUrl/ApiController/firmbrachlist";
  static const String branchClientListUrl = "$baseUrl/ApiController/branchwiseclientlist";
  static const String branchEmpListUrl = "$baseUrl/ApiController/employee_list_branchwise";
  static const String addPettyTaskUrl = "$baseUrl/ApiController/save_petty_task";

  ///chart
  static const String ownPieChartUrl = "$baseUrl/DashboardController/own_piechart";
  static const String serviceTriggerButNotAllottedUrl = "$baseUrl/DashboardController/service_triggered_but_not_allotted_chart";
  static const String allottedNotStartedUrl = "$baseUrl/DashboardController/allotted_but_not_started_chart";
  static const String startedNotCompletedUrl = "$baseUrl/DashboardController/started_but_not_completed_chart";
  static const String completedUDINPendingUrl = "$baseUrl/DashboardController/completed_but_udin_pending_chart";
  static const String completedNotBilledUrl = "$baseUrl/DashboardController/completed_but_not_billed_chart";
  static const String workOnHoldUrl = "$baseUrl/DashboardController/workon_hold_chart";
  static const String submittedForCheckingUrl = "$baseUrl/DashboardController/submitted_for_checking_chart";
  static const String allTaskCompletedUrl = "$baseUrl/DashboardController/alltasks_complete_chart";

  ///service own & team next click

  ///allotted not started past due -> team,own
  static const String allottedNotStartedPastDueTeamUrl = "$baseUrl/ServicesController/allotted_but_not_started_pastdue_team";
  static const String allottedNotStartedPastDueOwnUrl = "$baseUrl/ServicesController/allotted_but_not_started_pastdue_own";
  ///allotted not started probable overdue -> team,own
  static const String allottedNotStartedProbableOverdueTeamUrl = "$baseUrl/ServicesController/allotted_but_not_started_probabledue_team";
  static const String allottedNotStartedProbableOverdueOwnUrl = "$baseUrl/ServicesController/allotted_but_not_started_probabledue_own";
  ///allotted not started high -> team,own
  static const String allottedNotStartedHighTeamUrl = "$baseUrl/ServicesController/allotted_but_not_started_high_team";
  static const String allottedNotStartedHighOwnUrl = "$baseUrl/ServicesController/allotted_but_not_started_high_own";
  ///allotted not started medium -> team,own
  static const String allottedNotStartedMediumTeamUrl = "$baseUrl/ServicesController/allotted_but_not_started_medium_team";
  static const String allottedNotStartedMediumOwnUrl = "$baseUrl/ServicesController/allotted_but_not_started_medium_own";
  ///allotted not started low -> team,own
  static const String allottedNotStartedLowTeamUrl = "$baseUrl/ServicesController/allotted_but_not_started_low_teamm";
  static const String allottedNotStartedLowOwnUrl = "$baseUrl/ServicesController/allotted_but_not_started_low_own";

  ///service action
  static const String startServiceUrl = "$baseUrl/ServicesController/start_service";
  static const String loadAllTaskUrl = "$baseUrl/ServicesController/load_all_tasks";
  static const String startTaskUrl = "$baseUrl/ServicesController/start_task";
  static const String checkPasswordUrl = "$baseUrl/ServicesController/check_password";
  static const String cancelCurrentPeriodServiceUrl = "$baseUrl/ServicesController/cancel_service";
  static const String confirmCancelServiceUrl = "$baseUrl/ServicesController/confirm_cancel_service";

  ///calender
  static const String calenderUrl = "$baseUrl/CalenderController/calender_data";
  static const String calenderDueDateUrl = "$baseUrl/CalenderController/date_detail";
}