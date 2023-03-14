import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/dashboard/dashboard_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceDashboardNextScreen extends StatefulWidget {
  const ServiceDashboardNextScreen({Key? key}) : super(key: key);

  @override
  State<ServiceDashboardNextScreen> createState() => _ServiceDashboardNextScreenState();
}

class _ServiceDashboardNextScreenState extends State<ServiceDashboardNextScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont)
    {
      return WillPopScope(
          onWillPop: () async{
            return await cont.navigateToBottom();
          },
          child:Scaffold(
              appBar: AppBar(
                elevation: 0, backgroundColor: primaryColor, centerTitle: true,
                title: buildTextMediumWidget(
                  cont.selectedMainType == "AllottedNotStarted"? "Allotted but not started" :
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
                              child: SizedBox(
                                height: 40.0,
                                child: Center(
                                  child:buildTextBoldWidget("${cont.selectedType} ( ${cont.selectedCount} )" , blackColor, context, 14.0),
                                ),
                              )
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 10.0,left: 10.0,top: 5.0),
                          child: Card(
                              elevation: 1.0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
                                  side: const BorderSide(color: grey)),
                              child: SizedBox(
                                height: 40.0,width: MediaQuery.of(context).size.height,
                                child: Row(
                                  children: [
                                    Flexible(child: SizedBox(
                                      height: 40.0,
                                      child: Center(
                                          child: Padding
                                            (
                                            padding: const EdgeInsets.only(left: 5.0),
                                            child: TextFormField(
                                              controller: cont.searchController,
                                              keyboardType: TextInputType.text,
                                              textAlign: TextAlign.left,
                                              textAlignVertical: TextAlignVertical.center,
                                              textInputAction: TextInputAction.done,
                                              textCapitalization: TextCapitalization.sentences,
                                              onTap: () {
                                              },
                                              style:const TextStyle(fontSize: 15.0),
                                              decoration: InputDecoration(
                                                hintText: "Search by client name or service name",
                                                hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                                  color: blackColor, fontSize: 15,),),
                                                border: InputBorder.none,
                                              ),
                                              onChanged: (text) {
                                              },
                                            ),
                                          )
                                      ),
                                    )),
                                    const Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5.0,right: 5.0),
                                        child: Icon(Icons.search,color: primaryColor,),
                                      ),
                                    )
                                  ],
                                ),
                              )
                          )
                      ),
                      const SizedBox(height: 10.0,),

                      ///completed but udin pending
                      cont.selectedMainType == "CompletedUdinPending" ?
                      cont.completedUdinPendingDataList.isEmpty ? Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child:buildTextBoldWidget("No data found", blackColor, context, 16.0,align: TextAlign.center)):
                      Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 20.0),
                          child:SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: cont.completedUdinPendingDataList.length,
                          itemBuilder: (context,index){
                            final item = cont.completedUdinPendingDataList[index];
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Card(
                                elevation: 1.0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
                                    side: const BorderSide(color: grey)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            height: 40.0,
                                            decoration: const BoxDecoration(color: primaryColor,
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0),)),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                                  child: buildTextBoldWidget(item.clientCode!, whiteColor, context, 14.0),
                                                )
                                            )
                                        ),
                                        Flexible(child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 40.0,
                                            decoration: BoxDecoration(border: Border.all(color: grey),
                                                borderRadius: const BorderRadius.only(topRight: Radius.circular(7.0))),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 10.0),
                                                  child: buildTextBoldWidget(item.client!, primaryColor, context, 14.0,align: TextAlign.left),
                                                )
                                            )
                                        ),)
                                      ],
                                    ),
                                    const SizedBox(height: 10.0,),
                                    Padding(
                                        padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            buildTextBoldWidget("Service - ", blackColor, context, 14.0),
                                            Flexible(child:buildTextRegularWidget("${item.servicename}", blackColor, context, 14.0,align: TextAlign.left)),
                                          ],
                                        )
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            buildTextBoldWidget("Assigned to - ", blackColor, context, 14.0),
                                            Flexible(
                                              child:buildTextRegularWidget("${item.allottedTo}", blackColor, context, 14.0,align: TextAlign.left),
                                            )
                                          ],
                                        )
                                    ),
                                    cont.reportingHead == "0" ? const Opacity(opacity: 0.0) :
                                    Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Flexible(
                                                child: GestureDetector(
                                                  onTap: (){cont.callStartService(item.id!);},
                                                  child: buildButtonWidget(context, "Start Service",height: 40.0,buttonColor: Colors.green,buttonFontSize:14.0),
                                                )),
                                            const SizedBox(width: 10.0,),
                                            Flexible(
                                              child: buildButtonWidget(context, "Reassign",height: 40.0,buttonColor: Colors.orange,buttonFontSize:14.0),
                                            ),
                                            const SizedBox(width: 10.0,),
                                            Flexible(
                                                child: GestureDetector(
                                                  onTap: (){
                                                    cont.selectedCliId = item.id!;
                                                    cont.showCheckPasswordOrReasonDialog("Cancel - ${item.servicename}",context);
                                                  },
                                                  child: buildButtonWidget(context, "Cancel",height: 40.0,buttonColor: errorColor,buttonFontSize:14.0),
                                                )  ),
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              ),
                            );
                          })))

                      ///completed but not billed
                          : cont.selectedMainType == "CompletedNotBilled"
                          ? cont.completedNotBilledDataList.isEmpty ? Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child:buildTextBoldWidget("No data found", blackColor, context, 16.0,align: TextAlign.center)):
                          Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 20.0),
                          child:SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                          child:ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: cont.completedNotBilledDataList.length,
                              itemBuilder: (context,index){
                                final item = cont.completedNotBilledDataList[index];
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                                    elevation: 1.0,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
                                        side: const BorderSide(color: grey)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                height: 40.0,
                                                decoration: const BoxDecoration(color: primaryColor,
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0),)),
                                                child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                                      child: buildTextBoldWidget(item.clientCode!, whiteColor, context, 14.0),
                                                    )
                                                )
                                            ),
                                            Flexible(child: Container(
                                                width: MediaQuery.of(context).size.width,
                                                height: 40.0,
                                                decoration: BoxDecoration(border: Border.all(color: grey),
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(7.0))),
                                                child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 10.0),
                                                      child: buildTextBoldWidget(item.client!, primaryColor, context, 14.0,align: TextAlign.left),
                                                    )
                                                )
                                            ),)
                                          ],
                                        ),
                                        const SizedBox(height: 10.0,),
                                        Padding(
                                            padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                buildTextBoldWidget("Service - ", blackColor, context, 14.0),
                                                Flexible(child:buildTextRegularWidget("${item.servicename}", blackColor, context, 14.0,align: TextAlign.left)),
                                              ],
                                            )
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                            child: Row(
                                              children: [
                                                buildTextBoldWidget("Claim amount - ", blackColor, context, 14.0),
                                                buildTextRegularWidget("Rs. ${item.claimAmount}", blackColor, context, 14.0),
                                              ],
                                            )
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                            child: Row(
                                              children: [
                                                buildTextBoldWidget("Amount of service period - ", blackColor, context, 14.0),
                                                buildTextRegularWidget(item.amountOfServicePeriod!, blackColor, context, 14.0),
                                              ],
                                            )
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                // Flexible(
                                                //     child: GestureDetector(
                                                //       onTap: (){cont.callStartService(item.id!);},
                                                //       child: buildButtonWidget(context, "Start Service",height: 40.0,buttonColor: Colors.green,buttonFontSize:14.0),
                                                //     )),
                                                // const SizedBox(width: 10.0,),
                                                // Flexible(
                                                //   child: buildButtonWidget(context, "Reassign",height: 40.0,buttonColor: Colors.orange,buttonFontSize:14.0),
                                                // ),
                                                // const SizedBox(width: 10.0,),
                                                Flexible(
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        cont.selectedCliId = item.id!;
                                                        cont.showCheckPasswordOrReasonDialog("Cancel - ${item.servicename}",context);
                                                      },
                                                      child: buildButtonWidget(context, "Cancel",height: 40.0,buttonColor: errorColor,buttonFontSize:14.0),
                                                    )  ),
                                              ],
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                        )
                      )

                      ///submitted for checking
                          : cont.selectedMainType == "SubmittedForChecking"
                          ?  cont.submittedForCheckingPieDataList.isEmpty ? Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child:buildTextBoldWidget("No data found", blackColor, context, 16.0,align: TextAlign.center)):
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child:Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cont.submittedForCheckingPieDataList.length,
                              itemBuilder: (context,index){
                                final item = cont.submittedForCheckingPieDataList[index];
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                                    elevation: 1.0,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
                                        side: const BorderSide(color: grey)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                height: 40.0,
                                                decoration: const BoxDecoration(color: primaryColor,
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0),)),
                                                child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                                      child: buildTextBoldWidget(item.clientCode!, whiteColor, context, 14.0),
                                                    )
                                                )
                                            ),
                                            Flexible(child: Container(
                                                width: MediaQuery.of(context).size.width,
                                                height: 40.0,
                                                decoration: BoxDecoration(border: Border.all(color: grey),
                                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(7.0))),
                                                child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 10.0),
                                                      child: buildTextBoldWidget(item.client!, primaryColor, context, 14.0,align: TextAlign.left),
                                                    )
                                                )
                                            ),)
                                          ],
                                        ),
                                        const SizedBox(height: 10.0,),
                                        Padding(
                                            padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                buildTextBoldWidget("Service - ", blackColor, context, 14.0),
                                                Flexible(child:buildTextRegularWidget("${item.servicename}", blackColor, context, 14.0,align: TextAlign.left)),
                                              ],
                                            )
                                        ),
                                        ///priority
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                                          child: Row(
                                            children: [
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
                                                                cont.addedPriorityListForCurrent.contains(item.id) ?
                                                                cont.selectedCurrentPriority==""?item.priorityToShow!:cont.selectedCurrentPriority : item.priorityToShow!,
                                                                blackColor, context, 15.0),
                                                            isExpanded: true,
                                                            underline: Container(),
                                                            items:
                                                            cont.priorityList.map((String value) {
                                                              return DropdownMenuItem<String>(
                                                                value: value,
                                                                child: Text(value),
                                                              );
                                                            }).toList(),
                                                            onChanged: (val) {
                                                              cont.updatePriorityForCurrent(val!,item.id!);
                                                            },
                                                          ),
                                                        )
                                                    )
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                buildTextBoldWidget("Assigned to - ", blackColor, context, 14.0),
                                                Flexible(
                                                  child:buildTextRegularWidget("${item.allottedTo}", blackColor, context, 14.0,align: TextAlign.left),
                                                )
                                              ],
                                            )
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                          child: Table(
                                            children: [
                                              buildTableTwoByTwoTitle(context,title1: "Trigger Date",title2: "Target Date",fontSize: 14.0,
                                                  title1FW: FontWeight.bold,title2FW: FontWeight.bold),
                                              buildContentTwoByTwoSubTitle(context,contentTitle1: item.triggerDate!,contentTitle2: item.targetDate!,fontSize: 14.0,
                                                  title1FW: FontWeight.normal,title2FW: FontWeight.normal),
                                              const TableRow(children: [SizedBox(height: 15.0,),SizedBox(height: 15.0,),],),
                                            ],
                                          ),
                                        ),
                                        ///task,completion
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                                          child: Table(
                                            children: [
                                              TableRow(
                                                  children: [
                                                    buildTextBoldWidget("Task", blackColor, context, 14.0),
                                                    buildTextBoldWidget("Completion", blackColor, context, 14.0),
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    buildTextRegularWidget(item.tasks!, blackColor, context, 14.0),
                                                    buildTextRegularWidget(item.completionPercentage!.toString(), blackColor, context, 14.0),
                                                  ]
                                              ),
                                            ],
                                          ),
                                        ),
                                        ///status
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                                          child: Row(
                                            children: [
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
                                                                cont.addedStatusListForCurrent.contains(item.id) ?
                                                                cont.selectedServiceStatus==""?item.statusName!:cont.selectedServiceStatus : item.statusName!,
                                                                blackColor, context, 15.0),
                                                            isExpanded: true,
                                                            underline: Container(),
                                                            items:
                                                            cont.changeStatusList.map((String value) {
                                                              return DropdownMenuItem<String>(
                                                                value: value,
                                                                child: Text(value),
                                                              );
                                                            }).toList(),
                                                            onChanged: (val) {
                                                              cont.updateStatusForCurrent(val!,item.id!,context);
                                                            },
                                                          ),
                                                        )
                                                    )
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                Flexible(
                                                    child: GestureDetector(
                                                      onTap: (){cont.callStartService(item.id!);},
                                                      child: buildButtonWidget(context, "Start Service",height: 40.0,buttonColor: Colors.green,buttonFontSize:14.0),
                                                    )),
                                                const SizedBox(width: 10.0,),
                                                Flexible(
                                                  child: buildButtonWidget(context, "Reassign",height: 40.0,buttonColor: Colors.orange,buttonFontSize:14.0),
                                                ),
                                                const SizedBox(width: 10.0,),
                                                Flexible(
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        cont.selectedCliId = item.id!;
                                                        cont.showCheckPasswordOrReasonDialog("Cancel - ${item.servicename}",context);
                                                      },
                                                      child: buildButtonWidget(context, "Cancel",height: 40.0,buttonColor: errorColor,buttonFontSize:14.0),
                                                    )  ),
                                              ],
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                        ),
                      )

                      ///work on hold
                          : cont.selectedMainType == "WorkOnHold"
                          ? cont.workOnHoldPieDataList.isEmpty ? Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child:buildTextBoldWidget("No data found", blackColor, context, 16.0,align: TextAlign.center)):
                      Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 20.0),
                          child:SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child:ListView.builder(
                                  shrinkWrap: true,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  itemCount: cont.workOnHoldPieDataList.length,
                                  itemBuilder: (context,index){
                                    final item = cont.workOnHoldPieDataList[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                        elevation: 1.0,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
                                            side: const BorderSide(color: grey)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    height: 40.0,
                                                    decoration: const BoxDecoration(color: primaryColor,
                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0),)),
                                                    child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                                          child: buildTextBoldWidget(item.clientCode!, whiteColor, context, 14.0),
                                                        )
                                                    )
                                                ),
                                                Flexible(child: Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 40.0,
                                                    decoration: BoxDecoration(border: Border.all(color: grey),
                                                        borderRadius: const BorderRadius.only(topRight: Radius.circular(7.0))),
                                                    child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 10.0),
                                                          child: buildTextBoldWidget(item.client!, primaryColor, context, 14.0,align: TextAlign.left),
                                                        )
                                                    )
                                                ),)
                                              ],
                                            ),
                                            const SizedBox(height: 10.0,),
                                            Padding(
                                                padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    buildTextBoldWidget("Service - ", blackColor, context, 14.0),
                                                    Flexible(child:buildTextRegularWidget("${item.servicename}", blackColor, context, 14.0,align: TextAlign.left)),
                                                  ],
                                                )
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    buildTextBoldWidget("Assigned to - ", blackColor, context, 14.0),
                                                    Flexible(
                                                      child:buildTextRegularWidget("${item.allottedTo}", blackColor, context, 14.0,align: TextAlign.left),
                                                    )
                                                  ],
                                                )
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                              child: Table(
                                                children: [
                                                  buildTableTwoByTwoTitle(context,title1: "Trigger Date",title2: "Target Date",fontSize: 14.0,
                                                      title1FW: FontWeight.bold,title2FW: FontWeight.bold),
                                                  buildContentTwoByTwoSubTitle(context,contentTitle1: item.triggerDate!,contentTitle2: item.targetDate!,fontSize: 14.0,
                                                      title1FW: FontWeight.normal,title2FW: FontWeight.normal),
                                                  const TableRow(children: [SizedBox(height: 15.0,),SizedBox(height: 15.0,),],),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Row(
                                                  children: [
                                                    // Flexible(
                                                    //     child: GestureDetector(
                                                    //       onTap: (){cont.callStartService(item.id!);},
                                                    //       child: buildButtonWidget(context, "Start Service",height: 40.0,buttonColor: Colors.green,buttonFontSize:14.0),
                                                    //     )),
                                                    // const SizedBox(width: 10.0,),
                                                    // Flexible(
                                                    //   child: buildButtonWidget(context, "Reassign",height: 40.0,buttonColor: Colors.orange,buttonFontSize:14.0),
                                                    // ),
                                                    // const SizedBox(width: 10.0,),
                                                    Flexible(
                                                        child: GestureDetector(
                                                          onTap: (){
                                                            cont.selectedCliId = item.id!;
                                                            cont.showCheckPasswordOrReasonDialog("Cancel - ${item.servicename}",context);
                                                          },
                                                          child: buildButtonWidget(context, "Cancel",height: 40.0,buttonColor: errorColor,buttonFontSize:14.0),
                                                        )  ),
                                                  ],
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                          )
                      )

                      ///all tasks
                          : cont.selectedMainType == "AllTasks"
                          ? cont.allTasksDataList.isEmpty ? Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child:buildTextBoldWidget("No data found", blackColor, context, 16.0,align: TextAlign.center)):
                      Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 20.0),
                          child:SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child:ListView.builder(
                                  shrinkWrap: true,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  itemCount: cont.allTasksDataList.length,
                                  itemBuilder: (context,index){
                                    final item = cont.allTasksDataList[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                        elevation: 1.0,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
                                            side: const BorderSide(color: grey)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    height: 40.0,
                                                    decoration: const BoxDecoration(color: primaryColor,
                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0),)),
                                                    child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                                          child: buildTextBoldWidget(item.clientCode!, whiteColor, context, 14.0),
                                                        )
                                                    )
                                                ),
                                                Flexible(child: Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 40.0,
                                                    decoration: BoxDecoration(border: Border.all(color: grey),
                                                        borderRadius: const BorderRadius.only(topRight: Radius.circular(7.0))),
                                                    child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 10.0),
                                                          child: buildTextBoldWidget(item.client!, primaryColor, context, 14.0,align: TextAlign.left),
                                                        )
                                                    )
                                                ),)
                                              ],
                                            ),
                                            const SizedBox(height: 10.0,),
                                            Padding(
                                                padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    buildTextBoldWidget("Service - ", blackColor, context, 14.0),
                                                    Flexible(child:buildTextRegularWidget("${item.servicename}", blackColor, context, 14.0,align: TextAlign.left)),
                                                  ],
                                                )
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    buildTextBoldWidget("Assigned to - ", blackColor, context, 14.0),
                                                    Flexible(
                                                      child:buildTextRegularWidget("${item.allottedTo}", blackColor, context, 14.0,align: TextAlign.left),
                                                    )
                                                  ],
                                                )
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                              child: Table(
                                                children: [
                                                  buildTableTwoByTwoTitle(context,title1: "Trigger Date",title2: "Target Date",fontSize: 14.0,
                                                      title1FW: FontWeight.bold,title2FW: FontWeight.bold),
                                                  buildContentTwoByTwoSubTitle(context,contentTitle1: item.triggerDate!,contentTitle2: item.targetDate!,fontSize: 14.0,
                                                      title1FW: FontWeight.normal,title2FW: FontWeight.normal),
                                                  const TableRow(children: [SizedBox(height: 15.0,),SizedBox(height: 15.0,),],),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                        child: GestureDetector(
                                                          onTap: (){cont.callStartService(item.id!);},
                                                          child: buildButtonWidget(context, "Start Service",height: 40.0,buttonColor: Colors.green,buttonFontSize:14.0),
                                                        )),
                                                    const SizedBox(width: 10.0,),
                                                    Flexible(
                                                      child: buildButtonWidget(context, "Reassign",height: 40.0,buttonColor: Colors.orange,buttonFontSize:14.0),
                                                    ),
                                                    const SizedBox(width: 10.0,),
                                                    Flexible(
                                                        child: GestureDetector(
                                                          onTap: (){
                                                            cont.selectedCliId = item.id!;
                                                            cont.showCheckPasswordOrReasonDialog("Cancel - ${item.servicename}",context);
                                                          },
                                                          child: buildButtonWidget(context, "Cancel",height: 40.0,buttonColor: errorColor,buttonFontSize:14.0),
                                                        )  ),
                                                  ],
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                          )
                      )

                      ///allotted not started,started not completed
                          : DefaultTabController(
                        length: 5,
                        child: Stack(
                        children: [

                          SizedBox(
                            height: 40,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    cont.onPasDueSelected();
                                  },
                                  child: buildTabTitle(context, cont.isPastDueSelected, "Past Due (${cont.selectedPastDue})",width: 3),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cont.onPortableOverdueSelected();
                                  },
                                  child: buildTabTitle(context, cont.isPortableOverdueSelected, "Probable Overdue (${cont.selectedProbable})",width: 2),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cont.onHighSelected();
                                  },
                                  child: buildTabTitle(context, cont.isHighSelected, "High (${cont.selectedHigh})",width: 3),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cont.onHMediumSelected();
                                  },
                                  child: buildTabTitle(context, cont.isMediumSelected, "Medium (${cont.selectedMedium})",width: 3),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cont.onLowSelected();
                                  },
                                  child: buildTabTitle(context, cont.isLowSelected, "Low (${cont.selectedLow})",width: 3),
                                ),
                              ],
                            ),
                          ),

                          cont.isPastDueSelected ? Padding(
                            padding: const EdgeInsets.only(top: 50.0,left: 10.0,right: 10.0,bottom: 20.0),
                            child:
                            SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child:
                                  cont.selectedMainType == "AllottedNotStarted" ?
                              ///allotted not started
                                  cont.loader ? buildCircularIndicator() :
                                  cont.allottedNotStartedPastDueList.isEmpty
                                      ? Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child:buildTextBoldWidget("No data found", blackColor, context,
                                      16.0,align: TextAlign.center))
                                      : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  itemCount: cont.allottedNotStartedPastDueList.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context,index){
                                    final item = cont.allottedNotStartedPastDueList[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                        elevation: 1.0,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
                                            side: const BorderSide(color: grey)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    height: 40.0,
                                                    decoration: const BoxDecoration(color: primaryColor,
                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0),)),
                                                    child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                                          child: buildTextBoldWidget(item.clientCode!, whiteColor, context, 14.0),
                                                        )
                                                    )
                                                ),
                                                Flexible(child: Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 40.0,
                                                    decoration: BoxDecoration(border: Border.all(color: grey),
                                                        borderRadius: const BorderRadius.only(topRight: Radius.circular(7.0))),
                                                    child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 10.0),
                                                          child: buildTextBoldWidget(item.client!, primaryColor, context, 14.0,align: TextAlign.left),
                                                        )
                                                    )
                                                ),)
                                              ],
                                            ),
                                            const SizedBox(height: 10.0,),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: RichText(
                                                text: TextSpan(
                                                  text: "${item.servicename} triggered on ${item.triggerDateToShow} and ending on ",
                                                  style: const TextStyle(fontWeight: FontWeight.w400,color: blackColor,fontSize: 16.0),
                                                  // recognizer: TapGestureRecognizer()..onTap = () {
                                                  //   cont.navigateToDetails(item.id!,item.client!,item.servicename!);
                                                  // },
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: "${
                                                            cont.addedDateListForCurrent.contains(item.id)
                                                                ? cont.selectedDateToShowForCurrent == "" ? item.targetDateToShow : cont.selectedDateToShowForCurrent
                                                                : item.targetDateToShow}",
                                                        style: TextStyle(fontWeight: FontWeight.w400,color: blackColor,fontSize: 16.0,
                                                            decoration:
                                                            cont.reportingHead == "0"
                                                                ? TextDecoration.none : TextDecoration.underline,
                                                            decorationThickness: 2.0),
                                                        recognizer: TapGestureRecognizer()..onTap = () {
                                                          if(cont.reportingHead == "1"){
                                                            cont.selectTargetDateForCurrent(context,item.id!,item.triggerDateTimeFormat!,item.targetDateTimeFormat!);
                                                          }
                                                        }
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                                              child: Row(
                                                children: [
                                                  // Flexible(
                                                  //   child: GestureDetector(
                                                  //     onTap: (){
                                                  //       cont.navigateToServiceView(item.id!,item.client!,item.servicename!);
                                                  //     },
                                                  //     child: Container(
                                                  //         height: 40.0,
                                                  //         width: MediaQuery.of(context).size.width,
                                                  //         decoration: BoxDecoration(
                                                  //           borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                  //           border: Border.all(color: grey),),
                                                  //         child: Center(
                                                  //             child: Padding(
                                                  //               padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                                  //               child: buildTextRegularWidget("item.status", blackColor, context, 15.0),
                                                  //             )
                                                  //         )
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  // const SizedBox(width: 10.0,),
                                                  Flexible(
                                                    child: Container(
                                                        height: 40.0,
                                                        width: MediaQuery.of(context).size.width,
                                                        decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                          border: Border.all(color: grey),),
                                                        child: cont.reportingHead == "0"
                                                            ? Align(
                                                          alignment: Alignment.centerLeft,
                                                              child: Padding(
                                                          padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                                          child: buildTextRegularWidget(item.priorityToShow!, blackColor, context, 15.0,align: TextAlign.left),
                                                          ),
                                                            )
                                                            : Center(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                                              child:
                                                              DropdownButton(
                                                                hint: buildTextRegularWidget(
                                                                    cont.addedPriorityListForCurrent.contains(item.id) ?
                                                                    cont.selectedCurrentPriority==""?item.priorityToShow!:cont.selectedCurrentPriority : item.priorityToShow!,
                                                                    blackColor, context, 15.0),
                                                                isExpanded: true,
                                                                underline: Container(),
                                                                items:
                                                                cont.priorityList.map((String value) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: value,
                                                                    child: Text(value),
                                                                  );
                                                                }).toList(),
                                                                onChanged: (val) {
                                                                  cont.updatePriorityForCurrent(val!,item.id!);
                                                                },
                                                              ),
                                                            )
                                                        )
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                                child: Row(
                                                  crossAxisAlignment : CrossAxisAlignment.start,
                                                  children: [
                                                    buildTextBoldWidget("Assigned to - ", blackColor, context, 14.0),
                                                    Flexible(child:buildTextRegularWidget("${item.allottedTo}", blackColor, context, 14.0,align: TextAlign.left),)
                                                  ],
                                                )
                                            ),
                                            ///trigger date,statutory due date
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                                              child: Table(
                                                children: [
                                                  TableRow(
                                                      children: [
                                                        buildTextBoldWidget("Trigger Date", blackColor, context, 14.0),
                                                        buildTextBoldWidget("Statutory Due Date", blackColor, context, 14.0),
                                                      ]
                                                  ),
                                                  TableRow(
                                                      children: [
                                                        buildTextRegularWidget(item.triggerDateToShow!, blackColor, context, 14.0),
                                                        buildTextRegularWidget(item.satDateToShow!.toString(), blackColor, context, 14.0),
                                                      ]
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Row(
                                                  children: [
                                                     Flexible(
                                                        child: GestureDetector(
                                                          onTap: (){cont.callStartService(item.id!);},
                                                          child: buildButtonWidget(context, "Start Service",height: 40.0,buttonColor: Colors.green,buttonFontSize:14.0),
                                                        )),

                                                    cont.reportingHead == "0" ? const Opacity(opacity: 0.0) :
                                                    const SizedBox(width: 10.0,),
                                                    cont.reportingHead == "0" ? const Opacity(opacity: 0.0) :
                                                    Flexible(
                                                        child: GestureDetector(
                                                          onTap: (){
                                                            cont.selectedCliId = item.id!;
                                                            cont.showCheckPasswordOrReasonDialog("Cancel - ${item.servicename}",context);
                                                          },
                                                          child: buildButtonWidget(context, "Cancel",height: 40.0,buttonColor: errorColor,buttonFontSize:14.0),
                                                        )  ),

                                                    cont.reportingHead == "0" ? const Opacity(opacity: 0.0) :
                                                    const SizedBox(width: 10.0,),
                                                    cont.reportingHead == "0" ? const Opacity(opacity: 0.0) :
                                                    Flexible(
                                                      child: GestureDetector(
                                                      onTap:(){cont.navigateToDetails(item.id!,item.client!,item.servicename!);},
                                                      child: buildButtonWidget(context, "Reassign",height: 40.0,buttonColor: Colors.orange,buttonFontSize:14.0),
                                                    )),
                                                  ],
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                             ///started not completed
                              :  cont.loader ? buildCircularIndicator() :
                                  cont.startedNotCompletedPastDueList.isEmpty ? Padding(
                                      padding: const EdgeInsets.only(top: 50.0),
                                      child:buildTextBoldWidget("No data found", blackColor, context, 16.0,align: TextAlign.center)):
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: const AlwaysScrollableScrollPhysics(),
                                      itemCount: cont.startedNotCompletedPastDueList.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context,index){
                                        final item = cont.startedNotCompletedPastDueList[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Card(
                                            elevation: 1.0,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
                                                side: const BorderSide(color: grey)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                        height: 40.0,
                                                        decoration: const BoxDecoration(color: primaryColor,
                                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0),)),
                                                        child: Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                                              child: buildTextBoldWidget(item.clientCode!, whiteColor, context, 14.0),
                                                            )
                                                        )
                                                    ),
                                                    Flexible(child: Container(
                                                        width: MediaQuery.of(context).size.width,
                                                        height: 40.0,
                                                        decoration: BoxDecoration(border: Border.all(color: grey),
                                                            borderRadius: const BorderRadius.only(topRight: Radius.circular(7.0))),
                                                        child: Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 10.0),
                                                              child: buildTextBoldWidget(item.client!, primaryColor, context, 14.0,align: TextAlign.left),
                                                            )
                                                        )
                                                    ),)
                                                  ],
                                                ),
                                                const SizedBox(height: 10.0,),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10.0),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      text: "${item.servicename} triggered on ${item.triggerDateToShow} and ending on ",
                                                      style: const TextStyle(fontWeight: FontWeight.w400,color: blackColor,fontSize: 16.0),
                                                      recognizer: TapGestureRecognizer()..onTap = () {
                                                        //cont.navigateToDetails(item.id!,item.client!,item.servicename!);
                                                      },
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: "${
                                                                cont.addedDateListForCurrent.contains(item.id)
                                                                    ? cont.selectedDateToShowForCurrent == "" ? item.targetDateToShow : cont.selectedDateToShowForCurrent
                                                                    : item.targetDateToShow}",
                                                            style: const TextStyle(fontWeight: FontWeight.w400,color: blackColor,fontSize: 16.0,
                                                                decoration: TextDecoration.underline,decorationThickness: 2.0),
                                                            recognizer: TapGestureRecognizer()..onTap = () {
                                                              //cont.selectTargetDateForCurrent(context,item.id!);
                                                            }
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                ///priority
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                                                  child: Row(
                                                    children: [
                                                      Flexible(
                                                        child: Container(
                                                            height: 40.0,
                                                            width: MediaQuery.of(context).size.width,
                                                            decoration: BoxDecoration(
                                                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                              border: Border.all(color: grey),),
                                                            child: cont.reportingHead == "0"
                                                                ? Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                                                child: buildTextRegularWidget(item.priorityToShow!, blackColor, context, 15.0,align: TextAlign.left),
                                                              ),
                                                            )
                                                                :
                                                            Center(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                                                  child: DropdownButton(
                                                                    hint: buildTextRegularWidget(
                                                                        cont.addedPriorityListForCurrent.contains(item.id) ?
                                                                        cont.selectedCurrentPriority==""?item.priorityToShow!:cont.selectedCurrentPriority : item.priorityToShow!,
                                                                        blackColor, context, 15.0),
                                                                    isExpanded: true,
                                                                    underline: Container(),
                                                                    items:
                                                                    cont.priorityList.map((String value) {
                                                                      return DropdownMenuItem<String>(
                                                                        value: value,
                                                                        child: Text(value),
                                                                      );
                                                                    }).toList(),
                                                                    onChanged: (val) {
                                                                      cont.updatePriorityForCurrent(val!,item.id!);
                                                                    },
                                                                  ),
                                                                )
                                                            )
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                ///assigned to
                                                Padding(
                                                    padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        buildTextBoldWidget("Assigned to - ", blackColor, context, 14.0),
                                                        Flexible(child:buildTextRegularWidget("${item.allottedTo}", blackColor, context, 14.0)),
                                                      ],
                                                    )
                                                ),
                                                ///trigger date,statutory due date
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                                                  child: Table(
                                                    children: [
                                                      TableRow(
                                                          children: [
                                                            buildTextBoldWidget("Trigger Date", blackColor, context, 14.0),
                                                            buildTextBoldWidget("Statutory Due Date", blackColor, context, 14.0),
                                                          ]
                                                      ),
                                                      TableRow(
                                                          children: [
                                                            buildTextRegularWidget(item.triggerDateToShow!, blackColor, context, 14.0),
                                                            buildTextRegularWidget(item.satDateToShow!.toString(), blackColor, context, 14.0),
                                                          ]
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                ///task,completion
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                                                  child: Table(
                                                    children: [
                                                      TableRow(
                                                          children: [
                                                            buildTextBoldWidget("Task", blackColor, context, 14.0),
                                                            buildTextBoldWidget("Completion", blackColor, context, 14.0),
                                                          ]
                                                      ),
                                                      TableRow(
                                                          children: [
                                                            buildTextRegularWidget(item.tasks!, blackColor, context, 14.0),
                                                            buildTextRegularWidget(item.completionPercentage!.toString(), blackColor, context, 14.0),
                                                          ]
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                ///status
                                                Padding(
                                                     padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                                                  child: Row(
                                                    children: [
                                                      Flexible(
                                                        child: Container(
                                                            height: 40.0,
                                                            width: MediaQuery.of(context).size.width,
                                                            decoration: BoxDecoration(
                                                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                              border: Border.all(color: grey),),
                                                            child: cont.reportingHead == "0"
                                                                ? Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                                                child: buildTextRegularWidget(item.statusName!, blackColor, context, 15.0,align: TextAlign.left),
                                                              ),
                                                            )
                                                                :
                                                            Center(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                                                  child: DropdownButton(
                                                                    hint: buildTextRegularWidget(
                                                                        cont.addedStatusListForCurrent.contains(item.id) ?
                                                                        cont.selectedServiceStatus==""?item.statusName!:cont.selectedServiceStatus : item.statusName!,
                                                                        blackColor, context, 15.0),
                                                                    isExpanded: true,
                                                                    underline: Container(),
                                                                    items:
                                                                    cont.changeStatusList.map((String value) {
                                                                      return DropdownMenuItem<String>(
                                                                        value: value,
                                                                        child: Text(value),
                                                                      );
                                                                    }).toList(),
                                                                    onChanged: (val) {
                                                                      cont.updateStatusForCurrent(val!,item.id!,context);
                                                                    },
                                                                  ),
                                                                )
                                                            )
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Row(
                                                      children: [
                                                        // Flexible(
                                                        //     child: GestureDetector(
                                                        //       onTap: (){cont.callStartService(item.id!);},
                                                        //       child: buildButtonWidget(context, "Start Service",height: 40.0,buttonColor: Colors.green,buttonFontSize:14.0),
                                                        //     )),
                                                        // const SizedBox(width: 10.0,),
                                                        Flexible(
                                                          child: GestureDetector(
                                                            onTap:(){
                                                              cont.navigateToServiceView(item.id!,item.client!,item.servicename!);
                                                            },
                                                            child:buildButtonWidget(context, "Log",height: 40.0,buttonColor: Colors.orange,buttonFontSize:14.0),
                                                          )  ),
                                                        const SizedBox(width: 10.0,),
                                                        Flexible(
                                                            child: GestureDetector(
                                                              onTap: (){
                                                                cont.selectedCliId = item.id!;
                                                                cont.showCheckPasswordOrReasonDialog("Cancel - ${item.servicename}",context);
                                                              },
                                                              child: buildButtonWidget(context, "Cancel",height: 40.0,buttonColor: errorColor,buttonFontSize:14.0),
                                                            )  ),
                                                      ],
                                                    )
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                            ),
                          )
                              : const Opacity(opacity: 0.0),

                          cont.isPortableOverdueSelected ? Padding(
                            padding: const EdgeInsets.only(top: 50.0,left: 10.0,right: 10.0,bottom: 20.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child:
                              cont.allottedNotStartedPastDueList.isEmpty ? Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child:buildTextBoldWidget("No data found", blackColor, context, 16.0,align: TextAlign.center)):
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  itemCount: cont.allottedNotStartedPastDueList.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context,index){
                                    final item = cont.allottedNotStartedPastDueList[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                        elevation: 1.0,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
                                            side: const BorderSide(color: grey)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    height: 40.0,
                                                    decoration: const BoxDecoration(color: primaryColor,
                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0),)),
                                                    child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                                          child: buildTextBoldWidget(item.clientCode!, whiteColor, context, 14.0),
                                                        )
                                                    )
                                                ),
                                                Flexible(child: Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 40.0,
                                                    decoration: BoxDecoration(border: Border.all(color: grey),
                                                        borderRadius: const BorderRadius.only(topRight: Radius.circular(7.0))),
                                                    child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 10.0),
                                                          child: buildTextBoldWidget(item.client!, primaryColor, context, 14.0,align: TextAlign.left),
                                                        )
                                                    )
                                                ),)
                                              ],
                                            ),
                                            const SizedBox(height: 10.0,),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: RichText(
                                                text: TextSpan(
                                                  text: "${item.servicename} triggered on ${item.triggerDateToShow} and ending on ",
                                                  style: const TextStyle(fontWeight: FontWeight.w400,color: blackColor,fontSize: 16.0),
                                                  recognizer: TapGestureRecognizer()..onTap = () {
                                                    cont.navigateToDetails(item.id!,item.client!,item.servicename!);
                                                  },
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: "${
                                                            cont.addedDateListForCurrent.contains(item.id)
                                                                ? cont.selectedDateToShowForCurrent == "" ? item.targetDateToShow : cont.selectedDateToShowForCurrent
                                                                : item.targetDateToShow}",
                                                        style: const TextStyle(fontWeight: FontWeight.w400,color: blackColor,fontSize: 16.0,
                                                            decoration: TextDecoration.underline,decorationThickness: 2.0),
                                                        recognizer: TapGestureRecognizer()..onTap = () {
                                                          cont.selectTargetDateForCurrent(context,item.id!,item.triggerDateTimeFormat!,item.targetDateTimeFormat!);
                                                        }
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                                              child: Row(
                                                children: [
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
                                                                    cont.addedPriorityListForCurrent.contains(item.id) ?
                                                                    cont.selectedCurrentPriority==""?item.priorityToShow!:cont.selectedCurrentPriority : item.priorityToShow!,
                                                                    blackColor, context, 15.0),
                                                                isExpanded: true,
                                                                underline: Container(),
                                                                items:
                                                                cont.priorityList.map((String value) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: value,
                                                                    child: Text(value),
                                                                  );
                                                                }).toList(),
                                                                onChanged: (val) {
                                                                  cont.updatePriorityForCurrent(val!,item.id!,);
                                                                },
                                                              ),
                                                            )
                                                        )
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    buildTextBoldWidget("Assigned to - ", blackColor, context, 14.0),
                                                    Flexible(
                                                      child:buildTextRegularWidget("${item.allottedTo}", blackColor, context, 14.0,align: TextAlign.left),
                                                    )
                                                      ],
                                                )
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Row(
                                                  children: [
                                                    // Flexible(
                                                    //     child: GestureDetector(
                                                    //       onTap: (){cont.callStartService(item.id!);},
                                                    //       child: buildButtonWidget(context, "Start Service",height: 40.0,buttonColor: Colors.green,buttonFontSize:14.0),
                                                    //     )),
                                                    // const SizedBox(width: 10.0,),
                                                    Flexible(
                                                      child: buildButtonWidget(context, "Reassign",height: 40.0,buttonColor: Colors.orange,buttonFontSize:14.0),
                                                    ),
                                                    const SizedBox(width: 10.0,),
                                                    Flexible(
                                                        child: GestureDetector(
                                                          onTap: (){
                                                            cont.selectedCliId = item.id!;
                                                            cont.showCheckPasswordOrReasonDialog("Cancel - ${item.servicename}",context);
                                                          },
                                                          child: buildButtonWidget(context, "Cancel",height: 40.0,buttonColor: errorColor,buttonFontSize:14.0),
                                                        )  ),
                                                  ],
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          )
                              : const Opacity(opacity: 0.0),

                          cont.isHighSelected ? Padding(
                            padding: const EdgeInsets.only(top: 50.0,left: 10.0,right: 10.0,bottom: 20.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child:
                              cont.allottedNotStartedPastDueList.isEmpty ? Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child:buildTextBoldWidget("No data found", blackColor, context, 16.0,align: TextAlign.center)):
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  itemCount: cont.allottedNotStartedPastDueList.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context,index){
                                    final item = cont.allottedNotStartedPastDueList[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                        elevation: 1.0,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
                                            side: const BorderSide(color: grey)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    height: 40.0,
                                                    decoration: const BoxDecoration(color: primaryColor,
                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0),)),
                                                    child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                                          child: buildTextBoldWidget(item.clientCode!, whiteColor, context, 14.0),
                                                        )
                                                    )
                                                ),
                                                Flexible(child: Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 40.0,
                                                    decoration: BoxDecoration(border: Border.all(color: grey),
                                                        borderRadius: const BorderRadius.only(topRight: Radius.circular(7.0))),
                                                    child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 10.0),
                                                          child: buildTextBoldWidget(item.client!, primaryColor, context, 14.0,align: TextAlign.left),
                                                        )
                                                    )
                                                ),)
                                              ],
                                            ),
                                            const SizedBox(height: 10.0,),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: RichText(
                                                text: TextSpan(
                                                  text: "${item.servicename} triggered on ${item.triggerDateToShow} and ending on ",
                                                  style: const TextStyle(fontWeight: FontWeight.w400,color: blackColor,fontSize: 16.0),
                                                  recognizer: TapGestureRecognizer()..onTap = () {
                                                    cont.navigateToDetails(item.id!,item.client!,item.servicename!);
                                                  },
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: "${
                                                            cont.addedDateListForCurrent.contains(item.id)
                                                                ? cont.selectedDateToShowForCurrent == "" ? item.targetDateToShow : cont.selectedDateToShowForCurrent
                                                                : item.targetDateToShow}",
                                                        style: const TextStyle(fontWeight: FontWeight.w400,color: blackColor,fontSize: 16.0,
                                                            decoration: TextDecoration.underline,decorationThickness: 2.0),
                                                        recognizer: TapGestureRecognizer()..onTap = () {
                                                          cont.selectTargetDateForCurrent(context,item.id!,item.triggerDateTimeFormat!,item.targetDateTimeFormat!);
                                                        }
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                                              child: Row(
                                                children: [
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
                                                                    cont.addedPriorityListForCurrent.contains(item.id) ?
                                                                    cont.selectedCurrentPriority==""?item.priorityToShow!:cont.selectedCurrentPriority : item.priorityToShow!,
                                                                    blackColor, context, 15.0),
                                                                isExpanded: true,
                                                                underline: Container(),
                                                                items:
                                                                cont.priorityList.map((String value) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: value,
                                                                    child: Text(value),
                                                                  );
                                                                }).toList(),
                                                                onChanged: (val) {
                                                                  cont.updatePriorityForCurrent(val!,item.id!);
                                                                },
                                                              ),
                                                            )
                                                        )
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    buildTextBoldWidget("Assigned to - ", blackColor, context, 14.0),
                                                    Flexible(
                                                      child:buildTextRegularWidget("${item.allottedTo}", blackColor, context, 14.0,align: TextAlign.left),
                                                    )
                                                  ],
                                                )
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Row(
                                                  children: [
                                                    // Flexible(
                                                    //     child: GestureDetector(
                                                    //       onTap: (){cont.callStartService(item.id!);},
                                                    //       child: buildButtonWidget(context, "Start Service",height: 40.0,buttonColor: Colors.green,buttonFontSize:14.0),
                                                    //     )),
                                                    // const SizedBox(width: 10.0,),
                                                    Flexible(
                                                      child: buildButtonWidget(context, "Reassign",height: 40.0,buttonColor: Colors.orange,buttonFontSize:14.0),
                                                    ),
                                                    const SizedBox(width: 10.0,),
                                                    Flexible(
                                                        child: GestureDetector(
                                                          onTap: (){
                                                            cont.selectedCliId = item.id!;
                                                            cont.showCheckPasswordOrReasonDialog("Cancel - ${item.servicename}",context);
                                                          },
                                                          child: buildButtonWidget(context, "Cancel",height: 40.0,buttonColor: errorColor,buttonFontSize:14.0),
                                                        )  ),
                                                  ],
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          )
                              : const Opacity(opacity: 0.0),

                          cont.isMediumSelected ? Padding(
                            padding: const EdgeInsets.only(top: 50.0,left: 10.0,right: 10.0,bottom: 20.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child:
                              cont.allottedNotStartedPastDueList.isEmpty ? Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child:buildTextBoldWidget("No data found", blackColor, context, 16.0,align: TextAlign.center)):
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  itemCount: cont.allottedNotStartedPastDueList.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context,index){
                                    final item = cont.allottedNotStartedPastDueList[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                        elevation: 1.0,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
                                            side: const BorderSide(color: grey)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    height: 40.0,
                                                    decoration: const BoxDecoration(color: primaryColor,
                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0),)),
                                                    child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                                          child: buildTextBoldWidget(item.clientCode!, whiteColor, context, 14.0),
                                                        )
                                                    )
                                                ),
                                                Flexible(child: Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 40.0,
                                                    decoration: BoxDecoration(border: Border.all(color: grey),
                                                        borderRadius: const BorderRadius.only(topRight: Radius.circular(7.0))),
                                                    child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 10.0),
                                                          child: buildTextBoldWidget(item.client!, primaryColor, context, 14.0,align: TextAlign.left),
                                                        )
                                                    )
                                                ),)
                                              ],
                                            ),
                                            const SizedBox(height: 10.0,),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: RichText(
                                                text: TextSpan(
                                                  text: "${item.servicename} triggered on ${item.triggerDateToShow} and ending on ",
                                                  style: const TextStyle(fontWeight: FontWeight.w400,color: blackColor,fontSize: 16.0),
                                                  recognizer: TapGestureRecognizer()..onTap = () {
                                                    cont.navigateToDetails(item.id!,item.client!,item.servicename!);
                                                  },
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: "${
                                                            cont.addedDateListForCurrent.contains(item.id)
                                                                ? cont.selectedDateToShowForCurrent == "" ? item.targetDateToShow : cont.selectedDateToShowForCurrent
                                                                : item.targetDateToShow}",
                                                        style: const TextStyle(fontWeight: FontWeight.w400,color: blackColor,fontSize: 16.0,
                                                            decoration: TextDecoration.underline,decorationThickness: 2.0),
                                                        recognizer: TapGestureRecognizer()..onTap = () {
                                                          cont.selectTargetDateForCurrent(context,item.id!,item.triggerDateTimeFormat!,item.targetDateTimeFormat!);
                                                        }
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                                              child: Row(
                                                children: [
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
                                                                    cont.addedPriorityListForCurrent.contains(item.id) ?
                                                                    cont.selectedCurrentPriority==""?item.priorityToShow!:cont.selectedCurrentPriority : item.priorityToShow!,
                                                                    blackColor, context, 15.0),
                                                                isExpanded: true,
                                                                underline: Container(),
                                                                items:
                                                                cont.priorityList.map((String value) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: value,
                                                                    child: Text(value),
                                                                  );
                                                                }).toList(),
                                                                onChanged: (val) {
                                                                  cont.updatePriorityForCurrent(val!,item.id!);
                                                                },
                                                              ),
                                                            )
                                                        )
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    buildTextBoldWidget("Assigned to - ", blackColor, context, 14.0),
                                                    Flexible(
                                                      child:buildTextRegularWidget("${item.allottedTo}", blackColor, context, 14.0,align: TextAlign.left),
                                                    )
                                                  ],
                                                )
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Row(
                                                  children: [
                                                    // Flexible(
                                                    //     child: GestureDetector(
                                                    //       onTap: (){cont.callStartService(item.id!);},
                                                    //       child: buildButtonWidget(context, "Start Service",height: 40.0,buttonColor: Colors.green,buttonFontSize:14.0),
                                                    //     )),
                                                    // const SizedBox(width: 10.0,),
                                                    Flexible(
                                                      child: buildButtonWidget(context, "Reassign",height: 40.0,buttonColor: Colors.orange,buttonFontSize:14.0),
                                                    ),
                                                    const SizedBox(width: 10.0,),
                                                    Flexible(
                                                        child: GestureDetector(
                                                          onTap: (){
                                                            cont.selectedCliId = item.id!;
                                                            cont.showCheckPasswordOrReasonDialog("Cancel - ${item.servicename}",context);
                                                          },
                                                          child: buildButtonWidget(context, "Cancel",height: 40.0,buttonColor: errorColor,buttonFontSize:14.0),
                                                        )  ),
                                                  ],
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          )
                              : const Opacity(opacity: 0.0),

                          cont.isLowSelected ? Padding(
                            padding: const EdgeInsets.only(top: 50.0,left: 10.0,right: 10.0,bottom: 20.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child:
                              cont.allottedNotStartedPastDueList.isEmpty ? Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child:buildTextBoldWidget("No data found", blackColor, context, 16.0,align: TextAlign.center)):
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  itemCount: cont.allottedNotStartedPastDueList.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context,index){
                                    final item = cont.allottedNotStartedPastDueList[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                        elevation: 1.0,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
                                            side: const BorderSide(color: grey)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    height: 40.0,
                                                    decoration: const BoxDecoration(color: primaryColor,
                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0),)),
                                                    child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                                          child: buildTextBoldWidget(item.clientCode!, whiteColor, context, 14.0),
                                                        )
                                                    )
                                                ),
                                                Flexible(child: Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 40.0,
                                                    decoration: BoxDecoration(border: Border.all(color: grey),
                                                        borderRadius: const BorderRadius.only(topRight: Radius.circular(7.0))),
                                                    child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 10.0),
                                                          child: buildTextBoldWidget(item.client!, primaryColor, context, 14.0,align: TextAlign.left),
                                                        )
                                                    )
                                                ),)
                                              ],
                                            ),
                                            const SizedBox(height: 10.0,),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: RichText(
                                                text: TextSpan(
                                                  text: "${item.servicename} triggered on ${item.triggerDateToShow} and ending on ",
                                                  style: const TextStyle(fontWeight: FontWeight.w400,color: blackColor,fontSize: 16.0),
                                                  recognizer: TapGestureRecognizer()..onTap = () {
                                                    cont.navigateToDetails(item.id!,item.client!,item.servicename!);
                                                  },
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: "${
                                                            cont.addedDateListForCurrent.contains(item.id)
                                                                ? cont.selectedDateToShowForCurrent == "" ? item.targetDateToShow : cont.selectedDateToShowForCurrent
                                                                : item.targetDateToShow}",
                                                        style: const TextStyle(fontWeight: FontWeight.w400,color: blackColor,fontSize: 16.0,
                                                            decoration: TextDecoration.underline,decorationThickness: 2.0),
                                                        recognizer: TapGestureRecognizer()..onTap = () {
                                                          cont.selectTargetDateForCurrent(context,item.id!,item.triggerDateTimeFormat!,item.targetDateTimeFormat!);
                                                        }
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                                              child: Row(
                                                children: [
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
                                                                    cont.addedPriorityListForCurrent.contains(item.id) ?
                                                                    cont.selectedCurrentPriority==""?item.priorityToShow!:cont.selectedCurrentPriority : item.priorityToShow!,
                                                                    blackColor, context, 15.0),
                                                                isExpanded: true,
                                                                underline: Container(),
                                                                items:
                                                                cont.priorityList.map((String value) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: value,
                                                                    child: Text(value),
                                                                  );
                                                                }).toList(),
                                                                onChanged: (val) {
                                                                  cont.updatePriorityForCurrent(val!,item.id!,);
                                                                },
                                                              ),
                                                            )
                                                        )
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    buildTextBoldWidget("Assigned to - ", blackColor, context, 14.0),
                                                    Flexible(
                                                      child:buildTextRegularWidget("${item.allottedTo}", blackColor, context, 14.0,align: TextAlign.left),
                                                    )
                                                  ],
                                                )
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Row(
                                                  children: [
                                                    // Flexible(
                                                    //     child: GestureDetector(
                                                    //       onTap: (){cont.callStartService(item.id!);},
                                                    //       child: buildButtonWidget(context, "Start Service",height: 40.0,buttonColor: Colors.green,buttonFontSize:14.0),
                                                    //     )),
                                                    // const SizedBox(width: 10.0,),
                                                    Flexible(
                                                      child: buildButtonWidget(context, "Reassign",height: 40.0,buttonColor: Colors.orange,buttonFontSize:14.0),
                                                    ),
                                                    const SizedBox(width: 10.0,),
                                                    Flexible(
                                                        child: GestureDetector(
                                                          onTap: (){
                                                            cont.selectedCliId = item.id!;
                                                            cont.showCheckPasswordOrReasonDialog("Cancel - ${item.servicename}",context);
                                                          },
                                                          child: buildButtonWidget(context, "Cancel",height: 40.0,buttonColor: errorColor,buttonFontSize:14.0),
                                                        )  ),
                                                  ],
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          )
                              : const Opacity(opacity: 0.0),
                        ],
                      )),
                      const SizedBox(height: 20.0,)
                    ],
                  )
              )
          )
      );
    });
  }
}
