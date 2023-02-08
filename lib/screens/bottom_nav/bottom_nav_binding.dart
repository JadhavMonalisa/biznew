
import 'package:biznew/constant/provider/api.dart';
import 'package:get/get.dart';
import '../../constant/repository/api_repository.dart';
import 'bottom_nav_controller.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController(repository: ApiRepository(apiClient: ApiClient())));
  }
}