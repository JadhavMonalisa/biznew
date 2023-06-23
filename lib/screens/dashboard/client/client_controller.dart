import 'package:biznew/constant/provider/custom_exception.dart';
import 'package:biznew/constant/repository/api_repository.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/dashboard/client/client_dashboard_model.dart';
import 'package:biznew/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientDashboardController extends GetxController {
  final ApiRepository repository;

  // ignore: unnecessary_null_comparison
  ClientDashboardController({required this.repository}) : assert(repository != null);

  String userId="";
  String userName="";
  String name="";
  String reportingHead="";
  String roleId="";
  String userType="";
  bool loader = false;

  List<ClientDashboardList> clientDashboardListData = [];
  bool isExpanded = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    userId = GetStorage().read("userId")??"";
    userName = GetStorage().read("userName")??"";
    name = GetStorage().read("name")??"";
    reportingHead = GetStorage().read("reportingHead")??"";
    roleId = GetStorage().read("roleId")??"";
    userType = GetStorage().read("userType")??"";
    repository.getData();

    callClientDashboardList();
  }

  onWillPopBack(){
    Get.offNamedUntil(AppRoutes.bottomNav, (route) => false);
    update();
  }

  updateLoader(bool val) { loader = val; update(); }

  callLogout(){
    Utils.showLoadingDialog();
    GetStorage().remove("userId");
    GetStorage().remove("userName");
    GetStorage().remove("name");
    GetStorage().remove("firmId");
    GetStorage().erase();
    Utils.showSuccessSnackBar("Logout Successfully!");
    Utils.dismissLoadingDialog();
    Get.offNamedUntil(AppRoutes.login, (route) => false);
    update();
  }

  void callClientDashboardList() async {
    clientDashboardListData.clear();

    try {
      updateLoader(true);
      ClientDashboardModel? response = await repository.getClientDashboardList();

      if (response.success!) {
        if (response.clientDashboardList!.isEmpty) {
        }
        else{
          clientDashboardListData.addAll(response.clientDashboardList!);
        }

        updateLoader(false);
        update();
      } else {
        updateLoader(false);
        update();
      }
    } on CustomException {
      updateLoader(false);
      update();
    } catch (error) {
      updateLoader(false);
      update();
    }
  }

  List<int> addedIndex = [];

  onExpanded(bool expanded,int index){
    isExpanded = expanded;

    if(addedIndex.contains(index)){
      addedIndex.remove(index);
      update();
    }
    else{
      addedIndex.add(index);
      update();
    }
    update();
  }
}