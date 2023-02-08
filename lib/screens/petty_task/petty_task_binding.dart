import 'package:biznew/constant/provider/api.dart';
import 'package:biznew/screens/petty_task/petty_task_controller.dart';
import 'package:get/get.dart';
import '../../constant/repository/api_repository.dart';

class PettyTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PettyTaskController(repository: ApiRepository(apiClient: ApiClient())));
  }
}
