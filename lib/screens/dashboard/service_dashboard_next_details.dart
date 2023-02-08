import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/dashboard/dashboard_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                title: buildTextMediumWidget("Allotted but not started Details", whiteColor,context, 16,align: TextAlign.center),
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
                                      const Divider(color: grey,),
                                      const SizedBox(height: 5.0,),
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
                                      buildRichTextWidget("Assigned to - ", item.firmEmployeeName!),
                                      const SizedBox(height: 10.0,),
                                      item.start=="0" && item.status=="1"

                                          ? buildRichTextWidget("Status - ","Yet to start")
                                          : Row(
                                        children: [
                                          Flexible(child: buildTextBoldWidget("Status - ", blackColor, context, 14.0),),
                                          Flexible(child: GestureDetector(
                                            onTap: (){
                                              cont.startSelectedTask(item.id!, item.taskId!);
                                            },
                                            child: buildButtonWidget(context, "Start",height: 35.0,width: 100.0),
                                          )),
                                        ],
                                      ),
                                      const SizedBox(height: 5.0,),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  )
              )
          ));
    });
  }
}
