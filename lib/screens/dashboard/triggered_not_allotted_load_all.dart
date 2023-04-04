import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/claim_form/claim_model.dart';
import 'package:biznew/screens/dashboard/dashboard_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';

class TriggeredNotAllottedLoadAll extends StatefulWidget {
  const TriggeredNotAllottedLoadAll({Key? key}) : super(key: key);

  @override
  State<TriggeredNotAllottedLoadAll> createState() => _TriggeredNotAllottedLoadAllState();
}

class _TriggeredNotAllottedLoadAllState extends State<TriggeredNotAllottedLoadAll> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont)
    {
      return WillPopScope(
          onWillPop: () async{
            return await cont.navigateFromLoadAll();
          },
          child:Scaffold(
            appBar: AppBar(
              elevation: 0, backgroundColor: primaryColor, centerTitle: true,
              title: buildTextMediumWidget("Triggered Not Allotted", whiteColor,context, 16,align: TextAlign.center),
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
                            child:buildTextBoldWidget("${cont.selectedClientName} - ${cont.selectedServiceName}" , blackColor, context, 14.0,align: TextAlign.left),
                          ),
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 10.0,left: 20.0,top: 10.0),
                        child: Table(
                          children: [
                            TableRow(
                                children: [
                                  buildTextRegularWidget("Priority", blackColor, context, 14.0),
                                  Container(
                                      height: 30.0,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                                        border: Border.all(color: grey),),
                                      child: cont.reportingHead == "0"
                                          ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                          child: buildTextRegularWidget("Select", blackColor, context, 15.0,align: TextAlign.left),
                                        ),
                                      )
                                          :
                                      Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                            child: DropdownButton(
                                              hint: buildTextRegularWidget(cont.selectedCurrentPriority==""?"Select":cont.selectedCurrentPriority,
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
                                                cont.updatePriorityForTriggeredNotAllotted(val!);
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
                                              hint: buildTextRegularWidget(cont.selectedEmployee==""?"Select employee":cont.selectedEmployee, blackColor, context, 15.0),
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
                                                    cont.updateEmployeeFromTriggered(value.firmEmployeeName!,value.mastId!);
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
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 20.0),
                      child:
                      cont.triggeredNotAllottedLoadAll.isEmpty ? buildNoDataFound(context):
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cont.triggeredNotAllottedLoadAll.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context,index){
                            final item = cont.triggeredNotAllottedLoadAll[index];
                            return

                              Card(
                                elevation: 1.0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
                                    side: BorderSide(color: grey)),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     Container(
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                                            border: Border.all(color: grey),),
                                          child:
                                          cont.taskNameList.isEmpty ? null :
                                          TextFormField(
                                            controller: cont.taskNameList[index],
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
                                                    child:
                                                    cont.completionList.isEmpty ? null :
                                                    TextFormField(
                                                      controller: cont.completionList[index],
                                                      keyboardType: TextInputType.number,
                                                      textDirection: TextDirection.ltr,
                                                      onTap: () {
                                                      },
                                                      enabled: true,
                                                      style:const TextStyle(fontSize: 15.0),
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.all(10),
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
                                                buildTextRegularWidget("Days", blackColor, context, 14.0),
                                                Container(
                                                    height: 30.0,
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                      border: Border.all(color: grey),),
                                                    child:
                                                    cont.daysList.isEmpty ? null :
                                                    TextFormField(
                                                      controller: cont.daysList[index],
                                                      keyboardType: TextInputType.number,
                                                      textDirection: TextDirection.ltr,
                                                      onTap: () {

                                                      },
                                                      enabled: true,
                                                      style:const TextStyle(fontSize: 15.0),
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.all(10),
                                                        hintText: item.days!,
                                                        hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                                          color: blackColor, fontSize: 15,),),
                                                        border: InputBorder.none,
                                                      ),
                                                      onChanged: (value) {
                                                        //cont.addDays(index,value);
                                                      },
                                                    )
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
                                                buildTextRegularWidget("Hours", blackColor, context, 14.0),
                                                Container(
                                                    height: 30.0,
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                      border: Border.all(color: grey),),
                                                    child:
                                                    cont.hoursList.isEmpty ? null :
                                                    TextFormField(
                                                      controller: cont.hoursList[index],
                                                      keyboardType: TextInputType.number,
                                                      textDirection: TextDirection.ltr,
                                                      onTap: () {
                                                      },
                                                      enabled: true,
                                                      style:const TextStyle(fontSize: 15.0),
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.all(10),
                                                        hintText: item.hours!,
                                                        hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                                          color: blackColor, fontSize: 15,),),
                                                        border: InputBorder.none,
                                                      ),
                                                      onChanged: (value) {
                                                        //cont.addHours(index,value);
                                                      },
                                                    )
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
                                                buildTextRegularWidget("Minute", blackColor, context, 14.0),
                                                Container(
                                                    height: 30.0,
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                      border: Border.all(color: grey),),
                                                    child:
                                                    cont.minuteList.isEmpty ? null :
                                                    TextFormField(
                                                      controller: cont.minuteList[index],
                                                      keyboardType: TextInputType.number,
                                                      textAlign: TextAlign.left,
                                                      textDirection: TextDirection.ltr,
                                                      onTap: () {
                                                      },
                                                      enabled: true,
                                                      style:const TextStyle(fontSize: 15.0),
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.all(10),
                                                        hintText: item.minutes!,
                                                        hintStyle: GoogleFonts.rubik(textStyle: const TextStyle(
                                                          color: blackColor, fontSize: 15,),),
                                                        border: InputBorder.none,
                                                      ),
                                                      onChanged: (value) {
                                                       // cont.addMinutes(index,value);
                                                      },
                                                    )
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
                                                buildTextRegularWidget("Employee", blackColor, context, 14.0),
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
                                                                // cont.addedAssignedTo.contains(item.taskId) ?
                                                                // cont.selectedEmpFromDashboardNext==""?"":cont.selectedEmpFromDashboardNext : "",
                                                                // cont.triggerSelectedEmpList.isEmpty
                                                                //     ? "" : cont.triggerSelectedEmpList[index],
                                                                cont.addedAssignedTo.contains(item.taskId)
                                                                    ? cont.triggerSelectedEmpList[index]
                                                                    : "Select",
                                                                blackColor, context, 15.0),
                                                            isExpanded: true,
                                                            underline: Container(),
                                                            items:
                                                            cont.employeeList.map((ClaimSubmittedByList value) {
                                                              return DropdownMenuItem<String>(
                                                                value: value.firmEmployeeName,
                                                                child: Text(value.firmEmployeeName!),
                                                                onTap: (){
                                                                  cont.updateAssignedTo(index,value.firmEmployeeName!,value.firmEmployeeId!,item.taskId!);
                                                                },
                                                              );
                                                            }).toList(),
                                                            onChanged: (val) {
                                                             // cont.updateAssignedTo(index,val!,item.taskId!);
                                                            },
                                                          ),
                                                        )
                                                    )
                                                ),
                                              ]
                                          ),
                                          const TableRow(
                                              children: [
                                                SizedBox(height: 10.0,),
                                                SizedBox(height: 10.0,),
                                              ]
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10.0,),

                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                        child: Row(                                         
                                          children: [
                                            Flexible(
                                              child: GestureDetector(
                                                onTap: (){
                                                  //showInprocessDialog(context);
                                                  cont.checkAllAddedValues(index);
                                                },
                                                child: buildButtonWidget(context, "Add",
                                                  height: 40.0,buttonColor: approveColor,buttonFontSize:14.0,),
                                              ),
                                            ),
                                            const SizedBox(width: 10.0,),
                                            Flexible(
                                              child: GestureDetector(
                                                onTap: (){
                                                  cont.removeFromSelectedTriggered(index,);
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
              height: 200.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 15.0),
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child:buildTextBoldWidget("Select period to apply", blackColor, context, 15.0),
                      ),
                      Row(
                        children: [
                          Radio<int>(
                            value: 0,
                            groupValue: cont.selectedPeriod,
                            activeColor: primaryColor,
                            onChanged: (int? value) {
                              cont.updateSelectedPeriod(value!,context);
                            },
                          ),
                          buildTextRegularWidget("Current period", blackColor, context, 15.0),
                          Row(
                            children: [
                              Radio<int>(
                                value: 1,
                                groupValue: cont.selectedPeriod,
                                activeColor: primaryColor,
                                onChanged: (int? value) {
                                  cont.updateSelectedPeriod(value!,context);
                                },
                              ),
                              buildTextRegularWidget("Next all periods", blackColor, context, 15.0),
                            ],
                          )
                        ],
                      ),
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
                              child: GestureDetector(
                                onTap: (){
                                  cont.saveTriggeredNotAllottedLoadAll();
                                  //showInprocessDialog(context);
                                },
                                child: buildButtonWidget(context, "Save",buttonColor: approveColor),
                              )
                          ),
                          const SizedBox(width: 10.0,),
                          Flexible(
                            child: GestureDetector(
                              onTap: (){
                                cont.addMoreForTriggeredNotAllotted(cont.triggeredNotAllottedLoadAll.length);
                                //showInprocessDialog(context);
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
