import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/screens/leave_form/leave_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveDetailsScreen extends StatefulWidget {
  const LeaveDetailsScreen({Key? key}) : super(key: key);

  @override
  State<LeaveDetailsScreen> createState() => _LeaveDetailsScreenState();
}

class _LeaveDetailsScreenState extends State<LeaveDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeaveController>(builder: (cont) {
      return WillPopScope(
          onWillPop: () async {
            return cont.onBackPressToLeaveList();
          },
          child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 0.0,
                title: buildTextMediumWidget(
                    "Leave Details", whiteColor, context, 16,
                    align: TextAlign.center),
                leading: GestureDetector(
                  onTap: () {
                    cont.onBackPressToLeaveList();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: whiteColor,
                  ),
                ),
              ),
              body: cont.loader == true
                  ? Center(
                      child: buildCircularIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: cont.leaveEditList.length,
                              itemBuilder: (context, index) {
                                final item = cont.leaveEditList[0];
                                return Card(
                                  elevation: 1.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        buildTextBoldWidget(
                                            item.firmEmployeeName!,
                                            blackColor,
                                            context,
                                            14.0),
                                        const Divider(
                                          color: primaryColor,
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        buildRichTextWidget("Leave Status - ",
                                            item.leaveStatus!,
                                            title1Weight: FontWeight.normal,
                                            title2Weight: FontWeight.bold),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        buildTextRegularWidget("Updated On",
                                            blackColor, context, 14.0),
                                        buildTextBoldWidget(item.modifiedOn!,
                                            blackColor, context, 14.0),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        buildTextRegularWidget("Leave type",
                                            blackColor, context, 14.0),
                                        buildTextBoldWidget(item.leaveTypeName!,
                                            blackColor, context, 14.0),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        buildTextRegularWidget("Reason",
                                            blackColor, context, 14.0),
                                        buildTextBoldWidget(item.reason!,
                                            blackColor, context, 14.0),
                                        const Divider(
                                          color: primaryColor,
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Table(
                                          children: [
                                            buildTableTitle(context,
                                                title1: "Start Date",
                                                title2: "End Date",
                                                title3: "Days",
                                                fontSize: 14.0),
                                            buildContentSubTitle(context,
                                                contentTitle1:
                                                    item.startDateToShow!,
                                                contentTitle2:
                                                    item.endDateToShow!,
                                                contentTitle3: item.totalDays!,
                                                fontSize: 14.0),
                                            const TableRow(
                                              children: [
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                    )));
    });
  }
}
