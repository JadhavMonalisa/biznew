
import 'package:biznew/constant/provider/api.dart';
import 'package:biznew/screens/timesheet_form/timesheet_controller.dart';
import 'package:get/get.dart';
import '../../constant/repository/api_repository.dart';

class TimesheetFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TimesheetFormController(repository: ApiRepository(apiClient: ApiClient())));
  }
}
