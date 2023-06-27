import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/claim_form/claim_model.dart';
import 'package:biznew/screens/timesheet_form/timesheet_controller.dart';
import 'package:biznew/screens/timesheet_form/timesheet_model.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimesheetList extends StatefulWidget {
  const TimesheetList({Key? key}) : super(key: key);

  @override
  State<TimesheetList> createState() => _TimesheetListState();
}

class _TimesheetListState extends State<TimesheetList> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TimesheetFormController>(builder: (cont) {
      return WillPopScope(
          onWillPop: () async {
            return cont.onWillPopBack();
          },
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: buildTextMediumWidget("Timesheet", whiteColor, context, 16,
                  align: TextAlign.center),
              leading: GestureDetector(
                onTap: () {
                  cont.onWillPopBack();
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
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, bottom: 5.0, top: 5.0),
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(right: 5.0, left: 10.0),
                              child: Row(
                                children: [
                                  buildTextRegularWidget(
                                      "Select View Timesheet ",
                                      blackColor,
                                      context,
                                      15.0),
                                  Radio<int>(
                                    value: 0,
                                    groupValue: cont.selectedTimesheetFlag,
                                    activeColor: primaryColor,
                                    onChanged: (int? value) {
                                      cont.updateSelectedTimesheetFlag(
                                        value!,
                                        "own",
                                        context,
                                      );
                                    },
                                  ),
                                  buildTextRegularWidget(
                                      "Own", blackColor, context, 15.0),
                                  Radio<int>(
                                    value: 1,
                                    groupValue: cont.selectedTimesheetFlag,
                                    activeColor: primaryColor,
                                    onChanged: (int? value) {
                                      cont.updateSelectedTimesheetFlag(
                                        value!,
                                        "team",
                                        context,
                                      );
                                    },
                                  ),
                                  buildTextRegularWidget(
                                      "Team", blackColor, context, 15.0),
                                ],
                              )),
                          cont.selectedFlag == "own"
                              ? const Opacity(opacity: 0.0)
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0, left: 10.0, bottom: 10.0),
                                  child: Container(
                                      height: 40.0,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(color: grey),
                                      ),
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, right: 15.0),
                                        child: DropdownButton(
                                          hint: buildTextRegularWidget(
                                              cont.selectedEmployee == ""
                                                  ? "Select employee"
                                                  : cont.selectedEmployee,
                                              blackColor,
                                              context,
                                              15.0),
                                          isExpanded: true,
                                          underline: Container(),
                                          items: cont.employeeList.isEmpty
                                              ? cont.noDataList.map((value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList()
                                              : cont.employeeList.map(
                                                  (ClaimSubmittedByList value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value:
                                                        value.firmEmployeeName,
                                                    child: Text(value
                                                        .firmEmployeeName!),
                                                  );
                                                }).toList(),
                                          onChanged: (val) {
                                            cont.updateSelectedEmployee(val!);
                                          },
                                        ),
                                      ))),
                                ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0, left: 10.0, bottom: 10.0),
                            child: Container(
                                height: 40.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  border: Border.all(color: grey),
                                ),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0),
                                  child: DropdownButton(
                                    hint: buildTextRegularWidget(
                                        cont.selectedTimesheetStatus == ""
                                            ? "Select leave status"
                                            : cont.selectedTimesheetStatus,
                                        blackColor,
                                        context,
                                        15.0),
                                    isExpanded: true,
                                    underline: Container(),
                                    items: cont.timesheetStatusList
                                        .map((String leaveStatus) {
                                      return DropdownMenuItem<String>(
                                        value: leaveStatus,
                                        child: Text(leaveStatus),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      cont.updateSelectedTimesheetStatus(val!);
                                    },
                                  ),
                                ))),
                          ),
                          cont.timesheetList.isEmpty
                              ? buildNoDataFound(context)
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: cont.timesheetList.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: buildTimesheetList(
                                            cont.timesheetList[index], cont));
                                  })
                        ],
                      ),
                    ),
                  ),
            bottomNavigationBar: cont.loader == true
                ? const Opacity(opacity: 0.0)
                : Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10.0, left: 220.0, right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.timesheetNewForm);
                        //showInprocessDialog(context);
                      },
                      child: buildButtonWidget(context, "+ Add Timesheet",
                          radius: 5.0, height: 40.0),
                    ),
                  ),

            // Padding(
            //   padding: const EdgeInsets.only(left:20.0,right: 20.0,top: 50.0),
            //   child: Container(
            //     height: 200.0,
            //      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
            //    child: Column(
            //        crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //          buildTextBoldWidget("We're coming soon!", blackColor, context, 20,align: TextAlign.center),
            //          const Divider(color: primaryColor,),
            //          const SizedBox(height: 20.0,),
            //          buildTextRegularWidget("Sorry for inconvenience, this page is under construction.", blackColor, context, 16.0,align: TextAlign.left,),
            //        ],
            //      ),
            //    ),
            //  ),
          ));
    });
  }

  openLog(BuildContext context, TimesheetFormController cont, final item) {
    return showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter state) {
          return Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
                child: Container(
              height: 270.0,
              color: Colors.transparent,
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        buildTextBoldWidget(
                            "Timesheet log by ${item.firmEmployeeName}",
                            blackColor,
                            context,
                            16.0),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Table(
                          children: [
                            buildTableTwoByTwoTitle(context,
                                title1: "Date",
                                title2: "Status",
                                fontSize: 14.0),
                            buildContentTwoByTwoSubTitle(context,
                                contentTitle1: item.addedDate!,
                                contentTitle2: item.status!,
                                fontSize: 14.0),
                            const TableRow(
                              children: [
                                SizedBox(
                                  height: 15.0,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                              ],
                            ),
                            buildTableTwoByTwoTitle(context,
                                title1: "Remark",
                                title2: "Done By",
                                fontSize: 14.0),
                            buildContentTwoByTwoSubTitle(context,
                                contentTitle1: "",
                                contentTitle2: item.firmEmployeeName!,
                                fontSize: 14.0),
                            const TableRow(
                              children: [
                                SizedBox(
                                  height: 15.0,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: buildButtonWidget(
                            context,
                            "Close",
                            buttonColor: errorColor,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  )),
            )),
          );
        });
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  Widget buildTimesheetList(
      TimesheetListData item, TimesheetFormController cont) {
    return Card(
      color: faintGrey,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
          side: const BorderSide(color: grey)),
      child: ExpansionTile(
        title: buildTextRegularWidget(
            "${item.firmEmployeeName!} on ${item.addedDateToShow!} ${item.timeHours!} hours "
            "${item.timeMins == null || item.timeMins == "" ? "0" : item.timeMins!} Minutes.",
            blackColor,
            context,
            14.0,
            align: TextAlign.left),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: const EdgeInsets.all(15.0),
        children: [
          Table(
            children: [
              buildTableTwoByTwoTitle(context,
                  title1: "In Time", title2: "Out Time", fontSize: 14.0),
              buildContentTwoByTwoSubTitle(context,
                  contentTitle1: item.inTime!,
                  contentTitle2: item.outTime!,
                  fontSize: 14.0),
              const TableRow(
                children: [
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
          buildTextRegularWidget("Work At", blackColor, context, 14.0),
          buildTextBoldWidget(item.workat!, blackColor, context, 14.0),
          const SizedBox(
            height: 10.0,
          ),
          buildTextRegularWidget("Status", blackColor, context, 14.0),
          buildTextBoldWidget(
              item.status == "2"
                  ? "Saved "
                  : item.status == "4"
                      ? "Approved"
                      : item.status == "5"
                          ? "Sent for Resubmission"
                          : "Submit for Approval",
              blackColor,
              context,
              14.0),
          const SizedBox(
            height: 15.0,
          ),
          Row(
            children: [
              item.status == "Approved"
                  ? const Opacity(
                      opacity: 0.0,
                    )
                  : Flexible(
                      child: GestureDetector(
                      onTap: () {},
                      child: buildActionForClaim(errorColor, Icons.clear),
                    )),
              item.status == "Approved"
                  ? const Opacity(
                      opacity: 0.0,
                    )
                  : const SizedBox(
                      width: 5.0,
                    ),
              item.status == "Approved"
                  ? const Opacity(
                      opacity: 0.0,
                    )
                  : Flexible(
                      child: GestureDetector(
                          onTap: () {
                            cont.callTimesheetEdit(
                                item.addedBy!, item.tDate!, "form");
                          },
                          child: buildActionForClaim(editColor, Icons.edit))),
              item.status == "Approved"
                  ? const Opacity(
                      opacity: 0.0,
                    )
                  : const SizedBox(
                      width: 5.0,
                    ),
              item.status == "Approved"
                  ? const Opacity(
                      opacity: 0.0,
                    )
                  : Flexible(
                      child: GestureDetector(
                          onTap: () {
                            cont.callTimesheetLog(
                                context, item.tDate!, item.id!);
                          },
                          child: buildActionForClaim(
                              buttonColor, Icons.view_stream_rounded))),
              item.status == "Approved"
                  ? const Opacity(
                      opacity: 0.0,
                    )
                  : const SizedBox(
                      width: 5.0,
                    ),
              item.status == "Approved"
                  ? const Opacity(
                      opacity: 0.0,
                    )
                  : Flexible(
                      child: GestureDetector(
                          onTap: () {
                            // cont.callTimesheetAction(context, "5",item.id!, "Send for Resubmission");
                            cont.showActionDialog(context, item.id!);
                          },
                          child:
                              buildActionForClaim(approveColor, Icons.check))),
              item.status == "Approved"
                  ? const Opacity(
                      opacity: 0.0,
                    )
                  : const SizedBox(
                      width: 5.0,
                    ),
              Flexible(
                  child: GestureDetector(
                      onTap: () {
                        cont.callTimesheetEdit(
                            item.addedBy!, item.tDate!, "view");
                      },
                      child: buildActionForClaim(
                        primaryColor,
                        Icons.visibility,
                      ))),
              const SizedBox(
                width: 5.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
