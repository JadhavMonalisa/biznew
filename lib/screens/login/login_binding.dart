
import 'package:biznew/constant/provider/api.dart';
import 'package:get/get.dart';
import '../../constant/repository/api_repository.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(repository: ApiRepository(apiClient: ApiClient())));
  }
}
