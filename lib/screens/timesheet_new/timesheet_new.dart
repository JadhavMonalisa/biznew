import 'package:biznew/common_widget/error_text.dart';
import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/screens/timesheet_form/timesheet_model.dart';
import 'package:biznew/screens/timesheet_new/text_editior.dart';
import 'package:biznew/screens/timesheet_new/timesheet_new_controller.dart';
import 'package:biznew/screens/timesheet_new/timesheet_new_model.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class TimesheetNewForm extends StatefulWidget {
  const TimesheetNewForm({Key? key}) : super(key: key);

  @override
  State<TimesheetNewForm> createState() => _TimesheetNewFormState();
}

class _TimesheetNewFormState extends State<TimesheetNewForm> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TimesheetNewFormController>(builder: (cont) {
      return WillPopScope(
        onWillPop: () async {
          return cont.onWillPopBackTimesheetList();
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            title: buildTextMediumWidget("Timesheet", whiteColor, context, 16,
                align: TextAlign.center),
          ),
          drawer: Drawer(
            child: SizedBox(
                height: double.infinity,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 1.1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildDrawer(context, cont.name),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30.0,
                                  left: 10.0,
                                  bottom: 50.0,
                                  right: 10.0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showWarningOnTimesheetNewFormDialog(
                                          context,
                                          "Confirm Logout...!!!",
                                          "Do you want to logout from an app?",
                                          logoutFeature: true,
                                          cont);
                                    },
                                    child: const Icon(Icons.logout),
                                  ),
                                  const SizedBox(
                                    width: 7.0,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        showWarningOnTimesheetNewFormDialog(
                                            context,
                                            "Confirm Logout...!!!",
                                            "Do you want to logout from an app?",
                                            logoutFeature: true,
                                            cont);
                                      },
                                      child: buildTextBoldWidget(
                                          "Logout", blackColor, context, 15.0)),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {},
                                    child: buildTextRegularWidget(
                                        "App Version 1.0", grey, context, 14.0),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Expanded(
                    child: Stepper(
                      type: cont.stepperType,
                      physics: const AlwaysScrollableScrollPhysics(),
                      currentStep: cont.currentStep,
                      controlsBuilder: (context, details) {
                        return cont.currentStep == 0
                            ? Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: GestureDetector(
                                    onTap: () {
                                      //cont.continued();
                                      cont.checkValidationForStepper1();
                                    },
                                    child: cont.isLoadingForStepper1 ? const Opacity(opacity: 0.0):
                                    buildButtonWidget(context, "Next")),
                              )
                            : cont.currentStep == 1 &&
                                    cont.isFillTimesheetSelected == true
                                ? cont.currentService == "allotted"
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(top: 30.0),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: GestureDetector(
                                                  onTap: () {
                                                    cont.checkValidationForAllotted(context);
                                                  },
                                                  child: buildButtonWidget(context, "Save")),
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Flexible(
                                              child: GestureDetector(
                                                  onTap: () {
                                                    if(cont.cbNonAllotted){
                                                      cont.callEmployeeList();
                                                      cont.currentService = "nonAllotted";
                                                    }
                                                    else if(cont.cbOffice){
                                                      cont.currentService = "office";
                                                    }
                                                    cont.saveCurrentAllottedList();
                                                  },
                                                  child: buildButtonWidget(
                                                      context, "Next")),
                                            ),
                                          ],
                                        ))
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(top: 30.0),
                                        child: GestureDetector(
                                            onTap: () {
                                             print(cont.currentService);
                                             cont.currentService == "office"
                                                  ? cont
                                                      .checkValidationForOffice(
                                                          context)
                                                  : cont
                                                      .checkValidationForNonAllotted(
                                                          context);
                                            },
                                            child: buildButtonWidget(
                                                context, "Save")),
                                      )
                                : const Opacity(opacity: 0.0);
                      },
                      onStepTapped: (step) => cont.tapped(step),
                      onStepContinue: () {},
                      onStepCancel: cont.cancel,
                      steps: <Step>[
                        ///stepper 1
                        Step(
                          title: Container(),
                          content: buildStepperOne(cont),
                          isActive: cont.currentStep >= 0,
                          state: cont.currentStep >= 0
                              ? StepState.complete
                              : StepState.disabled,
                        ),

                        ///stepper 2
                        Step(
                          title: Container(),
                          content: buildStepperTwo(cont),
                          isActive: cont.currentStep >= 0,
                          state: cont.currentStep >= 1
                              ? StepState.complete
                              : StepState.disabled,
                        ),

                        ///stepper 3
                        Step(
                          title: Container(),
                          content: buildStepperThree(cont),
                          isActive: cont.currentStep >= 0,
                          state: cont.currentStep >= 2
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      );
    });
  }

  buildStepperOne(TimesheetNewFormController cont) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      child: cont.isLoadingForStepper1
      ? buildCircularIndicator()
      : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ///date
          buildTimeSheetTitle(context, "Date"),
          GestureDetector(
            onTap: () {
              cont.selectDate(context);
            },
            child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                      color: cont.validateStartDate ? errorColor : grey),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      Icons.calendar_today,
                      color: cont.selectedDateToShow == "" ? grey : blackColor,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    buildTextRegularWidget(
                        cont.selectedDateToShow == ""
                            ? "Timesheet Date"
                            : cont.selectedDateToShow,
                        cont.selectedDateToShow == "" ? grey : blackColor,
                        context,
                        15.0)
                  ],
                )),
          ),
          cont.validateStartDate == true
              ? ErrorText(
                  errorMessage: "Please select date",
                )
              : const Opacity(opacity: 0.0),

          ///work at
          buildTimeSheetTitle(context, "Work At"),
          MultiSelectDialogField<String>(
            items: cont.workAtItems,
            title: const Text("Work At"),
            selectedColor: primaryColor,

            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                color: grey,
              ),
            ),
            buttonIcon: const Icon(
              Icons.person,
              color: blackColor,
              size: 20.0,
            ),
            buttonText: buildTextRegularWidget(
                "Select Work At", blackColor, context, 15.0),
            onConfirm: (results) {
              cont.onSelectionForMultipleWorkAt(results);
            },
            dialogHeight: 250.0,
            chipDisplay: MultiSelectChipDisplay(
              onTap: (value) {
                cont.onDeleteMultipleWorkAt(value);
              },
              icon: const Icon(
                Icons.clear,
                color: errorColor,
              ),
            ),
          ),
          cont.validateWorkAt == true
              ? ErrorText(
                  errorMessage: "Please select work at",
                )
              : const Opacity(opacity: 0.0),

          ///in time
          buildTimeSheetTitle(context, "In Time"),
          GestureDetector(
            onTap: () {
              cont.selectTime(context, "start");
            },
            child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                      color: cont.validateInTime ? errorColor : grey),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      Icons.watch_later_outlined,
                      color:
                          cont.stepper1InTime.text.isEmpty ? grey : blackColor,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    buildTextRegularWidget(
                        cont.selectedStartTimeToShow == ""
                            ? "In Time (HH:MM)"
                            : cont.selectedStartTimeToShow,
                        cont.selectedStartTimeToShow == "" ? grey : blackColor,
                        context,
                        15.0)
                  ],
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          buildTextRegularWidget("(24 hours format)", blackColor, context, 14.0),

          ///end time
          buildTimeSheetTitle(context, "Out Time"),
          GestureDetector(
            onTap: () {
              cont.selectTime(context, "end");
            },
            child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                      color: cont.validateOutTime ? errorColor : grey),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      Icons.watch_later_outlined,
                      color:
                          cont.stepper1OutTime.text.isEmpty ? grey : blackColor,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    buildTextRegularWidget(
                        cont.selectedEndTimeToShow == ""
                            ? "Out Time (HH:MM)"
                            : cont.selectedEndTimeToShow,
                        cont.selectedEndTimeToShow == "" ? grey : blackColor,
                        context,
                        15.0)
                  ],
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          buildTextRegularWidget(
              "(24 hours format)", blackColor, context, 14.0),
          cont.validateOutTime == true
              ? ErrorText(
                  errorMessage: "Please select valid out time (24 format)",
                )
              : const Opacity(opacity: 0.0),

          ///total time
          buildTimeSheetTitle(context, "Total Time"),
          Container(
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border:
                  Border.all(color: cont.validateTotalTime ? errorColor : grey),
            ),
            child: TextFormField(
              controller: cont.timesheetTotalTime,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              textInputAction: TextInputAction.done,
              onTap: () {},
              enabled: false,
              style: const TextStyle(fontSize: 15.0),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                hintText: "Total time",
                hintStyle: GoogleFonts.rubik(
                  textStyle: const TextStyle(
                    color: grey,
                    fontSize: 15,
                  ),
                ),
                border: InputBorder.none,
              ),
              onChanged: (text) {
                cont.checkTotalTimeValidation();
              },
            ),
          ),
          cont.validateTotalTime == true
              ? ErrorText(
                  errorMessage: "Please select start time",
                )
              : const Opacity(opacity: 0.0),
        ],
      ),
    );
  }

  buildStepperTwo(TimesheetNewFormController cont) {
    return cont.showOffice
        ? Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          cont.isLoadingForStepper1=false;
                          cont.loaderAllottedForSerice=false;
                          cont.loader=false;
                          cont.goToPreviousFromOffice();
                        },
                        child: SizedBox(
                            width: 80.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildTextBoldWidget(
                                    "Previous", primaryColor, context, 15.0),
                                const Divider(
                                  thickness: 2.0,
                                  color: primaryColor,
                                ),
                              ],
                            ))),
                    GestureDetector(
                      onTap: () {
                        cont.nextFromOffice(true);
                      },
                      child: SizedBox(
                          width: 40.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              buildTextBoldWidget(
                                  "Skip", primaryColor, context, 15.0),
                              const Divider(
                                thickness: 2.0,
                                color: primaryColor,
                              ),
                            ],
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        cont.nextFromOffice(true);
                      },
                      child: SizedBox(
                          width: 40.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              buildTextBoldWidget(
                                  "Next", primaryColor, context, 15.0),
                              const Divider(
                                thickness: 2.0,
                                color: primaryColor,
                              ),
                            ],
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                buildTimeSheetTitle(context, "Office Related", fontSize: 16.0),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                    height: 40.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: grey),
                    ),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: DropdownButton(
                        itemHeight: 70.0,
                        hint: buildTextRegularWidget(
                            cont.selectedOfficeWorkName == ""
                                ? "Select Work Type"
                                : cont.selectedOfficeWorkName,
                            blackColor,
                            context,
                            15.0,
                            align: TextAlign.left),
                        isExpanded: true,
                        underline: Container(),
                        items: cont.workList.map((TypeOfWorkList value) {
                          return DropdownMenuItem<String>(
                            value: value.name,
                            child: Text(value.name!),
                            onTap: () {
                              cont.officeWorkIdList.clear();
                              cont.officeWorkNameList.clear();
                              cont.addOfficeWorkNameAndId(
                                  value.id!, value.name!);
                            },
                          );
                        }).toList(),
                        onChanged: (val) {
                          cont.onOfficeWorkType(val!);
                        },
                      ),
                    ))),
                const SizedBox(
                  height: 10.0,
                ),
                Table(
                  children: [
                    TableRow(children: [
                      SizedBox(
                          height: 40.0,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: buildTextRegularWidget(
                                "Details", blackColor, context, 14.0),
                          )),
                      Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: grey),
                        ),
                        child: TextFormField(
                          controller: cont.officeDetailsController,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.center,
                          textInputAction: TextInputAction.done,
                          onTap: () {},
                          enabled: true,
                          style: const TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "Details",
                            hintStyle: GoogleFonts.rubik(
                              textStyle: const TextStyle(
                                color: blackColor,
                                fontSize: 15,
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                    ]),
                    const TableRow(children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ]),
                    TableRow(children: [
                      SizedBox(
                          height: 40.0,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: buildTextRegularWidget(
                                "Time Spent", blackColor, context, 14.0),
                          )),
                      GestureDetector(
                        onTap: () {
                          cont.selectTime(context, "office");
                        },
                        child: Container(
                            height: 40.0,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: grey),
                            ),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: buildTextRegularWidget(
                                      cont.selectedOfficeTime == ""
                                          ? "Time Spent"
                                          : cont.selectedOfficeTime,
                                      blackColor,
                                      context,
                                      15.0),
                                ))),
                      ),
                    ]),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                buildRichTextWidget(
                  "Timesheet filled for * ",
                  "${cont.hrSum + cont.hrNonAllottedSum + cont.hrOfficeSum} "
                      "Hrs and ${cont.minSum + cont.minNonAllottedSum + cont.minOfficeSum} minutes",
                  title1Color: primaryColor,
                  title2Color: blackColor,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          )
        : cont.currentService == "allotted"
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          cont.loaderNonAllottedService=false;
                          cont.loaderForNonAllottedStatus=false;
                          cont.goToPreviousFromAllotted();
                          //cont.cancel();
                        },
                        child: SizedBox(
                            width: 80.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildTextBoldWidget("Previous",
                                    primaryColor, context, 15.0),
                                const Divider(
                                  thickness: 2.0,
                                  color: primaryColor,
                                ),
                              ],
                            ))),
                    GestureDetector(
                      onTap: () {
                        cont.isFillTimesheetSelected = true;
                        if(cont.cbNonAllotted){
                          cont.currentService = "nonAllotted";
                          cont.saveCurrentAllottedList();
                        }
                        else if(cont.cbOffice){
                          cont.currentService = "office";
                          cont.saveCurrentAllottedList();
                        }
                        else {
                          cont.isLoadingForStepper3 = false;
                          cont.continued();
                        }
                      },
                      child: SizedBox(
                          width: 40.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              buildTextBoldWidget(
                                  "Skip", primaryColor, context, 15.0),
                              const Divider(
                                thickness: 2.0,
                                color: primaryColor,
                              ),
                            ],
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        cont.isFillTimesheetSelected = true;
                        if(cont.cbNonAllotted){
                          cont.currentService = "nonAllotted";
                          cont.saveCurrentAllottedList();
                        }
                        else if(cont.cbOffice){
                          cont.currentService = "office";
                          cont.saveCurrentAllottedList();
                        }
                        else {
                          cont.isLoadingForStepper3 = false;
                          cont.continued();
                        }
                      },
                      child: SizedBox(
                          width: 40.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              buildTextBoldWidget(
                                  "Next", primaryColor, context, 15.0),
                              const Divider(
                                thickness: 2.0,
                                color: primaryColor,
                              ),
                            ],
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                buildTimeSheetTitle(context, "Allotted Services",
                    fontSize: 16.0),

                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: grey),
                  ),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: DropdownButton(
                      itemHeight: 70.0,
                      hint: buildTextRegularWidget(
                          cont.allottedSelectedClientName == ""
                              ? "Select Client"
                              : cont.allottedSelectedClientName,
                          blackColor,
                          context,
                          15.0,
                          align: TextAlign.left),
                      isExpanded: true,
                      underline: Container(),
                      items: cont.allottedEmployeeList
                          .map((ClientListData value) {
                            String clientNameWithCode = "";
                            if(value.firmClientClientCode == null || value.firmClientClientCode == ""){
                              clientNameWithCode = value.firmClientFirmName!;
                            }
                            else{
                              clientNameWithCode = "${value.firmClientFirmName!} (${value.firmClientClientCode})";
                            }
                        return DropdownMenuItem<String>(
                          value: clientNameWithCode,
                          child: Text(clientNameWithCode),
                          onTap: () {
                            cont.isFillTimesheetSelected=false;
                            cont.taskList.clear();
                            //cont.taskIdList.clear();
                            cont.timesheetTaskListData.clear();
                            cont.allottedServiceList.clear();
                            cont.allottedTimesheetSelectedServiceList.clear();
                            cont.allottedSelectedServiceName = "";
                            cont.checkStartList.clear();
                            cont.checkStatusList.clear();
                            cont.dataList.clear();

                            cont.addAllottedClientNameAndId(
                                value.firmClientId!,
                                "${value.firmClientFirmName!} (${value.firmClientClientCode})");
                          },
                        );
                      }).toList(),
                      onChanged: (val) {
                        cont.onSelectionAllottedEmp(val!);
                      },
                    ),
                  )),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                cont.loaderAllottedForSerice ? buildCircularIndicator() :
                Container(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: grey),
                  ),
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: DropdownButton(
                          itemHeight: 70.0,
                          hint: buildTextRegularWidget(
                              cont.allottedSelectedServiceName == ""
                                  ? "Select services"
                                  : cont.allottedSelectedServiceName,
                              blackColor,
                              context,
                              15.0,
                              align: TextAlign.left),
                          isExpanded: true,
                          underline: Container(),
                          items: cont.allottedServiceList
                              .map((TimesheetServicesListData value) {
                              String serviceNamePeriod = "";
                              String serviceDueDatePeriodicity = "";

                                // if(value.period == null || value.period == ""){
                                //   serviceNamePeriod = value.serviceName! ;
                                // }
                                // else{
                                //   serviceNamePeriod = "${value.serviceName} | ${value.period!}";
                                // }

                                if(value.serviceDueDatePeriodicity == null || value.serviceDueDatePeriodicity == ""){
                                  if(value.period == null || value.period == ""){
                                    serviceNamePeriod = value.serviceName! ;
                                  }
                                  else{
                                    serviceNamePeriod = "${value.serviceName} | ${value.period!}";
                                  }
                                }
                                else{
                                  serviceNamePeriod = "${value.serviceName} | ${value.serviceDueDatePeriodicity} | ${value.period!}";
                                }

                            return DropdownMenuItem<String>(
                              value: serviceNamePeriod,
                              child: Text(serviceNamePeriod),
                              onTap: () {
                                cont.taskList.clear();
                                //cont.taskIdList.clear();
                                cont.timesheetTaskListData.clear();
                                cont.allottedTimesheetSelectedServiceList.clear();
                                cont.checkStartList.clear();
                                cont.checkStatusList.clear();

                                cont.addAllottedServiceNameAndId(value.serviceId!,
                                    serviceNamePeriod,
                                    value);
                              },
                            );
                          }).toList(),
                          onTap: (){
                            cont.taskList.clear();
                            cont.timesheetTaskListData.clear();
                          },
                          onChanged: (val) {
                            cont.onSelectionAllottedService(val!);
                          },
                        ),
                      )),
                ),
                const SizedBox(
                  height: 15.0,
                ),

                buildTextBoldWidget("Also Fill", blackColor, context, 16.0),
                const SizedBox(
                  height: 5.0,
                ),

                Row(
                  children: <Widget>[
                    Checkbox(
                        value: cont.cbNonAllotted,
                        activeColor: Colors.green,
                        onChanged: (newValue) {
                          cont.updateNonAllottedCheckBox(newValue!);
                        }),
                    buildTextRegularWidget(
                        "Non Allotted Services", blackColor, context, 14.0)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                        value: cont.cbOffice,
                        activeColor: Colors.green,
                        onChanged: (newValue) {
                          cont.updateOfficeCheckBox(newValue!);
                        }),
                    buildTextRegularWidget(
                        "Office Related", blackColor, context, 14.0)
                  ],
                ),

                cont.loader ? const Opacity(opacity: 0.0) :
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: GestureDetector(
                      onTap: () {
                        cont.isLoadingStepper2 = true;
                        cont.fillTimesheet();
                      },
                      child: buildButtonWidget(context, "Fill Timesheet")),
                ),

                // Text(cont.toShowServiceId),
                // Text(cont.toShowClientServiceId),

                cont.loader ? buildCircularIndicator() :

                cont.isFillTimesheetSelected
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 10.0,
                          ),
                          cont.isLoadingStepper2 ? buildCircularIndicator():
                          ListView.builder(
                              shrinkWrap: true,
                              physics:const NeverScrollableScrollPhysics(),
                              itemCount: cont.timesheetTaskListData.length,
                              itemBuilder: (context, taskListIndex) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0),
                                      side: const BorderSide(
                                          color: primaryColor)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 20.0,
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            child: buildRichTextWidget(
                                              "${cont.timesheetTaskListData[taskListIndex].clientName} -> ",
                                              "${cont.timesheetTaskListData[taskListIndex].serviceName}"

                                                  // "${cont.timesheetTaskListData[taskListIndex].servicePeriodicity == null ||
                                                  // cont.timesheetTaskListData[taskListIndex].servicePeriodicity == ""
                                                  // ? "":"|${cont.timesheetTaskListData[taskListIndex].servicePeriodicity}|"}"

                                              "${cont.timesheetTaskListData[taskListIndex].servicePeriod == null ||
                                                  cont.timesheetTaskListData[taskListIndex].servicePeriod == ""
                                                  ? "":"${cont.timesheetTaskListData[taskListIndex].servicePeriod}"}",
                                              title1Color: primaryColor,
                                              title2Color: blackColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemCount: cont
                                                  .timesheetTaskListData[taskListIndex]
                                                  .timesheetTaskDetailsData!.length,
                                              itemBuilder: (context,
                                                  taskDetailsIndex) {
                                                return ExpansionTile(
                                                  expandedAlignment:
                                                      Alignment.topLeft,
                                                  title: buildTextBoldWidget(
                                                      cont
                                                              .timesheetTaskListData[
                                                                  taskListIndex]
                                                              .timesheetTaskDetailsData![
                                                                  taskDetailsIndex]
                                                              .taskName ??
                                                          "",
                                                      blackColor,
                                                      context,
                                                      15.0,
                                                      align: TextAlign.left),
                                                  expandedCrossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  childrenPadding:
                                                      const EdgeInsets.only(
                                                          left: 20.0),
                                                  children: [
                                                    Table(
                                                      children: [
                                                        TableRow(children: [
                                                          SizedBox(
                                                              height: 40.0,
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .centerLeft,
                                                                child: buildTextRegularWidget(
                                                                    "Details",
                                                                    blackColor,
                                                                    context,
                                                                    14.0),
                                                              )),
                                                          cont
                                                                  .timesheetTaskListData[
                                                                      taskListIndex]
                                                                  .timesheetTaskDetailsData!
                                                                  .isEmpty
                                                              ? const Opacity(
                                                                  opacity:
                                                                      0.0)
                                                              : Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          5.0),
                                                                  child:
                                                                      Container(
                                                                    height: 40.0,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                                      border: Border.all(color: grey),
                                                                      color: cont.checkStatusList[taskDetailsIndex] == "1" && cont.checkStartList[taskDetailsIndex] == "0"
                                                                         ? grey.withOpacity(0.2) : whiteColor
                                                                    ),
                                                                    child:TextEditingForAllotted(controller: cont.timesheetTaskListData[
                                                                    taskListIndex].timesheetTaskDetailsData![taskDetailsIndex].testTaskDetails,
                                                                      indexForService:taskListIndex,
                                                                      indexForTask: taskDetailsIndex,
                                                                    enabled: cont.checkStatusList[taskDetailsIndex] == "1" && cont.checkStartList[taskDetailsIndex] == "0"
                                                                      ? false:true,
                                                                      taskId: cont.timesheetTaskListData[
                                                                      taskListIndex].timesheetTaskDetailsData![taskDetailsIndex].taskId,
                                                                    )
                                                                  ),
                                                                ),
                                                        ]),
                                                        const TableRow(
                                                            children: [
                                                              SizedBox(
                                                                height: 10.0,
                                                              ),
                                                              SizedBox(
                                                                height: 10.0,
                                                              ),
                                                            ]),
                                                        TableRow(children: [
                                                          SizedBox(
                                                              height: 40.0,
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .centerLeft,
                                                                child: buildTextRegularWidget(
                                                                    "Time Spent",
                                                                    blackColor,
                                                                    context,
                                                                    14.0),
                                                              )),
                                                          GestureDetector(
                                                            onTap: () {
                                                              cont.checkStatusList[taskDetailsIndex] == "1" &&
                                                                  cont.checkStartList[taskDetailsIndex] == "0"
                                                              ? null
                                                              : cont.selectTimeForTask(
                                                                  context,
                                                                  taskListIndex,
                                                                  taskDetailsIndex,
                                                                  cont.timesheetTaskListData[taskListIndex]
                                                                      .timesheetTaskDetailsData![taskDetailsIndex].taskId!
                                                              );
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          5.0),
                                                              child: Container(
                                                                  height: 40.0,
                                                                  width: MediaQuery.of(context).size.width,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                                    border: Border.all(color: grey),
                                                                    color:cont.checkStatusList[taskDetailsIndex] == "1" && cont.checkStartList[taskDetailsIndex] == "0"
                                                                        ? grey.withOpacity(0.2) : whiteColor
                                                                  ),
                                                                  child: Align(
                                                                      alignment: Alignment.centerLeft,
                                                                      child: Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 10.0),
                                                                        //child: buildTextRegularWidget(cont.timeSpentList[taskDetailsIndex], blackColor, context, 15.0),
                                                                        child: buildTextRegularWidget(
                                                                            cont.timesheetTaskListData[taskListIndex].timesheetTaskDetailsData![taskDetailsIndex].timeSpent ?? "HH:MM",
                                                                            blackColor,
                                                                            context,
                                                                            15.0),
                                                                      ))
                                                                  ),
                                                            ),
                                                          ),
                                                        ]),
                                                        const TableRow(
                                                            children: [
                                                              SizedBox(
                                                                height: 10.0,
                                                              ),
                                                              SizedBox(
                                                                height: 10.0,
                                                              ),
                                                            ]),
                                                        TableRow(children: [
                                                          SizedBox(
                                                              height: 40.0,
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .centerLeft,
                                                                child: buildTextRegularWidget(
                                                                    "Status",
                                                                    blackColor,
                                                                    context,
                                                                    14.0),
                                                              )),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        5.0),
                                                            child:
                                                            cont.checkStartList.isEmpty ? const Text(""):
                                                            cont.checkStatusList[taskDetailsIndex] == "1" && cont.checkStartList[taskDetailsIndex] == "0"
                                                                ? GestureDetector(
                                                              onTap:
                                                                  () {
                                                                cont.callTimesheetStart(
                                                                    context,
                                                                    taskDetailsIndex,
                                                                    cont.clientAppServiceId,
                                                                    cont.timesheetTaskListData[taskListIndex].timesheetTaskDetailsData![taskDetailsIndex].taskId!);
                                                              },
                                                              child: buildButtonWidget(
                                                                  context,
                                                                  "Start",
                                                                  height:
                                                                  40.0),
                                                            )

                                                            ///if task is completed then show text or else dropdown
                                                                : cont.checkStatusList[taskDetailsIndex] == "5"
                                                            ? SizedBox(
                                                                height: 40.0,
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: buildTextRegularWidget("Completed", blackColor, context, 14.0),))
                                                                :

                                                            cont.isChangeStatusLoading ? buildCircularIndicator() :
                                                            Container(
                                                                height:
                                                                40.0,
                                                                width: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .width,
                                                                decoration:
                                                                BoxDecoration(
                                                                  borderRadius:
                                                                  const BorderRadius.all(Radius.circular(5)),
                                                                  border: Border.all(
                                                                      color:
                                                                      grey),
                                                                ),

                                                                child:
                                                                Center(
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                                                      child: DropdownButton<String>(
                                                                        hint: buildTextRegularWidget(
                                                                            cont.addedAllottedStatus.contains(taskDetailsIndex)
                                                                                ? cont.selectedAllottedStatus
                                                                            : cont.checkStatusList[taskDetailsIndex] == "1" ? "Inprocess" :
                                                                            cont.checkStatusList[taskDetailsIndex] == "2" ? "Awaiting for Client Input" :
                                                                            cont.checkStatusList[taskDetailsIndex] == "3" ? "Submitted for Checking" :
                                                                            cont.checkStatusList[taskDetailsIndex] == "4" ? "Put on Hold" :
                                                                            cont.checkStatusList[taskDetailsIndex] == "5" ? "Completed" :
                                                                            "Select",
                                                                            //cont.checkStatusList[taskDetailsIndex] == "4" ? "Put on Hold"
                                                                            // cont.checkStatusList[taskDetailsIndex] == "5" ? "Completed" :
                                                                            // cont.selectedAllottedStatus,
                                                                            blackColor, context, 15.0,align: TextAlign.left),
                                                                        isExpanded: true,
                                                                        underline: Container(),
                                                                        items:
                                                                        cont.allottedStartedStatusList.isEmpty
                                                                            ?
                                                                        cont.noDataList.map((value) {
                                                                          return DropdownMenuItem<String>(
                                                                            value: value,
                                                                            child: Text(value),
                                                                          );
                                                                        }).toList()
                                                                            :
                                                                        cont.allottedStartedStatusList.map((value) {
                                                                          return DropdownMenuItem<String>(
                                                                            value: value,
                                                                            child: Text(value),
                                                                            onTap: (){
                                                                            },
                                                                          );
                                                                        }).toList(),
                                                                        onChanged: (val) {
                                                                          print("val");
                                                                          print(val);
                                                                          cont.updateSelectedAllottedStatus(context,val!,taskDetailsIndex,
                                                                              cont.timesheetTaskListData[taskListIndex].timesheetTaskDetailsData![taskDetailsIndex].taskId!,
                                                                              cont.clientAppServiceId,taskDetailsIndex
                                                                          );
                                                                        },
                                                                      ),
                                                                    )
                                                                )
                                                            ),
                                                          )
                                                        ]),
                                                      ],
                                                    ),

                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                  ],
                                                );
                                              }),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),

                          const SizedBox(
                            height: 10.0,
                          ),
                          buildRichTextWidget(
                            "Timesheet filled for * ",
                            "${cont.hrSum} Hrs and ${cont.minSum} minutes",
                            title1Color: primaryColor,
                            title2Color: blackColor,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      )
                    : const Opacity(opacity: 0.0)
              ],
            )
            : Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              cont.isLoadingForStepper1=false;
                              cont.loaderAllottedForSerice=false;
                              cont.loader=false;
                              cont.goToPreviousFromNonAllotted();
                              //cont.cancel();
                            },
                            child: SizedBox(
                                width: 80.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildTextBoldWidget("Previous",
                                        primaryColor, context, 15.0),
                                    const Divider(
                                      thickness: 2.0,
                                      color: primaryColor,
                                    ),
                                  ],
                                ))),
                        GestureDetector(
                          onTap: () {
                            cont.isFillTimesheetSelected = true;
                            cont.saveCurrentNonAllottedList(fromNonAllottedNext: true);
                          },
                          child: SizedBox(
                              width: 40.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  buildTextBoldWidget(
                                      "Skip", primaryColor, context, 15.0),
                                  const Divider(
                                    thickness: 2.0,
                                    color: primaryColor,
                                  ),
                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            cont.isFillTimesheetSelected = true;
                            cont.saveCurrentNonAllottedList(fromNonAllottedNext: true);
                          },
                          child: SizedBox(
                              width: 40.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  buildTextBoldWidget(
                                      "Next", primaryColor, context, 15.0),
                                  const Divider(
                                    thickness: 2.0,
                                    color: primaryColor,
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    buildTimeSheetTitle(context, "Non Allotted Services",
                        fontSize: 16.0),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: grey),
                        ),
                        child: Center(
                            child: Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: DropdownButton(
                            itemHeight: 70.0,
                            hint: buildTextRegularWidget(
                                cont.nonAllottedSelectedClientName == ""
                                    ? "Select Client Name"
                                    : cont.nonAllottedSelectedClientName,
                                blackColor,
                                context,
                                15.0,
                                align: TextAlign.left),
                            isExpanded: true,
                            underline: Container(),
                            items: cont.allottedEmployeeList
                                .map((ClientListData value) {
                              String clientNameWithCode = "${value.firmClientFirmName!} (${value.firmClientClientCode})";

                              return DropdownMenuItem<String>(
                                value: clientNameWithCode,
                                child: Text(clientNameWithCode),
                                onTap: () {
                                  cont.allottedServiceList.clear();
                                  cont.nonAllottedTaskList.clear();
                                  cont.selectedNonAllottedClientNameList.clear();
                                  cont.selectedNonAllottedClientIdList.clear();
                                  cont.nonAllottedSelectedServiceName = "";
                                  cont.nonAllottedSelectedTaskName = "";
                                  cont.selectedNonAllottedTaskId = "";
                                  cont.addNonAllottedClientNameAndId(
                                      value.firmClientId!,
                                      "${value.firmClientFirmName} (${value.firmClientClientCode})");
                                },
                              );
                            }).toList(),
                            onChanged: (val) {
                              cont.onNonAllottedClientName(val!);
                            },
                          ),
                        ))),
                    const SizedBox(
                      height: 10.0,
                    ),
                    cont.loaderNonAllottedService ? buildCircularIndicator() :
                    Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: grey),
                        ),
                        child: Center(
                            child: Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: DropdownButton(
                            itemHeight: 70.0,
                            hint: buildTextRegularWidget(
                                cont.nonAllottedSelectedServiceName == ""
                                    ? "Select Service"
                                    : cont.nonAllottedSelectedServiceName,
                                blackColor,
                                context,
                                15.0,
                                align: TextAlign.left),
                            isExpanded: true,
                            underline: Container(),
                            items: cont.allottedServiceList
                                .map((TimesheetServicesListData value) {
                              String serviceNamePeriod = "";
                              // if(value.period == null || value.period == ""){
                              //   serviceNamePeriod = value.serviceName!;
                              // }
                              // else{
                              //   serviceNamePeriod = "${value.serviceName!}(${value.period!})";
                              // }

                              if(value.serviceDueDatePeriodicity == null || value.serviceDueDatePeriodicity == ""){
                                if(value.period == null || value.period == ""){
                                  serviceNamePeriod = value.serviceName! ;
                                }
                                else{
                                  serviceNamePeriod = "${value.serviceName} | ${value.period!}";
                                }
                              }
                              else{
                                serviceNamePeriod = "${value.serviceName} | ${value.serviceDueDatePeriodicity} | ${value.period!}";
                              }
                              return DropdownMenuItem<String>(
                                value: serviceNamePeriod,
                                child: Text(serviceNamePeriod),
                                onTap: () {
                                  cont.nonAllottedTaskList.clear();
                                  cont.selectedNonAllottedServiceNameList.clear();
                                  cont.selectedNonAllottedServiceIdList.clear();
                                  cont.selectedNonAllottedClientIdServiceIdList.clear();
                                  cont.selectedNonAllottedTaskId = "";
                                  cont.addNonAllottedServiceNameAndId(
                                      value.serviceId!,
                                      //"${value.serviceName!} (${value.period})",
                                      serviceNamePeriod,
                                      value.selectedClientId!,
                                      value.id!);
                                },
                              );
                            }).toList(),
                            onChanged: (val) {
                              cont.onNonAllottedServiceName(val!);
                            },
                          ),
                        ))),

                    const SizedBox(
                      height: 10.0,
                    ),

                    cont.loaderNonAllottedForTask ? buildCircularIndicator() :
                    Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: grey),
                        ),
                        child: Center(
                            child: Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: DropdownButton(
                            itemHeight: 70.0,
                            hint: buildTextRegularWidget(
                                cont.nonAllottedSelectedTaskName == ""
                                    ? "Select Task"
                                    : cont.nonAllottedSelectedTaskName,
                                blackColor,
                                context,
                                15.0,
                                align: TextAlign.left),
                            isExpanded: true,
                            underline: Container(),
                            items: cont.nonAllottedTaskList
                                .map((TimesheetTaskDetailsData value) {
                              return DropdownMenuItem<String>(
                                value: value.taskName,
                                child: Text(value.taskName!),
                                onTap: () {
                                  cont.selectedNonAllottedTaskNameList.clear();
                                  cont.selectedNonAllottedTaskIdList.clear();
                                  cont.addNonAllottedTaskNameAndId(
                                      value.taskId!, value.taskName!);
                                },
                              );
                            }).toList(),
                            onChanged: (val) {
                              cont.onNonAllottedTaskName(val!);
                            },
                          ),
                        ))),
                    const SizedBox(
                      height: 10.0,
                    ),

                    Table(
                      children: [
                        TableRow(children: [
                          SizedBox(
                              height: 40.0,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: buildTextRegularWidget(
                                    "Details", blackColor, context, 14.0),
                              )),
                          Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: grey),
                                color: cont.nonAllottedStatus == "1" && cont.nonAllottedStart == "0" ? grey.withOpacity(0.2):whiteColor
                            ),
                            child: TextFormField(
                              controller: cont.nonAllottedDetailsController,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              onTap: () {},
                              enabled: cont.nonAllottedStatus == "1" && cont.nonAllottedStart == "0"?false:true,
                              style: const TextStyle(fontSize: 15.0),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Details",
                                hintStyle: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: cont.nonAllottedStatus == "1" && cont.nonAllottedStart == "0"?grey:blackColor,
                                    fontSize: 15,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                        ]),
                        const TableRow(children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ]),
                        TableRow(children: [
                          SizedBox(
                              height: 40.0,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: buildTextRegularWidget(
                                    "Time Spent", blackColor, context, 14.0),
                              )),
                          GestureDetector(
                            onTap: () {
                              cont.nonAllottedStatus == "1" && cont.nonAllottedStart == "0"?null:
                              cont.selectTime(context, "nonAllotted");
                              //cont.selectTimeForTask(context,cont.hrList.length);
                            },
                            child: Container(
                                height: 40.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  border: Border.all(color: grey),
                                    color: cont.nonAllottedStatus == "1" && cont.nonAllottedStart == "0" ? grey.withOpacity(0.2):whiteColor

                                ),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: buildTextRegularWidget(
                                          cont.selectedNonAllottedTime == ""
                                              ? "Time Spent"
                                              : cont.selectedNonAllottedTime,
                                          cont.nonAllottedStatus == "1" && cont.nonAllottedStart == "0"?grey:blackColor,
                                          context,
                                          15.0),
                                    ))),
                          ),
                        ]),
                        const TableRow(children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ]),
                        TableRow(children: [
                          SizedBox(
                              height: 40.0,
                              child: Align(
                                alignment:
                                Alignment
                                    .centerLeft,
                                child: buildTextRegularWidget(
                                    "Status",
                                    blackColor,
                                    context,
                                    14.0),
                              )),
                          Padding(
                            padding:
                            const EdgeInsets
                                .only(
                                right:
                                5.0),
                            child:
                            cont.selectedNonAllottedTaskId==""?const Opacity(opacity: 0.0):
                                cont.loaderForNonAllottedStatus ? buildCircularIndicator():


                                cont.nonAllottedStatus == "1" && cont.nonAllottedStart == "0"
                                    ? GestureDetector(
                                  onTap:
                                      () {
                                        cont.callTimesheetStartForNonAllotted(context);
                                      },
                                  child: buildButtonWidget(
                                      context,
                                      "Start",
                                      height:
                                      40.0),
                                ) :


                                cont.nonAllottedStatus == "5" ?
                                SizedBox(
                                    height: 40.0,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: buildTextRegularWidget(
                                          "Completed", blackColor, context, 15.0),
                                    ))
                                    :
                            Container(
                                height:
                                40.0,
                                width: MediaQuery.of(
                                    context)
                                    .size
                                    .width,
                                decoration:
                                BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: grey),
                                ),

                                child: Center(
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                      child:
                                      DropdownButton<String>(
                                        hint: buildTextRegularWidget(
                                            cont.selectedNonAllottedStatus==""?
                                            cont.nonAllottedStatus == "1" ? "Inprocess" :
                                            cont.nonAllottedStatus == "2" ? "Awaiting for Client Input" :
                                            cont.nonAllottedStatus == "3" ? "Submitted for Checking" :
                                            cont.nonAllottedStatus == "4" ? "Put on Hold" :
                                            cont.nonAllottedStatus == "5" ? "Completed" :
                                            "Inprocess" : cont.selectedNonAllottedStatus,
                                            blackColor, context, 15.0,align: TextAlign.left),
                                        isExpanded: true,
                                        underline: Container(),
                                        items:
                                        cont.nonAllottedStartedStatusList.isEmpty
                                            ?
                                        cont.noDataList.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList()
                                            :
                                        cont.nonAllottedStartedStatusList.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                            onTap: (){
                                            },
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          cont.updateSelectedNonAllottedStatus(context,val!, cont.selectedNonAllottedClientApplicableService,
                                          );
                                        },
                                      ),
                                    )
                                )
                            )
                          )
                        ]),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    buildRichTextWidget(
                      "Timesheet filled for * ",
                      "${cont.hrSum + cont.hrNonAllottedSum} Hrs and ${cont.minSum + cont.minNonAllottedSum} minutes",
                      title1Color: primaryColor,
                      title2Color: blackColor,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              );
  }

  buildStepperThree(TimesheetNewFormController cont) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child:
      cont.isLoadingForStepper3 ? buildCircularIndicator():
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
              onTap: () {
                cont.goToPreviousFromStepper3();
              },
              child: SizedBox(
                  width: 80.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTextBoldWidget(
                          "Previous", primaryColor, context, 15.0),
                      const Divider(
                        thickness: 2.0,
                        color: primaryColor,
                      ),
                    ],
                  ))),
          const SizedBox(
            height: 30.0,
          ),
          buildRichTextWidget(
            "Timesheet filled for: ",
            "${cont.hrSum + cont.hrNonAllottedSum + cont.hrOfficeSum} Hours "
                "${cont.minSum + cont.minNonAllottedSum + cont.minOfficeSum} minutes",
            title1Color: primaryColor,
            title2Color: blackColor,
          ),
          cont.diff.inHours == 0 && cont.diff.inMinutes == 0
              ? const Opacity(opacity: 0.0,)
              : const Divider(),

          cont.diff.inHours == 0 && cont.diff.inMinutes == 0
              ? const Opacity(opacity: 0.0,)
              : const SizedBox(
            height: 10.0,
          ),

          cont.diff.inHours == 0 && cont.diff.inMinutes == 0
              ? const Opacity(opacity: 0.0,)
              :
          buildTextRegularWidget(
              "Total difference between in Time and out Time",
              blackColor,
              context,
              15.0),

          cont.diff.inHours == 0 && cont.diff.inMinutes == 0
              ? const Opacity(opacity: 0.0,)
              : const Divider(),

          cont.diff.inHours == 0 && cont.diff.inMinutes == 0
              ? const Opacity(opacity: 0.0,)
              : const SizedBox(
            height: 10.0,
          ),

          cont.diff.inHours == 0 && cont.diff.inMinutes == 0
              ? const Opacity(opacity: 0.0,)
              :
          buildRichTextWidget(
            "Time: ",
            "${cont.difference.inHours} Hours "
                "${cont.difference.inMinutes.remainder(60)} Minutes",
            title1Color: primaryColor,
            title2Color: blackColor,
          ),
          cont.diff.inHours == 0 && cont.diff.inMinutes == 0
              ? const Opacity(opacity: 0.0,)
              :
          const SizedBox(
            height: 10.0,
          ),
          buildRichTextWidget(
            "Difference hours: ",
            "${cont.diff.inHours} Hours "
                "${cont.diff.inMinutes.remainder(60)} Minutes",
            title1Color: primaryColor,
            title2Color: blackColor,
          ),
          cont.diff.inHours == 0 && cont.diff.inMinutes == 0
              ? const Opacity(opacity: 0.0,)
              :
          const SizedBox(
            height: 10.0,
          ),
          cont.diff.inHours == 0 && cont.diff.inMinutes == 0
          ? const Opacity(opacity: 0.0,)
          :
          buildRichTextWidget(
            "Note: ",
            "Difference should be zero to enable the Submit for Approval button",
            title1Color: errorColor,
            title2Color: errorColor,
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Divider(),
          const SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            onTap: () {
              cont.callApiToSaveAll("save");
            },
            child: buildButtonWidget(context, "Save",
                buttonColor: editColor, width: 100.0),
          ),
          const SizedBox(
            height: 10.0,
          ),

          GestureDetector(
            onTap: () {
              cont.diff.inHours == 0 && cont.diff.inMinutes == 0
                  ? cont.callApiToSaveAll("approve") : null;
                //cont.callApiToSaveAll("approve");
              // print("allotted data");
              // print(cont.selectedDateToSend);
              // print(cont.removeSecondBracket);
              // print(cont.removeSecondBracketForService);
              // print(cont.removeSecondBracketForClientApplicableService);
              // print(cont.removeSecondTaskIdListBracket);
              // print(cont.removeSecondDetailsBracket);
              // print(cont.removeSecondTimeSpentBracket);
              // print("non allotted data");
              // print("${cont.removeSecondBracket.replaceAll(", ", ",")},${cont.removeSecondNonAllottedClientIdListBracket.replaceAll(", ", ",")}");
              // print("${cont.removeSecondBracketForService.replaceAll(", ", ",")},${cont.removeSecondNonAllottedServiceIdListBracket.replaceAll(", ", ",")}");
              // print("${cont.removeSecondBracketForClientApplicableService.replaceAll(", ", ",")},${cont.removeSecondNonAllottedClientServiceIdListBracket.replaceAll(", ", ",")}");
              // print("${cont.removeSecondTaskIdListBracket.replaceAll(", ", ",")},${cont.removeSecondNonAllottedTaskIdBracket.replaceAll(", ", ",")}");
              // print("${cont.removeSecondTimeSpentBracket.replaceAll(", ", ",")},${cont.removeSecondNonAllottedTimeListBracket.replaceAll(", ", ",")}");
              // print("final");
              // print(cont.finalDetails);
              // print(cont.finalClientId);
              print("office data");
              print(cont.selectedDateToSend);
              print(cont.removeSecondOfficeWorkIdListBracket);
              print(cont.removeSecondOfficeDetailsListBracket);
              print(cont.removeSecondOfficeAddedTimeListBracket);
              print(cont.officeAction);
            },
            child: buildButtonWidget(context, "Submit for Approval",
                buttonColor: cont.diff.inHours == 0 && cont.diff.inMinutes == 0?editColor:grey, width: 250.0),
          ),
        ],
      ),
    );
  }
}
