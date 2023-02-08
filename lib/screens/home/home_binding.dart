
import 'package:biznew/constant/provider/api.dart';
import 'package:biznew/screens/home/home_controller.dart';
import 'package:get/get.dart';
import '../../constant/repository/api_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(repository: ApiRepository(apiClient: ApiClient())));
  }
}
