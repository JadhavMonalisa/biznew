import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/claim_form/claim_model.dart';
import 'package:biznew/screens/dashboard/dashboard_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceDashboardNextDetails extends StatefulWidget {
  const ServiceDashboardNextDetails({Key? key}) : super(key: key);

  @override
  State<ServiceDashboardNextDetails> createState() => _ServiceDashboardNextDetailsState();
}

class _ServiceDashboardNextDetailsState extends State<ServiceDashboardNextDetails> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont)
    {
      return WillPopScope(
          onWillPop: () async{
            return await cont.navigateFromAllotted();
          },
          child:Scaffold(
              appBar: AppBar(
                elevation: 0, backgroundColor: primaryColor, centerTitle: true,
                title: buildTextMediumWidget(cont.selectedMainType == "AllottedNotStarted"? "Allotted but not started" :
                cont.selectedMainType == "StartedNotCompleted" ? "Started but not completed" :
                cont.selectedMainType == "CompletedUdinPending"? "Completed but UDIN pending" :
                cont.selectedMainType == "CompletedNotBilled"? "Completed but not billed" :
                cont.selectedMainType == "WorkOnHold"? "Work on hold" :
                cont.selectedMainType == "SubmittedForChecking"? "Submitted for checking" : "All Tasks",
                    whiteColor,context, 16,align: TextAlign.center),
              ),
              body:
              cont.loader == true ? Center(child: buildCircularIndicator(),) :
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    physics:const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(right: 10.0,left: 10.0,top: 10.0),
                          child: Card(
                              elevation: 1.0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
                                  side: const BorderSide(color: grey)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child:buildTextBoldWidget("${cont.selectedClientName} - ${cont.selectedServiceName}" ,
                                    blackColor, context, 14.0,align: TextAlign.left),
                              ),
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 10.0,left: 20.0,top: 10.0),
                          child: Table(
                            children: [
                              TableRow(
                                  children: [
                                    buildTextRegularWidget("Employee", blackColor, context, 14.0),
                                    Container(
                                        height: 30.0,width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                                          border: Border.all(color: grey),),
                                        child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                              child: DropdownButton(
                                                hint: buildTextRegularWidget(
                                                    cont.selectedEmployee==""?
                                                "Select employee":
                                                cont.selectedEmployee,
                                                    blackColor, context, 15.0),
                                                isExpanded: true,
                                                underline: Container(),
                                                items:
                                                cont.employeeList.isEmpty
                                                    ? cont.noDataList.map((value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList()
                                                    : cont.employeeList.map((ClaimSubmittedByList value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value.firmEmployeeName,
                                                    child: Text(value.firmEmployeeName!),
                                                    onTap: (){
                                                      cont.updateEmployeeFromAllotted(value.firmEmployeeName!,value.mastId!);
                                                    },
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  //cont.updateEmployeeFromTriggered(val!,value.firmEmployeeName!);
                                                },
                                              ),
                                            )
                                        )
                                    ),
                                  ]
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cont.loadAllTaskList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context,index){
                              final item = cont.loadAllTaskList[index];
                              return
                                cont.showLoadingText ? const Center(child:Text("Loading..")) :
                                Card(
                                elevation: 1.0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
                                    side: const BorderSide(color: grey)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ///task name
                                      Container(
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                                            border: Border.all(color: grey),),
                                          child:cont.allottedTaskNameList.isEmpty ? null : TextFormField(
                                            controller: cont.allottedTaskNameList[index],
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
                                                hintText: item.taskName!,
                                                hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                                  color: blackColor, fontSize: 15,),),
                                                border: InputBorder.none,
                                            ),
                                            onChanged: (value) {
                                            },
                                          )
                                      ),

                                      const Divider(color: grey,),
                                      const SizedBox(height: 5.0,),
                                      ///assigned to
                                      Row(
                                          children: [
                                            buildTextRegularWidget("Assigned To", blackColor, context, 14.0),
                                            const SizedBox(width: 20.0,),
                                            Flexible(
                                              child: Container(
                                                  height: 40.0,
                                                  width: MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                    border: Border.all(color: grey),),
                                                  child: Center(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                                        child: DropdownButton(
                                                          hint: buildTextRegularWidget(
                                                            // cont.addedAssignedToAllotted.contains(item.taskId)
                                                            //       ? cont.allottedSelectedEmpList[index]
                                                            //       : "Select",

                                                              cont.allottedSelectedEmpList.isEmpty ? "":
                                                              cont.allottedSelectedEmpList[index] ,
                                                              blackColor, context, 15.0),
                                                          isExpanded: true,
                                                          underline: Container(),
                                                          items:
                                                          cont.employeeList.map((ClaimSubmittedByList value) {
                                                            return DropdownMenuItem<String>(
                                                              value: value.firmEmployeeName,
                                                              child: Text(value.firmEmployeeName!),
                                                              onTap: (){
                                                                cont.updateAssignedToAllotted(index,value.firmEmployeeName!,value.firmEmployeeId!,item.taskId!);
                                                              },
                                                            );
                                                          }).toList(),
                                                          onChanged: (val) {
                                                          },
                                                        ),
                                                      )
                                                  )
                                              ),
                                            ),
                                            //const SizedBox(width: 20.0,),
                                          ]
                                      ),
                                      const SizedBox(height: 5.0,),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              buildTextRegularWidget("Completion %", blackColor, context, 14.0),
                                              const SizedBox(width: 5.0,),
                                              Flexible(
                                                child: Container(
                                                    height: 30.0,width: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                      border: Border.all(color: grey),),
                                                    child:cont.allottedCompletionList.isEmpty ? null : TextFormField(
                                                      controller: cont.allottedCompletionList[index],
                                                      keyboardType: TextInputType.number,
                                                      textAlign: TextAlign.right,
                                                      onTap: () {
                                                      },
                                                      enabled: true,
                                                      style:const TextStyle(fontSize: 15.0),
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.only(left:2,bottom: 10.0),
                                                        hintText: item.completion!,
                                                        hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                                          color: blackColor, fontSize: 15,),),
                                                        border: InputBorder.none,
                                                      ),
                                                      onChanged: (value) {
                                                        //cont.addCompletion(index,value);
                                                      },
                                                    )
                                                ),
                                              ),
                                              const SizedBox(width:10.0),

                                              buildTextRegularWidget("D", blackColor, context, 14.0,align: TextAlign.center),
                                              const SizedBox(width:5.0),
                                              Flexible(
                                                child: Container(
                                                    height: 30.0,width: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                      border: Border.all(color: grey),),
                                                    child:  cont.allottedDaysList.isEmpty ? null : TextFormField(
                                                      controller: cont.allottedDaysList[index],
                                                      keyboardType: TextInputType.number,
                                                      textAlign: TextAlign.right,
                                                      onTap: () {

                                                      },
                                                      enabled: true,
                                                      style:const TextStyle(fontSize: 15.0),
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.only(left:2,bottom: 10.0),
                                                        hintText: item.days!,
                                                        hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                                          color: blackColor, fontSize: 15,),),
                                                        border: InputBorder.none,
                                                      ),
                                                      onChanged: (value) {
                                                        // print("value");
                                                        // print(value);
                                                        // cont.addDays(index,value);
                                                      },
                                                    )
                                                ),
                                              ),
                                              const SizedBox(width:10.0),

                                              buildTextRegularWidget("H", blackColor, context, 14.0,align: TextAlign.center),
                                              const SizedBox(width:5.0),
                                              Flexible(
                                                child: Container(
                                                    height: 30.0,width: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                      border: Border.all(color: grey),),
                                                    child: cont.allottedHoursList.isEmpty ? null :
                                                    TextFormField(
                                                      controller: cont.allottedHoursList[index],
                                                      keyboardType: TextInputType.number,
                                                      textAlign: TextAlign.right,
                                                      onTap: () {
                                                      },
                                                      enabled: true,
                                                      style:const TextStyle(fontSize: 15.0),
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.only(left:2,bottom: 10.0),
                                                        hintText: item.hours!,
                                                        hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                                          color: blackColor, fontSize: 15,),),
                                                        border: InputBorder.none,
                                                      ),
                                                      onChanged: (value) {
                                                        // cont.addHours(index,value);
                                                      },
                                                    )
                                                ),
                                              ),
                                              const SizedBox(width:10.0),

                                              buildTextRegularWidget("M", blackColor, context, 14.0,align: TextAlign.center),
                                              const SizedBox(width:5.0),
                                              Flexible(
                                                child: Container(
                                                    height: 30.0,width: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                      border: Border.all(color: grey),),
                                                    child: cont.allottedMinuteList.isEmpty ? null : TextFormField(
                                                      controller: cont.allottedMinuteList[index],
                                                      keyboardType: TextInputType.number,
                                                      textAlign: TextAlign.right,
                                                      onTap: () {
                                                      },
                                                      enabled: true,
                                                      style:const TextStyle(fontSize: 15.0),
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.only(left:2,bottom: 10.0),
                                                        hintText: item.mins!,
                                                        hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                                          color: blackColor, fontSize: 15,),),
                                                        border: InputBorder.none,
                                                      ),
                                                      onChanged: (value) {
                                                        //cont.addMinutes(index,value);
                                                      },
                                                    )
                                                ),
                                              ),
                                            ]
                                        ),
                                      ),
                                      const SizedBox(height: 10.0,),
                                      // Table(
                                      //   children: [
                                      //     ///completion
                                      //     TableRow(
                                      //       children: [
                                      //         buildTextRegularWidget("Completion %", blackColor, context, 14.0),
                                      //         Container(
                                      //             height: 30.0,
                                      //             decoration: BoxDecoration(
                                      //               borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      //               border: Border.all(color: grey),),
                                      //             child:cont.allottedCompletionList.isEmpty ? null : TextFormField(
                                      //               controller: cont.allottedCompletionList[index],
                                      //               keyboardType: TextInputType.number,
                                      //               textDirection: TextDirection.ltr,
                                      //               onTap: () {
                                      //               },
                                      //               enabled: true,
                                      //               style:const TextStyle(fontSize: 15.0),
                                      //               decoration: InputDecoration(
                                      //                 contentPadding: const EdgeInsets.all(10),
                                      //                 hintText: item.completion!,
                                      //                 hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                      //                   color: blackColor, fontSize: 15,),),
                                      //                 border: InputBorder.none,
                                      //               ),
                                      //               onChanged: (value) {
                                      //                 //cont.addCompletion(index,value);
                                      //               },
                                      //             )
                                      //         ),
                                      //       ]
                                      //     ),
                                      //     const TableRow(
                                      //       children: [
                                      //         SizedBox(height: 10.0,),
                                      //         SizedBox(height: 10.0,),
                                      //       ]
                                      //     ),
                                      //     ///days
                                      //     TableRow(
                                      //       children: [
                                      //         buildTextRegularWidget("Days", blackColor, context, 14.0),
                                      //         Container(
                                      //             height: 30.0,
                                      //             decoration: BoxDecoration(
                                      //               borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      //               border: Border.all(color: grey),),
                                      //             child:  cont.allottedDaysList.isEmpty ? null : TextFormField(
                                      //               controller: cont.allottedDaysList[index],
                                      //               keyboardType: TextInputType.number,
                                      //               textDirection: TextDirection.ltr,
                                      //               onTap: () {
                                      //
                                      //               },
                                      //               enabled: true,
                                      //               style:const TextStyle(fontSize: 15.0),
                                      //               decoration: InputDecoration(
                                      //                 contentPadding: const EdgeInsets.all(10),
                                      //                 hintText: item.days!,
                                      //                 hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                      //                   color: blackColor, fontSize: 15,),),
                                      //                 border: InputBorder.none,
                                      //               ),
                                      //               onChanged: (value) {
                                      //                 // print("value");
                                      //                 // print(value);
                                      //                 // cont.addDays(index,value);
                                      //               },
                                      //             )
                                      //         ),
                                      //       ]
                                      //     ),
                                      //     const TableRow(
                                      //         children: [
                                      //           SizedBox(height: 10.0,),
                                      //           SizedBox(height: 10.0,),
                                      //         ]
                                      //     ),
                                      //     ///hours
                                      //     TableRow(
                                      //       children: [
                                      //         buildTextRegularWidget("Hours", blackColor, context, 14.0),
                                      //         Container(
                                      //             height: 30.0,
                                      //             decoration: BoxDecoration(
                                      //               borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      //               border: Border.all(color: grey),),
                                      //             child: cont.allottedHoursList.isEmpty ? null :
                                      //             TextFormField(
                                      //               controller: cont.allottedHoursList[index],
                                      //               keyboardType: TextInputType.number,
                                      //               textDirection: TextDirection.ltr,
                                      //               onTap: () {
                                      //               },
                                      //               enabled: true,
                                      //               style:const TextStyle(fontSize: 15.0),
                                      //               decoration: InputDecoration(
                                      //                 contentPadding: const EdgeInsets.all(10),
                                      //                 hintText: item.hours!,
                                      //                 hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                      //                   color: blackColor, fontSize: 15,),),
                                      //                 border: InputBorder.none,
                                      //               ),
                                      //               onChanged: (value) {
                                      //                // cont.addHours(index,value);
                                      //               },
                                      //             )
                                      //         ),
                                      //       ]
                                      //     ),
                                      //     const TableRow(
                                      //         children: [
                                      //           SizedBox(height: 10.0,),
                                      //           SizedBox(height: 10.0,),
                                      //         ]
                                      //     ),
                                      //     ///minute
                                      //     TableRow(
                                      //       children: [
                                      //         buildTextRegularWidget("Minutes", blackColor, context, 14.0),
                                      //         Container(
                                      //             height: 30.0,
                                      //             decoration: BoxDecoration(
                                      //               borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      //               border: Border.all(color: grey),),
                                      //             child: cont.allottedMinuteList.isEmpty ? null : TextFormField(
                                      //               controller: cont.allottedMinuteList[index],
                                      //               keyboardType: TextInputType.number,
                                      //               textAlign: TextAlign.left,
                                      //               textDirection: TextDirection.ltr,
                                      //               onTap: () {
                                      //               },
                                      //               enabled: true,
                                      //               style:const TextStyle(fontSize: 15.0),
                                      //               decoration: InputDecoration(
                                      //                 contentPadding: const EdgeInsets.all(10),
                                      //                 hintText: item.mins!,
                                      //                 hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                      //                   color: blackColor, fontSize: 15,),),
                                      //                 border: InputBorder.none,
                                      //               ),
                                      //               onChanged: (value) {
                                      //                 //cont.addMinutes(index,value);
                                      //               },
                                      //             )
                                      //         ),
                                      //       ]
                                      //     ),
                                      //     const TableRow(
                                      //         children: [
                                      //           SizedBox(height: 10.0,),
                                      //           SizedBox(height: 10.0,),
                                      //         ]
                                      //     ),
                                      //   ],
                                      // ),
                                      // const SizedBox(height: 10.0,),

                                      ///view,add,remove
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: GestureDetector(
                                                onTap: (){
                                                  cont.removeFromSelectedAllotted(index,);
                                                },
                                                child: buildButtonWidget(context, "Remove",
                                                    height: 35.0,buttonColor: errorColor,buttonFontSize:14.0),
                                              ),
                                            ),
                                            const SizedBox(width: 10.0,),
                                            Flexible(
                                              child: GestureDetector(
                                                onTap: (){Get.toNamed(AppRoutes.serviceNextViewScreen);},
                                                child:  buildButtonWidget(context, "View",height: 35.0,width: 100.0,
                                                  buttonColor: editColor, buttonFontSize:14.0,),
                                              ),
                                            ),
                                            const SizedBox(width: 10.0,),
                                            Flexible(
                                              child: GestureDetector(
                                                onTap: (){
                                                  cont.checkAllAddedValuesForAllotted(index);
                                                },
                                                child: buildButtonWidget(context, "Add",
                                                  height: 35.0,buttonColor: approveColor,buttonFontSize:14.0,),
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
                        padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 5.0),
                        child:

                        Row(
                          children: [
                            buildTextBoldWidget("Completion % : ", blackColor, context, 15.0),
                            buildTextRegularWidget(cont.allottedTotalCompletion.toString(), blackColor, context, 15.0),

                            Spacer(),
                            buildTextBoldWidget("  Total : ", blackColor, context, 15.0),
                            buildTextRegularWidget(cont.allottedTotalDays.toString(), blackColor, context, 15.0),
                            buildTextBoldWidget("D ", blackColor, context, 15.0),

                            buildTextRegularWidget(cont.allottedTotalHours.toString(), blackColor, context, 15.0),
                            buildTextBoldWidget("H ", blackColor, context, 15.0),

                            buildTextRegularWidget(cont.allottedTotalMins.toString(), blackColor, context, 15.0),
                            buildTextBoldWidget("M", blackColor, context, 15.0),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 5.0,bottom: 10.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: GestureDetector(
                                onTap: (){
                                  cont.addMoreForAllottedNotCompleted();
                                  //showInprocessDialog(context);
                                  //cont.addMoreForTriggeredNotAllotted(cont.triggeredNotAllottedLoadAll.length);
                                },
                                child: buildButtonWidget(context, "Add more",buttonColor: editColor,height: 35.0),
                              ),
                            ),
                            const SizedBox(width: 10.0,),
                            Flexible(
                                child: GestureDetector(
                                  onTap: (){
                                    cont.checkAll();
                                    //showInprocessDialog(context);
                                  },
                                  child: buildButtonWidget(context, "Save",buttonColor: approveColor,height: 35.0),
                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
          )
      );
    });
  }
}
