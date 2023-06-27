import 'package:biznew/screens/attendance/attendance_binding.dart';
import 'package:biznew/screens/attendance/attendance_screen.dart';
import 'package:biznew/screens/bottom_nav/bottom_nav_binding.dart';
import 'package:biznew/screens/bottom_nav/bottom_navigation_screen.dart';
import 'package:biznew/screens/calender/caledner_binding.dart';
import 'package:biznew/screens/calender/calendar_demo.dart';
import 'package:biznew/screens/calender/calender_meeting_data.dart';
import 'package:biznew/screens/calender/calender_screen.dart';
import 'package:biznew/screens/claim_form/claim_binding.dart';
import 'package:biznew/screens/claim_form/claim_details.dart';
import 'package:biznew/screens/claim_form/claim_form.dart';
import 'package:biznew/screens/claim_form/claim_list.dart';
import 'package:biznew/screens/claim_form/export_poc.dart';
import 'package:biznew/screens/claim_form/webview_screen.dart';
import 'package:biznew/screens/dashboard/client/client_binding.dart';
import 'package:biznew/screens/dashboard/client/client_dashboard.dart';
import 'package:biznew/screens/dashboard/employee/employee_binding.dart';
import 'package:biznew/screens/dashboard/employee/employee_dashboard.dart';
import 'package:biznew/screens/dashboard/notification_list_screen.dart';
import 'package:biznew/screens/dashboard/service_dashboard_all.dart';
import 'package:biznew/screens/dashboard/service_dashboard.dart';
import 'package:biznew/screens/dashboard/dashboard_binding.dart';
import 'package:biznew/screens/dashboard/service_dashboard_next_demo.dart';
import 'package:biznew/screens/dashboard/service_dashboard_next_details.dart';
import 'package:biznew/screens/dashboard/service_dashboard_next_other.dart';
import 'package:biznew/screens/dashboard/service_dashboard_next_view.dart';
import 'package:biznew/screens/dashboard/started_not_completed_task_view.dart';
import 'package:biznew/screens/dashboard/triggered_not_allotted_load_all.dart';
import 'package:biznew/screens/dashboard/triggered_not_allotted_pie_chart_list.dart';
import 'package:biznew/screens/home/home_binding.dart';
import 'package:biznew/screens/home/home_screen.dart';
import 'package:biznew/screens/leave_form/leave_binding.dart';
import 'package:biznew/screens/leave_form/leave_details.dart';
import 'package:biznew/screens/leave_form/leave_list.dart';
import 'package:biznew/screens/leave_form/leave_screen.dart';
import 'package:biznew/screens/login/forgot_password.dart';
import 'package:biznew/screens/login/login_binding.dart';
import 'package:biznew/screens/login/login_screen.dart';
import 'package:biznew/screens/common/splash_screen.dart';
import 'package:biznew/screens/manual_assignment/manual_assignment_binding.dart';
import 'package:biznew/screens/manual_assignment/manual_assignment_screen.dart';
import 'package:biznew/screens/petty_task/petty_task_binding.dart';
import 'package:biznew/screens/petty_task/petty_task_client_form.dart';
import 'package:biznew/screens/petty_task/petty_task_form.dart';
import 'package:biznew/screens/timesheet_form/timesheet_binding.dart';
import 'package:biznew/screens/timesheet_form/timesheet_details.dart';
import 'package:biznew/screens/timesheet_form/timesheet_form.dart';
import 'package:biznew/screens/timesheet_form/timesheet_list.dart';
import 'package:biznew/screens/timesheet_new/timesheet_new.dart';
import 'package:biznew/screens/timesheet_new/timesheet_new_binding.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
part 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.defaultRoute;

  static final all = [
    GetPage(
      name: AppRoutes.defaultRoute,
      page: () => const SplashScreen(),
    ),

    ///user basics
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.bottomNav,
      page: () => const BottomNavigationScreen(),
      bindings: [
        BottomNavBinding(),
        TimesheetNewFormBinding(),
        ClaimFormBinding(),
        LeaveBinding(),
        DashboardBinding(),
        HomeBinding(),
        EmployeeBinding(),
        ClientBinding()
      ],
    ),

    ///home module
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.notificationScreen,
      page: () => const NotificationScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.serviceDashboard,
      page: () => const ServiceDashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.serviceDashboard,
      page: () => const ServiceDashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.serviceDashboardNext,
      page: () => const ServiceDashboardNextScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.serviceDashboardNextOther,
      page: () => const ServiceDashboardNextOther(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.serviceDashboardNextDetails,
      page: () => const ServiceDashboardNextDetails(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.serviceNextViewScreen,
      page: () => const ServiceNextViewScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.startedNotCompletedViewScreen,
      page: () => const StartedNotCompletedTaskViewScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.serviceCancelAll,
      page: () => const ServiceCancelAll(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.triggeredNotAllottedPieChartList,
      page: () => const TriggeredNotAllottedPieChartList(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.triggeredNotAllottedLoadAll,
      page: () => const TriggeredNotAllottedLoadAll(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.claimList,
      page: () => const ClaimList(),
      binding: ClaimFormBinding(),
    ),
    GetPage(
      name: AppRoutes.claimDetails,
      page: () => const ClaimDetailsScreen(),
      binding: ClaimFormBinding(),
    ),
    GetPage(
      name: AppRoutes.claimForm,
      page: () => const ClaimForm(),
      binding: ClaimFormBinding(),
    ),
    GetPage(
      name: AppRoutes.webViewScreen,
      page: () => const WebViewScreen(),
      binding: ClaimFormBinding(),
    ),
    GetPage(
      name: AppRoutes.exportScreen,
      page: () => const ExportScreen(),
      binding: ClaimFormBinding(),
    ),
    GetPage(
      name: AppRoutes.leaveList,
      page: () => const LeaveList(),
      binding: LeaveBinding(),
    ),
    GetPage(
      name: AppRoutes.leaveDetails,
      page: () => const LeaveDetailsScreen(),
      binding: LeaveBinding(),
    ),
    GetPage(
      name: AppRoutes.leaveForm,
      page: () => const LeaveForm(),
      binding: LeaveBinding(),
    ),
    GetPage(
      name: AppRoutes.timesheetList,
      page: () => const TimesheetList(),
      binding: TimesheetFormBinding(),
    ),
    GetPage(
      name: AppRoutes.timesheetDetails,
      page: () => const TimesheetDetailsScreen(),
      binding: TimesheetFormBinding(),
    ),
    GetPage(
      name: AppRoutes.timesheetForm,
      page: () => const TimesheetForm(),
      binding: TimesheetFormBinding(),
    ),
    GetPage(
      name: AppRoutes.timesheetNewForm,
      page: () => const TimesheetNewForm(),
      binding: TimesheetNewFormBinding(),
    ),
    GetPage(
      name: AppRoutes.pettyTaskFrom,
      page: () => const PettyTaskForm(),
      binding: PettyTaskBinding(),
    ),
    GetPage(
      name: AppRoutes.pettyTaskClientFrom,
      page: () => const PettyTaskClientForm(),
      binding: PettyTaskBinding(),
    ),
    GetPage(
      name: AppRoutes.manualAssignmentScreen,
      page: () => const ManualAssignmentScreen(),
      binding: ManualAssignmentBinding(),
    ),
    GetPage(
      name: AppRoutes.calenderScreen,
      page: () => const CalenderScreen(),
      binding: CalenderBinding(),
    ),
    GetPage(
      name: AppRoutes.calenderDemoScreen,
      page: () => const TableEventsExample(),
      binding: CalenderBinding(),
    ),
    GetPage(
      name: AppRoutes.calenderMeetingData,
      page: () => const CalenderMeetingData(),
      binding: CalenderBinding(),
    ),
    GetPage(
      name: AppRoutes.clientDashboard,
      page: () => const ClientDashboard(),
      binding: ClientBinding(),
    ),
    GetPage(
      name: AppRoutes.employeeDashboard,
      page: () => const EmployeeDashboardScreen(),
      binding: EmployeeBinding(),
    ),
    GetPage(
      name: AppRoutes.attendanceScreen,
      page: () => const AttendanceScreen(),
      binding: AttendanceBinding(),
    ),
  ];
}
