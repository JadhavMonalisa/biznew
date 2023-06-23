import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/constant/strings.dart';
import 'package:biznew/screens/dashboard/employee/employee_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeDashboardScreen extends StatefulWidget {
  const EmployeeDashboardScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeDashboardScreen> createState() => _EmployeeDashboardScreenState();
}

class _EmployeeDashboardScreenState extends State<EmployeeDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmployeeDashboardController>(builder: (cont) {
      return WillPopScope(
          onWillPop: () async{
            return cont.onWillPopBack();
          },
          child:Scaffold(
              backgroundColor: whiteColor,
              appBar: AppBar(
                centerTitle: true,
                title: buildTextMediumWidget("Employee Dashboard", whiteColor,context, 16,align: TextAlign.center),
              ),
              drawer: Drawer(
                child: SizedBox(
                    height: double.infinity,
                    child: ListView(
                      physics:const NeverScrollableScrollPhysics(),
                      children: [
                        Center(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height/1.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildDrawer(context,cont.name),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0,left: 10.0,bottom: 50.0,right: 10.0),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          showEmployeeDashboardDialog(context,"Confirm Logout...!!!","Do you want to logout from an app?",logoutFeature:true,cont);
                                        },
                                        child: const Icon(Icons.logout),
                                      ),
                                      const SizedBox(width: 7.0,),
                                      GestureDetector(
                                          onTap:(){
                                            showEmployeeDashboardDialog(context,"Confirm Logout...!!!","Do you want to logout from an app?",logoutFeature:true,cont);
                                          },
                                          child:buildTextBoldWidget("Logout", blackColor, context, 15.0)
                                      ),const Spacer(),
                                      GestureDetector(
                                        onTap:(){
                                        },
                                        child: buildTextRegularWidget("App Version 1.0", grey, context, 14.0),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),
              body:
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                child:
                cont.loader == true ? Center(child: buildCircularIndicator(),) :
                cont.employeeDashboardListData.isEmpty ? buildNoDataFound(context):
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cont.employeeDashboardListData.length,
                      itemBuilder: (context,index){
                        final item = cont.employeeDashboardListData[index];
                        return Padding(padding: const EdgeInsets.only(left:5.0,right: 5.0),
                            child:Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
                                  side: const BorderSide(color: blackColor)),
                              child: ListTileTheme(
                                //data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                contentPadding: const EdgeInsets.all(0),
                                dense: true,
                                horizontalTitleGap: 0.0,
                                minVerticalPadding: 0.0,
                                minLeadingWidth: 0,
                                child: ExpansionTile(
                                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                  childrenPadding: const EdgeInsets.only(left:15.0,right:15.0),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Transform(
                                      transform: Matrix4.translationValues(0.0, -7.0, 0.0),
                                      child: Icon(
                                        cont.addedIndex.contains(index) ?
                                        Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                        size: 25.0,
                                      ),
                                    ),
                                  ),
                                  onExpansionChanged: (value){
                                    cont.onExpanded(value,index);
                                  },
                                  collapsedIconColor: primaryColor,
                                  // title:Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     const SizedBox(height: 15.0,),
                                  //     Row(
                                  //       children: [
                                  //         Container(
                                  //             height: 40.0,
                                  //             decoration: const BoxDecoration(color: primaryColor,
                                  //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0),)),
                                  //             child: Align(
                                  //                 alignment: Alignment.centerLeft,
                                  //                 child: Padding(
                                  //                   padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                  //                   child: buildTextBoldWidget("${Strings.rupees} ${item.pendingClaims!}", whiteColor, context, 14.0),
                                  //                 )
                                  //             )
                                  //         ),
                                  //         Flexible(child: SizedBox(
                                  //             width: MediaQuery.of(context).size.width,
                                  //             height: 40.0,
                                  //             child: Align(
                                  //                 alignment: Alignment.centerLeft,
                                  //                 child: Padding(
                                  //                   padding: const EdgeInsets.only(left: 10.0),
                                  //                   child: buildTextBoldWidget(item.employee!, primaryColor, context, 14.0,align: TextAlign.left),
                                  //                 )
                                  //             )
                                  //         ),)
                                  //       ],
                                  //     ),
                                  //     const SizedBox(height: 5.0,),
                                  //     Table(
                                  //       defaultVerticalAlignment: TableCellVerticalAlignment.top,
                                  //       defaultColumnWidth: FixedColumnWidth(MediaQuery.of(context).size.width/3.3),
                                  //       children: [
                                  //
                                  //         TableRow(
                                  //             children: [
                                  //               buildTextBoldWidget("Allotted but\nnot started", Colors.blue, context, 14.0,align: TextAlign.center),
                                  //               buildTextBoldWidget("Pastdue", const Color(0xFFffc000), context, 14.0,align: TextAlign.center),
                                  //               buildTextBoldWidget("Probable\nOverdue", Color(0xff0000FF), context, 14.0,align: TextAlign.center),
                                  //             ]
                                  //         ),
                                  //         TableRow(
                                  //             children: [
                                  //               buildTextBoldWidget(item.allottedCnt!, blackColor, context, 14.0,align: TextAlign.center),
                                  //               buildTextBoldWidget(item.pastdueCnt!, blackColor, context, 14.0,align: TextAlign.center),
                                  //               buildTextBoldWidget(item.probableCnt!, blackColor, context, 14.0,align: TextAlign.center),
                                  //             ]
                                  //         ),
                                  //         TableRow(
                                  //             children: [
                                  //               buildTextBoldWidget("High",  Color(0xffFF0000), context, 14.0,align: TextAlign.center),
                                  //               buildTextBoldWidget("Medium",Color(0xffF57C00), context, 14.0,align: TextAlign.center),
                                  //               buildTextBoldWidget("Low", Color(0xff008000), context, 14.0,align: TextAlign.center),
                                  //             ]
                                  //         ),
                                  //         TableRow(
                                  //             children: [
                                  //               buildTextBoldWidget(item.highCnt!, blackColor, context, 14.0,align: TextAlign.center),
                                  //               buildTextBoldWidget(item.mediumCnt!, blackColor, context, 14.0,align: TextAlign.center),
                                  //               buildTextBoldWidget(item.lowCnt!, blackColor, context, 14.0,align: TextAlign.center),
                                  //             ]
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),

                                  title: Column(
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
                                                        child: buildTextBoldWidget("${Strings.rupees} ${item.pendingClaims!}", whiteColor, context, 14.0),
                                                      )
                                                  )
                                              ),
                                              Flexible(child: Container(
                                                  //width: MediaQuery.of(context).size.width,
                                                  decoration: const BoxDecoration(
                                                      borderRadius: BorderRadius.only(topRight: Radius.circular(7.0))),
                                                  //height: 40.0,
                                                  child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 10.0),
                                                        child: buildTextBoldWidget(item.employee!, primaryColor, context, 14.0,align: TextAlign.left),
                                                      )
                                                  )
                                              ),)
                                            ],
                                          ),
                                      const SizedBox(height: 5.0,),
                                      Transform(
                                          transform: Matrix4.translationValues(15.0, 0.0, 0.0),
                                          child:Row(
                                            children: [
                                              buildTextRegularWidget("Total Services : ", blackColor, context, 15.0,align: TextAlign.left),
                                              buildTextBoldWidget(item.totalCnt!, blackColor, context, 15.0,align: TextAlign.left),
                                              const Spacer(),
                                              buildTextRegularWidget("Status : ", blackColor, context, 15.0,align: TextAlign.left),
                                              buildTextBoldWidget(item.leaveStatus!,
                                                  item.leaveStatus == "Present" ? approveColor : errorColor,
                                                  context, 15.0,align: TextAlign.left),
                                              const SizedBox(width: 15.0),
                                            ],
                                          )  )
                                    ],
                                  ),
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left:20.0),
                                      child: Divider(color: primaryColor,),),

                                    const SizedBox(height: 5.0,),
                                    // Row(
                                    //   children: [
                                    //     Container(
                                    //         height: 40.0,
                                    //         decoration: const BoxDecoration(color: primaryColor,
                                    //             borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0),)),
                                    //         child: Align(
                                    //             alignment: Alignment.centerLeft,
                                    //             child: Padding(
                                    //               padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                    //               child: buildTextBoldWidget("${Strings.rupees} ${item.pendingClaims!}", whiteColor, context, 14.0),
                                    //             )
                                    //         )
                                    //     ),
                                    //     Flexible(child: SizedBox(
                                    //         width: MediaQuery.of(context).size.width,
                                    //         height: 40.0,
                                    //         child: Align(
                                    //             alignment: Alignment.centerLeft,
                                    //             child: Padding(
                                    //               padding: const EdgeInsets.only(left: 10.0),
                                    //               child: buildTextBoldWidget(item.employee!, primaryColor, context, 14.0,align: TextAlign.left),
                                    //             )
                                    //         )
                                    //     ),)
                                    //   ],
                                    // ),
                                    // const SizedBox(height: 5.0,),
                                    Table(
                                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                                      defaultColumnWidth: FixedColumnWidth(MediaQuery.of(context).size.width/3.3),
                                      children: [

                                        TableRow(
                                            children: [
                                              buildTextBoldWidget("Allotted but\nnot started", Colors.blue, context, 14.0,align: TextAlign.center),
                                              buildTextBoldWidget("Pastdue", const Color(0xFFffc000), context, 14.0,align: TextAlign.center),
                                              buildTextBoldWidget("Probable\nOverdue", const Color(0xff0000FF), context, 14.0,align: TextAlign.center),
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              buildTextBoldWidget(item.allottedCnt!, blackColor, context, 14.0,align: TextAlign.center),
                                              buildTextBoldWidget(item.pastdueCnt!, blackColor, context, 14.0,align: TextAlign.center),
                                              buildTextBoldWidget(item.probableCnt!, blackColor, context, 14.0,align: TextAlign.center),
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              buildTextBoldWidget("High",  const Color(0xffFF0000), context, 14.0,align: TextAlign.center),
                                              buildTextBoldWidget("Medium", const Color(0xffF57C00), context, 14.0,align: TextAlign.center),
                                              buildTextBoldWidget("Low", const Color(0xff008000), context, 14.0,align: TextAlign.center),
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              buildTextBoldWidget(item.highCnt!, blackColor, context, 14.0,align: TextAlign.center),
                                              buildTextBoldWidget(item.mediumCnt!, blackColor, context, 14.0,align: TextAlign.center),
                                              buildTextBoldWidget(item.lowCnt!, blackColor, context, 14.0,align: TextAlign.center),
                                            ]
                                        ),
                                      ],
                                    ),
                                    // Padding(
                                    //     padding: const EdgeInsets.only(left:10.0),
                                    //     child:Row(
                                    //       children: [
                                    //         buildRichTextWidget("Total Services : ", item.totalCnt!,title1Weight: FontWeight.normal,title2Weight: FontWeight.bold),
                                    //         const SizedBox(width: 5.0,),
                                    //         buildRichTextWidget("Status : ", item.leaveStatus!,title1Weight: FontWeight.normal,title2Weight: FontWeight.bold,
                                    //             title2Color: item.leaveStatus == "Present" ? approveColor : errorColor)
                                    //       ],
                                    //     )  )
                                  ],
                                ),
                              ),
                            ));
                      }),
                )
                 )
          ));
    });
  }
}
