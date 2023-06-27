import 'package:biznew/constant/provider/api.dart';
import 'package:biznew/screens/calender/calender_controller.dart';
import 'package:get/get.dart';
import '../../constant/repository/api_repository.dart';

class CalenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CalenderViewController(
        repository: ApiRepository(apiClient: ApiClient())));
  }
}
