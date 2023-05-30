import 'package:biznew/constant/provider/api.dart';
import 'package:biznew/constant/repository/api_repository.dart';
import 'package:biznew/screens/dashboard/client/client_controller.dart';
import 'package:get/get.dart';

class ClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ClientDashboardController(repository: ApiRepository(apiClient: ApiClient())));
  }
}
