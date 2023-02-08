import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/screens/claim_form/claim_form_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClaimDetailsScreen extends StatefulWidget {
  const ClaimDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ClaimDetailsScreen> createState() => _ClaimDetailsScreenState();
}

class _ClaimDetailsScreenState extends State<ClaimDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClaimFormController>(builder: (cont)
    {
      return WillPopScope(
          onWillPop: () async{
            return cont.onWillPopBack();
          },
          child:Scaffold(
              appBar: AppBar(
                centerTitle: true,elevation: 0.0,
                title: buildTextMediumWidget("Claim Details", whiteColor,context, 16,align: TextAlign.center),
                leading: GestureDetector(
                  onTap: (){cont.onWillPopBack();},
                  child: const Icon(Icons.arrow_back_ios,color: whiteColor,),
                ),
              ),
              body:
              cont.loader == true ? Center(child: buildCircularIndicator(),) :
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: cont.claimEditList.length,
                        itemBuilder: (context,index){
                         final item = cont.claimEditList[0];
                      return Card(
                        elevation: 1.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildTextBoldWidget(item.firmEmployeeName!, blackColor, context, 14.0),
                              const Divider(color: primaryColor,),
                              const SizedBox(height: 10.0,),
                              Table(
                                children: [
                                  buildTableTitle(context,title1: "Bill Date",title2: "Claim Date",fontSize: 14.0),
                                  buildContentSubTitle(context,contentTitle1: item.billDate!,contentTitle2: item.claimDate!,fontSize: 14.0),
                                  const TableRow(children: [SizedBox(height: 10.0,),SizedBox(height: 10.0,),SizedBox(height: 10.0,),],),

                                  buildTableTitle(context,title1: "Billable",title2: "Status",title3: "Amount",fontSize: 14.0),
                                  buildContentSubTitle(context,contentTitle1: item.cliamBillable!,contentTitle2: item.claimStatus!,contentTitle3: item.claimAmount!,fontSize: 14.0),
                                  const TableRow(children: [SizedBox(height: 10.0,),SizedBox(height: 10.0,),SizedBox(height: 10.0,),]),
                                ],
                              ),
                              const Divider(color: primaryColor,),
                              const SizedBox(height: 10.0,),
                              buildRichTextWidget("Nature of claim - ", item.name!),
                              const SizedBox(height: 10.0,),
                              buildRichTextWidget("Task name - ", item.taskName!),
                              const SizedBox(height: 10.0,),
                              buildRichTextWidget("Service name - ", item.serviceName!),
                              const SizedBox(height: 10.0,),
                              buildRichTextWidget("Client firm name - ", item.firmClientName!),
                              const SizedBox(height: 10.0,),
                              buildRichTextWidget("Employee name - ", item.firmEmployeeName!),
                              const SizedBox(height: 10.0,),
                              buildRichTextWidget("Year - ","${item.startYear!} - ${item.endYear!}"),
                              const Divider(color: primaryColor,),
                              const SizedBox(height: 10.0,),
                              buildTextBoldWidget("Particulars", blackColor, context, 14.0),
                              buildTextRegularWidget(item.particulars!, blackColor, context, 14.0),
                              const SizedBox(height: 10.0,),
                              item.claimFrom == "" || item.claimFrom == null ? const Opacity(opacity: 0.0):
                              buildRichTextWidget("Claim from - ", item.claimFrom!),
                              item.claimFrom == "" || item.claimFrom == null ? const Opacity(opacity: 0.0):
                              const SizedBox(height: 10.0,),

                              item.claimTo == "" || item.claimTo == null ? const Opacity(opacity: 0.0):
                              buildRichTextWidget("Claim to - ", item.claimTo!),
                              item.claimTo == "" || item.claimTo == null ? const Opacity(opacity: 0.0):
                              const SizedBox(height: 10.0,),

                              item.kms == "" || item.kms == null ? const Opacity(opacity: 0.0):
                              buildRichTextWidget("KMS - ", item.kms!),
                              const Divider(color: primaryColor,),
                              const SizedBox(height: 10.0,),
                              buildTextBoldWidget("Claim file", blackColor, context, 14.0),
                              const SizedBox(height: 10.0,),
                              Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: cont.validateClaimImage?errorColor:grey),),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        cont.openPdf();
                                       // Get.toNamed(AppRoutes.webViewScreen);
                                      },
                                      child: Container(
                                          height: 50.0,
                                          color:primaryColor,
                                          padding:const EdgeInsets.only(left: 10.0,right: 10.0),
                                          child: Center(child:buildTextRegularWidget("View", whiteColor, context, 15.0),)
                                      ),
                                    ),
                                    cont.claimFileName == "" ? const Opacity(opacity: 0.0) :
                                    Flexible(
                                      child: Container(
                                        padding:const EdgeInsets.only(left: 10.0,right: 10.0),
                                        child: buildTextRegularWidget(cont.claimFileName, blackColor, context, 15.0,maxLines: 2),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                ),
              )
          )
      );
    });
  }
}
