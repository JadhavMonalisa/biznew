import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/screens/claim_form/claim_model.dart';
import 'package:biznew/screens/dashboard/dashboard_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TriggeredNotAllottedLoadAll extends StatefulWidget {
  const TriggeredNotAllottedLoadAll({Key? key}) : super(key: key);

  @override
  State<TriggeredNotAllottedLoadAll> createState() =>
      _TriggeredNotAllottedLoadAllState();
}

class _TriggeredNotAllottedLoadAllState
    extends State<TriggeredNotAllottedLoadAll> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont) {
      return WillPopScope(
          onWillPop: () async {
            return await cont.navigateFromTrigger();
          },
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: primaryColor,
              centerTitle: true,
              title: buildTextMediumWidget(
                  "Triggered Not Allotted", whiteColor, context, 16,
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
                            child: Card(
                              elevation: 1.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  side: const BorderSide(color: grey)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: buildTextBoldWidget(
                                    "${cont.selectedClientName} - ${cont.selectedServiceName}",
                                    blackColor,
                                    context,
                                    14.0,
                                    align: TextAlign.left),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0, left: 20.0, top: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                buildTextRegularWidget(
                                    "Priority", blackColor, context, 14.0),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Flexible(
                                  child: Container(
                                      height: 30.0,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(color: grey),
                                      ),
                                      child: cont.reportingHead == "0"
                                          ? Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0, right: 15.0),
                                                child: buildTextRegularWidget(
                                                    "Select",
                                                    blackColor,
                                                    context,
                                                    15.0,
                                                    align: TextAlign.left),
                                              ),
                                            )
                                          : Center(
                                              child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, right: 15.0),
                                              child: DropdownButton(
                                                hint: buildTextRegularWidget(
                                                    cont.selectedCurrentPriority ==
                                                            ""
                                                        ? "Select"
                                                        : cont
                                                            .selectedCurrentPriority,
                                                    blackColor,
                                                    context,
                                                    15.0),
                                                isExpanded: true,
                                                underline: Container(),
                                                items: cont.priorityList
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  cont.updatePriorityForTriggeredNotAllotted(
                                                      val!);
                                                },
                                              ),
                                            ))),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                buildTextRegularWidget(
                                    "Employee", blackColor, context, 14.0),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Flexible(
                                  child: Container(
                                      height: 30.0,
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
                                                    onTap: () {
                                                      cont.updateEmployeeFromTriggered(
                                                          value
                                                              .firmEmployeeName!,
                                                          value.mastId!);
                                                    },
                                                  );
                                                }).toList(),
                                          onChanged: (val) {
                                            //cont.updateEmployeeFromTriggered(val!,value.firmEmployeeName!);
                                          },
                                        ),
                                      ))),
                                ),
                              ],
                            )),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: cont.triggeredNotAllottedLoadAll.isEmpty
                              ? buildNoDataFound(context)
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      cont.triggeredNotAllottedLoadAll.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    final item =
                                        cont.triggeredNotAllottedLoadAll[index];
                                    return Card(
                                      elevation: 1.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          side: const BorderSide(color: grey)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: 40.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5)),
                                                  border:
                                                      Border.all(color: grey),
                                                ),
                                                child: cont.taskNameList.isEmpty
                                                    ? null
                                                    : TextFormField(
                                                        controller:
                                                            cont.taskNameList[
                                                                index],
                                                        keyboardType:
                                                            TextInputType.text,
                                                        textAlign:
                                                            TextAlign.left,
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .center,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        onTap: () {},
                                                        enabled: true,
                                                        style: const TextStyle(
                                                            fontSize: 15.0),
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          hintText:
                                                              item.taskName!,
                                                          hintStyle:
                                                              GoogleFonts.rubik(
                                                            textStyle:
                                                                const TextStyle(
                                                              color: blackColor,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          border:
                                                              InputBorder.none,
                                                        ),
                                                        onChanged: (value) {},
                                                      )),
                                            const Divider(
                                              color: grey,
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(children: [
                                              buildTextRegularWidget("Employee",
                                                  blackColor, context, 14.0),
                                              const SizedBox(
                                                width: 33.0,
                                              ),
                                              Flexible(
                                                child: Container(
                                                    height: 30.0,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  5)),
                                                      border: Border.all(
                                                          color: grey),
                                                    ),
                                                    child: Center(
                                                        child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0,
                                                              right: 15.0),
                                                      child: DropdownButton(
                                                        hint:
                                                            buildTextRegularWidget(
                                                                // cont.addedAssignedTo.contains(item.taskId) ?
                                                                // cont.selectedEmpFromDashboardNext==""?"":cont.selectedEmpFromDashboardNext : "",
                                                                // cont.triggerSelectedEmpList.isEmpty
                                                                //     ? "" : cont.triggerSelectedEmpList[index],

                                                                cont.triggerSelectedEmpList
                                                                        .isEmpty
                                                                    ? ""
                                                                    : cont.triggerSelectedEmpList[
                                                                        index],

                                                                // cont.addedAssignedTo.contains(item.taskId)
                                                                //     ? cont.triggerSelectedEmpList[index]
                                                                //     : "Select",
                                                                blackColor,
                                                                context,
                                                                15.0),
                                                        isExpanded: true,
                                                        underline: Container(),
                                                        items: cont.employeeList
                                                            .map(
                                                                (ClaimSubmittedByList
                                                                    value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value
                                                                .firmEmployeeName,
                                                            child: Text(value
                                                                .firmEmployeeName!),
                                                            onTap: () {
                                                              cont.updateAssignedTo(
                                                                  index,
                                                                  value
                                                                      .firmEmployeeName!,
                                                                  value.mastId!,
                                                                  item.taskId!);
                                                            },
                                                          );
                                                        }).toList(),
                                                        onChanged: (val) {
                                                          // cont.updateAssignedTo(index,val!,item.taskId!);
                                                        },
                                                      ),
                                                    ))),
                                              ),
                                              //const SizedBox(width: 20.0,),
                                            ]),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    buildTextRegularWidget(
                                                        "Completion % ",
                                                        blackColor,
                                                        context,
                                                        14.0),
                                                    const SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Flexible(
                                                      child: Container(
                                                          height: 30.0,
                                                          width: 40,
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
                                                          child:
                                                              cont.completionList
                                                                      .isEmpty
                                                                  ? null
                                                                  : Center(
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            cont.completionList[index],
                                                                        keyboardType:
                                                                            TextInputType.number,
                                                                        onTap:
                                                                            () {},
                                                                        enabled:
                                                                            true,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              15.0,
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          contentPadding: const EdgeInsets.only(
                                                                              left: 2,
                                                                              bottom: 10.0),
                                                                          hintText:
                                                                              item.completion!,
                                                                          hintStyle:
                                                                              GoogleFonts.rubik(
                                                                            textStyle:
                                                                                const TextStyle(
                                                                              color: blackColor,
                                                                              fontSize: 15,
                                                                            ),
                                                                          ),
                                                                          border:
                                                                              InputBorder.none,
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          //cont.addCompletion(index,value);
                                                                        },
                                                                      ),
                                                                    )),
                                                    ),
                                                    const SizedBox(width: 10.0),
                                                    buildTextRegularWidget(
                                                        "D",
                                                        blackColor,
                                                        context,
                                                        14.0,
                                                        align:
                                                            TextAlign.center),
                                                    const SizedBox(width: 5.0),
                                                    Flexible(
                                                      child: Container(
                                                          height: 30.0,
                                                          width: 40,
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
                                                          child:
                                                              cont.daysList
                                                                      .isEmpty
                                                                  ? null
                                                                  : Center(
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            cont.daysList[index],
                                                                        keyboardType:
                                                                            TextInputType.number,
                                                                        onTap:
                                                                            () {},
                                                                        enabled:
                                                                            true,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                15.0),
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          contentPadding: const EdgeInsets.only(
                                                                              left: 2,
                                                                              bottom: 10.0),
                                                                          hintText:
                                                                              item.days!,
                                                                          hintStyle:
                                                                              GoogleFonts.rubik(
                                                                            textStyle:
                                                                                const TextStyle(
                                                                              color: blackColor,
                                                                              fontSize: 15,
                                                                            ),
                                                                          ),
                                                                          border:
                                                                              InputBorder.none,
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          //cont.addDays(index,value);
                                                                        },
                                                                      ),
                                                                    )),
                                                    ),
                                                    const SizedBox(width: 10.0),
                                                    buildTextRegularWidget(
                                                        "H",
                                                        blackColor,
                                                        context,
                                                        14.0,
                                                        align:
                                                            TextAlign.center),
                                                    const SizedBox(width: 5.0),
                                                    Flexible(
                                                      child: Container(
                                                          height: 30.0,
                                                          width: 40,
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
                                                          child:
                                                              cont.hoursList
                                                                      .isEmpty
                                                                  ? null
                                                                  : Center(
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            cont.hoursList[index],
                                                                        keyboardType:
                                                                            TextInputType.number,
                                                                        onTap:
                                                                            () {},
                                                                        enabled:
                                                                            true,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                15.0),
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              item.hours!,
                                                                          contentPadding: const EdgeInsets.only(
                                                                              left: 2,
                                                                              bottom: 10.0),
                                                                          hintStyle:
                                                                              GoogleFonts.rubik(
                                                                            textStyle:
                                                                                const TextStyle(
                                                                              color: blackColor,
                                                                              fontSize: 15,
                                                                            ),
                                                                          ),
                                                                          border:
                                                                              InputBorder.none,
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          //cont.addHours(index,value);
                                                                        },
                                                                      ),
                                                                    )),
                                                    ),
                                                    const SizedBox(width: 10.0),
                                                    buildTextRegularWidget(
                                                        "M",
                                                        blackColor,
                                                        context,
                                                        14.0,
                                                        align:
                                                            TextAlign.center),
                                                    const SizedBox(width: 5.0),
                                                    Flexible(
                                                      child: Container(
                                                          height: 30.0,
                                                          width: 40,
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
                                                          child:
                                                              cont.minuteList
                                                                      .isEmpty
                                                                  ? null
                                                                  : Center(
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            cont.minuteList[index],
                                                                        keyboardType:
                                                                            TextInputType.number,
                                                                        textAlign:
                                                                            TextAlign.right,
                                                                        onTap:
                                                                            () {},
                                                                        enabled:
                                                                            true,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                15.0),
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              item.minutes!,
                                                                          contentPadding: const EdgeInsets.only(
                                                                              left: 2,
                                                                              bottom: 10.0),
                                                                          hintStyle:
                                                                              GoogleFonts.rubik(
                                                                            textStyle:
                                                                                const TextStyle(
                                                                              color: blackColor,
                                                                              fontSize: 15,
                                                                            ),
                                                                          ),
                                                                          border:
                                                                              InputBorder.none,
                                                                        ),
                                                                        onChanged:
                                                                            (value) {
                                                                          // cont.addMinutes(index,value);
                                                                        },
                                                                      ),
                                                                    )),
                                                    ),
                                                  ]),
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, right: 10.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        cont.removeFromSelectedTriggered(
                                                          index,
                                                        );
                                                      },
                                                      child: buildButtonWidget(
                                                          context, "Remove",
                                                          height: 35.0,
                                                          width: 150.0,
                                                          buttonColor:
                                                              errorColor,
                                                          buttonFontSize: 14.0),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Flexible(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        //showInprocessDialog(context);
                                                        cont.checkAllAddedValues(
                                                            index);
                                                      },
                                                      child: buildButtonWidget(
                                                        context,
                                                        "Add",
                                                        width: 150.0,
                                                        height: 35.0,
                                                        buttonColor:
                                                            approveColor,
                                                        buttonFontSize: 14.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10.0),
                          child: Row(
                            children: [
                              buildTextBoldWidget(
                                  "Completion % : ", blackColor, context, 15.0),
                              buildTextRegularWidget(
                                  cont.totalCompletion.toString(),
                                  blackColor,
                                  context,
                                  15.0),
                              const Spacer(),
                              buildTextBoldWidget(
                                  "  Total : ", blackColor, context, 15.0),
                              buildTextRegularWidget(cont.totalDays.toString(),
                                  blackColor, context, 15.0),
                              buildTextBoldWidget(
                                  "D ", blackColor, context, 15.0),
                              buildTextRegularWidget(cont.totalHours.toString(),
                                  blackColor, context, 15.0),
                              buildTextBoldWidget(
                                  "H ", blackColor, context, 15.0),
                              buildTextRegularWidget(cont.totalMins.toString(),
                                  blackColor, context, 15.0),
                              buildTextBoldWidget(
                                  "M   ", blackColor, context, 15.0),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 10.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                buildTextBoldWidget(
                                    "Apply to :", blackColor, context, 14.0),
                                Radio<int>(
                                  value: 0,
                                  visualDensity:
                                      const VisualDensity(horizontal: -4.0),
                                  groupValue: cont.selectedPeriod,
                                  activeColor: primaryColor,
                                  onChanged: (int? value) {
                                    cont.updateSelectedPeriod(value!, context);
                                  },
                                ),
                                buildTextRegularWidget(
                                    "Current period", blackColor, context, 14.0,
                                    align: TextAlign.left),
                                Radio<int>(
                                  value: 1,
                                  visualDensity:
                                      const VisualDensity(horizontal: -4.0),
                                  groupValue: cont.selectedPeriod,
                                  activeColor: primaryColor,
                                  onChanged: (int? value) {
                                    cont.updateSelectedPeriod(value!, context);
                                  },
                                ),
                                Flexible(
                                    child: buildTextRegularWidget(
                                        "Next all periods",
                                        blackColor,
                                        context,
                                        14.0,
                                        align: TextAlign.left)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Row(
                            children: [
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    cont.addMoreForTriggeredNotAllotted(cont
                                        .triggeredNotAllottedLoadAll.length);
                                    //showInprocessDialog(context);
                                  },
                                  child: buildButtonWidget(context, "Add more",
                                      buttonColor: editColor, height: 35.0),
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Flexible(
                                  child: GestureDetector(
                                onTap: () {
                                  cont.saveTriggeredNotAllottedLoadAll();
                                  //showInprocessDialog(context);
                                },
                                child: buildButtonWidget(context, "Save",
                                    buttonColor: approveColor, height: 35.0),
                              )),
                            ],
                          ),
                        ),
                      ],
                    )),
          ));
    });
  }
}
