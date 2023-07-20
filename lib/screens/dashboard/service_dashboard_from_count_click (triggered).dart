import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/screens/dashboard/dashboard_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TriggeredNotAllottedPieChartList extends StatefulWidget {
  const TriggeredNotAllottedPieChartList({Key? key}) : super(key: key);

  @override
  State<TriggeredNotAllottedPieChartList> createState() =>
      _TriggeredNotAllottedPieChartListState();
}

class _TriggeredNotAllottedPieChartListState
    extends State<TriggeredNotAllottedPieChartList> {
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
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(170),
                  child: Container(
                    color: primaryColor,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        buildTextMediumWidget(
                            "Triggered Not Allotted", whiteColor, context, 16,
                            align: TextAlign.center),
                        Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0, left: 10.0, top: 10.0),
                            child: Card(
                                elevation: 1.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
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
                                    borderRadius: BorderRadius.circular(7.0),
                                    side: const BorderSide(color: grey)),
                                child: SizedBox(
                                  height: 40.0,
                                  width: MediaQuery.of(context).size.height,
                                  child: Row(
                                    children: [
                                      Flexible(
                                          child: SizedBox(
                                        height: 40.0,
                                        child: Center(
                                            child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: TextFormField(
                                            controller: cont.searchController,
                                            keyboardType: TextInputType.text,
                                            textAlign: TextAlign.left,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            textInputAction:
                                                TextInputAction.done,
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            enabled: true,
                                            onTap: () {},
                                            style: const TextStyle(
                                                fontSize: 15.0),
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
                                              text.isEmpty ?
                                              cont.navigateToTriggeredNotAllottedNext(cont.selectedType,cont.selectedCount)
                                              ///while searching
                                                  : cont.filterSearchResultsForTrigger(text);
                                            },
                                          ),
                                        )),
                                      )),
                                      const Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 5.0, right: 5.0),
                                          child: Icon(
                                            Icons.search,
                                            color: primaryColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ))),
                      ],
                    ),
                  )),
              body: cont.loader == true
                  ? Center(
                      child: buildCircularIndicator(),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: cont.triggeredNotAllottedPieChartDetails.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: buildTextBoldWidget(
                                  "No data found", blackColor, context, 16.0,
                                  align: TextAlign.center))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: cont
                                  .triggeredNotAllottedPieChartDetails.length,
                              itemBuilder: (context, index) {
                                final item = cont
                                    .triggeredNotAllottedPieChartDetails[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5.0),
                                  child: Card(
                                    elevation: 1.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                        side: const BorderSide(color: grey)),
                                    child: ExpansionTile(
                                      tilePadding: const EdgeInsets.all(0.0),
                                      trailing: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Icon(
                                          cont.addedIndex.contains(index)
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                          size: 25.0,
                                        ),
                                      ),
                                      onExpansionChanged: (value) {
                                        cont.onExpanded(value, index);
                                      },
                                      title: Column(
                                        children: [
                                          buildClientCodeWidget(
                                              item.clientCode!,
                                              item.client!,
                                              context),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: buildTextRegularWidget(
                                                  "${item.servicename}",
                                                  blackColor,
                                                  context,
                                                  14.0,
                                                  align: TextAlign.left)),
                                        ],
                                      ),
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Padding(
                                            //     padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                            //     child: Row(
                                            //       crossAxisAlignment: CrossAxisAlignment.start,
                                            //       children: [
                                            //         buildTextBoldWidget("Trigger Date - ", blackColor, context, 14.0),
                                            //         Flexible(
                                            //           child:buildTextRegularWidget("${item.triggerDateToShow}", blackColor, context, 14.0,align: TextAlign.left),
                                            //         )
                                            //       ],
                                            //     )
                                            // ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10.0,
                                                right: 10.0,
                                              ),
                                              child: Table(
                                                children: [
                                                  TableRow(children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 3.0),
                                                      child:
                                                          buildTextBoldWidget(
                                                              "Triggered\nDate",
                                                              blackColor,
                                                              context,
                                                              14.0,
                                                              align: TextAlign
                                                                  .center),
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          if (cont.reportingHead ==
                                                              "1") {
                                                            cont.selectTargetDateForCurrent(
                                                                context,
                                                                item.id!,
                                                                item.triggerDateTimeFormat!,
                                                                item.targetDateTimeFormat!,
                                                                'triggerApi',
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
                                                              TextDecoration
                                                                  .underline,
                                                        )),
                                                    buildTextBoldWidget(
                                                        "Statutory\nDue Date",
                                                        blackColor,
                                                        context,
                                                        14.0,
                                                        align:
                                                            TextAlign.center),
                                                  ]),
                                                  TableRow(children: [
                                                    buildTextRegularWidget(
                                                        item.triggerDateToShow!,
                                                        blackColor,
                                                        context,
                                                        14.0,
                                                        align:
                                                            TextAlign.center),
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (cont.reportingHead ==
                                                            "1") {
                                                          cont.selectTargetDateForCurrent(
                                                              context,
                                                              item.id!,
                                                              item.triggerDateTimeFormat!,
                                                              item.targetDateTimeFormat!,
                                                              'triggerApi',
                                                              item.staDateTimeFormat!);
                                                        }
                                                      },
                                                      child:
                                                          buildTextRegularWidget(
                                                        "${cont.addedDateListForAll.contains(item.id) ? cont.selectedDateToShowForCurrent == "" ? item.targetDateToShow : cont.selectedDateToShowForCurrent : item.targetDateToShow}",
                                                        blackColor,
                                                        context,
                                                        14.0,
                                                        align: TextAlign.center,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                    ),
                                                    buildTextRegularWidget(
                                                        item.satDateToShow!,
                                                        blackColor,
                                                        context,
                                                        14.0,
                                                        align:
                                                            TextAlign.center),
                                                  ]),
                                                ],
                                              ),
                                            ),
                                            cont.reportingHead == "0"
                                                ? const Opacity(opacity: 0.0)
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                            child:
                                                                GestureDetector(
                                                          onTap: () {
                                                            // cont.selectedCliId = item.id!;
                                                            // cont.showCheckPasswordOrReasonDialog("Cancel - ${item.servicename}",context);
                                                            showInprocessDialog(
                                                                context);
                                                          },
                                                          child:
                                                              buildButtonWidget(
                                                                  context,
                                                                  "Cancel",
                                                                  height: 40.0,
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
                                                            cont.callTriggeredNotAllottedLoadAll(
                                                                item.id!,
                                                                item.client!,
                                                                item.servicename!);
                                                          },
                                                          child: buildButtonWidget(
                                                              context, "Assign",
                                                              height: 40.0,
                                                              buttonColor:
                                                                  Colors.orange,
                                                              buttonFontSize:
                                                                  14.0),
                                                        )),
                                                      ],
                                                    ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })),
            ),
          ));
    });
  }
}
