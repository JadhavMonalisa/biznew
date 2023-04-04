import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/claim_form/claim_model.dart';
import 'package:biznew/screens/leave_form/leave_controller.dart';
import 'package:biznew/screens/leave_form/leave_model.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class LeaveList extends StatefulWidget {
  const LeaveList({Key? key}) : super(key: key);

  @override
  State<LeaveList> createState() => _LeaveListState();
}

class _LeaveListState extends State<LeaveList> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeaveController>(builder: (cont)
    {
      return WillPopScope(
          onWillPop: () async{
            return cont.onWillPopBack();
          },
          child:Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: buildTextMediumWidget("Leave", whiteColor,context, 16,align: TextAlign.center),
              leading: GestureDetector(
                onTap: (){cont.onWillPopBack();},
                child: const Icon(Icons.arrow_back_ios,color: whiteColor,),
              ),
            ),
            body:
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:const EdgeInsets.only(left: 12.0,right: 12.0,bottom: 5.0,top: 5.0),
                child: ListView(
                  physics:const AlwaysScrollableScrollPhysics(),shrinkWrap: true,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 5.0,left: 10.0),
                        child:Row(
                          children: [
                            buildTextRegularWidget("Select View Leave ", blackColor, context, 15.0),
                            Radio<int>(
                              value: 0,
                              groupValue: cont.selectedLeaveFlag,
                              activeColor: primaryColor,
                              onChanged: (int? value) {
                                cont.updateSelectedLeaveFlag(value!,context);
                              },
                            ),
                            buildTextRegularWidget("Own", blackColor, context, 15.0),
                            Radio<int>(
                              value: 1,
                              groupValue: cont.selectedLeaveFlag,
                              activeColor: primaryColor,
                              onChanged: (int? value) {
                                cont.updateSelectedLeaveFlag(value!,context);
                              },
                            ),
                            buildTextRegularWidget("Team", blackColor, context, 15.0),
                          ],
                        )),
                    cont.selectedLeaveFlag == 0  ? const Opacity(opacity: 0.0) :
                    Padding(
                      padding: EdgeInsets.only(right: 10.0,left: 10.0,bottom: 10.0),
                      // child: Container(
                      //     height: 40.0,width: MediaQuery.of(context).size.width,
                      //     decoration: BoxDecoration(
                      //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                      //       border: Border.all(color: grey),),
                      //     child: Center(
                      //         child: Padding(
                      //           padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                      //           child: DropdownButton(
                      //             hint: buildTextRegularWidget(cont.selectedEmployee==""?"Select employee":cont.selectedEmployee, blackColor, context, 15.0),
                      //             isExpanded: true,
                      //             underline: Container(),
                      //             items:
                      //             cont.employeeList.isEmpty
                      //                 ? cont.noDataList.map((value) {
                      //               return DropdownMenuItem<String>(
                      //                 value: value,
                      //                 child: Text(value),
                      //               );
                      //             }).toList()
                      //                 : cont.employeeList.map((ClaimSubmittedByList value) {
                      //               return DropdownMenuItem<String>(
                      //                 value: value.firmEmployeeName,
                      //                 child: Text(value.firmEmployeeName!),
                      //               );
                      //             }).toList(),
                      //             onChanged: (val) {
                      //               cont.updateSelectedEmployee(val!);
                      //             },
                      //           ),
                      //         )
                      //     )
                      // ),
                      ///2
                      child: MultiSelectDialogField<ClaimSubmittedByList>(
                        items: cont.items,
                        title: const Text("Employee"),
                        selectedColor: primaryColor,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: grey,),
                        ),
                        buttonIcon: const Icon(
                          Icons.person,
                          color: blackColor,size: 20.0,
                        ),
                        buttonText: buildTextRegularWidget("Select employee", blackColor, context, 15.0),
                        onConfirm: (results) {
                          cont.onSelectionForMultipleEmployee(results);
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          onTap: (value) {
                            cont.onDeleteMultipleEmployee(value);
                          },
                          icon: const Icon(Icons.clear,color: errorColor,),
                        ),
                      ),
                    ),
                    cont.selectedLeaveFlag == 0  ? const Opacity(opacity: 0.0) :
                    cont.selectedEmpList == null || cont.selectedEmpList.isEmpty
                        ? Container(
                        padding: const EdgeInsets.only(left:10),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "None employee selected",
                          style: TextStyle(color: Colors.black54),
                        ))
                        : const Opacity(opacity: 0.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0,left: 10.0,bottom: 10.0,),
                      child: Container(
                          height: 40.0,width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: grey),),
                          child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                child: DropdownButton(
                                  hint: buildTextRegularWidget(cont.selectedLeaveStatus==""?"Select leave status":cont.selectedLeaveStatus, blackColor, context, 15.0),
                                  isExpanded: true,
                                  underline: Container(),
                                  items:
                                  cont.leaveStatusList.map((String leaveStatus) {
                                    return DropdownMenuItem<String>(
                                      value: leaveStatus,
                                      child: Text(leaveStatus),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    cont.updateSelectedLeaveStatus(val!);
                                  },
                                ),
                              )
                          )
                      ),
                    ),

                    cont.loader == true ? Center(child: buildCircularIndicator(),) :
                    cont.leaveList.isEmpty ? buildNoDataFound(context):
                    ListView.builder(
                        shrinkWrap:true,
                        itemCount: cont.leaveList.length,
                        physics:const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                            child: buildLeaveList(cont.leaveList[index],cont),);
                        })
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 10.0,left: 270.0,right: 20.0),
              child:  GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoutes.leaveForm,arguments: ["add"]);
                },
                child: buildButtonWidget(context, "+ Add Leave",radius: 5.0,height: 40.0),
              ),
            ),
          )
      );
    });
  }

  Widget buildLeaveList(LeaveListData item,LeaveController cont) {
    return Card(
        // color: item.leaveStatus == "Pending" ? Colors.orange :
        // item.leaveStatus == "Rejected" ? Colors.red :
        // item.leaveStatus == "Approved" ? Colors.green : faintGrey,
        color: faintGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
        side: const BorderSide(color: grey)),
      child: ExpansionTile(
        // title: buildTextRegularWidget("${item.firmEmployeeName!} applied ${item.leaveType!} from ${item.startDateToShow!} to ${item.endDateToShow!}",
        //     blackColor, context, 14.0,align: TextAlign.left),
        title: buildRichTextWidget("${item.firmEmployeeName!} applied ${item.leaveType!} from ${item.startDateToShow!} to ${item.endDateToShow!} - ",
            item.leaveStatus!,title1Weight: FontWeight.normal,title2Weight: FontWeight.bold,
            title2Color: item.leaveStatus == "Pending" || item.leaveStatus == "Pending for approval" ? Colors.orange :
                         item.leaveStatus == "Rejected" || item.leaveStatus == "Deleted" ? Colors.red :
                         item.leaveStatus == "Approved" ? Colors.green : faintGrey,),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: const EdgeInsets.all(15.0),
        children: <Widget>[
          Table(
            children: [
              buildTableTwoByTwoTitle(context,title1: "Total Days",title2: "Total Leaves",fontSize: 14.0),
              buildContentTwoByTwoSubTitle(context,contentTitle1: item.totalDays!,contentTitle2: item.dayLeave!,fontSize: 14.0,),
              const TableRow(children: [SizedBox(height: 15.0,),SizedBox(height: 15.0,),],),
            ],
          ),
          buildRichTextWidget("Status - ", item.leaveStatus!,title1Weight: FontWeight.normal,title2Weight: FontWeight.bold,
          title2Color:   item.leaveStatus == "Pending" ? Colors.orange :
            item.leaveStatus == "Rejected" || item.leaveStatus == "Deleted" ? Colors.red : Colors.green,),
          const SizedBox(height: 10.0,),
          buildTextRegularWidget("Updated On", blackColor, context, 14.0),
          buildTextBoldWidget(item.modifiedOn!, blackColor, context, 14.0),
          const SizedBox(height: 15.0,),
          buildTextRegularWidget("Reason", blackColor, context, 14.0),
          buildTextBoldWidget(item.reason!, blackColor, context, 14.0),
          const SizedBox(height: 20.0,),
          Row(
            children: [
              //cont.reportingHead == "0" ? const Opacity(opacity: 0.0,):
              ///cancel
              item.leaveStatus == "Deleted" ? const Opacity(opacity: 0.0,):
              Flexible(child: GestureDetector(
                onTap: (){
                  showDialog(barrierDismissible: true,
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
                              buildTextRegularWidget("Do you want to cancel the leave?", blackColor, context, 20,align: TextAlign.left),
                              const SizedBox(height: 10.0,),
                              const Divider(color: primaryColor,),
                              buildTextRegularWidget("Applied from ${item.startDate} to ${item.endDate}", primaryColor, context, 14.0,align: TextAlign.left),
                              const Divider(color: primaryColor,),
                              const SizedBox(height: 10.0,),
                              buildTextRegularWidget("Add remark for cancellation", blackColor, context, 16.0,align: TextAlign.left,),
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
                                  },
                                ),
                              ),
                              const SizedBox(height: 20.0,),
                              Row(
                                children: [
                                  Flexible(child: GestureDetector(
                                    onTap: (){
                                      cont.updateStatus("Cancel",item.id!);
                                    },
                                    child: buildButtonWidget(context, "Yes",buttonColor:approveColor),
                                  )),
                                  const SizedBox(width:5.0),
                                  Flexible(child: GestureDetector(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: buildButtonWidget(context, "No",buttonColor: errorColor,),
                                  ))
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: buildActionForClaim(buttonColor,Icons.clear),
              )),
              //cont.reportingHead == "0" ? const Opacity(opacity: 0.0,):
              //item.leaveStatus == "Approved" || item.leaveStatus == "Deleted" ? const Opacity(opacity: 0.0,):
              const SizedBox(width: 5.0,),


              cont.reportingHead == "0" ? const Opacity(opacity: 0.0,):
              item.leaveStatus == "Pending for approval" ?
              Flexible(child: GestureDetector(
                  onTap: (){
                    cont.updateStatus("Approved",item.id!);
                  },
                  child:buildActionForClaim(approveColor,Icons.check)
              ))
              :const Opacity(opacity: 0.0,),

              item.leaveStatus == "Approved" || item.leaveStatus == "Deleted"? const Opacity(opacity: 0.0,):
              const SizedBox(width: 5.0,),

              //cont.reportingHead == "0" ? const Opacity(opacity: 0.0,):
              item.leaveStatus == "Approved" || item.leaveStatus == "Deleted"? const Opacity(opacity: 0.0,):
              Flexible(child: GestureDetector(onTap:(){
                cont.navigateToLeaveEdit(item.id!,"form");
              },
                  child:buildActionForClaim(editColor,Icons.edit))),
              //cont.reportingHead == "0" ? const Opacity(opacity: 0.0,):
              item.leaveStatus == "Approved" || item.leaveStatus == "Deleted"? const Opacity(opacity: 0.0,):
              const SizedBox(width: 5.0,),

              cont.reportingHead == "0" && item.leaveStatus == "Approved"? const Opacity(opacity: 0.0,):
              cont.reportingHead == "1" && item.leaveStatus == "Deleted" ? const Opacity(opacity: 0.0,):
              Flexible(child: GestureDetector(onTap:(){
                cont.updateStatus("Delete",item.id!);
              },
                  child:buildActionForClaim(errorColor,Icons.delete,))),
              const SizedBox(width: 5.0,),
              Flexible(child: GestureDetector(onTap:(){
                cont.navigateToLeaveEdit(item.id!,"view");
              },
                  child:buildActionForClaim(primaryColor,Icons.visibility,))),const SizedBox(width: 5.0,),
            ],
          )
        ],
      ),
    );
  }
}
