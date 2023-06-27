import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/dashboard/dashboard_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceNextViewScreen extends StatefulWidget {
  const ServiceNextViewScreen({Key? key}) : super(key: key);

  @override
  State<ServiceNextViewScreen> createState() => _ServiceNextViewScreenState();
}

class _ServiceNextViewScreenState extends State<ServiceNextViewScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont) {
      return WillPopScope(
          onWillPop: () async {
            return await Get.toNamed(AppRoutes.serviceDashboardNext);
          },
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: primaryColor,
              centerTitle: true,
              title: buildTextMediumWidget(
                  cont.selectedMainType == "AllottedNotStarted"
                      ? "Allotted but not started"
                      : cont.selectedMainType == "StartedNotCompleted"
                          ? "Started but not completed"
                          : cont.selectedMainType == "CompletedUdinPending"
                              ? "Completed but UDIN pending"
                              : cont.selectedMainType == "CompletedNotBilled"
                                  ? "Completed but not billed"
                                  : cont.selectedMainType == "WorkOnHold"
                                      ? "Work on hold"
                                      : cont.selectedMainType ==
                                              "SubmittedForChecking"
                                          ? "Submitted for checking"
                                          : "All Tasks",
                  whiteColor,
                  context,
                  16,
                  align: TextAlign.center),
            ),
            body: cont.loader == true
                ? Center(
                    child: buildCircularIndicator(),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0, left: 10.0, top: 10.0),
                            child: SizedBox(
                              height: 63.0,
                              child: Card(
                                elevation: 1.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    side: const BorderSide(color: grey)),
                                child: Row(
                                  children: [
                                    Container(
                                        decoration: const BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(7.0),
                                              bottomLeft: Radius.circular(7.0)),
                                        ),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, right: 10.0),
                                              child: buildTextBoldWidget(
                                                  cont.selectedClientCode,
                                                  whiteColor,
                                                  context,
                                                  14.0),
                                            ))),
                                    const SizedBox(width: 5.0),
                                    Flexible(
                                      child: buildTextBoldWidget(
                                          "${cont.selectedClientName} - ${cont.selectedServiceName}",
                                          blackColor,
                                          context,
                                          14.0,
                                          align: TextAlign.left),
                                    )
                                  ],
                                ),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 20.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cont.loadAllTaskList.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                final item = cont.loadAllTaskList[index];
                                return Card(
                                  elevation: 1.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      side: const BorderSide(color: grey)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        buildTextBoldWidget(
                                            "Task No ${index + 1} : Completion ${item.completion} %",
                                            blackColor,
                                            context,
                                            14.0),
                                        const Divider(
                                          color: grey,
                                        ),
                                        buildTextBoldWidget(item.taskName!,
                                            blackColor, context, 14.0),
                                        //buildTextRegularWidget("Completion in ${item.completion} %", blackColor, context, 14.0),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        // Container(
                                        //   width: MediaQuery.of(context).size.width/2,
                                        //   color: Colors.red,
                                        //   child: Row(
                                        //     crossAxisAlignment: CrossAxisAlignment.start,
                                        //     children: [
                                        //       // cont.selectedMainType == "StartedNotCompleted"
                                        //       //     ?buildRichTextWidget("Name of the staff - ", item.firmEmployeeName!)
                                        //       //     :buildRichTextWidget("Assigned to - ", item.firmEmployeeName!),
                                        //       //const Spacer(),
                                        //
                                        //      buildTextBoldWidget(cont.selectedMainType == "StartedNotCompleted"
                                        //          ?"Name of the staff - ":"Assigned to - ", blackColor, context, 14.0),
                                        //      buildTextRegularWidget(item.firmEmployeeName!, blackColor, context, 14.0),
                                        //
                                        //     buildTextBoldWidget(" Total : ", blackColor, context, 14.0),
                                        //     buildTextRegularWidget(item.days!, blackColor, context, 14.0),
                                        //     buildTextBoldWidget("D ", blackColor, context, 14.0),
                                        //     buildTextRegularWidget(item.hours!, blackColor, context, 14.0),
                                        //     buildTextBoldWidget("H ", blackColor, context, 14.0),
                                        //     buildTextRegularWidget(item.mins!, blackColor, context, 14.0),
                                        //     Flexible(
                                        //       child:
                                        //               buildTextBoldWidget("M", blackColor, context, 14.0,)),
                                        //
                                        //             ],
                                        //           ),
                                        //         ),

                                        RichText(
                                          textAlign: TextAlign.left,
                                          textDirection: TextDirection.ltr,
                                          textWidthBasis: TextWidthBasis.parent,
                                          text: TextSpan(
                                            text: cont.selectedMainType ==
                                                    "StartedNotCompleted"
                                                ? "Name of the staff - "
                                                : "Assigned to - ",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: blackColor,
                                              fontSize: 16,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: item.firmEmployeeName!,
                                                  style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: blackColor,
                                                    fontSize: 16.0,
                                                  )),
                                              const TextSpan(
                                                  text: "   Total : ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: blackColor,
                                                    fontSize: 16,
                                                  )),
                                              TextSpan(
                                                text: item.days!,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: blackColor,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: "D ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: blackColor,
                                                    fontSize: 16),
                                              ),
                                              TextSpan(
                                                text: item.hours!,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: blackColor,
                                                    fontSize: 16),
                                              ),
                                              const TextSpan(
                                                text: "H ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: blackColor,
                                                    fontSize: 16),
                                              ),
                                              TextSpan(
                                                text: item.mins!,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: blackColor,
                                                    fontSize: 16),
                                              ),
                                              const TextSpan(
                                                text: "M",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: blackColor,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        //cont.selectedMainType == "StartedNotCompleted" ? const Opacity(opacity: 0.0,):
                                        item.taskEmp == cont.userId
                                            ? item.start == "0" &&
                                                    item.status == "1"
                                                ? Row(
                                                    children: [
                                                      Flexible(
                                                        child:
                                                            buildTextBoldWidget(
                                                                "Status - ",
                                                                blackColor,
                                                                context,
                                                                14.0),
                                                      ),
                                                      Flexible(
                                                          child:
                                                              GestureDetector(
                                                        onTap: () {
                                                          cont.startSelectedTask(
                                                              item.id!);
                                                        },
                                                        child:
                                                            buildButtonWidget(
                                                                context,
                                                                "Start",
                                                                height: 35.0,
                                                                width: 100.0),
                                                      )),
                                                    ],
                                                  )
                                                : item.start == "1" &&
                                                        item.status == "1"
                                                    ? Row(
                                                        children: [
                                                          Flexible(
                                                            child:
                                                                buildTextBoldWidget(
                                                                    "Status - ",
                                                                    blackColor,
                                                                    context,
                                                                    14.0),
                                                          ),
                                                          Flexible(
                                                              child:
                                                                  buildTextRegularWidget(
                                                                      "Started",
                                                                      blackColor,
                                                                      context,
                                                                      14.0)),
                                                        ],
                                                      )
                                                    : buildRichTextWidget(
                                                        "Status - ",
                                                        "Yet to start")
                                            : buildRichTextWidget(
                                                "Status - ", "Yet to start"),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    )),
          ));
    });
  }
}
