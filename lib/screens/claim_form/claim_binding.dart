
import 'package:biznew/constant/provider/api.dart';
import 'package:biznew/screens/claim_form/claim_form_controller.dart';
import 'package:get/get.dart';
import '../../constant/repository/api_repository.dart';

class ClaimFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ClaimFormController(repository: ApiRepository(apiClient: ApiClient())));
  }
}
