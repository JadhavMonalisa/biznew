import 'package:biznew/constant/provider/api.dart';
import 'package:biznew/constant/repository/api_repository.dart';
import 'package:biznew/screens/dashboard/employee/employee_controller.dart';
import 'package:get/get.dart';

class EmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EmployeeDashboardController(
        repository: ApiRepository(apiClient: ApiClient())));
  }
}
