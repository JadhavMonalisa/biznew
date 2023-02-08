import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/screens/timesheet_form/timesheet_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimesheetDetailsScreen extends StatefulWidget {
  const TimesheetDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TimesheetDetailsScreen> createState() => _TimesheetDetailsScreenState();
}

class _TimesheetDetailsScreenState extends State<TimesheetDetailsScreen> {
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
                appBar: AppBar(
                  centerTitle: true,elevation: 0.0,
                  title: buildTextMediumWidget("Timesheet Details", whiteColor,context, 16,align: TextAlign.center),
                  leading: GestureDetector(
                    onTap: (){cont.onWillPopBackTimesheetList();},
                    child: const Icon(Icons.arrow_back_ios,color: whiteColor,),
                  ),
                ),
                body: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child:ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Card(
                                elevation: 1.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10.0,),
                                      buildTextBoldWidget(cont.viewTimesheet!.formattedDate!, primaryColor, context, 14.0),
                                      const Divider(color: primaryColor,),
                                      const SizedBox(height: 10.0,),
                                      Table(
                                        children: [
                                          buildTableTwoByTwoTitle(context,title1: "In Time",title2: "Out Time",fontSize: 14.0),
                                          buildContentTwoByTwoSubTitle(context,contentTitle1: cont.viewTimesheet!.inTime!,contentTitle2: cont.viewTimesheet!.outTime!,fontSize: 14.0),
                                          const TableRow(children: [SizedBox(height: 15.0,),SizedBox(height: 15.0,),],),
                                        ],
                                      ),
                                      buildTextRegularWidget("Work At", blackColor, context, 14.0),
                                      buildTextBoldWidget(cont.viewTimesheet!.workat!, blackColor, context, 14.0),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 1.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10.0,),
                                      buildTextBoldWidget("Non allotted", primaryColor, context, 14.0),
                                      const Divider(color: primaryColor,),
                                      const SizedBox(height: 10.0,),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: cont.viewNonAllottedTimesheet.length,
                                          itemBuilder: (context,index){
                                            final item = cont.viewNonAllottedTimesheet[index];
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                buildTextRegularWidget(item.client!, blackColor, context, 14.0),
                                                const SizedBox(height: 10.0,),
                                                buildRichTextWidget("Remark - ",item.remark!),
                                                const SizedBox(height: 10.0,),
                                                buildRichTextWidget("Filled type - ",item.filledType!),
                                                const SizedBox(height: 10.0,),
                                                buildRichTextWidget("Service - ",item.serviceName!),
                                                const SizedBox(height: 10.0,),
                                                buildRichTextWidget("Service periodicity - ",item.serviceDueDatePeriodicity!),
                                                const SizedBox(height: 10.0,),
                                                buildRichTextWidget("Period - ",item.period!),
                                                const SizedBox(height: 10.0,),
                                                buildRichTextWidget("Task - ",item.taskName!),
                                                const SizedBox(height: 10.0,),
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                              cont.viewOfficeRelatedTimesheet.isEmpty ? const Opacity(opacity: 0.0):
                              Card(
                                elevation: 1.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10.0,),
                                      buildTextBoldWidget("Office related", primaryColor, context, 14.0),
                                      const Divider(color: primaryColor,),
                                      const SizedBox(height: 10.0,),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: cont.viewOfficeRelatedTimesheet.length,
                                          itemBuilder: (context,index){
                                            final item = cont.viewOfficeRelatedTimesheet[index];
                                            return Table(
                                              children: [
                                                buildTableTwoByTwoTitle(context,title1: "Type",title2: "No of hours",fontSize: 14.0,),
                                                buildContentTwoByTwoSubTitle(context,contentTitle1: item.name!,contentTitle2: item.nohours!,fontSize: 14.0),
                                                const TableRow(children: [SizedBox(height: 10.0,),SizedBox(height: 10.0,),],),
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                )
                              )
                            ],
                          ),
                        ],
                      )
                    ),
                )
            )
        );
    });
  }
}
