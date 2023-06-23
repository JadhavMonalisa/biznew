import 'package:biznew/common_widget/error_text.dart';
import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/constant/assets.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/login/login_controller.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';

class ForgotPasswordScreen extends StatefulWidget {

  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await Get.toNamed(AppRoutes.login);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent, resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              ///main bg color container
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(color: primaryColor,),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300.0,
                  decoration: const BoxDecoration(borderRadius: BorderRadius.only(bottomRight:Radius.circular(25.0),bottomLeft: Radius.circular(25.0)),
                    color: Colors.white54,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(120.0),
                    child: Image.asset(Assets.splashLogo,fit: BoxFit.fill),
                  )
              ),
              ///card container
              Positioned(
                top: MediaQuery.of(context).size.height * 0.25,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                        elevation: 5, color: whiteColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                        child: GetBuilder<LoginController>(builder: (loginController)
                        {
                          return ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 30.0),
                            children: [
                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: buildTextMediumWidget(
                                        "Forgot Password", Colors.indigo, context, 26),
                                  ),
                                  const SizedBox(height: 20,),

                                  ///email address
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 3.0),
                                        child: buildTextRegularWidget(
                                          "Email", titleTextColor, context, 14,),
                                      ),
                                      const SizedBox(height: 10,),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                                          color: textFormBgColor,
                                          border: Border.all(color: textFormBgColor),),
                                        child: TextFormField(
                                          controller: loginController.forgotEmailController,
                                          obscureText: false,
                                          keyboardType: TextInputType.emailAddress,
                                          textAlign: TextAlign.left,
                                          textAlignVertical: TextAlignVertical.center,
                                          textInputAction: TextInputAction.done,
                                          onTap: () {},
                                          style:const TextStyle(fontSize: 15.0),
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            hintText: "Email",
                                            hintStyle: TextStyle(fontSize: 15.0),
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.only(top: 2),
                                              child: Icon(Icons.email),
                                            ),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                          ),
                                          onChanged: (text) {
                                            loginController.checkForgetEmailValidation(context);
                                          },
                                        ),
                                      ),
                                      loginController.validateForgetEmail == true
                                          ? ErrorText(
                                        errorMessage: "Please enter valid email address",)
                                          : const Opacity(opacity: 0.0),
                                    ],
                                  ),
                                  const SizedBox(height: 15,),

                                  GestureDetector(
                                    onTap: () {
                                      loginController.checkForgetPasswordValidation(context);
                                    },
                                    child: buildButtonWidget(context, "Submit"),
                                  ),
                                  const SizedBox(height: 30,),
                                ],
                              )
                            ],
                          );
                        })
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
