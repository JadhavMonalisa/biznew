import 'package:biznew/common_widget/error_text.dart';
import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/screens/claim_form/claim_model.dart';
import 'package:biznew/screens/manual_assignment/manual_assignment_controller.dart';
import 'package:biznew/screens/manual_assignment/manual_assignment_model.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ManualAssignmentScreen extends StatefulWidget {
  const ManualAssignmentScreen({Key? key}) : super(key: key);

  @override
  State<ManualAssignmentScreen> createState() => _ManualAssignmentScreenState();
}

class _ManualAssignmentScreenState extends State<ManualAssignmentScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManualAssignmentController>(builder: (cont) {
      return WillPopScope(
          onWillPop: () async {
            return cont.navigateToHomeScreen();
          },
          child: Scaffold(
              backgroundColor: primaryColor,
              appBar: AppBar(
                centerTitle: true,
                elevation: 0.0,
                title: buildTextMediumWidget(
                    "Manual Assignment", whiteColor, context, 16,
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
                                          showWarningOnManualAssignmentDialog(
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
                                            showWarningOnManualAssignmentDialog(
                                                context,
                                                "Confirm Logout...!!!",
                                                "Do you want to logout from an app?",
                                                logoutFeature: true,
                                                cont);
                                          },
                                          child: buildTextBoldWidget("Logout",
                                              blackColor, context, 15.0)),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {},
                                        child: buildTextRegularWidget(
                                            "App Version 1.0",
                                            grey,
                                            context,
                                            14.0),
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
              body: Container(
                  color: whiteColor,
                  padding: const EdgeInsets.all(20.0),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(physics: const ScrollPhysics(), children: [
                    ///financial year
                    buildTimeSheetTitle(context, "Financial Year"),
                    Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color:
                                  cont.validateClientYear ? errorColor : grey),
                        ),
                        child: Center(
                            child: Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: DropdownButton<String>(
                            hint: buildTextRegularWidget(
                                cont.selectedYear == ""
                                    ? "F.Y."
                                    : cont.selectedYear,
                                blackColor,
                                context,
                                15.0,
                                align: TextAlign.left),
                            isExpanded: true,
                            underline: Container(),
                            items: cont.yearList.isEmpty
                                ? cont.noDataList.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList()
                                : cont.yearList.map((YearList value) {
                                    String year =
                                        "${value.finanacialYearStartDate} - ${value.finanacialYearEndDate!}";
                                    return DropdownMenuItem<String>(
                                      value: year,
                                      child: Text(
                                          "${value.finanacialYearStartDate!} - ${value.finanacialYearEndDate!}"),
                                      onTap: () {
                                        cont.updateSelectedYearId(
                                            value.financialYearId!);
                                      },
                                    );
                                  }).toList(),
                            onChanged: (val) {
                              cont.updateSelectedYear(val!, context);
                            },
                          ),
                        ))),

                    ///clients
                    buildTimeSheetTitle(context, "Clients"),
                    Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color:
                                  cont.validateClientName ? errorColor : grey),
                        ),
                        child: Center(
                            child: Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: DropdownButton<String>(
                            hint: buildTextRegularWidget(
                                cont.selectedClientName == ""
                                    ? "Client Name"
                                    : cont.selectedClientName,
                                blackColor,
                                context,
                                15.0,
                                align: TextAlign.left),
                            isExpanded: true,
                            underline: Container(),
                            items: cont.clientNameList.isEmpty
                                ? cont.noDataList.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList()
                                : cont.clientNameList.map((NameList value) {
                                    return DropdownMenuItem<String>(
                                      value: value.firmClientFirmName,
                                      child: Text(value.firmClientFirmName!),
                                      onTap: () {
                                        cont.updateSelectedClientId(
                                            value.firmClientClientCode!,
                                            value.firmClientId!);
                                      },
                                    );
                                  }).toList(),
                            onChanged: (val) {
                              cont.updateSelectedClientName(val!, context);
                            },
                          ),
                        ))),

                    ///Main category
                    buildTimeSheetTitle(context, "Main Category"),
                    Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: cont.validateMainCategory
                                  ? errorColor
                                  : grey),
                        ),
                        child: Center(
                            child: Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: DropdownButton<String>(
                            hint: buildTextRegularWidget(
                                cont.selectedMainCategory == ""
                                    ? "Category"
                                    : cont.selectedMainCategory,
                                blackColor,
                                context,
                                15.0,
                                align: TextAlign.left),
                            isExpanded: true,
                            underline: Container(),
                            items: cont.mainCategoryList.isEmpty
                                ? cont.noDataList.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList()
                                : cont.mainCategoryList
                                    .map((ServicesMainCategoryList value) {
                                    return DropdownMenuItem<String>(
                                      value: value.serviceMainCategoryName,
                                      child:
                                          Text(value.serviceMainCategoryName!),
                                      onTap: () {
                                        cont.updateSelectedMainCategoryId(
                                            value.serviceMainCategoryId!);
                                      },
                                    );
                                  }).toList(),
                            onChanged: (val) {
                              cont.updateSelectedMainCategory(val!, context);
                            },
                          ),
                        ))),

                    ///services
                    buildTimeSheetTitle(context, "Service"),
                    Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: cont.validateClientService
                                  ? errorColor
                                  : grey),
                        ),
                        child: Center(
                            child: Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: DropdownButton<String>(
                            hint: buildTextRegularWidget(
                                cont.selectedService == ""
                                    ? "Service"
                                    : cont.selectedService,
                                blackColor,
                                context,
                                15.0,
                                align: TextAlign.left),
                            isExpanded: true,
                            underline: Container(),
                            items: cont.servicesFromCategoryList.isEmpty
                                ? cont.noDataList.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList()
                                : cont.servicesFromCategoryList
                                    .map((ServicesList value) {
                                    return DropdownMenuItem<String>(
                                      value: value.serviceName,
                                      child: Text(value.serviceName!),
                                      onTap: () {
                                        cont.updateSelectedServiceId(
                                            value.serviceId!,
                                            value.serviceName!);
                                      },
                                    );
                                  }).toList(),
                            onChanged: (val) {
                              cont.updateSelectedService(val!, context);
                            },
                          ),
                        ))),

                    ///target,trigger
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///trigger date
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildTimeSheetTitle(context, "Trigger date"),
                              GestureDetector(
                                onTap: () {
                                  cont.selectDate(context, "triggerDate");
                                },
                                child: Container(
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      border: Border.all(
                                          color: cont.validateTriggerDate
                                              ? errorColor
                                              : grey),
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Icon(
                                          Icons.calendar_today,
                                          color: cont.selectedTriggerDate == ""
                                              ? grey
                                              : blackColor,
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        buildTextRegularWidget(
                                            cont.selectedTriggerDate == ""
                                                ? "Select Date"
                                                : cont.selectedTriggerDate,
                                            cont.selectedTriggerDate == ""
                                                ? grey
                                                : blackColor,
                                            context,
                                            15.0)
                                      ],
                                    )),
                              ),
                              cont.validateTriggerDate == true
                                  ? ErrorText(
                                      errorMessage:
                                          "Please select trigger date",
                                    )
                                  : const Opacity(opacity: 0.0),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),

                        ///target date
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildTimeSheetTitle(context, "Target date"),
                              GestureDetector(
                                onTap: () {
                                  cont.selectDate(context, "targetDate");
                                },
                                child: Container(
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      border: Border.all(
                                          color: cont.validateTargetDate
                                              ? errorColor
                                              : grey),
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Icon(
                                          Icons.calendar_today,
                                          color: cont.selectedTargetDate == ""
                                              ? grey
                                              : blackColor,
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        buildTextRegularWidget(
                                            cont.selectedTargetDate == ""
                                                ? "Select Date"
                                                : cont.selectedTargetDate,
                                            cont.selectedTargetDate == ""
                                                ? grey
                                                : blackColor,
                                            context,
                                            15.0)
                                      ],
                                    )),
                              ),
                              cont.validateTargetDate == true
                                  ? ErrorText(
                                      errorMessage: "Please select target date",
                                    )
                                  : const Opacity(opacity: 0.0),
                              const SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    ///priority
                    buildTimeSheetTitle(context, "Priority"),
                    Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: cont.validatePriority ? errorColor : grey),
                        ),
                        child: Center(
                            child: Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: DropdownButton<String>(
                            hint: buildTextRegularWidget(
                                cont.selectedPriority == ""
                                    ? "Select Priority"
                                    : cont.selectedPriority,
                                blackColor,
                                context,
                                15.0),
                            isExpanded: true,
                            underline: Container(),
                            items: cont.priorityList.isEmpty
                                ? cont.noDataList.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList()
                                : cont.priorityList.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                      onTap: () {
                                        cont.updateSelectedPriority(
                                            value, context);
                                      },
                                    );
                                  }).toList(),
                            onChanged: (val) {
                              cont.updateSelectedPriority(val!, context);
                            },
                          ),
                        ))),

                    ///employee
                    buildTimeSheetTitle(context, "Employee"),
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
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList()
                                : cont.employeeList
                                    .map((ClaimSubmittedByList value) {
                                    return DropdownMenuItem<String>(
                                      value: value.firmEmployeeName,
                                      child: Text(value.firmEmployeeName!),
                                      onTap: () {
                                        cont.updateSelectedEmployee(
                                            value.firmEmployeeName!,
                                            value.mastId!);
                                      },
                                    );
                                  }).toList(),
                            onChanged: (val) {
                              //cont.updateEmployeeFromTriggered(val!,value.firmEmployeeName!);
                            },
                          ),
                        ))),

                    ///fees/period
                    buildTimeSheetTitle(context, "Fees/Period"),
                    Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: grey),
                      ),
                      child: TextFormField(
                        controller: cont.feesController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.left,
                        textCapitalization: TextCapitalization.words,
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.done,
                        onTap: () {},
                        style: const TextStyle(fontSize: 15.0),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: "Enter fees",
                          hintStyle: GoogleFonts.rubik(
                            textStyle: const TextStyle(
                              color: blackColor,
                              fontSize: 15,
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (text) {
                          //cont.checkFeesValidation(context);
                        },
                      ),
                    ),
                    // cont.validateFees == true
                    //     ? ErrorText(
                    //         errorMessage: "Please enter fees",
                    //       )
                    //     : const Opacity(opacity: 0.0),

                    ///remark
                    buildTimeSheetTitle(context,
                        "Remark (This will be appended to service name for reference)"),
                    Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: grey),
                      ),
                      child: TextFormField(
                        controller: cont.remarkController,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.left,
                        textCapitalization: TextCapitalization.words,
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.done,
                        onTap: () {},
                        style: const TextStyle(fontSize: 15.0),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: "Enter remark",
                          hintStyle: GoogleFonts.rubik(
                            textStyle: const TextStyle(
                              color: blackColor,
                              fontSize: 15,
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (text) {},
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    ///add tasks note
                    // buildTextBoldWidget("Add Tasks", errorColor, context, 16.0,align: TextAlign.center),
                    // const SizedBox(height:10.0),
                    // RichText(
                    //   text: const TextSpan(
                    //     text: "Note: Service without Due Dates will only appear in list. For Due Date applicable services, apply them through Client Master by ",
                    //     style: TextStyle(fontWeight: FontWeight.bold,color: errorColor,fontSize: 16.0),
                    //     children: <TextSpan>[
                    //       TextSpan(
                    //           text: "clicking here",
                    //           style: TextStyle(fontWeight: FontWeight.bold,color:Colors.blue,fontSize: 16.0)),
                    //     ],
                    //   ),
                    // ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(color: blackColor)),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cont.tasksList.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final item = cont.tasksList[index];

                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(color: grey),
                                      ),
                                      child: cont.taskNameList.isEmpty
                                          ? null
                                          : TextFormField(
                                              controller:
                                                  cont.taskNameList[index],
                                              keyboardType: TextInputType.text,
                                              textAlign: TextAlign.left,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              textInputAction:
                                                  TextInputAction.done,
                                              onTap: () {},
                                              enabled: true,
                                              style: const TextStyle(
                                                  fontSize: 15.0),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.all(10),
                                                hintText: item.taskName!,
                                                hintStyle: GoogleFonts.rubik(
                                                  textStyle: const TextStyle(
                                                    color: blackColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                border: InputBorder.none,
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
                                    buildTextRegularWidget(
                                        "Employee", blackColor, context, 14.0),
                                    const SizedBox(
                                      width: 33.0,
                                    ),
                                    Flexible(
                                      child: Container(
                                          height: 30.0,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            border: Border.all(color: grey),
                                          ),
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, right: 15.0),
                                            child: DropdownButton(
                                              hint: buildTextRegularWidget(
                                                  cont.taskSelectedEmpList
                                                          .isEmpty
                                                      ? ""
                                                      : cont.taskSelectedEmpList[
                                                          index],
                                                  blackColor,
                                                  context,
                                                  15.0),
                                              isExpanded: true,
                                              underline: Container(),
                                              items: cont.employeeList.map(
                                                  (ClaimSubmittedByList value) {
                                                return DropdownMenuItem<String>(
                                                  value: value.firmEmployeeName,
                                                  child: Text(
                                                      value.firmEmployeeName!),
                                                  onTap: () {
                                                    cont.updateEmployee(
                                                        index,
                                                        value.firmEmployeeName!,
                                                        value.mastId!,
                                                        item.taskId!);
                                                  },
                                                );
                                              }).toList(),
                                              onChanged: (val) {
                                                //cont.updateEmployee(index,val!,item.taskId!);
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
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5)),
                                                  border:
                                                      Border.all(color: grey),
                                                ),
                                                child: cont.taskCompletionList
                                                        .isEmpty
                                                    ? null
                                                    : Center(
                                                        child: TextFormField(
                                                          controller:
                                                              cont.taskCompletionList[
                                                                  index],
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          onTap: () {},
                                                          enabled: true,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15.0,
                                                          ),
                                                          textAlign:
                                                              TextAlign.right,
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 2,
                                                                    bottom:
                                                                        10.0),
                                                            hintText: item
                                                                .completion!,
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .rubik(
                                                              textStyle:
                                                                  const TextStyle(
                                                                color:
                                                                    blackColor,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                          onChanged: (value) {
                                                            //cont.addCompletion(index,value);
                                                          },
                                                        ),
                                                      )),
                                          ),
                                          const SizedBox(width: 10.0),
                                          buildTextRegularWidget(
                                              "D", blackColor, context, 14.0,
                                              align: TextAlign.center),
                                          const SizedBox(width: 5.0),
                                          Flexible(
                                            child: Container(
                                                height: 30.0,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5)),
                                                  border:
                                                      Border.all(color: grey),
                                                ),
                                                child: cont.taskDaysList.isEmpty
                                                    ? null
                                                    : Center(
                                                        child: TextFormField(
                                                          controller:
                                                              cont.taskDaysList[
                                                                  index],
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          onTap: () {},
                                                          enabled: true,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      15.0),
                                                          textAlign:
                                                              TextAlign.right,
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 2,
                                                                    bottom:
                                                                        10.0),
                                                            hintText:
                                                                item.days!,
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .rubik(
                                                              textStyle:
                                                                  const TextStyle(
                                                                color:
                                                                    blackColor,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                          onChanged: (value) {
                                                            //cont.addDays(index,value);
                                                          },
                                                        ),
                                                      )),
                                          ),
                                          const SizedBox(width: 10.0),
                                          buildTextRegularWidget(
                                              "H", blackColor, context, 14.0,
                                              align: TextAlign.center),
                                          const SizedBox(width: 5.0),
                                          Flexible(
                                            child: Container(
                                                height: 30.0,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5)),
                                                  border:
                                                      Border.all(color: grey),
                                                ),
                                                child: cont
                                                        .taskHoursList.isEmpty
                                                    ? null
                                                    : Center(
                                                        child: TextFormField(
                                                          controller:
                                                              cont.taskHoursList[
                                                                  index],
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          onTap: () {},
                                                          enabled: true,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      15.0),
                                                          textAlign:
                                                              TextAlign.right,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                item.hours!,
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 2,
                                                                    bottom:
                                                                        10.0),
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .rubik(
                                                              textStyle:
                                                                  const TextStyle(
                                                                color:
                                                                    blackColor,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                          onChanged: (value) {
                                                            //cont.addHours(index,value);
                                                          },
                                                        ),
                                                      )),
                                          ),
                                          const SizedBox(width: 10.0),
                                          buildTextRegularWidget(
                                              "M", blackColor, context, 14.0,
                                              align: TextAlign.center),
                                          const SizedBox(width: 5.0),
                                          Flexible(
                                            child: Container(
                                                height: 30.0,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5)),
                                                  border:
                                                      Border.all(color: grey),
                                                ),
                                                child: cont
                                                        .taskMinuteList.isEmpty
                                                    ? null
                                                    : Center(
                                                        child: TextFormField(
                                                          controller:
                                                              cont.taskMinuteList[
                                                                  index],
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          textAlign:
                                                              TextAlign.right,
                                                          onTap: () {},
                                                          enabled: true,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      15.0),
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                item.minutes!,
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 2,
                                                                    bottom:
                                                                        10.0),
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .rubik(
                                                              textStyle:
                                                                  const TextStyle(
                                                                color:
                                                                    blackColor,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                          onChanged: (value) {
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
                                              cont.removeFromSelected(
                                                index,
                                              );
                                            },
                                            child: buildButtonWidget(
                                                context, "Remove",
                                                height: 35.0,
                                                width: 150.0,
                                                buttonColor: errorColor,
                                                buttonFontSize: 14.0),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () {
                                              cont.checkAllAddedValues(index);
                                            },
                                            child: buildButtonWidget(
                                              context,
                                              "Add",
                                              width: 150.0,
                                              height: 35.0,
                                              buttonColor: approveColor,
                                              buttonFontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                    cont.tasksList.isEmpty
                        ? const Opacity(
                            opacity: 0.0,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 10.0),
                            child: Row(
                              children: [
                                buildTextBoldWidget("Completion % : ",
                                    blackColor, context, 15.0),
                                buildTextRegularWidget(
                                    cont.totalCompletion.toString(),
                                    blackColor,
                                    context,
                                    15.0),
                                const Spacer(),
                                buildTextBoldWidget(
                                    "  Total : ", blackColor, context, 15.0),
                                buildTextRegularWidget(
                                    cont.totalDays.toString(),
                                    blackColor,
                                    context,
                                    15.0),
                                buildTextBoldWidget(
                                    "D ", blackColor, context, 15.0),
                                buildTextRegularWidget(
                                    cont.totalHours.toString(),
                                    blackColor,
                                    context,
                                    15.0),
                                buildTextBoldWidget(
                                    "H ", blackColor, context, 15.0),
                                buildTextRegularWidget(
                                    cont.totalMins.toString(),
                                    blackColor,
                                    context,
                                    15.0),
                                buildTextBoldWidget(
                                    "M   ", blackColor, context, 15.0),
                              ],
                            ),
                          ),
                    cont.tasksList.isEmpty
                        ? const Opacity(
                            opacity: 0.0,
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Row(
                              children: [
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      cont.addMoreForManualAssignment(
                                          cont.tasksList.length);
                                    },
                                    child: buildButtonWidget(
                                        context, "Add more",
                                        buttonColor: editColor, height: 35.0),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Flexible(
                                    child: GestureDetector(
                                  onTap: () {
                                    cont.saveTasks();
                                  },
                                  child: buildButtonWidget(context, "Save",
                                      buttonColor: approveColor, height: 35.0),
                                )),
                              ],
                            ),
                          ),
                  ]))));
    });
  }
}
