import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/claim_form/claim_form_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  double progress = 0;
  double loadingContainerHeight = 5;
  bool isLoading = true;
  final _key = UniqueKey();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClaimFormController>(builder: (cont)
    {
    return WillPopScope(
      onWillPop:() async{
       return await Get.toNamed(AppRoutes.claimDetails);
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          centerTitle: true,elevation: 0.0,
          title: buildTextMediumWidget("Claim file", whiteColor,context, 16,align: TextAlign.center),
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * progress,
                  height: loadingContainerHeight,
                  color: primaryColor
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * (2 / 3),
                    child: WebView(
                      key: _key,
                      //initialUrl: cont.claimFileToShow,
                      initialUrl: "https://www.africau.edu/images/default/sample.pdf",
                      //initialUrl: "https://dev.bizalys.com/firm/uploads/124_29_11_2021/claim/cl_17_01_2023_1673961945_dummy.pdf",
                      javascriptMode: JavascriptMode.unrestricted,
                      onPageFinished: (finish){
                        setState(() {
                          isLoading=false;
                        });
                      },
                      onProgress: (int progress) {
                        setState(() {
                          this.progress = progress/100;
                          if(progress == 100){
                            loadingContainerHeight = 0;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            isLoading ? const Center(child: CircularProgressIndicator(),):Stack(),
          ],
        ),
      ),
    );
    });
  }
}
