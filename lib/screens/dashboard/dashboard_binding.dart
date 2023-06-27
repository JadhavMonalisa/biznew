import 'package:biznew/constant/provider/api.dart';
import 'package:biznew/screens/dashboard/dashboard_controller.dart';
import 'package:get/get.dart';
import '../../constant/repository/api_repository.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
        DashboardController(repository: ApiRepository(apiClient: ApiClient())));
  }
}
