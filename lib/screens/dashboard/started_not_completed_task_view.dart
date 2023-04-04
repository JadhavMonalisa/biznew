import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/dashboard/dashboard_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartedNotCompletedTaskViewScreen extends StatefulWidget {
  const StartedNotCompletedTaskViewScreen({Key? key}) : super(key: key);

  @override
  State<StartedNotCompletedTaskViewScreen> createState() => _StartedNotCompletedTaskViewScreenState();
}

class _StartedNotCompletedTaskViewScreenState extends State<StartedNotCompletedTaskViewScreen> {
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
              title: buildTextMediumWidget(
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
                                    buildTextBoldWidget(item.taskName!, blackColor, context, 14.0),
                                    buildTextRegularWidget("Completion in ${item.completion} %", blackColor, context, 14.0),
                                    const SizedBox(height: 5.0,),
                                    Table(
                                      children: [
                                        TableRow(
                                            children: [
                                              buildTextBoldWidget("Days", blackColor, context, 14.0),
                                              buildTextBoldWidget("Hours", blackColor, context, 14.0),
                                              buildTextBoldWidget("Minutes", blackColor, context, 14.0),
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 15.0),
                                                child: buildTextRegularWidget(item.days!, blackColor, context, 14.0),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20.0),
                                                child: buildTextRegularWidget(item.hours!, blackColor, context, 14.0),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 25.0),
                                                child: buildTextRegularWidget(item.mins!, blackColor, context, 14.0),
                                              ),
                                            ]
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10.0,),
                                    cont.selectedMainType == "StartedNotCompleted"
                                        ?buildRichTextWidget("Name of the staff - ", item.firmEmployeeName!)
                                        :buildRichTextWidget("Assigned to - ", item.firmEmployeeName!),
                                    const SizedBox(height: 10.0,),
                                    // item.start=="0" && item.status=="1"
                                    //     ? buildRichTextWidget("Status - ","Yet to start")
                                    //     :

                                    Row(
                                      children: [
                                        //Flexible(child: buildRichTextWidget("Status - ", item.status!),),
                                        buildTextRegularWidget("Status", blackColor, context, 14.0),
                                        const SizedBox(width:10.0),
                                        Flexible(
                                          child: Container(
                                              height: 40.0,
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                border: Border.all(color: grey),),
                                              child:
                                              // cont.reportingHead == "0"
                                              //     ? Align(
                                              //   alignment: Alignment.centerLeft,
                                              //   child: Padding(
                                              //     padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                              //     child: buildTextRegularWidget(
                                              //         item.status == "1" ? "Inprocess" :
                                              //         item.status == "2" ? "Awaiting for Client Input" :
                                              //         item.status == "3" ? "Submitted for Checking" :
                                              //         item.status == "4" ? "Put On Hold" : "Completed",
                                              //         blackColor, context, 15.0,align: TextAlign.left),
                                              //   ),
                                              // )
                                              //     :
                                              Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                                    child: DropdownButton(
                                                      hint: buildTextRegularWidget(
                                                          cont.addedTaskStatus.contains(item.id) ?
                                                          cont.selectedTaskStatus == ""
                                                              ?
                                                          item.status == "1" ? "Inprocess" :
                                                          item.status == "2" ? "Awaiting for Client Input" :
                                                          item.status == "3" ? "Submitted for Checking" :
                                                          item.status == "4" ? "Put On Hold" : "Completed"

                                                              : cont.selectedTaskStatus
                                                              :  item.status == "1" ? "Inprocess" :
                                                          item.status == "2" ? "Awaiting for Client Input" :
                                                          item.status == "3" ? "Submitted for Checking" :
                                                          item.status == "4" ? "Put On Hold" : "Completed",

                                                          blackColor, context, 15.0,align: TextAlign.left),
                                                      isExpanded: true,
                                                      underline: Container(),
                                                      items:
                                                      cont.taskStatusList.map((String value) {
                                                        return DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                      onChanged: (val) {
                                                        cont.updateTaskStatus(val!,item.id!,context,item.taskId!,item.taskName!);
                                                      },
                                                    ),
                                                  )
                                              )
                                          ),
                                        ),
                                        const SizedBox(width:10.0),
                                        Flexible(child: GestureDetector(
                                          onTap: (){
                                            cont.callUpdateTaskStatus(context,item.id!,item.taskId!,item.taskName!);
                                            },
                                          child: buildButtonWidget(context, "Go",height: 40.0,width: 100.0),
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                )
            ),
          )
      );
    });
  }
}
