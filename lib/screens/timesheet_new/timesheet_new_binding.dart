import 'package:biznew/constant/provider/api.dart';
import 'package:biznew/screens/timesheet_new/timesheet_new_controller.dart';
import 'package:get/get.dart';
import '../../constant/repository/api_repository.dart';

class TimesheetNewFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TimesheetNewFormController(
        repository: ApiRepository(apiClient: ApiClient())));
  }
}
