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
            //return await Get.toNamed(AppRoutes.serviceDashboardNext);
            return await cont.navigateFromStartedNotCompleted();
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
                        child: SizedBox(
                          height: 63.0,
                          child: Card(
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
                                side: const BorderSide(color: grey)),
                            child: Row(
                              children: [
                                Container(
                                    decoration: const BoxDecoration(color: primaryColor,
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0),
                                        bottomLeft: Radius.circular(7.0))),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                          child: buildTextBoldWidget(cont.selectedClientCode, whiteColor, context, 14.0),
                                        )
                                    )
                                ),
                                const SizedBox(width:5.0),
                                Flexible(
                                  child: buildTextBoldWidget("${cont.selectedClientName} - ${cont.selectedServiceName}" , blackColor, context, 14.0,align: TextAlign.left),
                                )
                                 ],
                            ),
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
                                    buildTextBoldWidget("Task No ${index+1} : Completion ${item.completion} %", blackColor, context, 14.0),
                                    const Divider(color: grey,),
                                    buildTextBoldWidget(item.taskName!, blackColor, context, 14.0),
                                    //buildTextRegularWidget("Completion in ${item.completion} %", blackColor, context, 14.0),
                                    const SizedBox(height: 5.0,),
                                    Row(
                                      children: [
                                        cont.selectedMainType == "StartedNotCompleted"
                                            ?buildRichTextWidget("Name - ", item.firmEmployeeName!,title1Size: 16.0,title2Size: 15.0)
                                            :buildRichTextWidget("Name - ", item.firmEmployeeName!,title1Size: 16.0,title2Size: 15.0),
                                        const Spacer(),

                                        buildTextBoldWidget(" Total : ", blackColor, context, 14.0),
                                        buildTextRegularWidget(item.days!, blackColor, context, 14.0),
                                        buildTextBoldWidget("D ", blackColor, context, 14.0),
                                        buildTextRegularWidget(item.hours!, blackColor, context, 14.0),
                                        buildTextBoldWidget("H ", blackColor, context, 14.0),
                                        buildTextRegularWidget(item.mins!, blackColor, context, 14.0),
                                        buildTextBoldWidget("M", blackColor, context, 14.0),
                                        // Flexible(
                                        //   child: Table(
                                        //     children: [
                                        //       TableRow(
                                        //           children: [
                                        //             buildTextBoldWidget("D", blackColor, context, 14.0),
                                        //             buildTextBoldWidget("H", blackColor, context, 14.0),
                                        //             buildTextBoldWidget("M", blackColor, context, 14.0),
                                        //           ]
                                        //       ),
                                        //       TableRow(
                                        //           children: [
                                        //             buildTextRegularWidget(item.days!, blackColor, context, 14.0),
                                        //             buildTextRegularWidget(item.hours!, blackColor, context, 14.0),
                                        //             buildTextRegularWidget(item.mins!, blackColor, context, 14.0),
                                        //           ]
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                           ],
                                    ),

                                    const SizedBox(height: 10.0,),

                                    ///role id 6 (admin)
                                    cont.roleId == "6"
                                    ? Container(
                                      child:
                                      ///start 1 and status 1
                                      item.start == "1" && item.status=="1"
                                          ? Row(
                                        children: [
                                          Flexible(child:buildTextBoldWidget("Status", blackColor, context, 14.0)),
                                          const SizedBox(width: 10.0,),
                                          item.status == "6" ?
                                          buildTextRegularWidget(
                                            "Cancel",
                                              blackColor, context, 15.0,align: TextAlign.left)
                                              :
                                          Flexible(
                                            flex: 3,
                                            child: Container(
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
                                                            cont.addedRh1TaskStatus.contains(item.id) ?
                                                            cont.selectedTaskStatus == ""
                                                                ? item.status == "1" ? "Inprocess" :
                                                            item.status == "2" ? "Awaiting for Client Input" :
                                                            item.status == "3" ? "Submitted for Checking" :
                                                            item.status == "4" ? "Put On Hold" :
                                                            item.status == "5" ? "Completed" :
                                                            item.status == "6" ? "Cancel" :
                                                            item.status == "7" ? "Sent for Rework" : "Select"
                                                                : cont.selectedTaskStatus
                                                            : item.status == "1" ? "Inprocess" :
                                                        item.status == "2" ? "Awaiting for Client Input" :
                                                        item.status == "3" ? "Submitted for Checking" :
                                                            item.status == "4" ? "Put On Hold" :
                                                        item.status == "5" ? "Completed" :
                                                        item.status == "6" ? "Cancel" :
                                                        item.status == "7" ? "Sent for Rework" : "Select"
                                                            ,

                                                            blackColor, context, 15.0,align: TextAlign.left),
                                                        isExpanded: true,
                                                        underline: Container(),
                                                        items:
                                                        cont.rh1taskStatusList.map((String value) {
                                                          return DropdownMenuItem<String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                        onChanged: (val) {
                                                          cont.updateRh1TaskStatus(val!,item.id!,context,item.taskId!,item.taskName!);
                                                        },
                                                      ),
                                                    )
                                                )
                                            ),
                                          ),
                                          const SizedBox(width: 10.0,),
                                          item.status == "6" ? const Opacity(opacity: 0.0) :
                                          Flexible(child: GestureDetector(
                                            onTap: (){
                                              cont.callUpdateTaskStatus(context,item.id!,item.taskId!,item.taskName!);
                                            },
                                            child: buildButtonWidget(context, "Go",height: 40.0,width: 100.0),
                                          )),
                                        ],
                                      )

                                          : item.start == "0" && item.status=="1"
                                      ///start 0 and status 1
                                          ? Row(
                                        children: [
                                          Flexible(child:buildTextBoldWidget("Status", blackColor, context, 14.0)),
                                          const SizedBox(width: 10.0,),
                                          Flexible(
                                            child: GestureDetector(
                                              onTap: (){
                                                cont.startSelectedTask(item.id!);
                                              },
                                              child: buildButtonWidget(context, "Start",height: 35.0,width: 100.0),
                                            ),
                                          )
                                        ],
                                      )

                                          : Row(
                                        children: [
                                          Flexible(child:buildTextBoldWidget("Status", blackColor, context, 14.0)),
                                          const SizedBox(width: 10.0,),
                                          item.status == "6" ?
                                          buildTextRegularWidget(
                                              "Cancel",
                                              blackColor, context, 15.0,align: TextAlign.left)
                                              :
                                          Flexible(
                                            flex: 3,
                                            child: Container(
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
                                                            cont.addedRh1TaskStatus.contains(item.id)
                                                                ? cont.selectedTaskStatus == ""
                                                                      ? item.status == "1" ? "Inprocess" :
                                                                        item.status == "2" ? "Awaiting for Client Input" :
                                                                        item.status == "3" ? "Submitted for Checking" :
                                                                        item.status == "4" ? "Put On Hold" :
                                                                        item.status == "5" ? "Completed" :
                                                                        item.status == "6" ? "Cancel" :
                                                                        item.status == "7" ? "Sent for Rework" : "Select"

                                                                : cont.selectedTaskStatus
                                                            : item.status == "1" ? "Inprocess" :
                                                            item.status == "2" ? "Awaiting for Client Input" :
                                                            item.status == "3" ? "Submitted for Checking" :
                                                            item.status == "4" ? "Put On Hold" :
                                                            item.status == "5" ? "Completed" :
                                                            item.status == "6" ? "Cancel" :
                                                            item.status == "7" ? "Sent for Rework" : "Select",

                                                            blackColor, context, 15.0,align: TextAlign.left),
                                                        isExpanded: true,
                                                        underline: Container(),
                                                        items:
                                                        cont.rh1taskStatusList.map((String value) {
                                                          return DropdownMenuItem<String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                        onChanged: (val) {
                                                          cont.updateRh1TaskStatus(val!,item.id!,context,item.taskId!,item.taskName!);
                                                        },
                                                      ),
                                                    )
                                                )
                                            ),
                                          ),
                                          const SizedBox(width: 10.0,),
                                          item.status == "6" ? const Opacity(opacity: 0.0) :
                                          Flexible(child: GestureDetector(
                                            onTap: (){
                                              cont.callUpdateTaskStatus(context,item.id!,item.taskId!,item.taskName!);
                                            },
                                            child: buildButtonWidget(context, "Go",height: 40.0,width: 100.0),
                                          )),
                                        ],
                                      )
                                    )
                                    : cont.roleId == "5" && cont.reportingHead == "1"

                                    ? cont.idInEmp.contains(item.taskEmp)
                                        ?  item.start == "0" && item.status == "1"
                                            ? Row(
                                      children: [
                                        Flexible(child:buildTextBoldWidget("Status", blackColor, context, 14.0)),
                                        const SizedBox(width: 10.0,),
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: (){
                                              cont.startSelectedTask(item.id!);
                                            },
                                            child: buildButtonWidget(context, "Start",height: 35.0,width: 100.0),
                                          ),
                                        )
                                      ],
                                    )
                                            : Container(
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
                                                            cont.addedRh1TaskStatus.contains(item.id) ?
                                                            cont.selectedTaskStatus == ""
                                                                ?
                                                            item.status == "1" ? "Inprocess" :
                                                            item.status == "2" ? "Awaiting for Client Input" :
                                                            item.status == "3" ? "Submitted for Checking" :
                                                            item.status == "4" ? "Put On Hold" :
                                                            item.status == "5" ? "Completed" :
                                                            item.status == "6" ? "Cancel" :
                                                            item.status == "7" ? "Sent for Rework" :  "Select"
                                                                : cont.selectedTaskStatus
                                                                : item.status == "1" ? "Inprocess" :
                                                            item.status == "2" ? "Awaiting for Client Input" :
                                                            item.status == "3" ? "Submitted for Checking" :
                                                            item.status == "4" ? "Put On Hold" :
                                                            item.status == "5" ? "Completed" :
                                                            item.status == "6" ? "Cancel" :
                                                            item.status == "7" ? "Sent for Rework" : "Select",

                                                            blackColor, context, 15.0,align: TextAlign.left),
                                                        isExpanded: true,
                                                        underline: Container(),
                                                        items:
                                                        cont.rh1taskStatusList.map((String value) {
                                                          return DropdownMenuItem<String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                        onChanged: (val) {
                                                          cont.updateRh1TaskStatus(val!,item.id!,context,item.taskId!,item.taskName!);
                                                        },
                                                      ),
                                                    )
                                                )
                                            )

                                        :  buildRichTextWidget("Status - ", item.status == "1" ? "Inprocess" :
                                    item.status == "2" ? "Awaiting for Client Input" :
                                    item.status == "3" ? "Submitted for Checking" :
                                    item.status == "4" ? "Put On Hold" :
                                    item.status == "5" ? "Completed" :
                                    item.status == "6" ? "Cancel" :
                                    item.status == "7" ? "Sent for Rework" : "Yet to start",)


                                    ///other than manger,admin
                                        : cont.reportingHead == "1" && cont.roleId != "5" && cont.roleId != "6"
                                            ? item.taskEmp == cont.userId
                                                ? item.start == "1" && item.status=="1"
                                                    ? Row(
                                      children: [
                                        Flexible(child:buildTextBoldWidget("Status", blackColor, context, 14.0)),
                                        const SizedBox(width: 10.0,),
                                        item.status == "6" ?
                                        buildTextRegularWidget(
                                            "Cancel",
                                            blackColor, context, 15.0,align: TextAlign.left)
                                            :
                                        Flexible(
                                          flex: 3,
                                          child: Container(
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
                                                          cont.addedRh1TaskStatus.contains(item.id) ?
                                                          cont.selectedTaskStatus == ""
                                                              ?
                                                          item.status == "1" ? "Inprocess" :
                                                          item.status == "2" ? "Awaiting for Client Input" :
                                                          item.status == "3" ? "Submitted for Checking" :
                                                          item.status == "4" ? "Put On Hold" :
                                                          item.status == "5" ? "Completed" :
                                                          item.status == "6" ? "Cancel" :
                                                          item.status == "7" ? "Sent for Rework" :  "Select"
                                                              : cont.selectedTaskStatus
                                                              : item.status == "1" ? "Inprocess" :
                                                          item.status == "2" ? "Awaiting for Client Input" :
                                                          item.status == "3" ? "Submitted for Checking" :
                                                          item.status == "4" ? "Put On Hold" :
                                                          item.status == "5" ? "Completed" :
                                                          item.status == "6" ? "Cancel" :
                                                          item.status == "7" ? "Sent for Rework" : "Select",

                                                          blackColor, context, 15.0,align: TextAlign.left),
                                                      isExpanded: true,
                                                      underline: Container(),
                                                      items:
                                                      cont.rh1taskStatusList.map((String value) {
                                                        return DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                      onChanged: (val) {
                                                        cont.updateRh1TaskStatus(val!,item.id!,context,item.taskId!,item.taskName!);
                                                      },
                                                    ),
                                                  )
                                              )
                                          ),
                                        ),
                                        const SizedBox(width: 10.0,),
                                        item.status == "6" ? const Opacity(opacity: 0.0) :
                                        Flexible(child: GestureDetector(
                                          onTap: (){
                                            cont.callUpdateTaskStatus(context,item.id!,item.taskId!,item.taskName!);
                                          },
                                          child: buildButtonWidget(context, "Go",height: 40.0,width: 100.0),
                                        )),
                                      ],
                                    )
                                                    : item.start == "0" && item.status=="1"
                                                        ? Row(
                                      children: [
                                        Flexible(child:buildTextBoldWidget("Status", blackColor, context, 14.0)),
                                        const SizedBox(width: 10.0,),
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: (){
                                              cont.startSelectedTask(item.id!);
                                            },
                                            child: buildButtonWidget(context, "Start",height: 35.0,width: 100.0),
                                          ),
                                        )
                                      ],
                                    )
                                                        : buildRichTextWidget("Status - ", item.status == "1" ? "Inprocess" :
                                                          item.status == "2" ? "Awaiting for Client Input" :
                                                          item.status == "3" ? "Submitted for Checking" :
                                                          item.status == "4" ? "Put On Hold" :
                                                          item.status == "5" ? "Completed" :
                                                          item.status == "6" ? "Cancel" :
                                                          item.status == "7" ? "Sent for Rework" : "Yet to start",)
                                                    : buildRichTextWidget("Status - ", item.status == "1" ? "Inprocess" :
                                                      item.status == "2" ? "Awaiting for Client Input" :
                                                      item.status == "3" ? "Submitted for Checking" :
                                                      item.status == "4" ? "Put On Hold" :
                                                      item.status == "5" ? "Completed" :
                                                      item.status == "6" ? "Cancel" :
                                                      item.status == "7" ? "Sent for Rework" : "Yet to start",)
                                              : item.taskEmp == cont.userId
                                               ? Row(
                                      children: [
                                        buildTextRegularWidget("Status", blackColor, context, 14.0),
                                        const SizedBox(width:10.0),
                                        item.status == "6" ? buildTextRegularWidget(
                                            "Cancel",
                                            blackColor, context, 15.0,align: TextAlign.left) :
                                        Flexible(
                                          flex: 3,
                                          child: Container(
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
                                                          cont.addedRh1TaskStatus.contains(item.id) ?
                                                          cont.selectedTaskStatus == ""
                                                              ?  item.status == "1" ? "Inprocess" :
                                                          item.status == "2" ? "Awaiting for Client Input" :
                                                          item.status == "3" ? "Submitted for Checking" :
                                                          item.status == "4" ? "Put On Hold" :
                                                          item.status == "5" ? "Completed" :
                                                          item.status == "6" ? "Cancel" :
                                                          item.status == "7" ? "Sent for Rework" :  "Select"
                                                              : cont.selectedTaskStatus
                                                              : item.status == "1" ? "Inprocess" :
                                                          item.status == "2" ? "Awaiting for Client Input" :
                                                          item.status == "3" ? "Submitted for Checking" :
                                                          item.status == "4" ? "Put On Hold" :
                                                          item.status == "5" ? "Completed" :
                                                          item.status == "6" ? "Cancel" :
                                                          item.status == "7" ? "Sent for Rework" : "Select",

                                                          blackColor, context, 15.0,align: TextAlign.left),
                                                      isExpanded: true,
                                                      underline: Container(),
                                                      items:
                                                      cont.rh0taskStatusList.map((String value) {
                                                        return DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                      onChanged: (val) {
                                                        cont.updateRh0TaskStatus(val!,item.id!,context,item.taskId!,item.taskName!);
                                                      },
                                                    ),
                                                  )
                                              )
                                          ),
                                        ),
                                        const SizedBox(width:10.0),
                                        item.status == "6" ? const Opacity(opacity: 0.0) :
                                        Flexible(child: GestureDetector(
                                          onTap: (){
                                            cont.callUpdateTaskStatus(context,item.id!,item.taskId!,item.taskName!);
                                          },
                                          child: buildButtonWidget(context, "Go",height: 40.0,width: 100.0),
                                        )),
                                      ],
                                    )
                                         : buildRichTextWidget("Status - ",
                                                    item.status == "1" ? "Inprocess" :
                                                    item.status == "2" ? "Awaiting for Client Input" :
                                                    item.status == "3" ? "Submitted for Checking" :
                                                    item.status == "4" ? "Put On Hold" :
                                                    item.status == "5" ? "Completed" :
                                                    item.status == "6" ? "Cancel" :
                                                    item.status == "7" ? "Sent for Rework" : "Yet to start",
                                                    title1Weight: FontWeight.normal),
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
