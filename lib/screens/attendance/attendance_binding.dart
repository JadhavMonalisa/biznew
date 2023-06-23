
import 'package:biznew/constant/provider/api.dart';
import 'package:biznew/screens/attendance/attendance_controller.dart';
import 'package:get/get.dart';
import '../../constant/repository/api_repository.dart';

class AttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AttendanceController(repository: ApiRepository(apiClient: ApiClient())));
  }
}
