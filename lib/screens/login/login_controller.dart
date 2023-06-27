import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../constant/provider/custom_exception.dart';
import '../../constant/repository/api_repository.dart';
import '../../routes/app_pages.dart';
import '../../utils/custom_response.dart';
import '../../utils/utils.dart';

class LoginController extends GetxController {
  final ApiRepository repository;

  // ignore: unnecessary_null_comparison
  LoginController({required this.repository}) : assert(repository != null);

  ///login screen
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  String loginEmail = "";
  String loginPass = "";
  bool validateLoginEmail = false, validateLoginPassword = false;
  //show password
  bool showPass = true;
  String patternEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp? regExpEmail;

  ///forget password
  TextEditingController forgotEmailController = TextEditingController();
  String forgotEmail = "";
  bool validateForgetEmail = false;

  ///Reset password
  TextEditingController resetPassController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String resetPass = "";
  String confirmPass = "";
  //show password
  bool showResetPass = true;
  bool showResetConfirmPass = true;
  bool validateResetPass = false,
      validateResetConfirmPass = false,
      validateResetBothPass = false;

  bool noData = false;
  bool loader = false;
  updateLoader(bool val) {
    loader = val;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    regExpEmail = RegExp(patternEmail);
  }

  ///Login Screen--------------------------------------------------
  //show/hide pass
  void onPassChange() {
    showPass = !showPass;
    update();
  }

  //values for login controller
  void addEmailId(dynamic value) {
    loginEmail = value;
    update();
  }

  void addPassword(dynamic value) {
    loginPass = value;
    update();
  }

  //validation for each textFormField
  checkLoginEmailValidation(BuildContext context) {
    if (loginEmailController.text.isEmpty) {
      validateLoginEmail = true;
      update();
    } else {
      validateLoginEmail = false;
      update();
    }
  }

  checkLoginPassValidation(BuildContext context) {
    if (loginPasswordController.text.isEmpty) {
      validateLoginPassword = true;
      update();
    } else {
      validateLoginPassword = false;
      update();
    }
  }

  //main validation on submit button
  checkLoginValidation(BuildContext context) {
    if (loginEmailController.text.isEmpty ||
        loginPasswordController.text.isEmpty) {
      loginEmailController.text.isEmpty
          ? validateLoginEmail = true
          : validateLoginEmail = false;
      loginPasswordController.text.isEmpty
          ? validateLoginPassword = true
          : validateLoginPassword = false;
      update();
    } else {
      addLoginApi(context);
    }
    update();
  }

  ///Forget Password---------------------------------------------------------------
  //values for forgot controller
  void addForgotEmailId(dynamic value) {
    forgotEmail = value;
    update();
  }

  //validation for each textFormField
  checkForgetEmailValidation(BuildContext context) {
    if (forgotEmailController.text.isEmpty) {
      validateForgetEmail = true;
      update();
    } else {
      validateForgetEmail = false;
      update();
    }
  }

  //main validation on submit button
  checkForgetPasswordValidation(BuildContext context) {
    if (forgotEmailController.text.isEmpty) {
      forgotEmailController.text.isEmpty
          ? validateForgetEmail = true
          : validateForgetEmail = false;
      update();
    } else {
      addForgetPasswordApi(context);
    }
    update();
  }

  ///add login api-----------------------------
  void addLoginApi(BuildContext context) async {
    try {
      Utils.dismissKeyboard();
      Utils.showLoadingDialog();
      LoginResponse? response = (await repository.doLogin(
        type: "login",
        username: loginEmail,
        password: loginPass,
      ));
      Utils.dismissLoadingDialog();
      if (response.success == true) {
        GetStorage().erase();
        GetStorage().write('userId', response.userDetails![0].id);
        GetStorage().write('userName', response.userDetails![0].username);
        GetStorage().write('name', response.userDetails![0].name);
        GetStorage().write('firmId', response.userDetails![0].firmId);
        GetStorage().write('userType', response.userDetails![0].userType);
        GetStorage().write('reportingHead', response.isReportingHead);
        GetStorage().write('roleId', response.roleId);
        Utils.showSuccessSnackBar(response.message);
        loginEmailController.clear();
        loginPasswordController.clear();
        repository.getData();
        addAccessRightApi();
        Get.toNamed(AppRoutes.bottomNav);
        update();
      } else {
        Utils.dismissLoadingDialog();
        //Utils.showErrorSnackBar("Invalid username or password"); update();
        Utils.showErrorSnackBar(response.message);
        update();
      }
    } on CustomException catch (e) {
      Utils.dismissLoadingDialog();
      Utils.showErrorSnackBar(e.getMsg().toString());
      update();
    } catch (error) {
      Utils.dismissLoadingDialog();
      Utils.showErrorSnackBar("Invalid username or password");
      update();
    }
  }

  /// add forgot password
  void addForgetPasswordApi(BuildContext context) async {
    try {
      Utils.dismissKeyboard();
      Utils.showLoadingDialog();
      ApiResponse? response =
          (await repository.doForgotPassword(forgotEmailController.text));
      Utils.dismissLoadingDialog();
      if (response.success == true) {
        Utils.dismissLoadingDialog();
        Utils.showErrorSnackBar(response.message);
        update();
      } else {
        Utils.dismissLoadingDialog();
        Utils.showErrorSnackBar(response.message);
        update();
      }
    } on CustomException catch (e) {
      Utils.dismissLoadingDialog();
      Utils.showErrorSnackBar(e.getMsg().toString());
      update();
    } catch (error) {
      Utils.dismissLoadingDialog();
      Utils.showErrorSnackBar("Something went wrong");
      update();
    }
  }

  ///access right api
  void addAccessRightApi() async {
    try {
      AccessRightResponse? response = (await repository.getAccessList());

      Utils.dismissLoadingDialog();
      if (response.success == true) {
        for (var element in response.accessRightDetails!) {
          if (element.moduleName == "Own Service Status") {
            //String statusValue = element.addAccess == "Y" ? "Y" : "N";
            GetStorage().write("OwnServiceStatus", element.addAccess);
          }
        }

        update();
      } else {
        //Utils.dismissLoadingDialog();
        //Utils.showErrorSnackBar("Invalid username or password"); update();
        //Utils.showErrorSnackBar(response.message); update();
      }
    } on CustomException catch (e) {
      // Utils.dismissLoadingDialog();
      // Utils.showErrorSnackBar(e.getMsg().toString());update();
    } catch (error) {
      // Utils.dismissLoadingDialog();
      // Utils.showErrorSnackBar("Invalid username or password"); update();
    }
  }
}
