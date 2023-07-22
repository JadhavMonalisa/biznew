import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/screens/dashboard/dashboard_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceDashboardNextScreen extends StatefulWidget {
  const ServiceDashboardNextScreen({Key? key}) : super(key: key);

  @override
  State<ServiceDashboardNextScreen> createState() =>
      _ServiceDashboardNextScreenState();
}

class _ServiceDashboardNextScreenState
    extends State<ServiceDashboardNextScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont) {
      return WillPopScope(
          onWillPop: () async {
            return await cont.navigateToBottom();
          },
          child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: DefaultTabController(
                length: 5,
                initialIndex: cont.initialIndex,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Scaffold(
                    // appBar: AppBar(
                    //   elevation: 0, backgroundColor: primaryColor, centerTitle: true,
                    //   title: buildTextMediumWidget(
                    //       cont.selectedMainType == "AllottedNotStarted"? "Allotted but not started" :
                    //       cont.selectedMainType == "StartedNotCompleted" ? "Started but not completed" :
                    //       cont.selectedMainType == "CompletedUdinPending"? "Completed but UDIN pending" :
                    //       cont.selectedMainType == "CompletedNotBilled"? "Completed but not billed" :
                    //       cont.selectedMainType == "WorkOnHold"? "Work on hold" :
                    //       cont.selectedMainType == "SubmittedForChecking"? "Submitted for checking" : "All Tasks",
                    //       whiteColor,context, 16,align: TextAlign.center),
                    //   bottom: Column(
                    //     children: [
                    //       TabBar(
                    //         onTap: (index){
                    //           print(index);
                    //         },
                    //         tabs: [
                    //           Tab(text: "Past Due"),
                    //           Tab(text: "High")
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    appBar: PreferredSize(
                        preferredSize: const Size.fromHeight(220),
                        child: Container(
                          color: primaryColor,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20.0,
                              ),
                              buildTextMediumWidget(
                                  cont.selectedMainType == "AllottedNotStarted"
                                      ? "Allotted but not started"
                                      : cont.selectedMainType ==
                                              "StartedNotCompleted"
                                          ? "Started but not completed"
                                          : cont.selectedMainType ==
                                                  "CompletedUdinPending"
                                              ? "Completed but UDIN pending"
                                              : cont.selectedMainType ==
                                                      "CompletedNotBilled"
                                                  ? "Completed but not billed"
                                                  : cont.selectedMainType ==
                                                          "WorkOnHold"
                                                      ? "Work on hold"
                                                      : cont.selectedMainType ==
                                                              "SubmittedForChecking"
                                                          ? "Submitted for checking"
                                                          : "All Tasks",
                                  whiteColor,
                                  context,
                                  16,
                                  align: TextAlign.center),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0, left: 10.0, top: 10.0),
                                  child: Card(
                                      elevation: 1.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          side: const BorderSide(color: grey)),
                                      child: SizedBox(
                                        height: 40.0,
                                        child: Center(
                                          child: buildTextBoldWidget(
                                              "${cont.selectedType} ( ${cont.selectedCount} )",
                                              blackColor,
                                              context,
                                              14.0),
                                        ),
                                      ))),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0,
                                      left: 10.0,
                                      top: 5.0,
                                      bottom: 10.0),
                                  child: Card(
                                      elevation: 1.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          side: const BorderSide(color: grey)),
                                      child: SizedBox(
                                        height: 40.0,
                                        width:
                                            MediaQuery.of(context).size.height,
                                        child: Row(
                                          children: [
                                            Flexible(
                                                child: SizedBox(
                                              height: 40.0,
                                              child: Center(
                                                  child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: TextFormField(
                                                  controller: cont.searchController,
                                                  keyboardType: TextInputType.text,
                                                  textAlign: TextAlign.left,
                                                  enabled: true,
                                                  textAlignVertical: TextAlignVertical.center,
                                                  textInputAction: TextInputAction.done,
                                                  textCapitalization: TextCapitalization.sentences,
                                                  onTap: () {},
                                                  style: const TextStyle(fontSize: 15.0),
                                                  decoration: InputDecoration(
                                                    hintText: "Search by client name or service name",
                                                    hintStyle: GoogleFonts.rubik(
                                                      textStyle: const TextStyle(
                                                        color: blackColor,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    border: InputBorder.none,
                                                  ),
                                                  onChanged: (text) {
                                                    cont.loader =true;
                                                    text.isEmpty ?
                                                    cont.callApiWhenSearchIsEmpty()
                                                    ///while searching
                                                    : cont.filterSearchResults(text);
                                                  },
                                                ),
                                              )),
                                            )),
                                             Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0, right: 5.0),
                                                child: GestureDetector(
                                                  onTap: (){
                                                    cont.loader = true;
                                                    cont.filterSearchResults(cont.searchController.text);
                                                  },
                                                  child: const Icon(
                                                    Icons.search,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ))),
                              TabBar(
                                physics: const AlwaysScrollableScrollPhysics(),
                                isScrollable: true,
                                indicatorColor: Colors.white,
                                labelStyle: const TextStyle(
                                    fontSize: 16.0,
                                    backgroundColor: primaryColor,
                                    color: whiteColor), //For Selected tab
                                unselectedLabelStyle: const TextStyle(
                                    fontSize: 16.0,
                                    backgroundColor: primaryColor,
                                    color: primaryColor), //For Un-selected Tabs
                                onTap: (index) {
                                  cont.onTabIndexSelect(index);
                                },
                                tabs: [
                                  Tab(
                                      text:
                                          "Past Due (${cont.selectedPastDue})"),
                                  Tab(
                                      text:
                                          "Probable Overdue (${cont.selectedProbable})"),
                                  Tab(text: "High (${cont.selectedHigh})"),
                                  Tab(text: "Medium (${cont.selectedMedium})"),
                                  Tab(text: "Low (${cont.selectedLow})")
                                ],
                              ),
                            ],
                          ),
                        )),
                    body: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ///past due
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: cont.selectedMainType == "AllottedNotStarted"
                              ?

                              ///allotted not started
                              cont.loader
                                  ? buildCircularIndicator()
                                  : cont.allottedNotStartedPastDueList.isEmpty
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 50.0),
                                          child: buildTextBoldWidget(
                                              "No data found",
                                              blackColor,
                                              context,
                                              16.0,
                                              align: TextAlign.center))
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: cont
                                              .allottedNotStartedPastDueList
                                              .length,
                                          itemBuilder: (context, index) {
                                            final item =
                                                cont.allottedNotStartedPastDueList[
                                                    index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, right: 5.0),
                                              child: Card(
                                                elevation: 1.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.0),
                                                    side: const BorderSide(
                                                        color: grey)),
                                                child: ExpansionTile(
                                                  tilePadding:
                                                      const EdgeInsets.all(0.0),
                                                  trailing: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child: Icon(
                                                      cont.addedIndex
                                                              .contains(index)
                                                          ? Icons
                                                              .keyboard_arrow_up
                                                          : Icons
                                                              .keyboard_arrow_down,
                                                      size: 25.0,
                                                    ),
                                                  ),
                                                  onExpansionChanged: (value) {
                                                    cont.onExpanded(
                                                        value, index);
                                                  },
                                                  title: Column(
                                                    children: [
                                                      buildClientCodeWidget(
                                                          item.clientCode!,
                                                          item.client!,
                                                          context),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0),
                                                          child: buildTextRegularWidget(
                                                              "${item.servicename}",
                                                              blackColor,
                                                              context,
                                                              14.0,
                                                              align: TextAlign
                                                                  .left)),
                                                    ],
                                                  ),
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0,
                                                                    right:
                                                                        10.0),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                buildTextBoldWidget(
                                                                    "Assigned to - ",
                                                                    blackColor,
                                                                    context,
                                                                    14.0),
                                                                Flexible(
                                                                  child: buildTextBoldWidget(
                                                                      "${item.allottedTo}",
                                                                      primaryColor,
                                                                      context,
                                                                      14.0,
                                                                      align: TextAlign
                                                                          .left),
                                                                )
                                                              ],
                                                            )),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0,
                                                                  right: 10.0,
                                                                  top: 5.0),
                                                          child: Row(
                                                            children: [
                                                              // Flexible(
                                                              //   child: GestureDetector(
                                                              //     onTap: (){
                                                              //       cont.navigateToServiceView(item.id!,item.client!,item.servicename!);
                                                              //     },
                                                              //     child: Container(
                                                              //         height: 40.0,
                                                              //         width: MediaQuery.of(context).size.width,
                                                              //         decoration: BoxDecoration(
                                                              //           borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                              //           border: Border.all(color: grey),),
                                                              //         child: Center(
                                                              //             child: Padding(
                                                              //               padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                                              //               child: buildTextRegularWidget("item.status", blackColor, context, 15.0),
                                                              //             )
                                                              //         )
                                                              //     ),
                                                              //   ),
                                                              // ),
                                                              // const SizedBox(width: 10.0,),
                                                              Flexible(
                                                                child: Container(
                                                                    height: 40.0,
                                                                    width: MediaQuery.of(context).size.width,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: const BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              5)),
                                                                      border: Border.all(
                                                                          color:
                                                                              grey),
                                                                    ),
                                                                    child: cont.reportingHead == "0"
                                                                        ? Align(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                              child: buildTextRegularWidget(
                                                                                  item.priorityToShow!,
                                                                                  item.priorityToShow == "High"
                                                                                      ? const Color(0xffFF0000)
                                                                                      : item.priorityToShow == "Medium"
                                                                                          ? const Color(0xffF57C00)
                                                                                          : const Color(0xff008000),
                                                                                  context,
                                                                                  15.0,
                                                                                  align: TextAlign.left),
                                                                            ),
                                                                          )
                                                                        : Center(
                                                                            child: Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                            child:
                                                                                DropdownButton(
                                                                              hint: buildTextRegularWidget(
                                                                                  cont.addedPriorityListForCurrent.contains(item.id)
                                                                                      ? cont.selectedCurrentPriority == ""
                                                                                          ? item.priorityToShow!
                                                                                          : cont.selectedCurrentPriority
                                                                                      : item.priorityToShow!,
                                                                                  item.priorityToShow == "High"
                                                                                      ? const Color(0xffFF0000)
                                                                                      : item.priorityToShow == "Medium"
                                                                                          ? const Color(0xffF57C00)
                                                                                          : const Color(0xff008000),
                                                                                  context,
                                                                                  15.0),
                                                                              isExpanded: true,
                                                                              underline: Container(),
                                                                              items: cont.priorityList.map((String value) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: value,
                                                                                  child: Text(value),
                                                                                );
                                                                              }).toList(),
                                                                              onChanged: (val) {
                                                                                cont.updatePriorityForCurrent(val!, item.id!);
                                                                              },
                                                                            ),
                                                                          ))),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0,
                                                                  right: 10.0,
                                                                  top: 5.0),
                                                          child: Table(
                                                            children: [
                                                              TableRow(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              3.0),
                                                                      child: buildTextBoldWidget(
                                                                          "Triggered\nDate",
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center),
                                                                    ),
                                                                    GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          if (cont.reportingHead ==
                                                                              "1") {
                                                                            cont.selectTargetDateForCurrent(
                                                                                context,
                                                                                item.id!,
                                                                                item.triggerDateTimeFormat!,
                                                                                item.targetDateTimeFormat!,
                                                                                "allottedApiPastDue",
                                                                                item.staDateTimeFormat!);
                                                                          }
                                                                        },
                                                                        child:
                                                                            buildTextBoldWidget(
                                                                          "Target Date",
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center,
                                                                          decoration:
                                                                              TextDecoration.underline,
                                                                        )),
                                                                    buildTextBoldWidget(
                                                                        "Statutory\nDue Date",
                                                                        blackColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .center),
                                                                  ]),
                                                              TableRow(
                                                                  children: [
                                                                    buildTextRegularWidget(
                                                                        item
                                                                            .triggerDateToShow!,
                                                                        blackColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .center),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        if (cont.reportingHead ==
                                                                            "1") {
                                                                          cont.selectTargetDateForCurrent(
                                                                              context,
                                                                              item.id!,
                                                                              item.triggerDateTimeFormat!,
                                                                              item.targetDateTimeFormat!,
                                                                              "allottedApiPastDue",
                                                                              item.staDateTimeFormat!);
                                                                        }
                                                                      },
                                                                      child:
                                                                          buildTextRegularWidget(
                                                                        "${cont.addedDateListForAll.contains(item.id) ? cont.selectedDateToShowForCurrent == "" ? item.targetDateToShow : cont.selectedDateToShowForCurrent : item.targetDateToShow}",
                                                                        blackColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .center,
                                                                        decoration:
                                                                            TextDecoration.underline,
                                                                      ),
                                                                    ),
                                                                    buildTextRegularWidget(
                                                                        item
                                                                            .satDateToShow!,
                                                                        blackColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .center),
                                                                  ]),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Row(
                                                              children: [
                                                                ///view
                                                                cont.reportingHead ==
                                                                        "0"
                                                                    ? const Opacity(
                                                                        opacity:
                                                                            0.0)
                                                                    : Flexible(
                                                                        child:
                                                                            GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          cont.navigateToServiceView(
                                                                              item.id!,
                                                                              item.client!,
                                                                              item.servicename!,
                                                                              item.clientCode!);
                                                                        },
                                                                        child: buildButtonWidget(
                                                                            context,
                                                                            "View",
                                                                            height:
                                                                                40.0,
                                                                            buttonColor:
                                                                                errorColor,
                                                                            buttonFontSize:
                                                                                14.0),
                                                                      )),

                                                                ///reassign
                                                                cont.reportingHead ==
                                                                        "0"
                                                                    ? const Opacity(
                                                                        opacity:
                                                                            0.0)
                                                                    : const SizedBox(
                                                                        width:
                                                                            10.0,
                                                                      ),
                                                                cont.reportingHead ==
                                                                        "0"
                                                                    ? const Opacity(
                                                                        opacity:
                                                                            0.0)
                                                                    : Flexible(
                                                                        child:
                                                                            GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          cont.navigateToDetails(
                                                                              item.id!,
                                                                              item.client!,
                                                                              item.servicename!,
                                                                              item.allottedTo!);
                                                                        },
                                                                        child: buildButtonWidget(
                                                                            context,
                                                                            "Reassign",
                                                                            height:
                                                                                40.0,
                                                                            buttonColor:
                                                                                Colors.orange,
                                                                            buttonFontSize: 14.0),
                                                                      )),

                                                                ///start service
                                                                const SizedBox(
                                                                  width: 10.0,
                                                                ),
                                                                Flexible(
                                                                    child:
                                                                        GestureDetector(
                                                                  onTap: () {
                                                                    cont.callStartService(
                                                                        item.id!,
                                                                        cont.selectedMainType);
                                                                  },
                                                                  child: buildButtonWidget(
                                                                      context,
                                                                      "Start Service",
                                                                      height:
                                                                          40.0,
                                                                      buttonColor:
                                                                          Colors
                                                                              .green,
                                                                      buttonFontSize:
                                                                          14.0),
                                                                )),
                                                              ],
                                                            ))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          })

                              ///started not completed
                              : cont.loader
                                  ? buildCircularIndicator()
                                  : cont.startedNotCompletedPastDueList.isEmpty
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 50.0),
                                          child: buildTextBoldWidget(
                                              "No data found",
                                              blackColor,
                                              context,
                                              16.0,
                                              align: TextAlign.center))
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: cont
                                              .startedNotCompletedPastDueList
                                              .length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            final item =
                                                cont.startedNotCompletedPastDueList[
                                                    index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, right: 5.0),
                                              child: Card(
                                                  elevation: 1.0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7.0),
                                                      side: const BorderSide(
                                                          color: grey)),
                                                  child: ExpansionTile(
                                                    tilePadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    trailing: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10.0),
                                                      child: Icon(
                                                        cont.addedIndex
                                                                .contains(index)
                                                            ? Icons
                                                                .keyboard_arrow_up
                                                            : Icons
                                                                .keyboard_arrow_down,
                                                        size: 25.0,
                                                      ),
                                                    ),
                                                    onExpansionChanged:
                                                        (value) {
                                                      cont.onExpanded(
                                                          value, index);
                                                    },
                                                    title: Column(
                                                      children: [
                                                        buildClientCodeWidget(
                                                            item.clientCode!,
                                                            item.client!,
                                                            context),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0),
                                                            child: buildTextRegularWidget(
                                                                "${item.servicename}",
                                                                blackColor,
                                                                context,
                                                                14.0,
                                                                align: TextAlign
                                                                    .left)),
                                                      ],
                                                    ),
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ///assigned to
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                              ),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  buildTextBoldWidget(
                                                                      "Assigned to - ",
                                                                      blackColor,
                                                                      context,
                                                                      14.0),
                                                                  Flexible(
                                                                      child: buildTextBoldWidget(
                                                                          "${item.allottedTo}",
                                                                          primaryColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.left)),
                                                                ],
                                                              )),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          10.0,
                                                                      right:
                                                                          10.0),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  buildTextBoldWidget(
                                                                      "Task - ",
                                                                      blackColor,
                                                                      context,
                                                                      14.0),
                                                                  Flexible(
                                                                    child: buildTextBoldWidget(
                                                                        "${item.tasks}",
                                                                        primaryColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .left),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          20.0),
                                                                  buildTextBoldWidget(
                                                                      "Completion % - ",
                                                                      blackColor,
                                                                      context,
                                                                      14.0),
                                                                  Flexible(
                                                                    child: buildTextBoldWidget(
                                                                        "${item.completionPercentage}",
                                                                        primaryColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .left),
                                                                  )
                                                                ],
                                                              )),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0,
                                                                    right: 10.0,
                                                                    top: 5.0),
                                                            child: Row(
                                                              children: [
                                                                Flexible(
                                                                  child: Container(
                                                                      height: 40.0,
                                                                      width: MediaQuery.of(context).size.width,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            const BorderRadius.all(Radius.circular(5)),
                                                                        border: Border.all(
                                                                            color:
                                                                                grey),
                                                                      ),
                                                                      child: cont.reportingHead == "0"
                                                                          ? Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                                child: buildTextRegularWidget(
                                                                                    item.priorityToShow!,
                                                                                    item.priorityToShow == "High"
                                                                                        ? const Color(0xffFF0000)
                                                                                        : item.priorityToShow == "Medium"
                                                                                            ? const Color(0xffF57C00)
                                                                                            : const Color(0xff008000),
                                                                                    context,
                                                                                    15.0,
                                                                                    align: TextAlign.left),
                                                                              ),
                                                                            )
                                                                          : Center(
                                                                              child: Padding(
                                                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                              child: DropdownButton(
                                                                                hint: buildTextRegularWidget(
                                                                                    cont.addedPriorityListForCurrent.contains(item.id)
                                                                                        ? cont.selectedCurrentPriority == ""
                                                                                            ? item.priorityToShow!
                                                                                            : cont.selectedCurrentPriority
                                                                                        : item.priorityToShow!,
                                                                                    item.priorityToShow == "High"
                                                                                        ? const Color(0xffFF0000)
                                                                                        : item.priorityToShow == "Medium"
                                                                                            ? const Color(0xffF57C00)
                                                                                            : const Color(0xff008000),
                                                                                    context,
                                                                                    15.0),
                                                                                isExpanded: true,
                                                                                underline: Container(),
                                                                                items: cont.priorityList.map((String value) {
                                                                                  return DropdownMenuItem<String>(
                                                                                    value: value,
                                                                                    child: Text(value),
                                                                                  );
                                                                                }).toList(),
                                                                                onChanged: (val) {
                                                                                  cont.updatePriorityForCurrent(val!, item.id!);
                                                                                },
                                                                              ),
                                                                            ))),
                                                                ),
                                                                const SizedBox(
                                                                    width:
                                                                        10.0),
                                                                Flexible(
                                                                  child: Container(
                                                                      height: 40.0,
                                                                      width: MediaQuery.of(context).size.width,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            const BorderRadius.all(Radius.circular(5)),
                                                                        border: Border.all(
                                                                            color:
                                                                                grey),
                                                                      ),
                                                                      child: cont.reportingHead == "0"
                                                                          ? Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                                child: buildTextRegularWidget(item.statusName!, blackColor, context, 15.0, align: TextAlign.left),
                                                                              ),
                                                                            )
                                                                          : Center(
                                                                              child: Padding(
                                                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                              child: DropdownButton(
                                                                                hint: buildTextRegularWidget(
                                                                                    cont.addedStatusListForCurrent.contains(item.id)
                                                                                        ? cont.selectedServiceStatus == ""
                                                                                            ? item.statusName!
                                                                                            : cont.selectedServiceStatus
                                                                                        : item.statusName!,
                                                                                    blackColor,
                                                                                    context,
                                                                                    15.0),
                                                                                isExpanded: true,
                                                                                underline: Container(),
                                                                                items: cont.changeStatusList.map((String value) {
                                                                                  return DropdownMenuItem<String>(
                                                                                    value: value,
                                                                                    child: Text(value),
                                                                                  );
                                                                                }).toList(),
                                                                                onChanged: (val) {
                                                                                  cont.updateStatusForCurrent(val!, item.id!, context);
                                                                                },
                                                                              ),
                                                                            ))),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0,
                                                                    right: 10.0,
                                                                    top: 5.0),
                                                            child: Table(
                                                              children: [
                                                                TableRow(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(right: 3.0),
                                                                        child: buildTextBoldWidget(
                                                                            "Triggered\nDate",
                                                                            blackColor,
                                                                            context,
                                                                            14.0,
                                                                            align:
                                                                                TextAlign.center),
                                                                      ),
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            if (cont.reportingHead ==
                                                                                "1") {
                                                                              cont.selectTargetDateForCurrent(context, item.id!, item.triggerDateTimeFormat!, item.targetDateTimeFormat!, "startedNotCompletedApiPastDue", item.staDateTimeFormat!);
                                                                            }
                                                                          },
                                                                          child:
                                                                              buildTextBoldWidget(
                                                                            "Target Date",
                                                                            blackColor,
                                                                            context,
                                                                            14.0,
                                                                            align:
                                                                                TextAlign.center,
                                                                            decoration:
                                                                                TextDecoration.underline,
                                                                          )),
                                                                      buildTextBoldWidget(
                                                                          "Statutory\nDue Date",
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center),
                                                                    ]),
                                                                TableRow(
                                                                    children: [
                                                                      buildTextRegularWidget(
                                                                          item
                                                                              .triggerDateToShow!,
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          if (cont.reportingHead ==
                                                                              "1") {
                                                                            cont.selectTargetDateForCurrent(
                                                                                context,
                                                                                item.id!,
                                                                                item.triggerDateTimeFormat!,
                                                                                item.targetDateTimeFormat!,
                                                                                "startedNotCompletedApiPastDue",
                                                                                item.staDateTimeFormat!);
                                                                          }
                                                                        },
                                                                        child:
                                                                            buildTextRegularWidget(
                                                                          "${cont.addedDateListForAll.contains(item.id) ? cont.selectedDateToShowForCurrent == "" ? item.targetDateToShow : cont.selectedDateToShowForCurrent : item.targetDateToShow}",
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center,
                                                                          decoration:
                                                                              TextDecoration.underline,
                                                                        ),
                                                                      ),
                                                                      buildTextRegularWidget(
                                                                          item
                                                                              .satDateToShow!,
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center),
                                                                    ]),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              child: Row(
                                                                children: [
                                                                  Flexible(
                                                                      child:
                                                                          GestureDetector(
                                                                    onTap: () {
                                                                      cont.selectedCliId =
                                                                          item.id!;
                                                                      cont.showCheckPasswordOrReasonDialog(
                                                                          "Cancel - ${item.servicename}",
                                                                          context);
                                                                    },
                                                                    child: buildButtonWidget(
                                                                        context,
                                                                        "Cancel",
                                                                        height:
                                                                            40.0,
                                                                        buttonColor:
                                                                            errorColor,
                                                                        buttonFontSize:
                                                                            14.0),
                                                                  )),
                                                                  const SizedBox(
                                                                    width: 10.0,
                                                                  ),
                                                                  Flexible(
                                                                      child:
                                                                          GestureDetector(
                                                                    onTap: () {
                                                                      cont.navigateToServiceView(
                                                                          item.id!,
                                                                          item.client!,
                                                                          item.servicename!,
                                                                          item.clientCode!);
                                                                    },
                                                                    child: buildButtonWidget(
                                                                        context,
                                                                        "Log",
                                                                        height:
                                                                            40.0,
                                                                        buttonColor:
                                                                            Colors
                                                                                .orange,
                                                                        buttonFontSize:
                                                                            14.0),
                                                                  )),
                                                                  const SizedBox(
                                                                    width: 10.0,
                                                                  ),
                                                                  Flexible(
                                                                      child:
                                                                          GestureDetector(
                                                                    onTap: () {
                                                                      cont.updateStatusForCurrent(
                                                                          "Complete",
                                                                          item.id!,
                                                                          context);
                                                                    },
                                                                    child: buildButtonWidget(
                                                                        context,
                                                                        "Complete",
                                                                        height:
                                                                            40.0,
                                                                        buttonColor:
                                                                            approveColor,
                                                                        buttonFontSize:
                                                                            14.0),
                                                                  )),
                                                                ],
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                            );
                                          }),
                        ),

                        ///probable overdue
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: cont.selectedMainType == "AllottedNotStarted"
                              ?

                              ///allotted not started
                              cont.loader
                                  ? buildCircularIndicator()
                                  : cont.allottedNotStartedPastDueList.isEmpty
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 50.0),
                                          child: buildTextBoldWidget(
                                              "No data found",
                                              blackColor,
                                              context,
                                              16.0,
                                              align: TextAlign.center))
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: cont
                                              .allottedNotStartedPastDueList
                                              .length,
                                          itemBuilder: (context, index) {
                                            final item =
                                                cont.allottedNotStartedPastDueList[
                                                    index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, right: 5.0),
                                              child: Card(
                                                elevation: 1.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.0),
                                                    side: const BorderSide(
                                                        color: grey)),
                                                child: ExpansionTile(
                                                  tilePadding:
                                                      const EdgeInsets.all(0.0),
                                                  trailing: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child: Icon(
                                                      cont.addedIndex
                                                              .contains(index)
                                                          ? Icons
                                                              .keyboard_arrow_up
                                                          : Icons
                                                              .keyboard_arrow_down,
                                                      size: 25.0,
                                                    ),
                                                  ),
                                                  onExpansionChanged: (value) {
                                                    cont.onExpanded(
                                                        value, index);
                                                  },
                                                  title: Column(
                                                    children: [
                                                      buildClientCodeWidget(
                                                          item.clientCode!,
                                                          item.client!,
                                                          context),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0),
                                                          child: buildTextRegularWidget(
                                                              "${item.servicename}",
                                                              blackColor,
                                                              context,
                                                              14.0,
                                                              align: TextAlign
                                                                  .left)),
                                                    ],
                                                  ),
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0,
                                                                    right:
                                                                        10.0),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                buildTextBoldWidget(
                                                                    "Assigned to - ",
                                                                    blackColor,
                                                                    context,
                                                                    14.0),
                                                                Flexible(
                                                                  child: buildTextBoldWidget(
                                                                      "${item.allottedTo}",
                                                                      primaryColor,
                                                                      context,
                                                                      14.0,
                                                                      align: TextAlign
                                                                          .left),
                                                                )
                                                              ],
                                                            )),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 10.0,
                                                            right: 10.0,
                                                          ),
                                                          child: Table(
                                                            children: [
                                                              TableRow(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              3.0),
                                                                      child: buildTextBoldWidget(
                                                                          "Triggered\nDate",
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center),
                                                                    ),
                                                                    GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          if (cont.reportingHead ==
                                                                              "1") {
                                                                            cont.selectTargetDateForCurrent(
                                                                                context,
                                                                                item.id!,
                                                                                item.triggerDateTimeFormat!,
                                                                                item.targetDateTimeFormat!,
                                                                                "allottedApiProbable",
                                                                                item.staDateTimeFormat!);
                                                                          }
                                                                        },
                                                                        child:
                                                                            buildTextBoldWidget(
                                                                          "Target Date",
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center,
                                                                          decoration:
                                                                              TextDecoration.underline,
                                                                        )),
                                                                    buildTextBoldWidget(
                                                                        "Statutory\nDue Date",
                                                                        blackColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .center),
                                                                  ]),
                                                              TableRow(
                                                                  children: [
                                                                    buildTextRegularWidget(
                                                                        item
                                                                            .triggerDateToShow!,
                                                                        blackColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .center),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        if (cont.reportingHead ==
                                                                            "1") {
                                                                          cont.selectTargetDateForCurrent(
                                                                              context,
                                                                              item.id!,
                                                                              item.triggerDateTimeFormat!,
                                                                              item.targetDateTimeFormat!,
                                                                              "allottedApiProbable",
                                                                              item.staDateTimeFormat!);
                                                                        }
                                                                      },
                                                                      child:
                                                                          buildTextRegularWidget(
                                                                        "${cont.addedDateListForAll.contains(item.id) ? cont.selectedDateToShowForCurrent == "" ? item.targetDateToShow : cont.selectedDateToShowForCurrent : item.targetDateToShow}",
                                                                        blackColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .center,
                                                                        decoration:
                                                                            TextDecoration.underline,
                                                                      ),
                                                                    ),
                                                                    buildTextRegularWidget(
                                                                        item
                                                                            .satDateToShow!,
                                                                        blackColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .center),
                                                                  ]),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0,
                                                                  right: 10.0,
                                                                  top: 5.0),
                                                          child: Row(
                                                            children: [
                                                              // Flexible(
                                                              //   child: GestureDetector(
                                                              //     onTap: (){
                                                              //       cont.navigateToServiceView(item.id!,item.client!,item.servicename!);
                                                              //     },
                                                              //     child: Container(
                                                              //         height: 40.0,
                                                              //         width: MediaQuery.of(context).size.width,
                                                              //         decoration: BoxDecoration(
                                                              //           borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                              //           border: Border.all(color: grey),),
                                                              //         child: Center(
                                                              //             child: Padding(
                                                              //               padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                                              //               child: buildTextRegularWidget("item.status", blackColor, context, 15.0),
                                                              //             )
                                                              //         )
                                                              //     ),
                                                              //   ),
                                                              // ),
                                                              // const SizedBox(width: 10.0,),
                                                              Flexible(
                                                                child: Container(
                                                                    height: 40.0,
                                                                    width: MediaQuery.of(context).size.width,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: const BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              5)),
                                                                      border: Border.all(
                                                                          color:
                                                                              grey),
                                                                    ),
                                                                    child: cont.reportingHead == "0"
                                                                        ? Align(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                              child: buildTextRegularWidget(
                                                                                  item.priorityToShow!,
                                                                                  item.priorityToShow == "High"
                                                                                      ? const Color(0xffFF0000)
                                                                                      : item.priorityToShow == "Medium"
                                                                                          ? const Color(0xffF57C00)
                                                                                          : const Color(0xff008000),
                                                                                  context,
                                                                                  15.0,
                                                                                  align: TextAlign.left),
                                                                            ),
                                                                          )
                                                                        : Center(
                                                                            child: Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                            child:
                                                                                DropdownButton(
                                                                              hint: buildTextRegularWidget(
                                                                                  cont.addedPriorityListForCurrent.contains(item.id)
                                                                                      ? cont.selectedCurrentPriority == ""
                                                                                          ? item.priorityToShow!
                                                                                          : cont.selectedCurrentPriority
                                                                                      : item.priorityToShow!,
                                                                                  item.priorityToShow == "High"
                                                                                      ? const Color(0xffFF0000)
                                                                                      : item.priorityToShow == "Medium"
                                                                                          ? const Color(0xffF57C00)
                                                                                          : const Color(0xff008000),
                                                                                  context,
                                                                                  15.0),
                                                                              isExpanded: true,
                                                                              underline: Container(),
                                                                              items: cont.priorityList.map((String value) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: value,
                                                                                  child: Text(value),
                                                                                );
                                                                              }).toList(),
                                                                              onChanged: (val) {
                                                                                cont.updatePriorityForCurrent(val!, item.id!);
                                                                              },
                                                                            ),
                                                                          ))),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Row(
                                                              children: [
                                                                ///view
                                                                cont.reportingHead ==
                                                                        "0"
                                                                    ? const Opacity(
                                                                        opacity:
                                                                            0.0)
                                                                    : Flexible(
                                                                        child:
                                                                            GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          cont.navigateToServiceView(
                                                                              item.id!,
                                                                              item.client!,
                                                                              item.servicename!,
                                                                              item.clientCode!);
                                                                        },
                                                                        child: buildButtonWidget(
                                                                            context,
                                                                            "View",
                                                                            height:
                                                                                40.0,
                                                                            buttonColor:
                                                                                errorColor,
                                                                            buttonFontSize:
                                                                                14.0),
                                                                      )),

                                                                ///reassign
                                                                cont.reportingHead ==
                                                                        "0"
                                                                    ? const Opacity(
                                                                        opacity:
                                                                            0.0)
                                                                    : const SizedBox(
                                                                        width:
                                                                            10.0,
                                                                      ),
                                                                cont.reportingHead ==
                                                                        "0"
                                                                    ? const Opacity(
                                                                        opacity:
                                                                            0.0)
                                                                    : Flexible(
                                                                        child:
                                                                            GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          cont.navigateToDetails(
                                                                              item.id!,
                                                                              item.client!,
                                                                              item.servicename!,
                                                                              item.allottedTo!);
                                                                        },
                                                                        child: buildButtonWidget(
                                                                            context,
                                                                            "Reassign",
                                                                            height:
                                                                                40.0,
                                                                            buttonColor:
                                                                                Colors.orange,
                                                                            buttonFontSize: 14.0),
                                                                      )),

                                                                ///start service
                                                                const SizedBox(
                                                                  width: 10.0,
                                                                ),
                                                                Flexible(
                                                                    child:
                                                                        GestureDetector(
                                                                  onTap: () {
                                                                    cont.callStartService(
                                                                        item.id!,
                                                                        cont.selectedMainType);
                                                                  },
                                                                  child: buildButtonWidget(
                                                                      context,
                                                                      "Start Service",
                                                                      height:
                                                                          40.0,
                                                                      buttonColor:
                                                                          Colors
                                                                              .green,
                                                                      buttonFontSize:
                                                                          14.0),
                                                                )),
                                                              ],
                                                            ))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          })

                              ///started not completed
                              : cont.loader
                                  ? buildCircularIndicator()
                                  : cont.startedNotCompletedPastDueList.isEmpty
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 50.0),
                                          child: buildTextBoldWidget(
                                              "No data found",
                                              blackColor,
                                              context,
                                              16.0,
                                              align: TextAlign.center))
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: cont
                                              .startedNotCompletedPastDueList
                                              .length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            final item =
                                                cont.startedNotCompletedPastDueList[
                                                    index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, right: 5.0),
                                              child: Card(
                                                  elevation: 1.0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7.0),
                                                      side: const BorderSide(
                                                          color: grey)),
                                                  child: ExpansionTile(
                                                    tilePadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    trailing: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10.0),
                                                      child: Icon(
                                                        cont.addedIndex
                                                                .contains(index)
                                                            ? Icons
                                                                .keyboard_arrow_up
                                                            : Icons
                                                                .keyboard_arrow_down,
                                                        size: 25.0,
                                                      ),
                                                    ),
                                                    onExpansionChanged:
                                                        (value) {
                                                      cont.onExpanded(
                                                          value, index);
                                                    },
                                                    title: Column(
                                                      children: [
                                                        buildClientCodeWidget(
                                                            item.clientCode!,
                                                            item.client!,
                                                            context),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0),
                                                            child: buildTextRegularWidget(
                                                                "${item.servicename}",
                                                                blackColor,
                                                                context,
                                                                14.0,
                                                                align: TextAlign
                                                                    .left)),
                                                      ],
                                                    ),
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ///assigned to
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                              ),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  buildTextBoldWidget(
                                                                      "Assigned to - ",
                                                                      blackColor,
                                                                      context,
                                                                      14.0),
                                                                  Flexible(
                                                                      child: buildTextBoldWidget(
                                                                          "${item.allottedTo}",
                                                                          primaryColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.left)),
                                                                ],
                                                              )),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          10.0,
                                                                      right:
                                                                          10.0),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  buildTextBoldWidget(
                                                                      "Task - ",
                                                                      blackColor,
                                                                      context,
                                                                      14.0),
                                                                  Flexible(
                                                                    child: buildTextBoldWidget(
                                                                        "${item.tasks}",
                                                                        primaryColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .left),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          20.0),
                                                                  buildTextBoldWidget(
                                                                      "Completion % - ",
                                                                      blackColor,
                                                                      context,
                                                                      14.0),
                                                                  Flexible(
                                                                    child: buildTextBoldWidget(
                                                                        "${item.completionPercentage}",
                                                                        primaryColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .left),
                                                                  )
                                                                ],
                                                              )),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0,
                                                                    right: 10.0,
                                                                    top: 5.0),
                                                            child: Row(
                                                              children: [
                                                                Flexible(
                                                                  child: Container(
                                                                      height: 40.0,
                                                                      width: MediaQuery.of(context).size.width,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            const BorderRadius.all(Radius.circular(5)),
                                                                        border: Border.all(
                                                                            color:
                                                                                grey),
                                                                      ),
                                                                      child: cont.reportingHead == "0"
                                                                          ? Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                                child: buildTextRegularWidget(
                                                                                    item.priorityToShow!,
                                                                                    item.priorityToShow == "High"
                                                                                        ? const Color(0xffFF0000)
                                                                                        : item.priorityToShow == "Medium"
                                                                                            ? const Color(0xffF57C00)
                                                                                            : const Color(0xff008000),
                                                                                    context,
                                                                                    15.0,
                                                                                    align: TextAlign.left),
                                                                              ),
                                                                            )
                                                                          : Center(
                                                                              child: Padding(
                                                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                              child: DropdownButton(
                                                                                hint: buildTextRegularWidget(
                                                                                    cont.addedPriorityListForCurrent.contains(item.id)
                                                                                        ? cont.selectedCurrentPriority == ""
                                                                                            ? item.priorityToShow!
                                                                                            : cont.selectedCurrentPriority
                                                                                        : item.priorityToShow!,
                                                                                    item.priorityToShow == "High"
                                                                                        ? const Color(0xffFF0000)
                                                                                        : item.priorityToShow == "Medium"
                                                                                            ? const Color(0xffF57C00)
                                                                                            : const Color(0xff008000),
                                                                                    context,
                                                                                    15.0),
                                                                                isExpanded: true,
                                                                                underline: Container(),
                                                                                items: cont.priorityList.map((String value) {
                                                                                  return DropdownMenuItem<String>(
                                                                                    value: value,
                                                                                    child: Text(value),
                                                                                  );
                                                                                }).toList(),
                                                                                onChanged: (val) {
                                                                                  cont.updatePriorityForCurrent(val!, item.id!);
                                                                                },
                                                                              ),
                                                                            ))),
                                                                ),
                                                                const SizedBox(
                                                                    width:
                                                                        10.0),
                                                                Flexible(
                                                                  child: Container(
                                                                      height: 40.0,
                                                                      width: MediaQuery.of(context).size.width,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            const BorderRadius.all(Radius.circular(5)),
                                                                        border: Border.all(
                                                                            color:
                                                                                grey),
                                                                      ),
                                                                      child: cont.reportingHead == "0"
                                                                          ? Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                                child: buildTextRegularWidget(item.statusName!, blackColor, context, 15.0, align: TextAlign.left),
                                                                              ),
                                                                            )
                                                                          : Center(
                                                                              child: Padding(
                                                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                              child: DropdownButton(
                                                                                hint: buildTextRegularWidget(
                                                                                    cont.addedStatusListForCurrent.contains(item.id)
                                                                                        ? cont.selectedServiceStatus == ""
                                                                                            ? item.statusName!
                                                                                            : cont.selectedServiceStatus
                                                                                        : item.statusName!,
                                                                                    blackColor,
                                                                                    context,
                                                                                    15.0),
                                                                                isExpanded: true,
                                                                                underline: Container(),
                                                                                items: cont.changeStatusList.map((String value) {
                                                                                  return DropdownMenuItem<String>(
                                                                                    value: value,
                                                                                    child: Text(value),
                                                                                  );
                                                                                }).toList(),
                                                                                onChanged: (val) {
                                                                                  cont.updateStatusForCurrent(val!, item.id!, context);
                                                                                },
                                                                              ),
                                                                            ))),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0,
                                                                    right: 10.0,
                                                                    top: 5.0),
                                                            child: Table(
                                                              children: [
                                                                TableRow(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(right: 3.0),
                                                                        child: buildTextBoldWidget(
                                                                            "Triggered\nDate",
                                                                            blackColor,
                                                                            context,
                                                                            14.0,
                                                                            align:
                                                                                TextAlign.center),
                                                                      ),
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            if (cont.reportingHead ==
                                                                                "1") {
                                                                              cont.selectTargetDateForCurrent(context, item.id!, item.triggerDateTimeFormat!, item.targetDateTimeFormat!, "startedNotCompletedApiProbable", item.staDateTimeFormat!);
                                                                            }
                                                                          },
                                                                          child:
                                                                              buildTextBoldWidget(
                                                                            "Target Date",
                                                                            blackColor,
                                                                            context,
                                                                            14.0,
                                                                            align:
                                                                                TextAlign.center,
                                                                            decoration:
                                                                                TextDecoration.underline,
                                                                          )),
                                                                      buildTextBoldWidget(
                                                                          "Statutory\nDue Date",
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center),
                                                                    ]),
                                                                TableRow(
                                                                    children: [
                                                                      buildTextRegularWidget(
                                                                          item
                                                                              .triggerDateToShow!,
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          if (cont.reportingHead ==
                                                                              "1") {
                                                                            cont.selectTargetDateForCurrent(
                                                                                context,
                                                                                item.id!,
                                                                                item.triggerDateTimeFormat!,
                                                                                item.targetDateTimeFormat!,
                                                                                "startedNotCompletedApiProbable",
                                                                                item.staDateTimeFormat!);
                                                                          }
                                                                        },
                                                                        child:
                                                                            buildTextRegularWidget(
                                                                          "${cont.addedDateListForAll.contains(item.id) ? cont.selectedDateToShowForCurrent == "" ? item.targetDateToShow : cont.selectedDateToShowForCurrent : item.targetDateToShow}",
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center,
                                                                          decoration:
                                                                              TextDecoration.underline,
                                                                        ),
                                                                      ),
                                                                      buildTextRegularWidget(
                                                                          item
                                                                              .satDateToShow!,
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center),
                                                                    ]),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              child: Row(
                                                                children: [
                                                                  Flexible(
                                                                      child:
                                                                          GestureDetector(
                                                                    onTap: () {
                                                                      cont.selectedCliId =
                                                                          item.id!;
                                                                      cont.showCheckPasswordOrReasonDialog(
                                                                          "Cancel - ${item.servicename}",
                                                                          context);
                                                                    },
                                                                    child: buildButtonWidget(
                                                                        context,
                                                                        "Cancel",
                                                                        height:
                                                                            40.0,
                                                                        buttonColor:
                                                                            errorColor,
                                                                        buttonFontSize:
                                                                            14.0),
                                                                  )),
                                                                  const SizedBox(
                                                                    width: 10.0,
                                                                  ),
                                                                  Flexible(
                                                                      child:
                                                                          GestureDetector(
                                                                    onTap: () {
                                                                      cont.navigateToServiceView(
                                                                          item.id!,
                                                                          item.client!,
                                                                          item.servicename!,
                                                                          item.clientCode!);
                                                                    },
                                                                    child: buildButtonWidget(
                                                                        context,
                                                                        "Log",
                                                                        height:
                                                                            40.0,
                                                                        buttonColor:
                                                                            Colors
                                                                                .orange,
                                                                        buttonFontSize:
                                                                            14.0),
                                                                  )),
                                                                  const SizedBox(
                                                                    width: 10.0,
                                                                  ),
                                                                  Flexible(
                                                                      child:
                                                                          GestureDetector(
                                                                    onTap: () {
                                                                      cont.updateStatusForCurrent(
                                                                          "Complete",
                                                                          item.id!,
                                                                          context);
                                                                    },
                                                                    child: buildButtonWidget(
                                                                        context,
                                                                        "Complete",
                                                                        height:
                                                                            40.0,
                                                                        buttonColor:
                                                                            approveColor,
                                                                        buttonFontSize:
                                                                            14.0),
                                                                  )),
                                                                ],
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                            );
                                          }),
                        ),

                        ///high
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: cont.selectedMainType == "AllottedNotStarted"
                              ?

                              ///allotted not started
                              cont.loader
                                  ? buildCircularIndicator()
                                  : cont.allottedNotStartedPastDueList.isEmpty
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 50.0),
                                          child: buildTextBoldWidget(
                                              "No data found",
                                              blackColor,
                                              context,
                                              16.0,
                                              align: TextAlign.center))
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: cont
                                              .allottedNotStartedPastDueList
                                              .length,
                                          itemBuilder: (context, index) {
                                            final item =
                                                cont.allottedNotStartedPastDueList[
                                                    index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, right: 5.0),
                                              child: Card(
                                                elevation: 1.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.0),
                                                    side: const BorderSide(
                                                        color: grey)),
                                                child: ExpansionTile(
                                                  tilePadding:
                                                      const EdgeInsets.all(0.0),
                                                  trailing: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child: Icon(
                                                      cont.addedIndex
                                                              .contains(index)
                                                          ? Icons
                                                              .keyboard_arrow_up
                                                          : Icons
                                                              .keyboard_arrow_down,
                                                      size: 25.0,
                                                    ),
                                                  ),
                                                  onExpansionChanged: (value) {
                                                    cont.onExpanded(
                                                        value, index);
                                                  },
                                                  title: Column(
                                                    children: [
                                                      buildClientCodeWidget(
                                                          item.clientCode!,
                                                          item.client!,
                                                          context),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0),
                                                          child: buildTextRegularWidget(
                                                              "${item.servicename}",
                                                              blackColor,
                                                              context,
                                                              14.0,
                                                              align: TextAlign
                                                                  .left)),
                                                    ],
                                                  ),
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0,
                                                                    right:
                                                                        10.0),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                buildTextBoldWidget(
                                                                    "Assigned to - ",
                                                                    blackColor,
                                                                    context,
                                                                    14.0),
                                                                Flexible(
                                                                  child: buildTextBoldWidget(
                                                                      "${item.allottedTo}",
                                                                      primaryColor,
                                                                      context,
                                                                      14.0,
                                                                      align: TextAlign
                                                                          .left),
                                                                )
                                                              ],
                                                            )),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 10.0,
                                                            right: 10.0,
                                                          ),
                                                          child: Table(
                                                            children: [
                                                              TableRow(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              3.0),
                                                                      child: buildTextBoldWidget(
                                                                          "Triggered\nDate",
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center),
                                                                    ),
                                                                    GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          if (cont.reportingHead ==
                                                                              "1") {
                                                                            cont.selectTargetDateForCurrent(
                                                                                context,
                                                                                item.id!,
                                                                                item.triggerDateTimeFormat!,
                                                                                item.targetDateTimeFormat!,
                                                                                "allottedApiHigh",
                                                                                item.staDateTimeFormat!);
                                                                          }
                                                                        },
                                                                        child:
                                                                            buildTextBoldWidget(
                                                                          "Target Date",
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center,
                                                                          decoration:
                                                                              TextDecoration.underline,
                                                                        )),
                                                                    buildTextBoldWidget(
                                                                        "Statutory\nDue Date",
                                                                        blackColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .center),
                                                                  ]),
                                                              TableRow(
                                                                  children: [
                                                                    buildTextRegularWidget(
                                                                        item
                                                                            .triggerDateToShow!,
                                                                        blackColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .center),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        if (cont.reportingHead ==
                                                                            "1") {
                                                                          cont.selectTargetDateForCurrent(
                                                                              context,
                                                                              item.id!,
                                                                              item.triggerDateTimeFormat!,
                                                                              item.targetDateTimeFormat!,
                                                                              "allottedApiHigh",
                                                                              item.staDateTimeFormat!);
                                                                        }
                                                                      },
                                                                      child:
                                                                          buildTextRegularWidget(
                                                                        "${cont.addedDateListForAll.contains(item.id) ? cont.selectedDateToShowForCurrent == "" ? item.targetDateToShow : cont.selectedDateToShowForCurrent : item.targetDateToShow}",
                                                                        blackColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .center,
                                                                        decoration:
                                                                            TextDecoration.underline,
                                                                      ),
                                                                    ),
                                                                    buildTextRegularWidget(
                                                                        item
                                                                            .satDateToShow!,
                                                                        blackColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .center),
                                                                  ]),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0,
                                                                  right: 10.0,
                                                                  top: 5.0),
                                                          child: Row(
                                                            children: [
                                                              // Flexible(
                                                              //   child: GestureDetector(
                                                              //     onTap: (){
                                                              //       cont.navigateToServiceView(item.id!,item.client!,item.servicename!);
                                                              //     },
                                                              //     child: Container(
                                                              //         height: 40.0,
                                                              //         width: MediaQuery.of(context).size.width,
                                                              //         decoration: BoxDecoration(
                                                              //           borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                              //           border: Border.all(color: grey),),
                                                              //         child: Center(
                                                              //             child: Padding(
                                                              //               padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                                              //               child: buildTextRegularWidget("item.status", blackColor, context, 15.0),
                                                              //             )
                                                              //         )
                                                              //     ),
                                                              //   ),
                                                              // ),
                                                              // const SizedBox(width: 10.0,),
                                                              Flexible(
                                                                child: Container(
                                                                    height: 40.0,
                                                                    width: MediaQuery.of(context).size.width,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: const BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              5)),
                                                                      border: Border.all(
                                                                          color:
                                                                              grey),
                                                                    ),
                                                                    child: cont.reportingHead == "0"
                                                                        ? Align(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                              child: buildTextRegularWidget(
                                                                                  item.priorityToShow!,
                                                                                  item.priorityToShow == "High"
                                                                                      ? const Color(0xffFF0000)
                                                                                      : item.priorityToShow == "Medium"
                                                                                          ? const Color(0xffF57C00)
                                                                                          : const Color(0xff008000),
                                                                                  context,
                                                                                  15.0,
                                                                                  align: TextAlign.left),
                                                                            ),
                                                                          )
                                                                        : Center(
                                                                            child: Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                            child:
                                                                                DropdownButton(
                                                                              hint: buildTextRegularWidget(
                                                                                  cont.addedPriorityListForCurrent.contains(item.id)
                                                                                      ? cont.selectedCurrentPriority == ""
                                                                                          ? item.priorityToShow!
                                                                                          : cont.selectedCurrentPriority
                                                                                      : item.priorityToShow!,
                                                                                  item.priorityToShow == "High"
                                                                                      ? const Color(0xffFF0000)
                                                                                      : item.priorityToShow == "Medium"
                                                                                          ? const Color(0xffF57C00)
                                                                                          : const Color(0xff008000),
                                                                                  context,
                                                                                  15.0),
                                                                              isExpanded: true,
                                                                              underline: Container(),
                                                                              items: cont.priorityList.map((String value) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: value,
                                                                                  child: Text(value),
                                                                                );
                                                                              }).toList(),
                                                                              onChanged: (val) {
                                                                                cont.updatePriorityForCurrent(val!, item.id!);
                                                                              },
                                                                            ),
                                                                          ))),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Row(
                                                              children: [
                                                                ///view
                                                                cont.reportingHead ==
                                                                        "0"
                                                                    ? const Opacity(
                                                                        opacity:
                                                                            0.0)
                                                                    : Flexible(
                                                                        child:
                                                                            GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          cont.navigateToServiceView(
                                                                              item.id!,
                                                                              item.client!,
                                                                              item.servicename!,
                                                                              item.clientCode!);
                                                                        },
                                                                        child: buildButtonWidget(
                                                                            context,
                                                                            "View",
                                                                            height:
                                                                                40.0,
                                                                            buttonColor:
                                                                                errorColor,
                                                                            buttonFontSize:
                                                                                14.0),
                                                                      )),

                                                                ///reassign
                                                                cont.reportingHead ==
                                                                        "0"
                                                                    ? const Opacity(
                                                                        opacity:
                                                                            0.0)
                                                                    : const SizedBox(
                                                                        width:
                                                                            10.0,
                                                                      ),
                                                                cont.reportingHead ==
                                                                        "0"
                                                                    ? const Opacity(
                                                                        opacity:
                                                                            0.0)
                                                                    : Flexible(
                                                                        child:
                                                                            GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          cont.navigateToDetails(
                                                                              item.id!,
                                                                              item.client!,
                                                                              item.servicename!,
                                                                              item.allottedTo!);
                                                                        },
                                                                        child: buildButtonWidget(
                                                                            context,
                                                                            "Reassign",
                                                                            height:
                                                                                40.0,
                                                                            buttonColor:
                                                                                Colors.orange,
                                                                            buttonFontSize: 14.0),
                                                                      )),

                                                                ///start service
                                                                const SizedBox(
                                                                  width: 10.0,
                                                                ),
                                                                Flexible(
                                                                    child:
                                                                        GestureDetector(
                                                                  onTap: () {
                                                                    cont.callStartService(
                                                                        item.id!,
                                                                        cont.selectedMainType);
                                                                  },
                                                                  child: buildButtonWidget(
                                                                      context,
                                                                      "Start Service",
                                                                      height:
                                                                          40.0,
                                                                      buttonColor:
                                                                          Colors
                                                                              .green,
                                                                      buttonFontSize:
                                                                          14.0),
                                                                )),
                                                              ],
                                                            ))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          })

                              ///started not completed
                              : cont.loader
                                  ? buildCircularIndicator()
                                  : cont.startedNotCompletedPastDueList.isEmpty
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 50.0),
                                          child: buildTextBoldWidget(
                                              "No data found",
                                              blackColor,
                                              context,
                                              16.0,
                                              align: TextAlign.center))
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: cont
                                              .startedNotCompletedPastDueList
                                              .length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            final item =
                                                cont.startedNotCompletedPastDueList[
                                                    index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, right: 5.0),
                                              child: Card(
                                                  elevation: 1.0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7.0),
                                                      side: const BorderSide(
                                                          color: grey)),
                                                  child: ExpansionTile(
                                                    tilePadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    trailing: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10.0),
                                                      child: Icon(
                                                        cont.addedIndex
                                                                .contains(index)
                                                            ? Icons
                                                                .keyboard_arrow_up
                                                            : Icons
                                                                .keyboard_arrow_down,
                                                        size: 25.0,
                                                      ),
                                                    ),
                                                    onExpansionChanged:
                                                        (value) {
                                                      cont.onExpanded(
                                                          value, index);
                                                    },
                                                    title: Column(
                                                      children: [
                                                        buildClientCodeWidget(
                                                            item.clientCode!,
                                                            item.client!,
                                                            context),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0),
                                                            child: buildTextRegularWidget(
                                                                "${item.servicename}",
                                                                blackColor,
                                                                context,
                                                                14.0,
                                                                align: TextAlign
                                                                    .left)),
                                                      ],
                                                    ),
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ///assigned to
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                              ),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  buildTextBoldWidget(
                                                                      "Assigned to - ",
                                                                      blackColor,
                                                                      context,
                                                                      14.0),
                                                                  Flexible(
                                                                      child: buildTextBoldWidget(
                                                                          "${item.allottedTo}",
                                                                          primaryColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.left)),
                                                                ],
                                                              )),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          10.0,
                                                                      right:
                                                                          10.0),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  buildTextBoldWidget(
                                                                      "Task - ",
                                                                      blackColor,
                                                                      context,
                                                                      14.0),
                                                                  Flexible(
                                                                    child: buildTextBoldWidget(
                                                                        "${item.tasks}",
                                                                        primaryColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .left),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          20.0),
                                                                  buildTextBoldWidget(
                                                                      "Completion % - ",
                                                                      blackColor,
                                                                      context,
                                                                      14.0),
                                                                  Flexible(
                                                                    child: buildTextBoldWidget(
                                                                        "${item.completionPercentage}",
                                                                        primaryColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .left),
                                                                  )
                                                                ],
                                                              )),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0,
                                                                    right: 10.0,
                                                                    top: 5.0),
                                                            child: Row(
                                                              children: [
                                                                Flexible(
                                                                  child: Container(
                                                                      height: 40.0,
                                                                      width: MediaQuery.of(context).size.width,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            const BorderRadius.all(Radius.circular(5)),
                                                                        border: Border.all(
                                                                            color:
                                                                                grey),
                                                                      ),
                                                                      child: cont.reportingHead == "0"
                                                                          ? Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                                child: buildTextRegularWidget(
                                                                                    item.priorityToShow!,
                                                                                    item.priorityToShow == "High"
                                                                                        ? const Color(0xffFF0000)
                                                                                        : item.priorityToShow == "Medium"
                                                                                            ? const Color(0xffF57C00)
                                                                                            : const Color(0xff008000),
                                                                                    context,
                                                                                    15.0,
                                                                                    align: TextAlign.left),
                                                                              ),
                                                                            )
                                                                          : Center(
                                                                              child: Padding(
                                                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                              child: DropdownButton(
                                                                                hint: buildTextRegularWidget(
                                                                                    cont.addedPriorityListForCurrent.contains(item.id)
                                                                                        ? cont.selectedCurrentPriority == ""
                                                                                            ? item.priorityToShow!
                                                                                            : cont.selectedCurrentPriority
                                                                                        : item.priorityToShow!,
                                                                                    item.priorityToShow == "High"
                                                                                        ? const Color(0xffFF0000)
                                                                                        : item.priorityToShow == "Medium"
                                                                                            ? const Color(0xffF57C00)
                                                                                            : const Color(0xff008000),
                                                                                    context,
                                                                                    15.0),
                                                                                isExpanded: true,
                                                                                underline: Container(),
                                                                                items: cont.priorityList.map((String value) {
                                                                                  return DropdownMenuItem<String>(
                                                                                    value: value,
                                                                                    child: Text(value),
                                                                                  );
                                                                                }).toList(),
                                                                                onChanged: (val) {
                                                                                  cont.updatePriorityForCurrent(val!, item.id!);
                                                                                },
                                                                              ),
                                                                            ))),
                                                                ),
                                                                const SizedBox(
                                                                    width:
                                                                        10.0),
                                                                Flexible(
                                                                  child: Container(
                                                                      height: 40.0,
                                                                      width: MediaQuery.of(context).size.width,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            const BorderRadius.all(Radius.circular(5)),
                                                                        border: Border.all(
                                                                            color:
                                                                                grey),
                                                                      ),
                                                                      child: cont.reportingHead == "0"
                                                                          ? Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                                child: buildTextRegularWidget(item.statusName!, blackColor, context, 15.0, align: TextAlign.left),
                                                                              ),
                                                                            )
                                                                          : Center(
                                                                              child: Padding(
                                                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                              child: DropdownButton(
                                                                                hint: buildTextRegularWidget(
                                                                                    cont.addedStatusListForCurrent.contains(item.id)
                                                                                        ? cont.selectedServiceStatus == ""
                                                                                            ? item.statusName!
                                                                                            : cont.selectedServiceStatus
                                                                                        : item.statusName!,
                                                                                    blackColor,
                                                                                    context,
                                                                                    15.0),
                                                                                isExpanded: true,
                                                                                underline: Container(),
                                                                                items: cont.changeStatusList.map((String value) {
                                                                                  return DropdownMenuItem<String>(
                                                                                    value: value,
                                                                                    child: Text(value),
                                                                                  );
                                                                                }).toList(),
                                                                                onChanged: (val) {
                                                                                  cont.updateStatusForCurrent(val!, item.id!, context);
                                                                                },
                                                                              ),
                                                                            ))),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0,
                                                                    right: 10.0,
                                                                    top: 5.0),
                                                            child: Table(
                                                              children: [
                                                                TableRow(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(right: 3.0),
                                                                        child: buildTextBoldWidget(
                                                                            "Triggered\nDate",
                                                                            blackColor,
                                                                            context,
                                                                            14.0,
                                                                            align:
                                                                                TextAlign.center),
                                                                      ),
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            if (cont.reportingHead ==
                                                                                "1") {
                                                                              cont.selectTargetDateForCurrent(context, item.id!, item.triggerDateTimeFormat!, item.targetDateTimeFormat!, "startedNotCompletedApiHigh", item.staDateTimeFormat!);
                                                                            }
                                                                          },
                                                                          child:
                                                                              buildTextBoldWidget(
                                                                            "Target Date",
                                                                            blackColor,
                                                                            context,
                                                                            14.0,
                                                                            align:
                                                                                TextAlign.center,
                                                                            decoration:
                                                                                TextDecoration.underline,
                                                                          )),
                                                                      buildTextBoldWidget(
                                                                          "Statutory\nDue Date",
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center),
                                                                    ]),
                                                                TableRow(
                                                                    children: [
                                                                      buildTextRegularWidget(
                                                                          item
                                                                              .triggerDateToShow!,
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          if (cont.reportingHead ==
                                                                              "1") {
                                                                            cont.selectTargetDateForCurrent(
                                                                                context,
                                                                                item.id!,
                                                                                item.triggerDateTimeFormat!,
                                                                                item.targetDateTimeFormat!,
                                                                                "startedNotCompletedApiHigh",
                                                                                item.staDateTimeFormat!);
                                                                          }
                                                                        },
                                                                        child:
                                                                            buildTextRegularWidget(
                                                                          "${cont.addedDateListForAll.contains(item.id) ? cont.selectedDateToShowForCurrent == "" ? item.targetDateToShow : cont.selectedDateToShowForCurrent : item.targetDateToShow}",
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center,
                                                                          decoration:
                                                                              TextDecoration.underline,
                                                                        ),
                                                                      ),
                                                                      buildTextRegularWidget(
                                                                          item
                                                                              .satDateToShow!,
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center),
                                                                    ]),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              child: Row(
                                                                children: [
                                                                  Flexible(
                                                                      child:
                                                                          GestureDetector(
                                                                    onTap: () {
                                                                      cont.selectedCliId =
                                                                          item.id!;
                                                                      cont.showCheckPasswordOrReasonDialog(
                                                                          "Cancel - ${item.servicename}",
                                                                          context);
                                                                    },
                                                                    child: buildButtonWidget(
                                                                        context,
                                                                        "Cancel",
                                                                        height:
                                                                            40.0,
                                                                        buttonColor:
                                                                            errorColor,
                                                                        buttonFontSize:
                                                                            14.0),
                                                                  )),
                                                                  const SizedBox(
                                                                    width: 10.0,
                                                                  ),
                                                                  Flexible(
                                                                      child:
                                                                          GestureDetector(
                                                                    onTap: () {
                                                                      cont.navigateToServiceView(
                                                                          item.id!,
                                                                          item.client!,
                                                                          item.servicename!,
                                                                          item.clientCode!);
                                                                    },
                                                                    child: buildButtonWidget(
                                                                        context,
                                                                        "Log",
                                                                        height:
                                                                            40.0,
                                                                        buttonColor:
                                                                            Colors
                                                                                .orange,
                                                                        buttonFontSize:
                                                                            14.0),
                                                                  )),
                                                                  const SizedBox(
                                                                    width: 10.0,
                                                                  ),
                                                                  Flexible(
                                                                      child:
                                                                          GestureDetector(
                                                                    onTap: () {
                                                                      cont.updateStatusForCurrent(
                                                                          "Complete",
                                                                          item.id!,
                                                                          context);
                                                                    },
                                                                    child: buildButtonWidget(
                                                                        context,
                                                                        "Complete",
                                                                        height:
                                                                            40.0,
                                                                        buttonColor:
                                                                            approveColor,
                                                                        buttonFontSize:
                                                                            14.0),
                                                                  )),
                                                                ],
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                            );
                                          }),
                        ),

                        ///medium
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: cont.selectedMainType == "AllottedNotStarted"
                              ?

                              ///allotted not started
                              cont.loader
                                  ? buildCircularIndicator()
                                  : cont.allottedNotStartedPastDueList.isEmpty
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 50.0),
                                          child: buildTextBoldWidget(
                                              "No data found",
                                              blackColor,
                                              context,
                                              16.0,
                                              align: TextAlign.center))
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: cont
                                              .allottedNotStartedPastDueList
                                              .length,
                                          itemBuilder: (context, index) {
                                            final item =
                                                cont.allottedNotStartedPastDueList[
                                                    index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, right: 5.0),
                                              child: Card(
                                                elevation: 1.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.0),
                                                    side: const BorderSide(
                                                        color: grey)),
                                                child: ExpansionTile(
                                                  tilePadding:
                                                      const EdgeInsets.all(0.0),
                                                  trailing: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child: Icon(
                                                      cont.addedIndex
                                                              .contains(index)
                                                          ? Icons
                                                              .keyboard_arrow_up
                                                          : Icons
                                                              .keyboard_arrow_down,
                                                      size: 25.0,
                                                    ),
                                                  ),
                                                  onExpansionChanged: (value) {
                                                    cont.onExpanded(
                                                        value, index);
                                                  },
                                                  title: Column(
                                                    children: [
                                                      buildClientCodeWidget(
                                                          item.clientCode!,
                                                          item.client!,
                                                          context),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0),
                                                          child: buildTextRegularWidget(
                                                              "${item.servicename}",
                                                              blackColor,
                                                              context,
                                                              14.0,
                                                              align: TextAlign
                                                                  .left)),
                                                    ],
                                                  ),
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0,
                                                                    right:
                                                                        10.0),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                buildTextBoldWidget(
                                                                    "Assigned to - ",
                                                                    blackColor,
                                                                    context,
                                                                    14.0),
                                                                Flexible(
                                                                  child: buildTextBoldWidget(
                                                                      "${item.allottedTo}",
                                                                      primaryColor,
                                                                      context,
                                                                      14.0,
                                                                      align: TextAlign
                                                                          .left),
                                                                )
                                                              ],
                                                            )),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 10.0,
                                                            right: 10.0,
                                                          ),
                                                          child: Table(
                                                            children: [
                                                              TableRow(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              3.0),
                                                                      child: buildTextBoldWidget(
                                                                          "Triggered\nDate",
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center),
                                                                    ),
                                                                    GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          if (cont.reportingHead ==
                                                                              "1") {
                                                                            cont.selectTargetDateForCurrent(
                                                                                context,
                                                                                item.id!,
                                                                                item.triggerDateTimeFormat!,
                                                                                item.targetDateTimeFormat!,
                                                                                "allottedApiMedium",
                                                                                item.staDateTimeFormat!);
                                                                          }
                                                                        },
                                                                        child:
                                                                            buildTextBoldWidget(
                                                                          "Target Date",
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center,
                                                                          decoration:
                                                                              TextDecoration.underline,
                                                                        )),
                                                                    buildTextBoldWidget(
                                                                        "Statutory\nDue Date",
                                                                        blackColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .center),
                                                                  ]),
                                                              TableRow(
                                                                  children: [
                                                                    buildTextRegularWidget(
                                                                        item
                                                                            .triggerDateToShow!,
                                                                        blackColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .center),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        if (cont.reportingHead ==
                                                                            "1") {
                                                                          cont.selectTargetDateForCurrent(
                                                                              context,
                                                                              item.id!,
                                                                              item.triggerDateTimeFormat!,
                                                                              item.targetDateTimeFormat!,
                                                                              "allottedApiMedium",
                                                                              item.staDateTimeFormat!);
                                                                        }
                                                                      },
                                                                      child:
                                                                          buildTextRegularWidget(
                                                                        "${cont.addedDateListForAll.contains(item.id) ? cont.selectedDateToShowForCurrent == "" ? item.targetDateToShow : cont.selectedDateToShowForCurrent : item.targetDateToShow}",
                                                                        blackColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .center,
                                                                        decoration:
                                                                            TextDecoration.underline,
                                                                      ),
                                                                    ),
                                                                    buildTextRegularWidget(
                                                                        item
                                                                            .satDateToShow!,
                                                                        blackColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .center),
                                                                  ]),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0,
                                                                  right: 10.0,
                                                                  top: 5.0),
                                                          child: Row(
                                                            children: [
                                                              // Flexible(
                                                              //   child: GestureDetector(
                                                              //     onTap: (){
                                                              //       cont.navigateToServiceView(item.id!,item.client!,item.servicename!);
                                                              //     },
                                                              //     child: Container(
                                                              //         height: 40.0,
                                                              //         width: MediaQuery.of(context).size.width,
                                                              //         decoration: BoxDecoration(
                                                              //           borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                              //           border: Border.all(color: grey),),
                                                              //         child: Center(
                                                              //             child: Padding(
                                                              //               padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                                              //               child: buildTextRegularWidget("item.status", blackColor, context, 15.0),
                                                              //             )
                                                              //         )
                                                              //     ),
                                                              //   ),
                                                              // ),
                                                              // const SizedBox(width: 10.0,),
                                                              Flexible(
                                                                child: Container(
                                                                    height: 40.0,
                                                                    width: MediaQuery.of(context).size.width,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: const BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              5)),
                                                                      border: Border.all(
                                                                          color:
                                                                              grey),
                                                                    ),
                                                                    child: cont.reportingHead == "0"
                                                                        ? Align(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                              child: buildTextRegularWidget(
                                                                                  item.priorityToShow!,
                                                                                  item.priorityToShow == "High"
                                                                                      ? const Color(0xffFF0000)
                                                                                      : item.priorityToShow == "Medium"
                                                                                          ? const Color(0xffF57C00)
                                                                                          : const Color(0xff008000),
                                                                                  context,
                                                                                  15.0,
                                                                                  align: TextAlign.left),
                                                                            ),
                                                                          )
                                                                        : Center(
                                                                            child: Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                            child:
                                                                                DropdownButton(
                                                                              hint: buildTextRegularWidget(
                                                                                  cont.addedPriorityListForCurrent.contains(item.id)
                                                                                      ? cont.selectedCurrentPriority == ""
                                                                                          ? item.priorityToShow!
                                                                                          : cont.selectedCurrentPriority
                                                                                      : item.priorityToShow!,
                                                                                  item.priorityToShow == "High"
                                                                                      ? const Color(0xffFF0000)
                                                                                      : item.priorityToShow == "Medium"
                                                                                          ? const Color(0xffF57C00)
                                                                                          : const Color(0xff008000),
                                                                                  context,
                                                                                  15.0),
                                                                              isExpanded: true,
                                                                              underline: Container(),
                                                                              items: cont.priorityList.map((String value) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: value,
                                                                                  child: Text(value),
                                                                                );
                                                                              }).toList(),
                                                                              onChanged: (val) {
                                                                                cont.updatePriorityForCurrent(val!, item.id!);
                                                                              },
                                                                            ),
                                                                          ))),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Row(
                                                              children: [
                                                                ///view
                                                                cont.reportingHead ==
                                                                        "0"
                                                                    ? const Opacity(
                                                                        opacity:
                                                                            0.0)
                                                                    : Flexible(
                                                                        child:
                                                                            GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          cont.navigateToServiceView(
                                                                              item.id!,
                                                                              item.client!,
                                                                              item.servicename!,
                                                                              item.clientCode!);
                                                                        },
                                                                        child: buildButtonWidget(
                                                                            context,
                                                                            "View",
                                                                            height:
                                                                                40.0,
                                                                            buttonColor:
                                                                                errorColor,
                                                                            buttonFontSize:
                                                                                14.0),
                                                                      )),

                                                                ///reassign
                                                                cont.reportingHead ==
                                                                        "0"
                                                                    ? const Opacity(
                                                                        opacity:
                                                                            0.0)
                                                                    : const SizedBox(
                                                                        width:
                                                                            10.0,
                                                                      ),
                                                                cont.reportingHead ==
                                                                        "0"
                                                                    ? const Opacity(
                                                                        opacity:
                                                                            0.0)
                                                                    : Flexible(
                                                                        child:
                                                                            GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          cont.navigateToDetails(
                                                                              item.id!,
                                                                              item.client!,
                                                                              item.servicename!,
                                                                              item.allottedTo!);
                                                                        },
                                                                        child: buildButtonWidget(
                                                                            context,
                                                                            "Reassign",
                                                                            height:
                                                                                40.0,
                                                                            buttonColor:
                                                                                Colors.orange,
                                                                            buttonFontSize: 14.0),
                                                                      )),

                                                                ///start service
                                                                const SizedBox(
                                                                  width: 10.0,
                                                                ),
                                                                Flexible(
                                                                    child:
                                                                        GestureDetector(
                                                                  onTap: () {
                                                                    cont.callStartService(
                                                                        item.id!,
                                                                        cont.selectedMainType);
                                                                  },
                                                                  child: buildButtonWidget(
                                                                      context,
                                                                      "Start Service",
                                                                      height:
                                                                          40.0,
                                                                      buttonColor:
                                                                          Colors
                                                                              .green,
                                                                      buttonFontSize:
                                                                          14.0),
                                                                )),
                                                              ],
                                                            ))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          })

                              ///started not completed
                              : cont.loader
                                  ? buildCircularIndicator()
                                  : cont.startedNotCompletedPastDueList.isEmpty
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 50.0),
                                          child: buildTextBoldWidget(
                                              "No data found",
                                              blackColor,
                                              context,
                                              16.0,
                                              align: TextAlign.center))
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: cont
                                              .startedNotCompletedPastDueList
                                              .length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            final item =
                                                cont.startedNotCompletedPastDueList[
                                                    index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, right: 5.0),
                                              child: Card(
                                                  elevation: 1.0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7.0),
                                                      side: const BorderSide(
                                                          color: grey)),
                                                  child: ExpansionTile(
                                                    tilePadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    trailing: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10.0),
                                                      child: Icon(
                                                        cont.addedIndex
                                                                .contains(index)
                                                            ? Icons
                                                                .keyboard_arrow_up
                                                            : Icons
                                                                .keyboard_arrow_down,
                                                        size: 25.0,
                                                      ),
                                                    ),
                                                    onExpansionChanged:
                                                        (value) {
                                                      cont.onExpanded(
                                                          value, index);
                                                    },
                                                    title: Column(
                                                      children: [
                                                        buildClientCodeWidget(
                                                            item.clientCode!,
                                                            item.client!,
                                                            context),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0),
                                                            child: buildTextRegularWidget(
                                                                "${item.servicename}",
                                                                blackColor,
                                                                context,
                                                                14.0,
                                                                align: TextAlign
                                                                    .left)),
                                                      ],
                                                    ),
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ///assigned to
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                              ),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  buildTextBoldWidget(
                                                                      "Assigned to - ",
                                                                      blackColor,
                                                                      context,
                                                                      14.0),
                                                                  Flexible(
                                                                      child: buildTextBoldWidget(
                                                                          "${item.allottedTo}",
                                                                          primaryColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.left)),
                                                                ],
                                                              )),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          10.0,
                                                                      right:
                                                                          10.0),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  buildTextBoldWidget(
                                                                      "Task - ",
                                                                      blackColor,
                                                                      context,
                                                                      14.0),
                                                                  Flexible(
                                                                    child: buildTextBoldWidget(
                                                                        "${item.tasks}",
                                                                        primaryColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .left),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          20.0),
                                                                  buildTextBoldWidget(
                                                                      "Completion % - ",
                                                                      blackColor,
                                                                      context,
                                                                      14.0),
                                                                  Flexible(
                                                                    child: buildTextBoldWidget(
                                                                        "${item.completionPercentage}",
                                                                        primaryColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .left),
                                                                  )
                                                                ],
                                                              )),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0,
                                                                    right: 10.0,
                                                                    top: 5.0),
                                                            child: Row(
                                                              children: [
                                                                Flexible(
                                                                  child: Container(
                                                                      height: 40.0,
                                                                      width: MediaQuery.of(context).size.width,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            const BorderRadius.all(Radius.circular(5)),
                                                                        border: Border.all(
                                                                            color:
                                                                                grey),
                                                                      ),
                                                                      child: cont.reportingHead == "0"
                                                                          ? Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                                child: buildTextRegularWidget(
                                                                                    item.priorityToShow!,
                                                                                    item.priorityToShow == "High"
                                                                                        ? const Color(0xffFF0000)
                                                                                        : item.priorityToShow == "Medium"
                                                                                            ? const Color(0xffF57C00)
                                                                                            : const Color(0xff008000),
                                                                                    context,
                                                                                    15.0,
                                                                                    align: TextAlign.left),
                                                                              ),
                                                                            )
                                                                          : Center(
                                                                              child: Padding(
                                                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                              child: DropdownButton(
                                                                                hint: buildTextRegularWidget(
                                                                                    cont.addedPriorityListForCurrent.contains(item.id)
                                                                                        ? cont.selectedCurrentPriority == ""
                                                                                            ? item.priorityToShow!
                                                                                            : cont.selectedCurrentPriority
                                                                                        : item.priorityToShow!,
                                                                                    item.priorityToShow == "High"
                                                                                        ? const Color(0xffFF0000)
                                                                                        : item.priorityToShow == "Medium"
                                                                                            ? const Color(0xffF57C00)
                                                                                            : const Color(0xff008000),
                                                                                    context,
                                                                                    15.0),
                                                                                isExpanded: true,
                                                                                underline: Container(),
                                                                                items: cont.priorityList.map((String value) {
                                                                                  return DropdownMenuItem<String>(
                                                                                    value: value,
                                                                                    child: Text(value),
                                                                                  );
                                                                                }).toList(),
                                                                                onChanged: (val) {
                                                                                  cont.updatePriorityForCurrent(val!, item.id!);
                                                                                },
                                                                              ),
                                                                            ))),
                                                                ),
                                                                const SizedBox(
                                                                    width:
                                                                        10.0),
                                                                Flexible(
                                                                  child: Container(
                                                                      height: 40.0,
                                                                      width: MediaQuery.of(context).size.width,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            const BorderRadius.all(Radius.circular(5)),
                                                                        border: Border.all(
                                                                            color:
                                                                                grey),
                                                                      ),
                                                                      child: cont.reportingHead == "0"
                                                                          ? Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                                child: buildTextRegularWidget(item.statusName!, blackColor, context, 15.0, align: TextAlign.left),
                                                                              ),
                                                                            )
                                                                          : Center(
                                                                              child: Padding(
                                                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                              child: DropdownButton(
                                                                                hint: buildTextRegularWidget(
                                                                                    cont.addedStatusListForCurrent.contains(item.id)
                                                                                        ? cont.selectedServiceStatus == ""
                                                                                            ? item.statusName!
                                                                                            : cont.selectedServiceStatus
                                                                                        : item.statusName!,
                                                                                    blackColor,
                                                                                    context,
                                                                                    15.0),
                                                                                isExpanded: true,
                                                                                underline: Container(),
                                                                                items: cont.changeStatusList.map((String value) {
                                                                                  return DropdownMenuItem<String>(
                                                                                    value: value,
                                                                                    child: Text(value),
                                                                                  );
                                                                                }).toList(),
                                                                                onChanged: (val) {
                                                                                  cont.updateStatusForCurrent(val!, item.id!, context);
                                                                                },
                                                                              ),
                                                                            ))),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0,
                                                                    right: 10.0,
                                                                    top: 5.0),
                                                            child: Table(
                                                              children: [
                                                                TableRow(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(right: 3.0),
                                                                        child: buildTextBoldWidget(
                                                                            "Triggered\nDate",
                                                                            blackColor,
                                                                            context,
                                                                            14.0,
                                                                            align:
                                                                                TextAlign.center),
                                                                      ),
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            if (cont.reportingHead ==
                                                                                "1") {
                                                                              cont.selectTargetDateForCurrent(context, item.id!, item.triggerDateTimeFormat!, item.targetDateTimeFormat!, "startedNotCompletedApiMedium", item.staDateTimeFormat!);
                                                                            }
                                                                          },
                                                                          child:
                                                                              buildTextBoldWidget(
                                                                            "Target Date",
                                                                            blackColor,
                                                                            context,
                                                                            14.0,
                                                                            align:
                                                                                TextAlign.center,
                                                                            decoration:
                                                                                TextDecoration.underline,
                                                                          )),
                                                                      buildTextBoldWidget(
                                                                          "Statutory\nDue Date",
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center),
                                                                    ]),
                                                                TableRow(
                                                                    children: [
                                                                      buildTextRegularWidget(
                                                                          item
                                                                              .triggerDateToShow!,
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          if (cont.reportingHead ==
                                                                              "1") {
                                                                            cont.selectTargetDateForCurrent(
                                                                                context,
                                                                                item.id!,
                                                                                item.triggerDateTimeFormat!,
                                                                                item.targetDateTimeFormat!,
                                                                                "startedNotCompletedApiMedium",
                                                                                item.staDateTimeFormat!);
                                                                          }
                                                                        },
                                                                        child:
                                                                            buildTextRegularWidget(
                                                                          "${cont.addedDateListForAll.contains(item.id) ? cont.selectedDateToShowForCurrent == "" ? item.targetDateToShow : cont.selectedDateToShowForCurrent : item.targetDateToShow}",
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center,
                                                                          decoration:
                                                                              TextDecoration.underline,
                                                                        ),
                                                                      ),
                                                                      buildTextRegularWidget(
                                                                          item
                                                                              .satDateToShow!,
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center),
                                                                    ]),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              child: Row(
                                                                children: [
                                                                  Flexible(
                                                                      child:
                                                                          GestureDetector(
                                                                    onTap: () {
                                                                      cont.selectedCliId =
                                                                          item.id!;
                                                                      cont.showCheckPasswordOrReasonDialog(
                                                                          "Cancel - ${item.servicename}",
                                                                          context);
                                                                    },
                                                                    child: buildButtonWidget(
                                                                        context,
                                                                        "Cancel",
                                                                        height:
                                                                            40.0,
                                                                        buttonColor:
                                                                            errorColor,
                                                                        buttonFontSize:
                                                                            14.0),
                                                                  )),
                                                                  const SizedBox(
                                                                    width: 10.0,
                                                                  ),
                                                                  Flexible(
                                                                      child:
                                                                          GestureDetector(
                                                                    onTap: () {
                                                                      cont.navigateToServiceView(
                                                                          item.id!,
                                                                          item.client!,
                                                                          item.servicename!,
                                                                          item.clientCode!);
                                                                    },
                                                                    child: buildButtonWidget(
                                                                        context,
                                                                        "Log",
                                                                        height:
                                                                            40.0,
                                                                        buttonColor:
                                                                            Colors
                                                                                .orange,
                                                                        buttonFontSize:
                                                                            14.0),
                                                                  )),
                                                                  const SizedBox(
                                                                    width: 10.0,
                                                                  ),
                                                                  Flexible(
                                                                      child:
                                                                          GestureDetector(
                                                                    onTap: () {
                                                                      cont.updateStatusForCurrent(
                                                                          "Complete",
                                                                          item.id!,
                                                                          context);
                                                                    },
                                                                    child: buildButtonWidget(
                                                                        context,
                                                                        "Complete",
                                                                        height:
                                                                            40.0,
                                                                        buttonColor:
                                                                            approveColor,
                                                                        buttonFontSize:
                                                                            14.0),
                                                                  )),
                                                                ],
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                            );
                                          }),
                        ),

                        ///low
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: cont.selectedMainType == "AllottedNotStarted"
                              ?

                              ///allotted not started
                              cont.loader
                                  ? buildCircularIndicator()
                                  : cont.allottedNotStartedPastDueList.isEmpty
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 50.0),
                                          child: buildTextBoldWidget(
                                              "No data found",
                                              blackColor,
                                              context,
                                              16.0,
                                              align: TextAlign.center))
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: cont
                                              .allottedNotStartedPastDueList
                                              .length,
                                          itemBuilder: (context, index) {
                                            final item =
                                                cont.allottedNotStartedPastDueList[
                                                    index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, right: 5.0),
                                              child: Card(
                                                elevation: 1.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.0),
                                                    side: const BorderSide(
                                                        color: grey)),
                                                child: ExpansionTile(
                                                  tilePadding:
                                                      const EdgeInsets.all(0.0),
                                                  trailing: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child: Icon(
                                                      cont.addedIndex
                                                              .contains(index)
                                                          ? Icons
                                                              .keyboard_arrow_up
                                                          : Icons
                                                              .keyboard_arrow_down,
                                                      size: 25.0,
                                                    ),
                                                  ),
                                                  onExpansionChanged: (value) {
                                                    cont.onExpanded(
                                                        value, index);
                                                  },
                                                  title: Column(
                                                    children: [
                                                      buildClientCodeWidget(
                                                          item.clientCode!,
                                                          item.client!,
                                                          context),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0),
                                                          child: buildTextRegularWidget(
                                                              "${item.servicename}",
                                                              blackColor,
                                                              context,
                                                              14.0,
                                                              align: TextAlign
                                                                  .left)),
                                                    ],
                                                  ),
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0,
                                                                    right:
                                                                        10.0),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                buildTextBoldWidget(
                                                                    "Assigned to - ",
                                                                    blackColor,
                                                                    context,
                                                                    14.0),
                                                                Flexible(
                                                                  child: buildTextBoldWidget(
                                                                      "${item.allottedTo}",
                                                                      primaryColor,
                                                                      context,
                                                                      14.0,
                                                                      align: TextAlign
                                                                          .left),
                                                                )
                                                              ],
                                                            )),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 10.0,
                                                            right: 10.0,
                                                          ),
                                                          child: Table(
                                                            children: [
                                                              TableRow(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              3.0),
                                                                      child: buildTextBoldWidget(
                                                                          "Triggered\nDate",
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center),
                                                                    ),
                                                                    GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          if (cont.reportingHead ==
                                                                              "1") {
                                                                            cont.selectTargetDateForCurrent(
                                                                                context,
                                                                                item.id!,
                                                                                item.triggerDateTimeFormat!,
                                                                                item.targetDateTimeFormat!,
                                                                                "allottedApiLow",
                                                                                item.staDateTimeFormat!);
                                                                          }
                                                                        },
                                                                        child:
                                                                            buildTextBoldWidget(
                                                                          "Target Date",
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center,
                                                                          decoration:
                                                                              TextDecoration.underline,
                                                                        )),
                                                                    buildTextBoldWidget(
                                                                        "Statutory\nDue Date",
                                                                        blackColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .center),
                                                                  ]),
                                                              TableRow(
                                                                  children: [
                                                                    buildTextRegularWidget(
                                                                        item
                                                                            .triggerDateToShow!,
                                                                        blackColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .center),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        if (cont.reportingHead ==
                                                                            "1") {
                                                                          cont.selectTargetDateForCurrent(
                                                                              context,
                                                                              item.id!,
                                                                              item.triggerDateTimeFormat!,
                                                                              item.targetDateTimeFormat!,
                                                                              "allottedApiLow",
                                                                              item.staDateTimeFormat!);
                                                                        }
                                                                      },
                                                                      child:
                                                                          buildTextRegularWidget(
                                                                        "${cont.addedDateListForAll.contains(item.id) ? cont.selectedDateToShowForCurrent == "" ? item.targetDateToShow : cont.selectedDateToShowForCurrent : item.targetDateToShow}",
                                                                        blackColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .center,
                                                                        decoration:
                                                                            TextDecoration.underline,
                                                                      ),
                                                                    ),
                                                                    buildTextRegularWidget(
                                                                        item
                                                                            .satDateToShow!,
                                                                        blackColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .center),
                                                                  ]),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0,
                                                                  right: 10.0,
                                                                  top: 5.0),
                                                          child: Row(
                                                            children: [
                                                              // Flexible(
                                                              //   child: GestureDetector(
                                                              //     onTap: (){
                                                              //       cont.navigateToServiceView(item.id!,item.client!,item.servicename!);
                                                              //     },
                                                              //     child: Container(
                                                              //         height: 40.0,
                                                              //         width: MediaQuery.of(context).size.width,
                                                              //         decoration: BoxDecoration(
                                                              //           borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                              //           border: Border.all(color: grey),),
                                                              //         child: Center(
                                                              //             child: Padding(
                                                              //               padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                                              //               child: buildTextRegularWidget("item.status", blackColor, context, 15.0),
                                                              //             )
                                                              //         )
                                                              //     ),
                                                              //   ),
                                                              // ),
                                                              // const SizedBox(width: 10.0,),
                                                              Flexible(
                                                                child: Container(
                                                                    height: 40.0,
                                                                    width: MediaQuery.of(context).size.width,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: const BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              5)),
                                                                      border: Border.all(
                                                                          color:
                                                                              grey),
                                                                    ),
                                                                    child: cont.reportingHead == "0"
                                                                        ? Align(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                              child: buildTextRegularWidget(
                                                                                  item.priorityToShow!,
                                                                                  item.priorityToShow == "High"
                                                                                      ? const Color(0xffFF0000)
                                                                                      : item.priorityToShow == "Medium"
                                                                                          ? const Color(0xffF57C00)
                                                                                          : const Color(0xff008000),
                                                                                  context,
                                                                                  15.0,
                                                                                  align: TextAlign.left),
                                                                            ),
                                                                          )
                                                                        : Center(
                                                                            child: Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                            child:
                                                                                DropdownButton(
                                                                              hint: buildTextRegularWidget(
                                                                                  cont.addedPriorityListForCurrent.contains(item.id)
                                                                                      ? cont.selectedCurrentPriority == ""
                                                                                          ? item.priorityToShow!
                                                                                          : cont.selectedCurrentPriority
                                                                                      : item.priorityToShow!,
                                                                                  item.priorityToShow == "High"
                                                                                      ? const Color(0xffFF0000)
                                                                                      : item.priorityToShow == "Medium"
                                                                                          ? const Color(0xffF57C00)
                                                                                          : const Color(0xff008000),
                                                                                  context,
                                                                                  15.0),
                                                                              isExpanded: true,
                                                                              underline: Container(),
                                                                              items: cont.priorityList.map((String value) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: value,
                                                                                  child: Text(value),
                                                                                );
                                                                              }).toList(),
                                                                              onChanged: (val) {
                                                                                cont.updatePriorityForCurrent(val!, item.id!);
                                                                              },
                                                                            ),
                                                                          ))),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Row(
                                                              children: [
                                                                ///view
                                                                cont.reportingHead ==
                                                                        "0"
                                                                    ? const Opacity(
                                                                        opacity:
                                                                            0.0)
                                                                    : Flexible(
                                                                        child:
                                                                            GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          cont.navigateToServiceView(
                                                                              item.id!,
                                                                              item.client!,
                                                                              item.servicename!,
                                                                              item.clientCode!);
                                                                        },
                                                                        child: buildButtonWidget(
                                                                            context,
                                                                            "View",
                                                                            height:
                                                                                40.0,
                                                                            buttonColor:
                                                                                errorColor,
                                                                            buttonFontSize:
                                                                                14.0),
                                                                      )),

                                                                ///reassign
                                                                cont.reportingHead ==
                                                                        "0"
                                                                    ? const Opacity(
                                                                        opacity:
                                                                            0.0)
                                                                    : const SizedBox(
                                                                        width:
                                                                            10.0,
                                                                      ),
                                                                cont.reportingHead ==
                                                                        "0"
                                                                    ? const Opacity(
                                                                        opacity:
                                                                            0.0)
                                                                    : Flexible(
                                                                        child:
                                                                            GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          cont.navigateToDetails(
                                                                              item.id!,
                                                                              item.client!,
                                                                              item.servicename!,
                                                                              item.allottedTo!);
                                                                        },
                                                                        child: buildButtonWidget(
                                                                            context,
                                                                            "Reassign",
                                                                            height:
                                                                                40.0,
                                                                            buttonColor:
                                                                                Colors.orange,
                                                                            buttonFontSize: 14.0),
                                                                      )),

                                                                ///start service
                                                                const SizedBox(
                                                                  width: 10.0,
                                                                ),
                                                                Flexible(
                                                                    child:
                                                                        GestureDetector(
                                                                  onTap: () {
                                                                    cont.callStartService(
                                                                        item.id!,
                                                                        cont.selectedMainType);
                                                                  },
                                                                  child: buildButtonWidget(
                                                                      context,
                                                                      "Start Service",
                                                                      height:
                                                                          40.0,
                                                                      buttonColor:
                                                                          Colors
                                                                              .green,
                                                                      buttonFontSize:
                                                                          14.0),
                                                                )),
                                                              ],
                                                            ))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          })

                              ///started not completed
                              : cont.loader
                                  ? buildCircularIndicator()
                                  : cont.startedNotCompletedPastDueList.isEmpty
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 50.0),
                                          child: buildTextBoldWidget(
                                              "No data found",
                                              blackColor,
                                              context,
                                              16.0,
                                              align: TextAlign.center))
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: cont
                                              .startedNotCompletedPastDueList
                                              .length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            final item =
                                                cont.startedNotCompletedPastDueList[
                                                    index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Card(
                                                  elevation: 1.0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7.0),
                                                      side: const BorderSide(
                                                          color: grey)),
                                                  child: ExpansionTile(
                                                    tilePadding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    trailing: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10.0),
                                                      child: Icon(
                                                        cont.addedIndex
                                                                .contains(index)
                                                            ? Icons
                                                                .keyboard_arrow_up
                                                            : Icons
                                                                .keyboard_arrow_down,
                                                        size: 25.0,
                                                      ),
                                                    ),
                                                    onExpansionChanged:
                                                        (value) {
                                                      cont.onExpanded(
                                                          value, index);
                                                    },
                                                    title: Column(
                                                      children: [
                                                        buildClientCodeWidget(
                                                            item.clientCode!,
                                                            item.client!,
                                                            context),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0),
                                                            child: buildTextRegularWidget(
                                                                "${item.servicename}",
                                                                blackColor,
                                                                context,
                                                                14.0,
                                                                align: TextAlign
                                                                    .left)),
                                                      ],
                                                    ),
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ///assigned to
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                              ),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  buildTextBoldWidget(
                                                                      "Assigned to - ",
                                                                      blackColor,
                                                                      context,
                                                                      14.0),
                                                                  Flexible(
                                                                      child: buildTextBoldWidget(
                                                                          "${item.allottedTo}",
                                                                          primaryColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.left)),
                                                                ],
                                                              )),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          10.0,
                                                                      right:
                                                                          10.0),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  buildTextBoldWidget(
                                                                      "Task - ",
                                                                      blackColor,
                                                                      context,
                                                                      14.0),
                                                                  Flexible(
                                                                    child: buildTextBoldWidget(
                                                                        "${item.tasks}",
                                                                        primaryColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .left),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          20.0),
                                                                  buildTextBoldWidget(
                                                                      "Completion % - ",
                                                                      blackColor,
                                                                      context,
                                                                      14.0),
                                                                  Flexible(
                                                                    child: buildTextBoldWidget(
                                                                        "${item.completionPercentage}",
                                                                        primaryColor,
                                                                        context,
                                                                        14.0,
                                                                        align: TextAlign
                                                                            .left),
                                                                  )
                                                                ],
                                                              )),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0,
                                                                    right: 10.0,
                                                                    top: 5.0),
                                                            child: Row(
                                                              children: [
                                                                Flexible(
                                                                  child: Container(
                                                                      height: 40.0,
                                                                      width: MediaQuery.of(context).size.width,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            const BorderRadius.all(Radius.circular(5)),
                                                                        border: Border.all(
                                                                            color:
                                                                                grey),
                                                                      ),
                                                                      child: cont.reportingHead == "0"
                                                                          ? Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                                child: buildTextRegularWidget(
                                                                                    item.priorityToShow!,
                                                                                    item.priorityToShow == "High"
                                                                                        ? const Color(0xffFF0000)
                                                                                        : item.priorityToShow == "Medium"
                                                                                            ? const Color(0xffF57C00)
                                                                                            : const Color(0xff008000),
                                                                                    context,
                                                                                    15.0,
                                                                                    align: TextAlign.left),
                                                                              ),
                                                                            )
                                                                          : Center(
                                                                              child: Padding(
                                                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                              child: DropdownButton(
                                                                                hint: buildTextRegularWidget(
                                                                                    cont.addedPriorityListForCurrent.contains(item.id)
                                                                                        ? cont.selectedCurrentPriority == ""
                                                                                            ? item.priorityToShow!
                                                                                            : cont.selectedCurrentPriority
                                                                                        : item.priorityToShow!,
                                                                                    item.priorityToShow == "High"
                                                                                        ? const Color(0xffFF0000)
                                                                                        : item.priorityToShow == "Medium"
                                                                                            ? const Color(0xffF57C00)
                                                                                            : const Color(0xff008000),
                                                                                    context,
                                                                                    15.0),
                                                                                isExpanded: true,
                                                                                underline: Container(),
                                                                                items: cont.priorityList.map((String value) {
                                                                                  return DropdownMenuItem<String>(
                                                                                    value: value,
                                                                                    child: Text(value),
                                                                                  );
                                                                                }).toList(),
                                                                                onChanged: (val) {
                                                                                  cont.updatePriorityForCurrent(val!, item.id!);
                                                                                },
                                                                              ),
                                                                            ))),
                                                                ),
                                                                const SizedBox(
                                                                    width:
                                                                        10.0),
                                                                Flexible(
                                                                  child: Container(
                                                                      height: 40.0,
                                                                      width: MediaQuery.of(context).size.width,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            const BorderRadius.all(Radius.circular(5)),
                                                                        border: Border.all(
                                                                            color:
                                                                                grey),
                                                                      ),
                                                                      child: cont.reportingHead == "0"
                                                                          ? Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                                child: buildTextRegularWidget(item.statusName!, blackColor, context, 15.0, align: TextAlign.left),
                                                                              ),
                                                                            )
                                                                          : Center(
                                                                              child: Padding(
                                                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                                              child: DropdownButton(
                                                                                hint: buildTextRegularWidget(
                                                                                    cont.addedStatusListForCurrent.contains(item.id)
                                                                                        ? cont.selectedServiceStatus == ""
                                                                                            ? item.statusName!
                                                                                            : cont.selectedServiceStatus
                                                                                        : item.statusName!,
                                                                                    blackColor,
                                                                                    context,
                                                                                    15.0),
                                                                                isExpanded: true,
                                                                                underline: Container(),
                                                                                items: cont.changeStatusList.map((String value) {
                                                                                  return DropdownMenuItem<String>(
                                                                                    value: value,
                                                                                    child: Text(value),
                                                                                  );
                                                                                }).toList(),
                                                                                onChanged: (val) {
                                                                                  cont.updateStatusForCurrent(val!, item.id!, context);
                                                                                },
                                                                              ),
                                                                            ))),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0,
                                                                    right: 10.0,
                                                                    top: 5.0),
                                                            child: Table(
                                                              children: [
                                                                TableRow(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(right: 3.0),
                                                                        child: buildTextBoldWidget(
                                                                            "Triggered\nDate",
                                                                            blackColor,
                                                                            context,
                                                                            14.0,
                                                                            align:
                                                                                TextAlign.center),
                                                                      ),
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            if (cont.reportingHead ==
                                                                                "1") {
                                                                              cont.selectTargetDateForCurrent(context, item.id!, item.triggerDateTimeFormat!, item.targetDateTimeFormat!, "startedNotCompletedApiLow", item.staDateTimeFormat!);
                                                                            }
                                                                          },
                                                                          child:
                                                                              buildTextBoldWidget(
                                                                            "Target Date",
                                                                            blackColor,
                                                                            context,
                                                                            14.0,
                                                                            align:
                                                                                TextAlign.center,
                                                                            decoration:
                                                                                TextDecoration.underline,
                                                                          )),
                                                                      buildTextBoldWidget(
                                                                          "Statutory\nDue Date",
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center),
                                                                    ]),
                                                                TableRow(
                                                                    children: [
                                                                      buildTextRegularWidget(
                                                                          item
                                                                              .triggerDateToShow!,
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          if (cont.reportingHead ==
                                                                              "1") {
                                                                            cont.selectTargetDateForCurrent(
                                                                                context,
                                                                                item.id!,
                                                                                item.triggerDateTimeFormat!,
                                                                                item.targetDateTimeFormat!,
                                                                                "startedNotCompletedApiLow",
                                                                                item.staDateTimeFormat!);
                                                                          }
                                                                        },
                                                                        child:
                                                                            buildTextRegularWidget(
                                                                          "${cont.addedDateListForAll.contains(item.id) ? cont.selectedDateToShowForCurrent == "" ? item.targetDateToShow : cont.selectedDateToShowForCurrent : item.targetDateToShow}",
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center,
                                                                          decoration:
                                                                              TextDecoration.underline,
                                                                        ),
                                                                      ),
                                                                      buildTextRegularWidget(
                                                                          item
                                                                              .satDateToShow!,
                                                                          blackColor,
                                                                          context,
                                                                          14.0,
                                                                          align:
                                                                              TextAlign.center),
                                                                    ]),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              child: Row(
                                                                children: [
                                                                  Flexible(
                                                                      child:
                                                                          GestureDetector(
                                                                    onTap: () {
                                                                      cont.selectedCliId =
                                                                          item.id!;
                                                                      cont.showCheckPasswordOrReasonDialog(
                                                                          "Cancel - ${item.servicename}",
                                                                          context);
                                                                    },
                                                                    child: buildButtonWidget(
                                                                        context,
                                                                        "Cancel",
                                                                        height:
                                                                            40.0,
                                                                        buttonColor:
                                                                            errorColor,
                                                                        buttonFontSize:
                                                                            14.0),
                                                                  )),
                                                                  const SizedBox(
                                                                    width: 10.0,
                                                                  ),
                                                                  Flexible(
                                                                      child:
                                                                          GestureDetector(
                                                                    onTap: () {
                                                                      cont.navigateToServiceView(
                                                                          item.id!,
                                                                          item.client!,
                                                                          item.servicename!,
                                                                          item.clientCode!);
                                                                    },
                                                                    child: buildButtonWidget(
                                                                        context,
                                                                        "Log",
                                                                        height:
                                                                            40.0,
                                                                        buttonColor:
                                                                            Colors
                                                                                .orange,
                                                                        buttonFontSize:
                                                                            14.0),
                                                                  )),
                                                                  const SizedBox(
                                                                    width: 10.0,
                                                                  ),
                                                                  Flexible(
                                                                      child:
                                                                          GestureDetector(
                                                                    onTap: () {
                                                                      cont.updateStatusForCurrent(
                                                                          "Complete",
                                                                          item.id!,
                                                                          context);
                                                                    },
                                                                    child: buildButtonWidget(
                                                                        context,
                                                                        "Complete",
                                                                        height:
                                                                            40.0,
                                                                        buttonColor:
                                                                            approveColor,
                                                                        buttonFontSize:
                                                                            14.0),
                                                                  )),
                                                                ],
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                            );
                                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
