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
    return GetBuilder<DashboardController>(builder: (cont) {
      return Scaffold(
        appBar: AppBar(
          title:
              buildTextRegularWidget("Notification", whiteColor, context, 16.0),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  cont.callNotificationMarkAllRead();
                },
                child: buildButtonWidget(context, "Mark All Read",
                    width: 150.0,
                    buttonColor: whiteColor,
                    textColor: primaryColor),
              ),
            )
          ],
        ),
        body: cont.loader == true
            ? Center(
                child: buildCircularIndicator(),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: cont.notificationListData.isEmpty
                    ? buildNoDataFound(context)
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: cont.notificationListData.length,
                            itemBuilder: (context, index) {
                              final item = cont.notificationListData[index];
                              return Card(
                                color: (index % 2 == 0)
                                    ? notificationCardColor
                                    : whiteColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5.0),
                                      GestureDetector(
                                        onTap: () {
                                          cont.callNotificationMarkSelectedRead(
                                              item.id!);
                                        },
                                        child: const Align(
                                            alignment: Alignment.topRight,
                                            child: Icon(Icons.clear)),
                                      ),
                                      const SizedBox(height: 5.0),
                                      buildRichTextWidget(
                                          "${item.type} : ", item.message!),
                                      const SizedBox(height: 5.0),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )),
      );
    });
  }
}
