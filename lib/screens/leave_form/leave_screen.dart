import 'package:biznew/common_widget/error_text.dart';
import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/screens/leave_form/leave_controller.dart';
import 'package:biznew/screens/leave_form/leave_model.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaveForm extends StatefulWidget {
  const LeaveForm({Key? key}) : super(key: key);

  @override
  State<LeaveForm> createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  String screenFor = Get.arguments[0];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeaveController>(builder: (cont)
    {
    return WillPopScope(
        onWillPop: () async{
      return cont.onBackPressToLeaveList();
    },
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          centerTitle: true,elevation: 0.0,
          title: buildTextMediumWidget("Leave Form", whiteColor,context, 16,align: TextAlign.center),
        ),
        drawer: Drawer(
            child: SizedBox(
                height: double.infinity,
                child: ListView(
                  physics:const NeverScrollableScrollPhysics(),
                  children: [
                    Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height/1.1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildDrawer(context,cont.name),const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0,left: 10.0,bottom: 50.0,right: 10.0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      showWarningOnLeaveDialog(context,"Confirm Logout...!!!","Do you want to logout from an app?",logoutFeature:true,cont);
                                    },
                                    child: const Icon(Icons.logout),
                                  ),
                                  const SizedBox(width: 7.0,),
                                  GestureDetector(
                                      onTap:(){
                                        showWarningOnLeaveDialog(context,"Confirm Logout...!!!","Do you want to logout from an app?",logoutFeature:true,cont);
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
        body:cont.loader == true ? Center(child: buildCircularIndicator(),) :
        Stack(
          children: [
            Container(
              color:primaryColor,
              height: MediaQuery.of(context).size.height * 0.128,width: MediaQuery.of(context).size.width,
              child: const Center(
                child: CircleAvatar(
                    radius: 40.0,
                    backgroundColor: whiteColor,
                    child:Center(child:Icon(Icons.calendar_today,color: primaryColor,size: 50.0,))
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
                  padding: const EdgeInsets.all(20.0),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left:10.0,right:10.0),
                    child: ListView(
                      children: [
                        screenFor=="add" ? const Opacity(opacity: 0.0) :
                        buildTextBoldWidget(cont.firmEmployeeName, blackColor, context, 16.0),
                        screenFor=="add" ? const Opacity(opacity: 0.0) :
                        const Divider(color: primaryColor,),
                        screenFor=="add" ? const Opacity(opacity: 0.0) :
                        const SizedBox(height: 10.0,),
                        ///leave type
                        screenFor=="add" ? const SizedBox(height: 15,) :
                        const SizedBox(height: 5,),
                        Container(
                            height: 40.0,width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: cont.validateLeaveType?errorColor:grey),),
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                  child: DropdownButton(
                                    hint: buildTextRegularWidget(cont.selectedLeaveType==""?"Select leave type":cont.selectedLeaveType, blackColor, context, 15.0),
                                    isExpanded: true,
                                    underline: Container(),
                                    items:
                                    cont.leaveTypeList.isEmpty
                                        ? cont.noDataList.map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList()
                                        : cont.leaveTypeList.map((LeaveTypeList leaveType) {
                                      return DropdownMenuItem<String>(
                                        value: leaveType.leaveType,
                                        child: Text(leaveType.leaveType!),
                                        onTap: (){
                                          cont.updateSelectedLeaveTypeId(leaveType.id!,leaveType.leaveType!);
                                        },
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      cont.updateSelectedLeave(val!,context);
                                    },
                                  ),
                                )
                            )
                        ),
                        cont.validateLeaveType == true
                            ? ErrorText(errorMessage: "Please select leave type",)
                            : const Opacity(opacity: 0.0),

                        ///start date
                        const SizedBox(height: 15,),
                        GestureDetector(
                          onTap: (){cont.selectDate(context,"start");},
                          child: Container(
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(color:  cont.validateStartDate?errorColor:grey),),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10.0,),const Icon(Icons.calendar_today),const SizedBox(width: 10.0,),
                                  buildTextRegularWidget(cont.selectedStartDateToShow==""?"Select Start Date":cont.selectedStartDateToShow, blackColor, context, 15.0)
                                ],
                              )
                          ),
                        ),
                        cont.validateStartDate == true
                            ? ErrorText(errorMessage: "Please select start date",)
                            : const Opacity(opacity: 0.0),

                        ///end date
                        const SizedBox(height: 15,),
                        GestureDetector(
                          onTap: (){cont.selectDate(context,"end");},
                          child: Container(
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(color: cont.validateEndDate?errorColor:grey),),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10.0,),const Icon(Icons.calendar_today),const SizedBox(width: 10.0,),
                                  buildTextRegularWidget(cont.selectedEndDateToShow==""?"Select End Date":cont.selectedEndDateToShow, blackColor, context, 15.0)
                                ],
                              )
                          ),
                        ),
                        cont.validateEndDate == true
                            ? ErrorText(errorMessage: "Please select end date",)
                            : const Opacity(opacity: 0.0),

                        ///leave reason
                        const SizedBox(height: 15,),
                        Container(
                          decoration: BoxDecoration(
                            color: cont.edit ? whiteColor: grey.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color:cont.validateReason?errorColor: grey),),
                          child: TextFormField(
                            controller: cont.leaveReason,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.left,
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.done,
                            textCapitalization: TextCapitalization.sentences,
                            maxLines: 3,
                            onTap: () {
                            },
                            enabled: cont.edit,
                            style:const TextStyle(fontSize: 15.0),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "Reason",
                              hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                color: blackColor, fontSize: 15,),),
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {
                              cont.checkReasonValidation(context);
                            },
                          ),
                        ),
                        cont.validateReason == true
                            ? ErrorText(errorMessage: "Please select leave reason",)
                            : const Opacity(opacity: 0.0),

                        ///no of leaves
                        const SizedBox(height: 15,),

                        const Divider(color: grey,thickness: 2.0),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Flexible(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:40.0,
                                        child:buildTextBoldWidget("No. of days leave",
                                            blackColor, context, 15.0),
                                      ),
                                      buildTextRegularWidget("${cont.days} days "
                                          "${cont.month==0?"":cont.month}" " ${cont.month==0?"":"month"}"
                                          "${cont.year==0?"":cont.year}" " ${cont.year==0?"":"year"}",
                                          blackColor, context, 15.0),
                                    ],
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                color: grey,
                                thickness: 2,
                              ),
                              Flexible(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 40.0,
                                        child:buildTextBoldWidget("Total leaves in this year",
                                            blackColor, context, 15.0,align: TextAlign.center),
                                      ),
                                      buildTextRegularWidget("${cont.totalDays} days",
                                          blackColor, context, 15.0),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // buildRichTextWidget("No. of days leave  ${cont.days} days "
                        //     "${cont.month==0?"":cont.month}" " ${cont.month==0?"":"month"}"
                        //     "${cont.year==0?"":cont.year}" " ${cont.year==0?"":"year"}",
                        // "Total leaves in this year ${cont.totalDays}"),
                        const Divider(color: grey,thickness: 2.0),
                        const SizedBox(height: 15,),
                        // buildTextRegularWidget("No. of days leave  ${cont.days} days "
                        //     "${cont.month==0?"":cont.month}" " ${cont.month==0?"":"month"}"
                        //     "${cont.year==0?"":cont.year}" " ${cont.year==0?"":"year"}",
                        //     blackColor, context, 15.0),
                        //const SizedBox(height: 15,),

                        ///total leaves
                        // buildTextRegularWidget("Total leaves in this year ${cont.totalDays}", blackColor, context, 15.0),
                        // const SizedBox(height: 15,),
                        // const Divider(color: grey,thickness: 2.0),
                        // const SizedBox(height: 15,),

                        ///leave for 1
                        cont.selectedStartDateToShow == cont.selectedEndDateToShow ?
                        buildTextRegularWidget("Leave For ", blackColor, context, 15.0)
                            :const Opacity(opacity: 0.0),
                        cont.selectedStartDateToShow == cont.selectedEndDateToShow ?
                        // ListView.builder(
                        // shrinkWrap: true,
                        // itemCount: cont.leaveForList.length,
                        // itemBuilder: (context, index) {
                        //   return RadioListTile(
                        //   value: cont.leaveForList[index],
                        //   groupValue: cont.selectedLeave,
                        //   selected: cont.leaveForList[index] == cont.selectedLeaveIndex,
                        //   onChanged: (dynamic v){
                        //     cont.changeSelectedIndex(v,cont.leaveForList[cont.selectedLeaveIndex]);
                        //   },
                        //   title: Align(
                        //     child: buildTextRegularWidget(cont.leaveForList[index], blackColor, context, 15.0),
                        //     alignment: const Alignment(-1,20),
                        //   ),
                        //   contentPadding: EdgeInsets.zero,dense: true,
                        //   );},)

                        SizedBox(
                          width: double.infinity,height: 50.0,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              // Flexible(
                              //   child: RadioListTile(
                              //     title: const Text('Full Day',style: TextStyle(fontSize: 14.0),),
                              //     value: cont.leaveForList[0],
                              //     groupValue: cont.selectedLeave,
                              //     onChanged: (dynamic v) {
                              //       cont.changeSelectedIndex(v,cont.leaveForList[cont.selectedLeaveIndex]);
                              //     },
                              //   ),
                              // ),
                              // Flexible(
                              //   child: RadioListTile(
                              //     title: const Text('First Half',style: TextStyle(fontSize: 14.0),),
                              //     value: cont.leaveForList[1],
                              //     groupValue: cont.selectedLeave,
                              //     onChanged: (dynamic v) {
                              //       cont.changeSelectedIndex(v,cont.leaveForList[cont.selectedLeaveIndex]);
                              //     },
                              //   ),
                              // ),
                              // Flexible(
                              //   child: RadioListTile(
                              //     title: const Text('Second Half',style: TextStyle(fontSize: 14.0),),
                              //     value: cont.leaveForList[2],
                              //     groupValue: cont.selectedLeave,
                              //     onChanged: (dynamic v) {
                              //       cont.changeSelectedIndex(v,cont.leaveForList[cont.selectedLeaveIndex]);
                              //     },
                              //   ),
                              // ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio(
                                  activeColor: Colors.green,
                                  value: cont.leaveForList[0],
                                  visualDensity: const VisualDensity(horizontal: -4.0),
                                  groupValue: cont.selectedLeave,
                                  onChanged: (dynamic v) {
                                    cont.changeSelectedIndex(v,cont.leaveForList[0]);
                                  },
                                ),
                                buildTextRegularWidget("Full Day", blackColor, context, 14.0),
                              ],
                            ),
                             Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Radio(
                                   activeColor: Colors.green,
                                   value: cont.leaveForList[1],
                                   groupValue: cont.selectedLeave,
                                   visualDensity: const VisualDensity(horizontal: -4.0),
                                   onChanged: (dynamic v) {
                                     cont.changeSelectedIndex(v,cont.leaveForList[1]);
                                   },
                                 ),
                                 buildTextRegularWidget("First Half", blackColor, context, 14.0),
                               ],
                             ),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Radio(
                                    activeColor: Colors.green,
                                    value: cont.leaveForList[2],
                                    groupValue: cont.selectedLeave,
                                    visualDensity: const VisualDensity(horizontal: -4.0),
                                    onChanged: (dynamic v) {
                                      cont.changeSelectedIndex(v,cont.leaveForList[2]);
                                    },
                                  ),
                                  buildTextRegularWidget("Second Half", blackColor, context, 14.0)
                                ],
                              )
                            ],
                          ),
                        )
                            : const Opacity(opacity: 0.0),
                        cont.validateLeaveFor == true
                            ? ErrorText(errorMessage: "Please select leave for",)
                            : const Opacity(opacity: 0.0),
                        cont.selectedStartDateToShow == cont.selectedEndDateToShow ?
                        const Divider(color: grey,thickness: 2.0,)
                            :const Opacity(opacity: 0.0),

                        ///no of attempt
                        cont.selectedLeaveType == "Exam Leave" && cont.selectedStartDateToShow == cont.selectedEndDateToShow
                            ? const SizedBox(height: 15,) : const Opacity(opacity: 0.0,),
                        cont.selectedLeaveType == "Exam Leave"
                            ? Container(
                          height: 40.0,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: cont.validateNoOfAttempt?errorColor:grey),),
                          child: TextFormField(
                            controller: cont.noOfAttempt,
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
                              hintText: "No of this attempt",
                              hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                color: blackColor, fontSize: 15,),),
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {
                              cont.checkNoOfThisAttemptValidation(context);
                            },
                          ),
                        )
                            : const Opacity(opacity: 0.0,),
                        cont.validateNoOfAttempt == true
                            ? ErrorText(errorMessage: "Please enter no of attempt",)
                            : const Opacity(opacity: 0.0),
                        cont.selectedLeaveType == "Exam Leave"
                            ? const SizedBox(height: 15,) : const Opacity(opacity: 0.0,),

                        ///leave for exam 2
                        cont.selectedLeaveType == "Exam Leave"
                            ? buildTextRegularWidget("Leave For ", blackColor, context, 15.0)
                            : const Opacity(opacity: 0.0,),
                        cont.selectedLeaveType == "Exam Leave"
                            ?
                        // ListView.builder(
                        //   shrinkWrap: true,
                        //   itemCount: cont.leaveForExamList.length,
                        //   itemBuilder: (context, index) {
                        //     return RadioListTile(
                        //       value: cont.leaveForExamList[index],
                        //       groupValue: cont.selectedLeaveForExam,
                        //       selected: cont.leaveForExamList[index] == cont.selectedLeaveForExamIndex,
                        //       onChanged: (dynamic v){
                        //         cont.changeSelectedIndexForExam(v,cont.leaveForExamList[cont.selectedLeaveForExamIndex]);
                        //       },
                        //       title:Align(
                        //         child: buildTextRegularWidget(cont.leaveForExamList[index], blackColor, context, 14.0),
                        //         alignment: const Alignment(-1,20),
                        //       ),
                        //       contentPadding: const EdgeInsets.all(0.0),dense: true,
                        //     );
                        //   },
                        // )
                        SizedBox(
                          width: double.infinity,height: 50.0,
                          child:
                          ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: cont.leaveForExamList.length,
                            itemBuilder: (context, index) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Radio(
                                    activeColor: Colors.green,
                                    value: cont.leaveForExamList[index],
                                    groupValue: cont.selectedLeaveForExam,
                                    visualDensity: const VisualDensity(horizontal: -4.0),
                                    //selected: cont.leaveForExamList[index] == cont.selectedLeaveForExamIndex,
                                    onChanged: (dynamic v){
                                      cont.changeSelectedIndexForExam(v,cont.leaveForExamList[index]);
                                    },
                                  ),
                                  buildTextRegularWidget(cont.leaveForExamList[index], blackColor, context, 14.0),
                                ],
                              );
                            },
                          )
                        )
                            : const Opacity(opacity: 0.0,),
                        cont.validateLeaveForExam == true
                            ? ErrorText(errorMessage: "Please select leave for",)
                            : const Opacity(opacity: 0.0),
                      ],
                    ),
                  )
                )
            )
          ],
        ),
        bottomNavigationBar: cont.loader == true ? const Opacity(opacity:0.0) :
        Container(
          color: whiteColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20.0),
            child: GestureDetector(
              onTap: (){
                cont.functionCall(screenFor);
              },
              child: buildButtonWidget(context, screenFor=="add"?"Submit":"Update",radius: 5.0,height: 50.0),
            ),
          ),
        )
    ));
    });
  }
}
