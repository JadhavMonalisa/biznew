import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/dashboard/dashboard_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceCancelAll extends StatefulWidget {
  const ServiceCancelAll({Key? key}) : super(key: key);

  @override
  State<ServiceCancelAll> createState() => _ServiceCancelAllState();
}

class _ServiceCancelAllState extends State<ServiceCancelAll> {
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
                  "Allotted but not started (Bulk)", whiteColor, context, 16,
                  align: TextAlign.center),
            ),
            body: cont.loader == true
                ? Center(
                    child: buildCircularIndicator(),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0, bottom: 20.0),
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: buildTextBoldWidget(
                                  "Select services to cancel",
                                  blackColor,
                                  context,
                                  16.0),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount:
                                      cont.allottedNotStartedPastDueList.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    final item = cont
                                        .allottedNotStartedPastDueList[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                        elevation: 1.0,
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
                                                            color: primaryColor,
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
                                                                primaryColor,
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
                                              child: RichText(
                                                text: TextSpan(
                                                  text:
                                                      "${item.servicename} triggered on ${item.triggerDateToShow} and ending on ",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: blackColor,
                                                      fontSize: 16.0),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          cont.navigateToDetails(
                                                              item.id!,
                                                              item.client!,
                                                              item.servicename!,
                                                              item.allottedTo!);
                                                        },
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text:
                                                            "${cont.addedDateListForAll.contains(item.id) ? cont.selectedDateToShowForCurrent == "" ? item.targetDateToShow : cont.selectedDateToShowForCurrent : item.targetDateToShow}",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: blackColor,
                                                            fontSize: 16.0,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            decorationThickness:
                                                                2.0),
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = () {
                                                                cont.selectTargetDateForAll(
                                                                    context,
                                                                    item.id!);
                                                              }),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                buildTextRegularWidget(
                                                    "Select this service to cancel",
                                                    blackColor,
                                                    context,
                                                    14.0),
                                                Checkbox(
                                                    value: cont.addedId
                                                            .contains(item.id)
                                                        ? true
                                                        : false,
                                                    onChanged: (onChanged) {
                                                      cont.onCheckBoxSelect(
                                                          context, item.id!);
                                                    }),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  right: 10.0,
                                                  top: 10.0),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: Container(
                                                        height: 40.0,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          border: Border.all(
                                                              color: grey),
                                                        ),
                                                        child: Center(
                                                            child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15.0,
                                                                  right: 15.0),
                                                          child: DropdownButton(
                                                            hint: buildTextRegularWidget(
                                                                cont.addedPriorityListForAll.contains(item.id)
                                                                    ? cont.selectedAllPriority == ""
                                                                        ? item.priorityToShow!
                                                                        : cont.selectedAllPriority
                                                                    : item.priorityToShow!,
                                                                blackColor,
                                                                context,
                                                                15.0),
                                                            isExpanded: true,
                                                            underline:
                                                                Container(),
                                                            items: cont
                                                                .priorityList
                                                                .map((String
                                                                    value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child:
                                                                    Text(value),
                                                              );
                                                            }).toList(),
                                                            onChanged: (val) {
                                                              cont.updatePriorityForAll(
                                                                  val!,
                                                                  item.id!);
                                                            },
                                                          ),
                                                        ))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  right: 10.0,
                                                  top: 10.0,
                                                ),
                                                child: Row(
                                                  children: [
                                                    buildTextBoldWidget(
                                                        "Assigned to - ",
                                                        blackColor,
                                                        context,
                                                        14.0),
                                                    buildTextRegularWidget(
                                                        "${item.allottedTo}",
                                                        blackColor,
                                                        context,
                                                        14.0),
                                                  ],
                                                )),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                        child: GestureDetector(
                                                      onTap: () {
                                                        //cont.callStartService(item.id!);
                                                      },
                                                      child: buildButtonWidget(
                                                          context,
                                                          "Start Service",
                                                          height: 40.0,
                                                          buttonColor:
                                                              Colors.green,
                                                          buttonFontSize: 14.0),
                                                    )),
                                                    const SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Flexible(
                                                      child: buildButtonWidget(
                                                          context, "Reassign",
                                                          height: 40.0,
                                                          buttonColor:
                                                              Colors.orange,
                                                          buttonFontSize: 14.0),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        )),
                    //child:buildTextBoldWidget("In progress", blackColor, context, 16.0)
                  ),
            bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(
                    bottom: 10.0, left: 20.0, right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    // cont.showCheckPasswordOrReasonDialog("Reason for cancel",context);
                    cont.showCheckPasswordOrReasonDialog(
                        "Cancel selected services", context);
                  },
                  child: buildButtonWidget(context, "Cancel selected services",
                      height: 50.0,
                      buttonColor: errorColor,
                      buttonFontSize: 14.0),
                )),
          ));
    });
  }
}
