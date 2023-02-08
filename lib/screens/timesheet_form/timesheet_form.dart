import 'package:biznew/common_widget/error_text.dart';
import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/screens/timesheet_form/timesheet_controller.dart';
import 'package:biznew/screens/timesheet_form/timesheet_model.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TimesheetForm extends StatefulWidget {
  const TimesheetForm({Key? key}) : super(key: key);

  @override
  State<TimesheetForm> createState() => _TimesheetFormState();
}

class _TimesheetFormState extends State<TimesheetForm> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TimesheetFormController>(builder: (cont)
    {
      return
        WillPopScope(
          onWillPop: () async{
            return cont.onWillPopBackTimesheetList();
          },
          child: Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            centerTitle: true,elevation: 0.0,
            title: buildTextMediumWidget("Timesheet", whiteColor,context, 16,align: TextAlign.center),
          ),
          drawer: Drawer(
            child: SizedBox(
                height: double.infinity,
                child: ListView(
                  children: [
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildDrawer(context,cont.name),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0,left: 10.0,bottom: 30.0,right: 10.0),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    showWarningOnTimesheetFormDialog(context,"Confirm Logout...!!!","Do you want to logout from an app?",logoutFeature:true,cont);
                                  },
                                  child: const Icon(Icons.logout),
                                ),
                                const SizedBox(width: 7.0,),
                                GestureDetector(
                                    onTap:(){
                                      showWarningOnTimesheetFormDialog(context,"Confirm Logout...!!!","Do you want to logout from an app?",logoutFeature:true,cont);
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
                  ],
                )
            ),
          ),
          body:
          cont.loader == true ? Center(child: buildCircularIndicator(),) :
          Stack(
            children: [
              Container(
                color:primaryColor,
                height: MediaQuery.of(context).size.height * 0.128,width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: CircleAvatar(
                      radius: 40.0,
                      backgroundColor: whiteColor,
                      child:Center(child:Icon(Icons.timer,color: primaryColor,size: 50.0,))
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14,),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(25.0), topLeft: Radius.circular(25.0),),
                      color: whiteColor,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child:Column(
                      children: [
                        Expanded(
                          child: Stepper(
                            type: cont.stepperType,
                            physics: const AlwaysScrollableScrollPhysics(),
                            currentStep: cont.currentStep,
                            controlsBuilder: (context,details){
                              return
                                cont.currentStep==1
                                    ? Padding(
                                  padding: const EdgeInsets.only(top:30.0),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                          onTap: (){
                                            cont.checkStepperValidation("save&add");
                                            },
                                          child:buildButtonWidget(context, "Save & Add More")
                                      ),
                                      const SizedBox(height: 10.0,),
                                      GestureDetector(
                                          onTap: (){
                                            cont.checkStepperValidation("save&goToNonAllotted");
                                            },
                                          child:buildButtonWidget(context,
                                              cont.currentService == "office"
                                                  ? "Save & Go to Non Allotted Services"
                                                  : "Save & Go to Office related services")
                                      ),
                                    ],
                                  ),
                                )
                                    : cont.currentStep==2
                                      ? Padding(
                                  padding: const EdgeInsets.only(top:30.0),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                          onTap: (){
                                            cont.checkStepperValidation("save");
                                          },
                                          child:buildButtonWidget(context, "Save")
                                      ),
                                      const SizedBox(height: 10.0,),
                                      GestureDetector(
                                          onTap: (){
                                            cont.checkStepperValidation("approve");
                                          },
                                          child:buildButtonWidget(context, "Submit For Approval")
                                      ),
                                    ],
                                  ),
                                )
                                      : Padding(
                                padding: const EdgeInsets.only(top:30.0,left: 130.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: GestureDetector(
                                          onTap: (){cont.checkStepperValidation("continue");},
                                          child:buildButtonWidget(context, "Continue")
                                      ),
                                    ),
                                    const SizedBox(width: 10.0,),
                                    Flexible(
                                    child: GestureDetector(
                                        onTap: (){cont.cancel();},
                                        child:buildButtonWidget(context, "Cancel")
                                    ))
                                  ],
                                )
                              );
                            },
                            onStepTapped: (step) => cont.tapped(step),
                            onStepContinue:  (){
                              //cont.continued;
                              cont.checkStepperValidation("continue");
                            },
                            onStepCancel: cont.cancel,
                            steps: <Step>[
                              ///stepper 1
                              Step(
                                title:Container(),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
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
                                        ? ErrorText(errorMessage: "Please select start time",)
                                        : const Opacity(opacity: 0.0),

                                    ///work at
                                    buildTimeSheetTitle(context,"Work At"),
                                    Container(
                                        height: 40.0,width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                                          border: Border.all(color: cont.validateWorkAt?errorColor:grey),),
                                        child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                              child: DropdownButton<String>(
                                                hint: buildTextRegularWidget(cont.selectedWorkAt==""?"Select work at":cont.selectedWorkAt,
                                                    cont.selectedWorkAt==""?grey:blackColor, context, 15.0),
                                                isExpanded: true,
                                                underline: Container(),
                                                iconEnabledColor: cont.selectedWorkAt==""?grey:blackColor,
                                                items:
                                                cont.workAtList.isEmpty
                                                    ?
                                                cont.noDataList.map((value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList()
                                                   :
                                                cont.workAtList.map((value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                    onTap: (){
                                                      //cont.updateSelectedWorkAt(value);
                                                    },
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  cont.updateSelectedWorkAt(val!);
                                                },
                                              ),
                                            )
                                        )
                                    ),
                                    cont.validateWorkAt== true
                                        ? ErrorText(errorMessage: "Please select work at",)
                                        : const Opacity(opacity: 0.0),

                                    ///start time
                                    buildTimeSheetTitle(context,"In Time"),
                                    Container(
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                                          border: Border.all(color: cont.validateInTime?errorColor:grey),),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 10.0,),
                                            GestureDetector(
                                              onTap: (){cont.selectTime(context,"start");},
                                              child: Icon(Icons.watch_later_outlined,color: cont.stepper1InTime.text.isEmpty?grey:blackColor,),
                                            ),
                                            const SizedBox(width: 10.0,),
                                            // buildTextRegularWidget(cont.selectedStartTimeToShow==""?"In Time (HH:MM)":cont.selectedStartTimeToShow,
                                            //     cont.selectedStartTimeToShow==""?grey:blackColor, context, 15.0)
                                            Flexible(
                                              child: TextFormField(
                                                controller: cont.stepper1InTime,
                                                keyboardType: TextInputType.number,
                                                textAlign: TextAlign.left,
                                                textAlignVertical: TextAlignVertical.center,
                                                textInputAction: TextInputAction.done,
                                                onTap: () {
                                                },
                                                style:const TextStyle(fontSize: 15.0),
                                                decoration: InputDecoration(
                                                  hintText: "In Time (HH:MM)",
                                                  hintStyle: GoogleFonts.rubik(textStyle: TextStyle(
                                                    color: cont.stepper1InTime.text.isEmpty?grey:blackColor, fontSize: 15,),),
                                                  border: InputBorder.none,
                                                ),
                                                inputFormatters: [LengthLimitingTextInputFormatter(5),],
                                                onChanged: (value) {
                                                  if(value.isEmpty){}
                                                  else if (value.isNotEmpty){
                                                    cont.validateInTime=false;
                                                    if(value.length >= 2 && !value.contains(":")) {
                                                      value = '$value:';
                                                      cont.stepper1InTime.value = TextEditingValue(text:
                                                      value,selection: TextSelection.collapsed(offset: value.length),);
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                    const SizedBox(height: 10,),
                                    buildTextRegularWidget("(24 hours format)", blackColor, context, 14.0),
                                    cont.validateInTime== true
                                        ? ErrorText(errorMessage: "Please select in time",)
                                        : const Opacity(opacity: 0.0),

                                    ///end time
                                    buildTimeSheetTitle(context,"Out Time"),
                                    Container(
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                                          border: Border.all(color: cont.validateOutTime?errorColor:grey),),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 10.0,),
                                            GestureDetector(
                                              onTap: (){cont.selectTime(context,"end");},
                                              child: Icon(Icons.watch_later_outlined,color: cont.stepper1OutTime.text.isEmpty?grey:blackColor,),
                                            ),
                                            const SizedBox(width: 10.0,),
                                            // buildTextRegularWidget(cont.selectedEndTimeToShow==""?"Out Time (HH:MM)":cont.selectedEndTimeToShow,
                                            //     cont.selectedEndTimeToShow==""?grey:blackColor, context, 15.0)
                                            Flexible(
                                              child: TextFormField(
                                                controller: cont.stepper1OutTime,
                                                keyboardType: TextInputType.number,
                                                textAlign: TextAlign.left,
                                                textAlignVertical: TextAlignVertical.center,
                                                textInputAction: TextInputAction.done,
                                                onTap: () {
                                                },
                                                style:const TextStyle(fontSize: 15.0),
                                                decoration: InputDecoration(
                                                  hintText: "Out Time (HH:MM)",
                                                  hintStyle: GoogleFonts.rubik(textStyle: TextStyle(
                                                    color: cont.stepper1OutTime.text.isEmpty?grey:blackColor, fontSize: 15,),),
                                                  border: InputBorder.none,
                                                ),
                                                inputFormatters: [LengthLimitingTextInputFormatter(5),],
                                                onChanged: (value) {
                                                  if(value.isEmpty){}
                                                  else if(value.isNotEmpty){
                                                    cont.validateOutTime = false;
                                                    if(value.length >= 2 && !value.contains(":")) {
                                                      value = '$value:';
                                                      cont.stepper1OutTime.value = TextEditingValue(text:
                                                      value,selection: TextSelection.collapsed(offset: value.length),);
                                                    }
                                                    cont.calculateTotalTime();
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                    const SizedBox(height: 10,),
                                    buildTextRegularWidget("(24 hours format)", blackColor, context, 14.0),
                                    cont.validateOutTime== true
                                        ? ErrorText(errorMessage: "Please select out time",)
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
                                isActive: cont.currentStep >= 0,
                                state: cont.currentStep >= 0 ? StepState.complete : StepState.disabled,
                              ),
                              ///stepper 2
                              Step(
                                title:Container(),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            cont.cancel();
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
                                            cont.checkStepperValidation("next");
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
                                    buildTimeSheetTitle(context,"Allotted Services",fontSize:16.0),
                                    ///client
                                    buildTimeSheetTitle(context,"Client"),
                                    Container(
                                        height: 40.0,width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                                          border: Border.all(color: cont.validateClientName?errorColor:grey),),
                                        child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                              child: DropdownButton<String>(
                                                hint: buildTextRegularWidget(cont.selectedClient==""?"Select Client":cont.selectedClient,
                                                    cont.selectedClient==""?grey:blackColor, context, 15.0),
                                                isExpanded: true,
                                                underline: Container(),
                                                iconEnabledColor: cont.selectedClient==""?grey:blackColor,
                                                items:
                                                cont.clientNameList.isEmpty
                                                    ?
                                                cont.noDataList.map((value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList()
                                                  :
                                                cont.clientNameList.map((ClientListData value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value.firmClientFirmName,
                                                    child: Text(value.firmClientFirmName!),
                                                    onTap: (){
                                                      cont.updateSelectedClientId(value.firmClientId!);
                                                    },
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  cont.checkClientNameValidation(val!);
                                                },
                                              ),
                                            )
                                        )
                                    ),
                                    cont.validateClientName== true
                                        ? ErrorText(errorMessage: "Please select client",)
                                        : const Opacity(opacity: 0.0),

                                    ///service
                                    buildTimeSheetTitle(context,"Service"),
                                    Container(
                                        height: 40.0,width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                                          border: Border.all(color: cont.validateServiceName?errorColor:grey),),
                                        child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                              child: DropdownButton<String>(
                                                hint: buildTextRegularWidget(cont.selectedService==""?"Select Service":cont.selectedService,
                                                    cont.selectedService==""?grey:blackColor, context, 15.0),
                                                isExpanded: true,
                                                underline: Container(),
                                                iconEnabledColor: cont.selectedService==""?grey:blackColor,
                                                items:
                                                cont.serviceList.isEmpty
                                                    ?
                                                cont.noDataList.map((value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList()
                                                  :
                                                cont.serviceList.map((TimesheetServicesData value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value.serviceName,
                                                    child: Text(value.serviceName!),
                                                    onTap: (){
                                                      cont.updateSelectedServiceId(value.serviceId!,value.id!);
                                                    },
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  cont.checkServiceValidation(val!);
                                                },
                                              ),
                                            )
                                        )
                                    ),
                                    cont.validateServiceName== true
                                        ? ErrorText(errorMessage: "Please select service",)
                                        : const Opacity(opacity: 0.0),

                                    ///task
                                    buildTimeSheetTitle(context,"Task"),
                                    Container(
                                        height: 40.0,width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                                          border: Border.all(color: cont.validateTaskName?errorColor:grey),),
                                        child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                              child: DropdownButton<String>(
                                                hint: buildTextRegularWidget(cont.selectedTask==""?"Select task":cont.selectedTask,
                                                    cont.selectedTask==""?grey:blackColor, context, 15.0),
                                                isExpanded: true,
                                                underline: Container(),
                                                iconEnabledColor: cont.selectedTask==""?grey:blackColor,
                                                items:
                                                cont.taskList.isEmpty
                                                    ?
                                                cont.noDataList.map((value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList()
                                                  :
                                                cont.taskList.map((TimesheetTaskData value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value.taskName,
                                                    child: Text(value.taskName!),
                                                    onTap: (){
                                                      cont.updateSelectedTaskId(value.taskId!);
                                                    },
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  // cont.updateSelectedWorkAt(val!,context);
                                                  cont.checkTaskValidation(val!);
                                                },
                                              ),
                                            )
                                        )
                                    ),
                                    cont.validateTaskName== true
                                        ? ErrorText(errorMessage: "Please enter task",)
                                        : const Opacity(opacity: 0.0),

                                    ///status
                                    cont.selectedTask == "" ? const Opacity(opacity: 0.0,):
                                    buildTimeSheetTitle(context,"Status"),
                                    cont.selectedTask == "" ? const Opacity(opacity: 0.0,):
                                    Container(
                                        height: 40.0,width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                                          border: Border.all(color: cont.validateTaskName?errorColor:grey),),
                                        child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                              child: DropdownButton<String>(
                                                hint: buildTextRegularWidget(cont.selectedStatus==""?"Select status":cont.selectedStatus,
                                                    cont.selectedStatus==""?grey:blackColor, context, 15.0),
                                                isExpanded: true,
                                                underline: Container(),
                                                iconEnabledColor: cont.selectedStatus==""?grey:blackColor,
                                                items:
                                                cont.statusList.isEmpty
                                                    ?
                                                cont.noDataList.map((value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList()
                                                    :
                                                cont.statusList.map((StatusList value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value.name,
                                                    child: Text(value.name!),
                                                    onTap: (){
                                                      cont.updateSelectedStatusId(value.id!);
                                                    },
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  //cont.checkStatusValidation(val!,context);
                                                      cont.statusStart == "0" ||
                                                      val=="Awaiting for Client Input" ||
                                                      val=="Submitted for Checking" ||
                                                      val=="Put on Hold"
                                                   //? cont.showStartTaskModal(context,val!)
                                                   ? openDialog(context,cont,val!)
                                                   : cont.checkStatusValidation(val!,context);
                                                },
                                              ),
                                            )
                                        )
                                    ),
                                    cont.validateStatusName== true
                                        ? ErrorText(errorMessage: "Please enter task",)
                                        : const Opacity(opacity: 0.0),

                                    ///details
                                    buildTimeSheetTitle(context,"Details"),
                                    Container(
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                                        border: Border.all(color: cont.validateDetailsStepper2?errorColor:grey),),
                                      child: TextFormField(
                                        controller: cont.details,
                                        keyboardType: TextInputType.text,
                                        textAlign: TextAlign.left,
                                        textAlignVertical: TextAlignVertical.center,
                                        textInputAction: TextInputAction.done,
                                        onTap: () {
                                        },
                                        style:const TextStyle(fontSize: 15.0),
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.all(10),
                                          hintText: "Enter details",
                                          hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                            color: grey, fontSize: 15,),),
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (text) {
                                          cont.checkDetailsValidationStepper2();
                                        },
                                      ),
                                    ),
                                    cont.validateDetailsStepper2== true
                                        ? ErrorText(errorMessage: "Please select details",)
                                        : const Opacity(opacity: 0.0),

                                    ///time spent
                                    buildTimeSheetTitle(context,"Time Spent"),
                                    Container(
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                                          border: Border.all(color: cont.validateTimeSpentStepper2?errorColor:grey),),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 10.0,),
                                            GestureDetector(
                                              onTap: (){cont.selectTime(context,"timeSpent");},
                                              child:Icon(Icons.watch_later_outlined,
                                                color: cont.stepper2TimeSpent.text.isEmpty?grey:blackColor,),
                                            ),
                                            const SizedBox(width: 10.0,),
                                            // buildTextRegularWidget(cont.selectedTimeSpentToShow==""?"HH:MM":cont.selectedTimeSpentToShow,
                                            //     cont.selectedTimeSpentToShow==""?grey:blackColor, context, 15.0)
                                            Flexible(
                                              child: TextFormField(
                                                controller: cont.stepper2TimeSpent,
                                                keyboardType: TextInputType.number,
                                                textAlign: TextAlign.left,
                                                textAlignVertical: TextAlignVertical.center,
                                                textInputAction: TextInputAction.done,
                                                onTap: () {
                                                },
                                                style:const TextStyle(fontSize: 15.0),
                                                decoration: InputDecoration(
                                                  contentPadding: const EdgeInsets.all(10),
                                                  hintText: "HH:MM",
                                                  hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                                    color: grey, fontSize: 15,),),
                                                  border: InputBorder.none,
                                                  // suffixIcon: GestureDetector(
                                                  //   onTap: (){cont.stepper2TimeSpent.clear();},
                                                  //   child:const Icon(Icons.clear)
                                                  // )
                                                ),
                                                inputFormatters: [LengthLimitingTextInputFormatter(5),],
                                                onChanged: (value) {
                                                  if(value.isEmpty){}
                                                  else if (value.isNotEmpty){
                                                    cont.validateTimeSpentStepper2=false;
                                                    if(value.length >= 2 && !value.contains(":")) {
                                                      value = '$value:';
                                                      cont.stepper2TimeSpent.value = TextEditingValue(text:
                                                      value,selection: TextSelection.collapsed(offset: value.length),);
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                    cont.validateTimeSpentStepper2== true
                                        ? ErrorText(errorMessage: "Please select time",)
                                        : const Opacity(opacity: 0.0),

                                    const SizedBox(height: 10.0,),
                                    buildTextBoldWidget("Total Time ${cont.totalTimeToShow}", blackColor, context, 14.0),
                                    const SizedBox(height: 10.0,),
                                    buildTextBoldWidget("Balance Time ${cont.balanceTimeToShow}", blackColor, context, 14.0),
                                    const SizedBox(height: 10.0,),
                                  ],
                                ),
                                isActive: cont.currentStep >= 0,
                                state: cont.currentStep >= 1 ? StepState.complete : StepState.disabled,
                              ),
                              ///stepper 3
                              Step(
                                title:Container(),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    GestureDetector(
                                        onTap: (){
                                          cont.cancel();
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
                                    buildTimeSheetTitle(context,"Office Related",fontSize: 16.0),

                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: cont.workList.length,
                                        itemBuilder: (context,index){
                                          return Column(
                                            children: [
                                              buildTableWidget(context,
                                                  Container(
                                                      height: 40.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                        border: Border.all(color: grey),),
                                                      child: Padding(
                                                          padding: const EdgeInsets.only(right:10.0,left:10.0),
                                                          child:Row(
                                                            children: [
                                                              SizedBox(
                                                                width: MediaQuery.of(context).size.width/3.5,
                                                                child: buildTextRegularWidget(cont.workList[index].name!,
                                                                    cont.selectedTimeSpentToShow==""?grey:blackColor, context, 15.0,align: TextAlign.left),
                                                              ),
                                                              const Spacer(),
                                                              const Icon(Icons.arrow_drop_down,color:grey,),
                                                            ],
                                                          )
                                                      )
                                                  ),
                                                  Container(
                                                  height: 40.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                    border: Border.all(color: grey),),
                                                  child: TextFormField(
                                                    controller: cont.timeStepper3List[index],
                                                    keyboardType: TextInputType.number,
                                                    textAlign: TextAlign.left,
                                                    textAlignVertical: TextAlignVertical.center,
                                                    textInputAction: TextInputAction.done,
                                                    onTap: () {
                                                    },
                                                    style:const TextStyle(fontSize: 15.0),
                                                    decoration: InputDecoration(
                                                      contentPadding: const EdgeInsets.all(10),
                                                      hintText: "HH:MM",
                                                      hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                                        color: grey, fontSize: 15,),),
                                                      border: InputBorder.none,
                                                      suffixIcon: GestureDetector(
                                                        onTap: (){
                                                          cont.selectTimeForStepper3(context,cont.timeStepper3List[index].text,index);
                                                        },
                                                        child:const Icon(Icons.watch_later_outlined,color: grey,)
                                                      )
                                                    ),
                                                    inputFormatters: [LengthLimitingTextInputFormatter(5),],
                                                    onChanged: (value) {
                                                      cont.addTime(index, cont.timeStepper3List[index],value);
                                                    },
                                                  )
                                                ),

                                                // Container(
                                                //   height: 40.0,
                                                //   decoration: BoxDecoration(
                                                //     borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                //     border: Border.all(color: grey),),
                                                //   child: TextFormField(
                                                //     controller: cont.timeStepper3List[index],
                                                //     keyboardType: TextInputType.text,
                                                //     textAlign: TextAlign.left,
                                                //     textAlignVertical: TextAlignVertical.center,
                                                //     textInputAction: TextInputAction.done,
                                                //     onTap: () {
                                                //     },
                                                //     style:const TextStyle(fontSize: 15.0),
                                                //     decoration: InputDecoration(
                                                //       contentPadding: const EdgeInsets.all(10),
                                                //       hintText: "Enter details $index",
                                                //       hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                                //         color: grey, fontSize: 15,),),
                                                //       border: InputBorder.none,
                                                //       suffixIcon: GestureDetector(
                                                //         onTap: (){
                                                //         },
                                                //         child: const Icon(Icons.watch_later_outlined,color: grey),
                                                //       )
                                                //     ),
                                                //     onChanged: (text) {
                                                //       cont.addTime(index,cont.timeStepper3List[index]);
                                                //     },
                                                //   ),
                                                // ),
                                              ),
                                              Container(
                                                height: 40.0,
                                                decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                  border: Border.all(color: grey),),
                                                child: TextFormField(
                                                  controller: cont.detailsStepper3List[index],
                                                  keyboardType: TextInputType.text,
                                                  textAlign: TextAlign.left,
                                                  textAlignVertical: TextAlignVertical.center,
                                                  textInputAction: TextInputAction.done,
                                                  onTap: () {
                                                  },
                                                  style:const TextStyle(fontSize: 15.0),
                                                  decoration: InputDecoration(
                                                    contentPadding: const EdgeInsets.all(10),
                                                    hintText: "Enter details $index",
                                                    hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                                      color: grey, fontSize: 15,),),
                                                    border: InputBorder.none,
                                                  ),
                                                  onChanged: (text) {
                                                    cont.addDetails(index,cont.detailsStepper3List[index]);
                                                  },
                                                ),
                                              ),
                                              buildTimeSheetDivider(),
                                            ],
                                          );
                                    }),
                                    const SizedBox(height: 10.0,),
                                    buildTextBoldWidget("Total Time ${cont.totalTimeToShow}", blackColor, context, 14.0),
                                    const SizedBox(height: 10.0,),
                                    buildTextBoldWidget("Balance Time ${cont.balanceTimeToShow}", blackColor, context, 14.0),
                                    const SizedBox(height: 10.0,),
                                  ],
                                ),
                                isActive:cont.currentStep >= 0,
                                state: cont.currentStep >= 2 ? StepState.complete : StepState.disabled,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              )
            ],
          )
      )
      );
    });
  }

  openDialog(BuildContext context,TimesheetFormController cont,String val){
    cont.selectedStatus = val; cont.validateStatusName=false;
    return showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return StatefulBuilder(
            builder: (BuildContext context,StateSetter state){
            return Align(
              alignment: Alignment.topCenter,
              child: SafeArea(
                child: cont.statusStart == "0"
                  ? Container(
                  height: 150.0,
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
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child:const Align(
                                alignment: Alignment.topRight,
                                child: Icon(Icons.clear),
                              ),
                            ),
                            buildTextBoldWidget("Do you want to start this task?", blackColor, context, 16.0),
                            const SizedBox(height: 20.0,),
                            Row(
                              children: [
                                Flexible(child:GestureDetector(
                                  onTap: (){
                                    cont.callTimesheetStart(context);
                                  },
                                  child: buildButtonWidget(context, "Yes",height: 40.0),
                                )),const SizedBox(width: 10.0,),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: (){Navigator.pop(context);},
                                    child: buildButtonWidget(context, "No",height: 40.0),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                )
                  : Container(
                    height: 250,
                    decoration: const BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0),bottomRight:Radius.circular(15.0),)),
                    child:Scaffold(
                      resizeToAvoidBottomInset: false,
                      backgroundColor: Colors.transparent,
                      body: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child:const Align(
                                alignment: Alignment.topRight,
                                child: Icon(Icons.clear),
                              ),
                            ),
                            buildTextBoldWidget("Remark", blackColor, context, 16.0),
                            const SizedBox(height: 20.0,),
                            Container(
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(color: cont.validateRemarkStepper2?errorColor:grey),),
                              child: TextFormField(
                                controller: cont.remark,
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.left,
                                textAlignVertical: TextAlignVertical.center,
                                textInputAction: TextInputAction.done,
                                onTap: () {
                                },
                                style:const TextStyle(fontSize: 15.0),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  hintText: "Enter Remark",
                                  hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                    color: grey, fontSize: 15,),),
                                  border: InputBorder.none,
                                ),
                                onChanged: (text) {
                                  cont.checkRemarkValidationStepper2();
                                },
                              ),
                            ),
                            cont.validateRemarkStepper2== true
                                ? ErrorText(errorMessage: "Please enter remark",)
                                : const Opacity(opacity: 0.0),
                            const SizedBox(height: 20.0,),
                            Row(
                              children: [
                                Flexible(child:GestureDetector(
                                  onTap: (){
                                    cont.callTimesheetUpdate(context);
                                  },
                                  child: buildButtonWidget(context, "Add",height: 40.0),
                                )),const SizedBox(width: 10.0,),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: (){Navigator.pop(context);},
                                    child: buildButtonWidget(context, "Cancel",height: 40.0),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    )
                ),
              ),
            );
        }
        );},
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim1),
          child: child,
        );},
    );
  }

  showRemarkDialog(TimesheetFormController cont){
    return showDialog(barrierDismissible: true,
      context:context,
      builder:(BuildContext context){
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: Container(
            height: 301.0,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0,),
                buildTextRegularWidget("Remark", blackColor, context, 20,align: TextAlign.left),
                const SizedBox(height: 10.0,),
                const Divider(color: primaryColor,),
                const SizedBox(height: 10.0,),
                buildTextRegularWidget("Add remark", blackColor, context, 16.0,align: TextAlign.left,),
                const SizedBox(height: 20.0,),
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: grey),),
                  child: TextFormField(
                    controller: cont.remark,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.sentences,
                    onTap: () {
                    },
                    style:const TextStyle(fontSize: 15.0),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Remark",
                      hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                        color: blackColor, fontSize: 15,),),
                      border: InputBorder.none,
                    ),
                    onChanged: (text) {
                      cont.checkRemarkValidationStepper2();
                    },
                  ),
                ),
                const SizedBox(height: 20.0,),
                Row(
                  children: [
                    Flexible(child: GestureDetector(
                      onTap: (){
                      },
                      child: buildButtonWidget(context, "Save",buttonColor:approveColor),
                    )),
                    const SizedBox(width:5.0),
                    Flexible(child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: buildButtonWidget(context, "Close",buttonColor: errorColor,),
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}