import 'package:biznew/constant/provider/api.dart';
import 'package:biznew/screens/leave_form/leave_controller.dart';
import 'package:get/get.dart';
import '../../constant/repository/api_repository.dart';

class LeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LeaveController(repository: ApiRepository(apiClient: ApiClient())));
  }
}
