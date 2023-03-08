import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/screens/dashboard/dashboard_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont)
    {
      return Scaffold(
        appBar: AppBar(
          title: buildTextRegularWidget("Notification", whiteColor, context, 16.0),
        ),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:
            cont.notificationListData.isEmpty ? buildNoDataFound(context):
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: cont.notificationListData.length,
                  itemBuilder: (context,index){
                    final item = cont.notificationListData[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child:buildTextRegularWidget(item.addedDate!, approveColor, context, 15.0),
                          ),
                          const SizedBox(height:5.0),
                          buildRichTextWidget("Title : ", item.mtitle!),
                          const SizedBox(height:5.0),
                          buildRichTextWidget("Message : ", item.message!),
                        ],
                      ),
                    ),
                  );
              }),
            )
        ),
      );
    });
  }
}
