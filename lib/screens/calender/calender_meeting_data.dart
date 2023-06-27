import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/screens/calender/calender_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalenderMeetingData extends StatefulWidget {
  const CalenderMeetingData({Key? key}) : super(key: key);

  @override
  State<CalenderMeetingData> createState() => _CalenderMeetingDataState();
}

class _CalenderMeetingDataState extends State<CalenderMeetingData> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalenderViewController>(builder: (cont) {
      return WillPopScope(
          onWillPop: () async {
            // cont.dueDateList.clear();cont.calenderDataList.clear();
            // return await Get.toNamed(AppRoutes.calenderScreen);
            return await cont.navigateToCalenderScreen();
          },
          child: Scaffold(
              backgroundColor: whiteColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: primaryColor,
                centerTitle: true,
                title: buildTextMediumWidget(
                    cont.typeToSendApi == "OwnCount"
                        ? "Own Due Data"
                        : cont.typeToSendApi == "TeamCount"
                            ? "Team Due Data"
                            : cont.typeToSendApi == "Holiday"
                                ? "Holiday Due Data"
                                : "Appointment Due Data",
                    whiteColor,
                    context,
                    16,
                    align: TextAlign.center),
              ),
              body: cont.isLoading == true
                  ? Center(
                      child: buildCircularIndicator(),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: buildTextBoldWidget(
                                    "Statutory Due Date for ${cont.dateOnDueDataScreen.day}/${cont.dateOnDueDataScreen.month}/${cont.dateOnDueDataScreen.year}",
                                    primaryColor,
                                    context,
                                    14.0),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: cont.dueDateList.length,
                                  itemBuilder: (context, index) {
                                    final item = cont.dueDateList[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                        elevation: 1.0,
                                        color: faintGrey,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            side:
                                                const BorderSide(color: grey)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    height: 40.0,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: blackColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      7.0),
                                                            )),
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0,
                                                                  right: 10.0),
                                                          child: buildTextBoldWidget(
                                                              item.clientCode!,
                                                              whiteColor,
                                                              context,
                                                              14.0),
                                                        ))),
                                                Flexible(
                                                  child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 40.0,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: grey),
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          7.0))),
                                                      child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0),
                                                            child: buildTextBoldWidget(
                                                                item.client!,
                                                                blackColor,
                                                                context,
                                                                14.0,
                                                                align: TextAlign
                                                                    .left),
                                                          ))),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: buildTextRegularWidget(
                                                  "${item.service} triggered on ${item.triggerDate} and ending on ${item.targetDate}",
                                                  blackColor,
                                                  context,
                                                  14.0,
                                                  align: TextAlign.left),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  right: 10.0,
                                                  top: 10.0),
                                              child: Row(
                                                children: [
                                                  buildTextBoldWidget(
                                                      item.status!,
                                                      item.status == "Inprocess"
                                                          ? Colors.green
                                                          : Colors.red,
                                                      context,
                                                      14.0),
                                                  const Spacer(),
                                                  buildTextBoldWidget(
                                                      item.priority!,
                                                      item.priority == "High"
                                                          ? errorColor
                                                          : item.priority ==
                                                                  "Medium"
                                                              ? Colors.orange
                                                              : approveColor,
                                                      context,
                                                      14.0),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10.0,
                                                    top: 10.0),
                                                child: Row(
                                                  children: [
                                                    buildTextBoldWidget(
                                                        "Completion - ",
                                                        blackColor,
                                                        context,
                                                        14.0),
                                                    buildTextRegularWidget(
                                                        "${item.completion}  |  ${item.total} %",
                                                        blackColor,
                                                        context,
                                                        14.0),
                                                  ],
                                                )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  right: 10.0,
                                                  top: 10.0,
                                                  bottom: 20.0),
                                              child: buildRichTextWidget(
                                                  "Assigned to - ",
                                                  "${item.name}"),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          )))));
    });
  }
}
