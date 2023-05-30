import 'package:biznew/common_widget/error_text.dart';
import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/screens/claim_form/claim_model.dart';
import 'package:biznew/screens/timesheet_form/timesheet_model.dart';
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
    return GetBuilder<TimesheetNewFormController>(builder: (cont)
    {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,elevation: 0.0,
          title: buildTextMediumWidget("Timesheet", whiteColor,context, 16,align: TextAlign.center),
        ),
        drawer: Drawer(
          child: SizedBox(
              height: double.infinity,
              child: ListView(
                physics:const NeverScrollableScrollPhysics(),
                children: [
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height/1.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildDrawer(context,cont.name),Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0,left: 10.0,bottom: 50.0,right: 10.0),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    showWarningOnTimesheetNewFormDialog(context,"Confirm Logout...!!!","Do you want to logout from an app?",logoutFeature:true,cont);
                                  },
                                  child: const Icon(Icons.logout),
                                ),
                                const SizedBox(width: 7.0,),
                                GestureDetector(
                                    onTap:(){
                                      showWarningOnTimesheetNewFormDialog(context,"Confirm Logout...!!!","Do you want to logout from an app?",logoutFeature:true,cont);
                                    },
                                    child:buildTextBoldWidget("Logout", blackColor, context, 15.0)
                                ),const Spacer(),
                                GestureDetector(
                                  onTap:(){
                                  },
                                  child: buildTextRegularWidget("App Version 1.0", grey, context, 14.0),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
          ),
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
                    controlsBuilder: (context,details){
                      return

                        cont.currentStep == 0
                        ? Padding(
                          padding: const EdgeInsets.only(top:30.0),
                          child:GestureDetector(
                              onTap: (){
                                cont.continued();
                              },
                              child:buildButtonWidget(context, "Next")
                          ),
                        )
                        : cont.currentStep == 1 && cont.isFillTimesheetSelected == true
                            ? cont.currentService == "allotted"
                                ? Padding(
                            padding: const EdgeInsets.only(top:30.0),
                            child: Row(
                              children: [
                                Flexible(
                                  child: GestureDetector(
                                      onTap: (){
                                        cont.checkValidationForAllotted(context);
                                       //cont.showConfirmationDialog(context);
                                      },
                                      child:buildButtonWidget(context, "Save")
                                  ),
                                ),
                                const SizedBox(width: 10.0,),
                                Flexible(
                                  child: GestureDetector(
                                      onTap: (){
                                        cont.nextFromAllotted();
                                      },
                                      child:buildButtonWidget(context, "Next")
                                  ),
                                ),
                              ],
                            )
                        )
                                : Padding(
                            padding: const EdgeInsets.only(top:30.0),
                            child: GestureDetector(
                                onTap: (){
                                  // cont.currentService == "office"
                                  //     ? cont.showConfirmationDialogForOffice(context)
                                  //     : cont.showConfirmationDialogForNonAllotted(context);

                                  cont.currentService == "office"
                                      ? cont.checkValidationForOffice(context)
                                      : cont.checkValidationForNonAllotted(context);
                                },
                                child:buildButtonWidget(context, "Save")
                            ),
                        )
                            : const Opacity(opacity: 0.0);
                    },
                    onStepTapped: (step) => cont.tapped(step),
                    onStepContinue:  (){
                    },
                    onStepCancel: cont.cancel,
                    steps: <Step>[
                      ///stepper 1
                      Step(
                        title:Container(),
                        content: buildStepperOne(cont),
                        isActive: cont.currentStep >= 0,
                        state: cont.currentStep >= 0 ? StepState.complete : StepState.disabled,
                      ),
                      ///stepper 2
                      Step(
                        title:Container(),
                        content: buildStepperTwo(cont),
                        isActive: cont.currentStep >= 0,
                        state: cont.currentStep >= 1 ? StepState.complete : StepState.disabled,
                      ),
                      ///stepper 3
                      Step(
                        title:Container(),
                        content: buildStepperThree(cont),
                        isActive:cont.currentStep >= 0,
                        state: cont.currentStep >= 2 ? StepState.complete : StepState.disabled,
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      );
    });
  }

  buildStepperOne(TimesheetNewFormController cont) {
    return Padding(
      padding: const EdgeInsets.only(left:10.0,right:10.0,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ///date
          buildTimeSheetTitle(context,"Date"),
          GestureDetector(
            onTap: (){cont.selectDate(context);},
            child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color:  cont.validateStartDate?errorColor:grey),),
                child: Row(
                  children: [
                    const SizedBox(width: 10.0,),
                    Icon(Icons.calendar_today,color: cont.selectedDateToShow==""?grey:blackColor,),
                    const SizedBox(width: 10.0,),
                    buildTextRegularWidget(cont.selectedDateToShow==""?"Select Date":cont.selectedDateToShow,
                        cont.selectedDateToShow==""?grey:blackColor, context, 15.0)
                  ],
                )
            ),
          ),
          cont.validateStartDate== true
              ? ErrorText(errorMessage: "Please select date",)
              : const Opacity(opacity: 0.0),

          ///work at
          buildTimeSheetTitle(context,"Work At"),
          MultiSelectDialogField<String>(
            items: cont.workAtItems,
            title: const Text("Work At"),
            selectedColor: primaryColor,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: grey,),
            ),
            buttonIcon: const Icon(
              Icons.person,
              color: blackColor,size: 20.0,
            ),
            buttonText: buildTextRegularWidget("Select Work At", blackColor, context, 15.0),
            onConfirm: (results) {
              cont.onSelectionForMultipleWorkAt(results);
            },
            chipDisplay: MultiSelectChipDisplay(
              onTap: (value) {
                cont.onDeleteMultipleWorkAt(value);
              },
              icon: const Icon(Icons.clear,color: errorColor,),
            ),
          ),
          cont.validateWorkAt== true
              ? ErrorText(errorMessage: "Please select work at",)
              : const Opacity(opacity: 0.0),

          ///in time
          buildTimeSheetTitle(context,"In Time"),
          GestureDetector(
            onTap: (){cont.selectTime(context,"start");},
            child:  Container(
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: cont.validateInTime?errorColor:grey),),
                child: Row(
                  children: [
                    const SizedBox(width: 10.0,),
                    Icon(Icons.watch_later_outlined,color: cont.stepper1InTime.text.isEmpty?grey:blackColor,),
                    const SizedBox(width: 10.0,),
                    buildTextRegularWidget(cont.selectedStartTimeToShow==""?"In Time (HH:MM)":cont.selectedStartTimeToShow,
                        cont.selectedStartTimeToShow==""?grey:blackColor, context, 15.0)
                  ],
                )
            ),
          ),
          const SizedBox(height: 10,),
          buildTextRegularWidget("(24 hours format)", blackColor, context, 14.0),

          ///end time
          buildTimeSheetTitle(context,"Out Time"),
          GestureDetector(
            onTap: (){cont.selectTime(context,"end");},
            child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: cont.validateOutTime?errorColor:grey),),
                child: Row(
                  children: [
                    const SizedBox(width: 10.0,),
                    Icon(Icons.watch_later_outlined,color: cont.stepper1OutTime.text.isEmpty?grey:blackColor,),
                    const SizedBox(width: 10.0,),
                    buildTextRegularWidget(cont.selectedEndTimeToShow==""?"Out Time (HH:MM)":cont.selectedEndTimeToShow,
                        cont.selectedEndTimeToShow==""?grey:blackColor, context, 15.0)
                  ],
                )
            ),
          ),
          const SizedBox(height: 10,),
          buildTextRegularWidget("(24 hours format)", blackColor, context, 14.0),
          cont.validateOutTime== true
              ? ErrorText(errorMessage: "Please select valid out time (24 format)",)
              : const Opacity(opacity: 0.0),

          ///total time
          buildTimeSheetTitle(context,"Total Time"),
          Container(
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(color:cont.validateTotalTime?errorColor: grey),),
            child: TextFormField(
              controller: cont.timesheetTotalTime,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              textInputAction: TextInputAction.done,
              onTap: () {
              },enabled: false,
              style:const TextStyle(fontSize: 15.0),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                hintText: "Total time",
                hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                  color: grey, fontSize: 15,),),
                border: InputBorder.none,
              ),
              onChanged: (text) {
                cont.checkTotalTimeValidation();
              },
            ),
          ),
          cont.validateTotalTime== true
              ? ErrorText(errorMessage: "Please select start time",)
              : const Opacity(opacity: 0.0),
        ],
      ),
    );
  }

  buildStepperTwo(TimesheetNewFormController cont) {
    return
      cont.showOffice
          ? Padding(
        padding: const EdgeInsets.only(left:5.0,right:5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      cont.goToPreviousFromOffice();
                      //cont.cancel();
                    },
                    child:SizedBox(
                        width: 80.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildTextBoldWidget("Previous", primaryColor, context, 15.0),
                            const Divider(thickness: 2.0,color: primaryColor,),
                          ],
                        )
                    )
                ),
                GestureDetector(
                  onTap: (){
                  },
                  child: SizedBox(
                      width: 40.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          buildTextBoldWidget("Skip", primaryColor, context, 15.0),
                          const Divider(thickness: 2.0,color: primaryColor,),
                        ],
                      )
                  ),
                ),
                GestureDetector(
                  onTap: (){
                  },
                  child: SizedBox(
                      width: 40.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          buildTextBoldWidget("Next", primaryColor, context, 15.0),
                          const Divider(thickness: 2.0,color: primaryColor,),
                        ],
                      )
                  ),
                )
              ],
            ),
            const SizedBox(height: 10.0,),
            buildTimeSheetTitle(context,"Office Related", fontSize:16.0),
            const SizedBox(height: 10.0,),
            Container(
                height: 40.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: grey),),
                child:
                Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                      child: DropdownButton(
                        itemHeight: 70.0,
                        hint: buildTextRegularWidget(
                            cont.selectedOfficeWorkName == ""? "Select Work Type" : cont.selectedOfficeWorkName,
                            blackColor, context, 15.0,align: TextAlign.left),
                        isExpanded: true,
                        underline: Container(),
                        items:
                        cont.workList.map((TypeOfWorkList value) {
                          return DropdownMenuItem<String>(
                            value: value.name,
                            child: Text(value.name!),
                            onTap: (){
                              cont.addOfficeWorkNameAndId(value.id!,value.name!);
                            },
                          );
                        }).toList(),
                        onChanged: (val) {
                          cont.onOfficeWorkType(val!);
                        },
                      ),
                    )
                )
            ),
            const SizedBox(height: 10.0,),
            Table(
              children: [
                TableRow(
                    children: [
                      SizedBox(
                          height: 40.0,
                          child:Align(
                            alignment: Alignment.centerLeft,
                            child: buildTextRegularWidget("Details", blackColor, context, 14.0),
                          )),
                      Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: grey),),
                        child: TextFormField(
                          controller: cont.officeDetailsController,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.center,
                          textInputAction: TextInputAction.done,
                          onTap: () {
                          },
                          enabled: true,
                          style:const TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "Details",
                            hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                              color: blackColor, fontSize: 15,),),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                          },
                        ),
                      ),
                    ]
                ),
                const TableRow(
                    children: [
                      SizedBox(height: 10.0,),
                      SizedBox(height: 10.0,),
                    ]
                ),
                TableRow(
                    children: [
                      SizedBox(
                          height: 40.0,
                          child:Align(
                            alignment: Alignment.centerLeft,
                            child: buildTextRegularWidget("Time Spent", blackColor, context, 14.0),
                          )),
                      GestureDetector(
                        onTap: (){
                          cont.selectTime(context,"office");
                        },
                        child: Container(
                            height: 40.0,width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: grey),),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child:Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: buildTextRegularWidget(cont.selectedOfficeTime==""?"Time Spent":cont.selectedOfficeTime, blackColor, context, 15.0),
                                )
                            )
                        ),
                      ),
                    ]
                ),
                const TableRow(
                    children: [
                      SizedBox(height: 10.0,),
                      SizedBox(height: 10.0,),
                    ]
                ),
                TableRow(
                    children: [
                      SizedBox(
                          height: 40.0,
                          child:Align(
                            alignment: Alignment.centerLeft,
                            child: buildTextRegularWidget("Claim Amount", blackColor, context, 14.0),
                          )),
                      Container(
                          height: 40.0,width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: grey),),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: buildTextRegularWidget("0", blackColor, context, 14.0),
                            ),
                          )
                      )
                    ]
                ),
              ],
            ),
            const SizedBox(height: 15.0,),
            Center(
                child: buildButtonWidget(context, "Add Claim",height: 35.0,width: 120.0,buttonColor: approveColor)
            ),
            const SizedBox(height: 15.0,),
            buildRichTextWidget("Timesheet filled for * ", "${cont.hrOfficeSum} Hrs and ${cont.minOfficeSum} minutes",title1Color: primaryColor,title2Color: blackColor,),
            const SizedBox(height: 10.0,),
            buildRichTextWidget("Difference hours * ", "1 Hrs",title1Color: primaryColor,title2Color: blackColor,),
            const SizedBox(height: 10.0,),
          ],
        ),
      )

          : cont.currentService == "allotted"
              ? Padding(
      padding: const EdgeInsets.only(left:5.0,right:5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: (){
                    cont.goToPreviousFromAllotted();
                    //cont.cancel();
                  },
                  child:SizedBox(
                      width: 80.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTextBoldWidget("Previous", primaryColor, context, 15.0),
                          const Divider(thickness: 2.0,color: primaryColor,),
                        ],
                      )
                  )
              ),
              GestureDetector(
                onTap: (){
                },
                child: SizedBox(
                    width: 40.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        buildTextBoldWidget("Skip", primaryColor, context, 15.0),
                        const Divider(thickness: 2.0,color: primaryColor,),
                      ],
                    )
                ),
              ),
              GestureDetector(
                onTap: (){
                },
                child: SizedBox(
                    width: 40.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        buildTextBoldWidget("Next", primaryColor, context, 15.0),
                        const Divider(thickness: 2.0,color: primaryColor,),
                      ],
                    )
                ),
              )
            ],
          ),
          const SizedBox(height: 10.0,),
          buildTimeSheetTitle(context,"Allotted Services", fontSize:16.0),

          const SizedBox(height: 10.0,),
          MultiSelectDialogField<ClientListData>(
            items: cont.items,
            title: const Text("Employee"),
            selectedColor: primaryColor,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: grey,),
            ),
            //initialValue: cont.allottedTimesheetSelectedEmpList,
            buttonIcon: const Icon(
              Icons.person,
              color: blackColor,size: 20.0,
            ),
            buttonText: buildTextRegularWidget("Select employee", blackColor, context, 15.0),
            onConfirm: (results) {
              cont.onSelectionForMultipleEmployee(results);
            },
            chipDisplay: MultiSelectChipDisplay(
              onTap: (value) {
                cont.onDeleteMultipleEmployee(value);
              },
              icon: const Icon(Icons.clear,color: errorColor,),
            ),
          ),
          const SizedBox(height: 15.0,),
          MultiSelectDialogField<TimesheetServicesListData>(
            items: cont.serviceItems,
            title: const Text("Service"),
            selectedColor: primaryColor,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: grey,),
            ),
            //initialValue: cont.allottedTimesheetSelectedServiceList,
            buttonIcon: const Icon(
              Icons.person,
              color: blackColor,size: 20.0,
            ),
            buttonText: buildTextRegularWidget("Select services", blackColor, context, 15.0),
            onConfirm: (results) {
              cont.onSelectionForMultipleService(results);
            },
            chipDisplay: MultiSelectChipDisplay(
              onTap: (value) {
                print("service value");
                print(value);
                cont.onDeleteMultipleService(value);
              },
              icon: const Icon(Icons.clear,color: errorColor,),
            ),
          ),
          const SizedBox(height: 15.0,),

          buildTextBoldWidget("Also Fill", blackColor, context, 16.0),
          const SizedBox(height: 5.0,),

          Row(
            children: <Widget>[
               Checkbox(value: cont.cbNonAllotted,
                  activeColor: Colors.green,
                  onChanged:(newValue){
                 cont.updateNonAllottedCheckBox(newValue!);
                  }),
              buildTextRegularWidget("Non Allotted Services", blackColor, context, 14.0)
            ],
          ),
          Row(
            children: <Widget>[
              Checkbox(value: cont.cbOffice,
                  activeColor: Colors.green,
                  onChanged:(newValue){
                    cont.updateOfficeCheckBox(newValue!);
                  }),
              buildTextRegularWidget("Office Related", blackColor, context, 14.0)
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top:30.0),
            child:GestureDetector(
                onTap: (){
                  cont.fillTimesheet();
                },
                child:buildButtonWidget(context, "Fill Timesheet")
            ),
          ),

          cont.isFillTimesheetSelected ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10.0,),


              ListView.builder(
                  shrinkWrap: true,
                  itemCount: cont.timesheetTaskListData.length,
                  itemBuilder: (context,taskListIndex){
                return  Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),
                      side: const BorderSide(color: primaryColor)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                          child: buildRichTextWidget("${cont.timesheetTaskListData[taskListIndex].clientName} -> ",
                            "${cont.timesheetTaskListData[taskListIndex].serviceName}",
                            title1Color: primaryColor,title2Color: blackColor,),
                        ),
                        const SizedBox(height: 10.0,),

                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: cont.timesheetTaskListData[taskListIndex].timesheetTaskDetailsData!.length,
                            itemBuilder: (context,taskDetailsIndex){
                              return ExpansionTile(
                                          expandedAlignment:Alignment.topLeft,
                                          title: buildTextBoldWidget(cont.timesheetTaskListData[taskListIndex].timesheetTaskDetailsData![taskDetailsIndex].taskName!,
                                          blackColor, context, 15.0,align: TextAlign.left),
                                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                          childrenPadding: const EdgeInsets.only(left:20.0),
                                          children: [

                                            Table(
                                              children: [
                                                TableRow(
                                                    children: [
                                                      SizedBox(
                                                        height: 40.0,
                                                        child:Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: buildTextRegularWidget("Details", blackColor, context, 14.0),
                                                        )
                                                      ),
                                                      cont.detailsControllerList.isEmpty ? const Opacity(opacity: 0.0) :
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 15.0),
                                                        child: Container(
                                                          height: 40.0,
                                                          decoration: BoxDecoration(
                                                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                            border: Border.all(color: grey),),
                                                          child: TextFormField(
                                                            controller: cont.detailsControllerList[taskDetailsIndex],
                                                            keyboardType: TextInputType.text,
                                                            textAlign: TextAlign.left,
                                                            textAlignVertical: TextAlignVertical.center,
                                                            textInputAction: TextInputAction.done,
                                                            onTap: () {
                                                            },
                                                            enabled: true,
                                                            style:const TextStyle(fontSize: 15.0),
                                                            decoration: InputDecoration(
                                                              contentPadding: const EdgeInsets.all(10),
                                                              hintText: "Details",
                                                              hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                                                color: blackColor, fontSize: 15,),),
                                                              border: InputBorder.none,
                                                            ),
                                                            onChanged: (value) {
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ]
                                                ),
                                                const TableRow(
                                                    children: [
                                                      SizedBox(height: 10.0,),
                                                      SizedBox(height: 10.0,),
                                                    ]
                                                ),
                                                TableRow(
                                                    children: [
                                                      SizedBox(
                                                          height: 40.0,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: buildTextRegularWidget("Time Spent", blackColor, context, 14.0),
                                                          )
                                                      ),
                                                      GestureDetector(
                                                        onTap: (){
                                                          cont.selectTimeForTask(context,taskDetailsIndex);
                                                        },
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(right: 15.0),
                                                          child: Container(
                                                              height: 40.0,width: MediaQuery.of(context).size.width,
                                                              decoration: BoxDecoration(
                                                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                                border: Border.all(color: grey),),
                                                              child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child:Padding(
                                                                    padding: const EdgeInsets.only(left: 10.0),
                                                                    child: buildTextRegularWidget(cont.timeSpentList[taskDetailsIndex], blackColor, context, 15.0),
                                                                  )
                                                              )
                                                          ),
                                                        ),
                                                      ),
                                                    ]
                                                ),
                                                const TableRow(
                                                    children: [
                                                      SizedBox(height: 10.0,),
                                                      SizedBox(height: 10.0,),
                                                    ]
                                                ),
                                                TableRow(
                                                    children: [
                                                      SizedBox(
                                                          height: 40.0,
                                                          child:Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: buildTextRegularWidget("Claim Amount", blackColor, context, 14.0),
                                                          )
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 15.0),
                                                        child: Container(
                                                          height: 40.0,width: MediaQuery.of(context).size.width,
                                                          decoration: BoxDecoration(
                                                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                            border: Border.all(color: grey),),
                                                          child: Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 10.0),
                                                              child: buildTextRegularWidget("0", blackColor, context, 14.0),
                                                            ),
                                                          )
                                                        ),
                                                      )
                                                    ]
                                                ),
                                              ],
                                            ),

                                          const SizedBox(height: 10.0,),
                                          Center(
                                            child: buildButtonWidget(context, "Add Claim",height: 35.0,width: 120.0,buttonColor: approveColor)
                                          ),
                                        const SizedBox(height: 10.0,),
                              ],
                              );
                        }),

                        const SizedBox(height: 10.0,),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 10.0,),
              buildRichTextWidget("Timesheet filled for * ", "${cont.hrSum} Hrs and ${cont.minSum} minutes",title1Color: primaryColor,title2Color: blackColor,),
              const SizedBox(height: 10.0,),
              buildRichTextWidget("Difference hours * ", "1 Hrs",title1Color: primaryColor,title2Color: blackColor,),
              const SizedBox(height: 10.0,),
            ],
          )
              : const Opacity(opacity: 0.0)
        ],
      ),
    )
              : Padding(
        padding: const EdgeInsets.only(left:5.0,right:5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      cont.goToPreviousFromNonAllotted();
                      //cont.cancel();
                    },
                    child:SizedBox(
                        width: 80.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildTextBoldWidget("Previous", primaryColor, context, 15.0),
                            const Divider(thickness: 2.0,color: primaryColor,),
                          ],
                        )
                    )
                ),
                GestureDetector(
                  onTap: (){
                  },
                  child: SizedBox(
                      width: 40.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          buildTextBoldWidget("Skip", primaryColor, context, 15.0),
                          const Divider(thickness: 2.0,color: primaryColor,),
                        ],
                      )
                  ),
                ),
                GestureDetector(
                  onTap: (){
                  },
                  child: SizedBox(
                      width: 40.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          buildTextBoldWidget("Next", primaryColor, context, 15.0),
                          const Divider(thickness: 2.0,color: primaryColor,),
                        ],
                      )
                  ),
                )
              ],
            ),
            const SizedBox(height: 10.0,),
            buildTimeSheetTitle(context,"Non Allotted Services", fontSize:16.0),
            const SizedBox(height: 10.0,),
            Container(
                height: 40.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: grey),),
                child:
                Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                      child: DropdownButton(
                        itemHeight: 70.0,
                        hint: buildTextRegularWidget(
                            cont.nonAllottedSelectedClientName==""?"Select Client Name":cont.nonAllottedSelectedClientName,
                            blackColor, context, 15.0,align: TextAlign.left),
                        isExpanded: true,
                        underline: Container(),
                        items:
                        cont.allottedEmployeeList.map((ClientListData value) {
                          return DropdownMenuItem<String>(
                            value: value.firmClientFirmName,
                            child: Text(value.firmClientFirmName!),
                            onTap: (){
                              cont.addNonAllottedClientNameAndId(value.firmClientId!,value.firmClientFirmName!);
                            },
                          );
                        }).toList(),
                        onChanged: (val) {
                          cont.onNonAllottedClientName(val!);
                        },
                      ),
                    )
                )
            ),
            const SizedBox(height: 10.0,),
            Container(
                height: 40.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: grey),),
                child:
                Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                      child: DropdownButton(
                        itemHeight: 70.0,
                        hint: buildTextRegularWidget(
                            cont.nonAllottedSelectedServiceName==""?"Select Service":cont.nonAllottedSelectedServiceName,
                            blackColor, context, 15.0,align: TextAlign.left),
                        isExpanded: true,
                        underline: Container(),
                        items:
                        cont.allottedServiceList.map((TimesheetServicesListData value) {
                          return DropdownMenuItem<String>(
                            value: value.serviceName,
                            child: Text(value.serviceName!),
                            onTap: (){
                              cont.addNonAllottedServiceNameAndId(value.serviceId!,value.serviceName!,value.selectedClientId!);
                            },
                          );
                        }).toList(),
                        onChanged: (val) {
                          cont.onNonAllottedServiceName(val!);
                        },
                      ),
                    )
                )
            ),
            const SizedBox(height: 10.0,),
            Container(
                height: 40.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: grey),),
                child:
                Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                      child: DropdownButton(
                        itemHeight: 70.0,
                        hint: buildTextRegularWidget(
                           cont.nonAllottedSelectedTaskName == ""? "Select Task" : cont.nonAllottedSelectedTaskName,
                            blackColor, context, 15.0,align: TextAlign.left),
                        isExpanded: true,
                        underline: Container(),
                        items:
                        cont.nonAllottedTaskList.map((TimesheetTaskDetailsData value) {
                          return DropdownMenuItem<String>(
                            value: value.taskName,
                            child: Text(value.taskName!),
                            onTap: (){
                              cont.addNonAllottedTaskNameAndId(value.taskId!,value.taskName!);
                            },
                          );
                        }).toList(),
                        onChanged: (val) {
                          cont.onNonAllottedTaskName(val!);
                        },
                      ),
                    )
                )
            ),
            const SizedBox(height: 10.0,),
            Table(
              children: [
                TableRow(
                    children: [
                      SizedBox(
                          height: 40.0,
                          child:Align(
                            alignment: Alignment.centerLeft,
                            child: buildTextRegularWidget("Details", blackColor, context, 14.0),
                          )),
                      Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: grey),),
                        child: TextFormField(
                          controller: cont.nonAllottedDetailsController,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.center,
                          textInputAction: TextInputAction.done,
                          onTap: () {
                          },
                          enabled: true,
                          style:const TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "Details",
                            hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                              color: blackColor, fontSize: 15,),),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                          },
                        ),
                      ),
                    ]
                ),
                const TableRow(
                    children: [
                      SizedBox(height: 10.0,),
                      SizedBox(height: 10.0,),
                    ]
                ),
                TableRow(
                    children: [
                      SizedBox(
                          height: 40.0,
                          child:Align(
                            alignment: Alignment.centerLeft,
                            child: buildTextRegularWidget("Time Spent", blackColor, context, 14.0),
                          )),
                      GestureDetector(
                        onTap: (){
                          cont.selectTime(context,"nonAllotted");
                        },
                        child: Container(
                            height: 40.0,width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: grey),),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child:Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: buildTextRegularWidget(cont.selectedNonAllottedTime==""?"Time Spent":cont.selectedNonAllottedTime, blackColor, context, 15.0),
                                )
                            )
                        ),
                      ),
                    ]
                ),
                const TableRow(
                    children: [
                      SizedBox(height: 10.0,),
                      SizedBox(height: 10.0,),
                    ]
                ),
                TableRow(
                    children: [
                      SizedBox(
                          height: 40.0,
                          child:Align(
                            alignment: Alignment.centerLeft,
                            child: buildTextRegularWidget("Claim Amount", blackColor, context, 14.0),
                          )),
                      Container(
                          height: 40.0,width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: grey),),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: buildTextRegularWidget("0", blackColor, context, 14.0),
                            ),
                          )
                      )
                    ]
                ),
              ],
            ),
            const SizedBox(height: 10.0,),
            Center(
                child: buildButtonWidget(context, "Add Claim",height: 35.0,width: 120.0,buttonColor: approveColor)
            ),
            const SizedBox(height: 10.0,),
            buildRichTextWidget("Timesheet filled for * ", "${cont.hrNonAllottedSum} Hrs and ${cont.minNonAllottedSum}",title1Color: primaryColor,title2Color: blackColor,),
            const SizedBox(height: 10.0,),
            buildRichTextWidget("Difference hours * ", "1 Hrs",title1Color: primaryColor,title2Color: blackColor,),
            const SizedBox(height: 10.0,),
          ],
        ),
      ) ;
  }

  buildStepperThree(TimesheetNewFormController cont) {
    return Padding(
      padding: const EdgeInsets.only(left:10.0,right:10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
              onTap: (){
                cont.goToPreviousFromStepper3();
              },
              child:SizedBox(
                  width: 80.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTextBoldWidget("Previous", primaryColor, context, 15.0),
                      const Divider(thickness: 2.0,color: primaryColor,),
                    ],
                  )
              )
          ),
          const SizedBox(height: 30.0,),
          buildRichTextWidget("Timesheet filled for: " , "${cont.hrSum + cont.hrNonAllottedSum + cont.hrOfficeSum} Hrs and "
              "${cont.minSum + cont.minNonAllottedSum + cont.minOfficeSum} minutes",
            title1Color: primaryColor,title2Color: blackColor,),
          const Divider(),
          const SizedBox(height: 10.0,),
          buildTextRegularWidget("Total difference between in Time and out Time", blackColor, context, 15.0),
          const Divider(),
          const SizedBox(height: 10.0,),
          buildRichTextWidget("Time: ", "1 Hrs",title1Color: primaryColor,title2Color: blackColor,),
          const SizedBox(height: 10.0,),
          buildRichTextWidget("Difference hours: ", "1 Hrs",title1Color: primaryColor,title2Color: blackColor,),
          const SizedBox(height: 10.0,),
          buildRichTextWidget("Note: ", "1 Hrs",title1Color: primaryColor,title2Color: blackColor,),
          const SizedBox(height: 10.0,),
          const Divider(),
          const SizedBox(height: 20.0,),

          buildButtonWidget(context, "Save",buttonColor: editColor,width: 100.0),
          const SizedBox(height: 10.0,),
          buildButtonWidget(context, "Submit for Approval",buttonColor: editColor,width: 250.0),
        ],
      ),
    );
  }

}
