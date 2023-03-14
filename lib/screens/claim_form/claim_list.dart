import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/claim_form/claim_form_controller.dart';
import 'package:biznew/screens/claim_form/claim_model.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ClaimList extends StatefulWidget {
  const ClaimList({Key? key}) : super(key: key);

  @override
  State<ClaimList> createState() => _ClaimListState();
}

class _ClaimListState extends State<ClaimList> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClaimFormController>(builder: (cont)
    {
    return WillPopScope(
        onWillPop: () async{
          return cont.onBackPress();
        },
    child:Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: buildTextMediumWidget("Claims", whiteColor,context, 16,align: TextAlign.center),
        leading: GestureDetector(
          onTap: (){cont.onBackPress();},
          child: const Icon(Icons.arrow_back_ios,color: whiteColor,),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              cont.navigateToExportScreen();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),
                  color: Colors.orange,),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                  child: Row(
                    children: [
                      buildTextBoldWidget("Export", whiteColor, context, 15.0),
                      const Icon(Icons.import_export,color: whiteColor,size: 25.0,),
                    ],
                  ),
                )
              ),
            )
          ),
          const SizedBox(width: 20.0,)
        ],
      ),
      body: cont.loader == true ? Center(child: buildCircularIndicator(),) :
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
                      buildTextRegularWidget("Select View Claim ", blackColor, context, 15.0),
                      Radio<int>(
                        value: 0,
                        groupValue: cont.selectedFlag,
                        activeColor: primaryColor,
                        onChanged: (int? value) {
                          cont.updateSelectedFlag(value!,context);
                        },
                      ),
                      buildTextRegularWidget("Own", blackColor, context, 15.0),
                      Radio<int>(
                        value: 1,
                        groupValue: cont.selectedFlag,
                        activeColor: primaryColor,
                        onChanged: (int? value) {
                          cont.updateSelectedFlag(value!,context);
                        },
                      ),
                      buildTextRegularWidget("Team", blackColor, context, 15.0),
                    ],
                  )),
              cont.selectedFlag == 0  ? const Opacity(opacity: 0.0) :
              Padding(
                padding: const EdgeInsets.only(right: 10.0,left: 10.0,bottom: 10.0),
                child: Container(
                    height: 40.0,width: MediaQuery.of(context).size.width,
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
                                cont.claimSubmittedByList.isEmpty
                              ? cont.noDataList.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList()
                             : cont.claimSubmittedByList.map((ClaimSubmittedByList value) {
                              return DropdownMenuItem<String>(
                                value: value.firmEmployeeName,
                                child: Text(value.firmEmployeeName!),
                              );
                            }).toList(),
                            onChanged: (val) {
                              cont.updateSelectedEmployee(val!);
                            },
                          ),
                        )
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0,left: 10.0,bottom: 10.0),
                child: Container(
                    height: 40.0,width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: grey),),
                    child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                          child: DropdownButton(
                            hint: buildTextRegularWidget(cont.selectedClaimStatus==""?"Select claim status":cont.selectedClaimStatus, blackColor, context, 15.0),
                            isExpanded: true,
                            underline: Container(),
                            items:
                            cont.claimStatusList.map((String claimStatus) {
                              return DropdownMenuItem<String>(
                                value: claimStatus,
                                child: Text(claimStatus),
                              );
                            }).toList(),
                            onChanged: (val) {
                              cont.updateSelectedClaimStatus(val!);
                            },
                          ),
                        )
                    )
                ),
              ),
              cont.claimClientList.isEmpty ? buildNoDataFound(context):
              ListView.builder(
                  shrinkWrap:true,
                  itemCount: cont.claimClientList.length,
                  physics:const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    return Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                      child:buildClaimList(cont.claimClientList[index],cont)
                    );
                  })
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10.0,left: 270.0,right: 20.0),
        child:  GestureDetector(
          onTap: (){Get.toNamed(AppRoutes.claimForm,arguments: ["add"]);},
          child: buildButtonWidget(context, "+ Add Claim",radius: 5.0,height: 40.0),
        ),
      ),
    )
    );
    });
  }

  Widget buildClaimList(ClaimClientListDetails item,ClaimFormController cont) {
    return Card(
      color:
      // item.claimStatus == "Pending" ? Colors.orange :
      // item.claimStatus == "Reject" ? Colors.red :
      // item.claimStatus == "Approved" ? Colors.green :
      faintGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
          side: const BorderSide(color: grey)),
      child: ExpansionTile(
        title:
        item.office=="0"
        ? buildTextRegularWidget("${item.firmEmployeeName!} submitted claim of Rs. ${item.claimAmount!} against ${item.firmClientFirmName!} on ${item.claimDate!}.",
            blackColor, context, 14.0,align: TextAlign.left)
        : buildTextRegularWidget("${item.firmEmployeeName!} submitted claim of Rs. ${item.claimAmount!} on ${item.claimDate!}.",
            blackColor, context, 14.0,align: TextAlign.left),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: const EdgeInsets.all(15.0),
        children: <Widget>[
          Table(
            children: [
              buildTableTitle(context,title1: "Bill Date",title2: "Billable",title3: "Status",fontSize: 14.0),
              buildContentSubTitle(context,contentTitle1: item.billDate!,contentTitle2: item.cliamBillable!,contentTitle3: item.claimStatus!,
                  fontSize: 14.0),
              const TableRow(children: [SizedBox(height: 10.0,),SizedBox(height: 10.0,),SizedBox(height: 10.0,)]),
            ],
          ),
          Table(
            children: [
              TableRow(
                  children:[
                    buildTextRegularWidget("Particulars", blackColor, context, 14.0)
                  ]
              ),
              TableRow(
                  children:[
                    buildTextBoldWidget(item.particulars!, blackColor, context, 14.0),
                  ]
              ),
            ],
          ),
          const SizedBox(height: 20.0,),
          Row(
            children: [
              cont.reportingHead == "0" ? const Opacity(opacity: 0.0,):
              item.claimStatus == "Approved" ? const Opacity(opacity: 0.0,):
              Flexible(child: GestureDetector(
                onTap: (){
                  //cont.updateStatus("Reject",item.claimId!);
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
                              buildTextRegularWidget("Do you want to reject this claim?", blackColor, context, 20,align: TextAlign.left),
                              const SizedBox(height: 10.0,),
                              const Divider(color: primaryColor,),
                              const SizedBox(height: 10.0,),
                              buildTextRegularWidget("Add remark for rejection", blackColor, context, 16.0,align: TextAlign.left,),
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
                                      cont.updateStatus("Reject",item.claimId!,context);
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
                child: buildActionForClaim(editColor,Icons.clear),
              )),
              item.claimStatus == "Approved" ? const Opacity(opacity: 0.0,):
              const SizedBox(width: 5.0,),

              cont.reportingHead == "0" ? const Opacity(opacity: 0.0,):
              item.claimStatus == "Approved" ? const Opacity(opacity: 0.0,):
              Flexible(child: GestureDetector(
                  onTap: (){cont.updateStatus("Approved",item.claimId!,context);},
                  child:buildActionForClaim(approveColor,Icons.check)
              )),
              item.claimStatus == "Approved" ? const Opacity(opacity: 0.0,):
              const SizedBox(width: 5.0,),

              item.claimStatus == "Approved" ? const Opacity(opacity: 0.0,):
              Flexible(child: GestureDetector(onTap:(){
                cont.navigateToClaimEdit(item.claimId!,"form");
              },
                  child:buildActionForClaim(buttonColor,Icons.edit))),
              item.claimStatus == "Approved" ? const Opacity(opacity: 0.0,):
              const SizedBox(width: 5.0,),

              cont.reportingHead == "0" && item.claimStatus == "Approved" ? const Opacity(opacity: 0.0,):
              Flexible(child: GestureDetector(onTap:(){
                cont.updateStatus("Delete",item.claimId!,context);
              },
                  child:buildActionForClaim(errorColor,Icons.delete,))),
              cont.reportingHead == "0" && item.claimStatus == "Approved" ? const Opacity(opacity: 0.0,):
              const SizedBox(width: 5.0,),

              Flexible(child: GestureDetector(onTap:(){
                cont.navigateToClaimEdit(item.claimId!,"view");
              },
                  child:buildActionForClaim(primaryColor,Icons.visibility,))),
              const SizedBox(width: 5.0,),
            ],
          )
        ],
      ),
    );
  }
}
