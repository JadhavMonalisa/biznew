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
            return await Get.toNamed(AppRoutes.serviceDashboardNext);
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
              body:  cont.loader == true ? Center(child: buildCircularIndicator(),) :
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
                                child:buildTextBoldWidget("${cont.selectedClientName} - ${cont.selectedServiceName}" , blackColor, context, 14.0,align: TextAlign.left),
                              ),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 20.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cont.loadAllTaskList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context,index){
                              final item = cont.loadAllTaskList[index];
                              return Card(
                                elevation: 1.0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
                                    side: const BorderSide(color: grey)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //buildTextBoldWidget(item.taskName!, blackColor, context, 14.0),

                                      Container(
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                                            border: Border.all(color: grey),),
                                          child: TextFormField(
                                            controller: cont.taskNameList[index],
                                            keyboardType: TextInputType.text,
                                            textAlign: TextAlign.left,
                                            textAlignVertical: TextAlignVertical.center,
                                            textInputAction: TextInputAction.done,
                                            onTap: () {
                                            },
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

                                      Table(
                                        children: [
                                          TableRow(
                                            children: [
                                              buildTextRegularWidget("Completion in %", blackColor, context, 14.0),
                                              Container(
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                    border: Border.all(color: grey),),
                                                  child: TextFormField(
                                                    controller: cont.completionList[index],
                                                    keyboardType: TextInputType.number,
                                                    textAlign: TextAlign.left,
                                                    textAlignVertical: TextAlignVertical.center,
                                                    textInputAction: TextInputAction.done,
                                                    onTap: () {
                                                    },
                                                    style:const TextStyle(fontSize: 15.0),
                                                    decoration: InputDecoration(
                                                      contentPadding: const EdgeInsets.all(10),
                                                      hintText: item.completion!,
                                                      hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                                        color: blackColor, fontSize: 15,),),
                                                      border: InputBorder.none,
                                                    ),
                                                    onChanged: (value) {
                                                    },
                                                  )
                                              ),
                                            ]
                                          ),
                                          TableRow(
                                            children: [
                                              const SizedBox(height: 10.0,),
                                              const SizedBox(height: 10.0,),
                                            ]
                                          ),
                                          TableRow(
                                            children: [
                                              buildTextRegularWidget("Days", blackColor, context, 14.0),
                                              Container(
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                    border: Border.all(color: grey),),
                                                  child: TextFormField(
                                                    controller: cont.daysList[index],
                                                    keyboardType: TextInputType.number,
                                                    textAlign: TextAlign.left,
                                                    textAlignVertical: TextAlignVertical.center,
                                                    textInputAction: TextInputAction.done,
                                                    onTap: () {
                                                    },
                                                    style:const TextStyle(fontSize: 15.0),
                                                    decoration: InputDecoration(
                                                      contentPadding: const EdgeInsets.all(10),
                                                      hintText: item.days!,
                                                      hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                                        color: blackColor, fontSize: 15,),),
                                                      border: InputBorder.none,
                                                    ),
                                                    onChanged: (value) {
                                                    },
                                                  )
                                              ),
                                            ]
                                          ),
                                          TableRow(
                                              children: [
                                                const SizedBox(height: 10.0,),
                                                const SizedBox(height: 10.0,),
                                              ]
                                          ),
                                          TableRow(
                                            children: [
                                              buildTextRegularWidget("Hours", blackColor, context, 14.0),
                                              Container(
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                    border: Border.all(color: grey),),
                                                  child: TextFormField(
                                                    controller: cont.hoursList[index],
                                                    keyboardType: TextInputType.number,
                                                    textAlign: TextAlign.left,
                                                    textAlignVertical: TextAlignVertical.center,
                                                    textInputAction: TextInputAction.done,
                                                    onTap: () {
                                                    },
                                                    style:const TextStyle(fontSize: 15.0),
                                                    decoration: InputDecoration(
                                                      contentPadding: const EdgeInsets.all(10),
                                                      hintText: item.hours!,
                                                      hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                                        color: blackColor, fontSize: 15,),),
                                                      border: InputBorder.none,
                                                    ),
                                                    onChanged: (value) {
                                                    },
                                                  )
                                              ),
                                            ]
                                          ),
                                          TableRow(
                                              children: [
                                                const SizedBox(height: 10.0,),
                                                const SizedBox(height: 10.0,),
                                              ]
                                          ),
                                          TableRow(
                                            children: [
                                              buildTextRegularWidget("Minute", blackColor, context, 14.0),
                                              Container(
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                    border: Border.all(color: grey),),
                                                  child: TextFormField(
                                                    controller: cont.minuteList[index],
                                                    keyboardType: TextInputType.number,
                                                    textAlign: TextAlign.left,
                                                    textAlignVertical: TextAlignVertical.center,
                                                    textInputAction: TextInputAction.done,
                                                    onTap: () {
                                                    },
                                                    style:const TextStyle(fontSize: 15.0),
                                                    decoration: InputDecoration(
                                                      contentPadding: const EdgeInsets.all(10),
                                                      hintText: item.mins!,
                                                      hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                                        color: blackColor, fontSize: 15,),),
                                                      border: InputBorder.none,
                                                    ),
                                                    onChanged: (value) {
                                                    },
                                                  )
                                              ),
                                            ]
                                          ),
                                          TableRow(
                                              children: [
                                                const SizedBox(height: 10.0,),
                                                const SizedBox(height: 10.0,),
                                              ]
                                          ),
                                          TableRow(
                                              children: [
                                                buildTextRegularWidget("Assigned to", blackColor, context, 14.0),
                                                Container(
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
                                                                cont.addedAssignedTo.contains(item.id) ?
                                                                cont.selectedEmpFromDashboardNext==""?item.firmEmployeeName!:cont.selectedEmpFromDashboardNext : item.firmEmployeeName!,

                                                                blackColor, context, 15.0),
                                                            isExpanded: true,
                                                            underline: Container(),
                                                            items:
                                                            cont.employeeList.map((ClaimSubmittedByList value) {
                                                              return DropdownMenuItem<String>(
                                                                value: value.firmEmployeeName,
                                                                child: Text(value.firmEmployeeName!),
                                                              );
                                                            }).toList(),
                                                            onChanged: (val) {
                                                              cont.updateAssignedTo(val!,item.id!);
                                                            },
                                                          ),
                                                        )
                                                    )
                                                ),
                                              ]
                                          ),
                                        ],
                                      ),
                                      // buildTextRegularWidget("Completion in ${item.completion} %", blackColor, context, 14.0),
                                      // const SizedBox(height: 5.0,),
                                      // Table(
                                      //   children: [
                                      //     TableRow(
                                      //         children: [
                                      //           buildTextBoldWidget("Days", blackColor, context, 14.0),
                                      //           buildTextBoldWidget("Hours", blackColor, context, 14.0),
                                      //           buildTextBoldWidget("Minutes", blackColor, context, 14.0),
                                      //         ]
                                      //     ),
                                      //     TableRow(
                                      //         children: [
                                      //           Padding(
                                      //             padding: const EdgeInsets.only(left: 15.0),
                                      //             child: buildTextRegularWidget(item.days!, blackColor, context, 14.0),
                                      //           ),
                                      //           Padding(
                                      //             padding: const EdgeInsets.only(left: 20.0),
                                      //             child: buildTextRegularWidget(item.hours!, blackColor, context, 14.0),
                                      //           ),
                                      //           Padding(
                                      //             padding: const EdgeInsets.only(left: 25.0),
                                      //             child: buildTextRegularWidget(item.mins!, blackColor, context, 14.0),
                                      //           ),
                                      //         ]
                                      //     ),
                                      //   ],
                                      // ),
                                      // const SizedBox(height: 10.0,),
                                      // buildRichTextWidget("Assigned to - ", item.firmEmployeeName!),
                                      // const SizedBox(height: 10.0,),
                                      // item.start=="0" && item.status=="1"
                                      //
                                      //     ? buildRichTextWidget("Status - ","Yet to start")
                                      //     : Row(
                                      //   children: [
                                      //     Flexible(child: buildTextBoldWidget("Status - ", blackColor, context, 14.0),),
                                      //     Flexible(child: GestureDetector(
                                      //       onTap: (){
                                      //         cont.startSelectedTask(item.id!, item.taskId!);
                                      //       },
                                      //       child: buildButtonWidget(context, "Start",height: 35.0,width: 100.0),
                                      //     )),
                                      //   ],
                                      // ),
                                      const SizedBox(height: 10.0,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: GestureDetector(
                                                onTap: (){Get.toNamed(AppRoutes.serviceNextViewScreen);},
                                                child:  buildButtonWidget(context, "View",height: 40.0,buttonColor: approveColor,buttonFontSize:14.0,),
                                              ),
                                            ),
                                            const SizedBox(width: 10.0,),
                                            Flexible(
                                              child: GestureDetector(
                                                onTap: (){
                                                  cont.printAll(index);
                                                },
                                                child: buildButtonWidget(context, "Remove",height: 40.0,buttonColor: errorColor,buttonFontSize:14.0),
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
                    ],
                  )
              ),
            bottomNavigationBar: SizedBox(
              height: 130.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 15.0),
                child:
                Column(
                  children:[
                    Table(
                      children: [
                        TableRow(
                            children: [
                              buildTextBoldWidget("Completion", blackColor, context, 14.0),
                              buildTextBoldWidget("Days", blackColor, context, 14.0),
                              buildTextBoldWidget("Hours", blackColor, context, 14.0),
                              buildTextBoldWidget("Mins", blackColor, context, 14.0),
                            ]
                        ),
                        const TableRow(
                            children: [
                              SizedBox(height: 10.0,),
                              SizedBox(height: 10.0,),
                              SizedBox(height: 10.0,),
                              SizedBox(height: 10.0,),
                            ]
                        ),
                        TableRow(
                            children: [
                              buildTextRegularWidget(cont.totalCompletion.toString(), blackColor, context, 14.0),
                              buildTextRegularWidget(cont.totalDays.toString(), blackColor, context, 14.0),
                              buildTextRegularWidget(cont.totalHours.toString(), blackColor, context, 14.0),
                              buildTextRegularWidget(cont.totalMins.toString(), blackColor, context, 14.0),
                            ]
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0,),
                    Row(
                    children: [
                      Flexible(
                        child: buildButtonWidget(context, "Save",buttonColor: approveColor),
                      ),
                      const SizedBox(width: 10.0,),
                      Flexible(
                        child: GestureDetector(
                          onTap: (){
                            cont.addMore();
                          },
                          child: buildButtonWidget(context, "Add more",buttonColor: editColor),
                        ),
                      ),
                    ],
                  ),]
                ),
              ),
            ),
          )
      );
    });
  }
}
