import 'package:biznew/constant/provider/api.dart';
import 'package:biznew/screens/manual_assignment/manual_assignment_controller.dart';
import 'package:get/get.dart';
import '../../constant/repository/api_repository.dart';

class ManualAssignmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ManualAssignmentController(
        repository: ApiRepository(apiClient: ApiClient())));
  }
}
