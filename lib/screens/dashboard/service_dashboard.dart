import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/dashboard/dashboard_controller.dart';
import 'package:biznew/screens/petty_task/petty_task_model.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:biznew/utils/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

class ServiceDashboardScreen extends StatefulWidget {
  const ServiceDashboardScreen({Key? key}) : super(key: key);

  @override
  State<ServiceDashboardScreen> createState() => _ServiceDashboardScreenState();
}

class _ServiceDashboardScreenState extends State<ServiceDashboardScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: 'GlobalKey');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont)
    {
    return WillPopScope(
        onWillPop: () async{
          return await Get.toNamed(AppRoutes.bottomNav);
        },
    child:Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          elevation: 0, backgroundColor: primaryColor, centerTitle: true,
          title: buildTextMediumWidget("Employee Dashboard", whiteColor,context, 16,align: TextAlign.center),
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: GestureDetector(
                onTap:(){
                  scaffoldKey.currentState?.openDrawer();
                },
                child:const Icon(Icons.dehaze)
            ),
          ),
          actions: [
            GestureDetector(
              onTap: (){
                Utils.showAlertSnackBar("Coming Soon!");
              },
              child:const Padding(
                  padding: EdgeInsets.only(right: 15.0,left: 15.0,bottom: 3.0),
                  child: Icon(Icons.notifications_active,color: whiteColor,)
              ),
            ),
            const SizedBox(width: 5.0,),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: (){
                  showWarningDialog(context,"Confirm Logout...!!!","Do you want to logout from an app?",logoutFeature:true,cont);
                },
                child: const Icon(Icons.logout),
              ),
            )
          ],
        ),
      drawer: Drawer(
        child: SizedBox(
            height: double.infinity,width: MediaQuery.of(context).size.width,
            child: ListView(
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDrawer(context,cont.name,branchWidget:
                      Padding(
                          padding: const EdgeInsets.only(top:5.0,right: 10.0,),
                          child: Container(
                              height: 40.0,width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(color: cont.selectedBranchName==""?grey:whiteColor),),
                              child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                    child: DropdownButton(
                                      hint: buildTextRegularWidget(cont.selectedBranchName==""?"Branch name":cont.selectedBranchName,
                                          cont.selectedBranchName==""?grey:whiteColor, context, 15.0),
                                      isExpanded: true,
                                      underline: Container(),
                                      iconEnabledColor: cont.selectedBranchName==""?grey:whiteColor,
                                      items:
                                      cont.branchNameList.isEmpty
                                          ?
                                      cont.noDataList.map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList()
                                          : cont.branchNameList.map((Branchlist value) {
                                        return DropdownMenuItem<String>(
                                          value: value.name,
                                          child: Text(value.name!),
                                          onTap: (){
                                            cont.updateSelectedBranchId(value.id!);
                                          },
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        cont.checkBranchNameValidation(val!);
                                      },
                                    ),
                                  )
                              )
                          ),
                        ),),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0,left: 10.0,bottom: 30.0,right: 10.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                showDashboardDialog(context,"Confirm Logout...!!!","Do you want to logout from an app?",logoutFeature:true,cont);
                              },
                              child: const Icon(Icons.logout),
                            ),
                            const SizedBox(width: 7.0,),
                            GestureDetector(
                                onTap:(){
                                  showDashboardDialog(context,"Confirm Logout...!!!","Do you want to logout from an app?",logoutFeature:true,cont);
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
              ],
            )
        ),
      ),
      body:  cont.loader == true ? Center(child: buildCircularIndicator(),) :
      SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
              padding:const EdgeInsets.only(left: 12.0,right: 12.0,bottom: 5.0,top: 10.0),
              child:SizedBox(
                  height:MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider.builder(
                      itemCount: 8,
                      carouselController: cont.carouselController,
                      options: CarouselOptions(
                        autoPlay: false,
                        aspectRatio: 0.9,
                        viewportFraction: 0.9,
                        disableCenter: true,
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          cont.updateSlider(index);
                        },
                        initialPage: cont.currentPos
                      ),
                      itemBuilder: (context, index, realIdx) {
                        return Center(
                          child: ListView(
                            children: [
                              ///pie chart
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0,bottom: 15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: (){cont.goToPrevSlider();},
                                      child: const Icon(Icons.arrow_back_ios,color: primaryColor,),
                                    ),
                                    const Spacer(),
                                    PieChart(
                                      dataMap: index == 0 ? cont.triggerNotAllottedValues :
                                      index == 1 ? cont.allottedNotStartedValues :
                                      index == 2 ? cont.startedNotCompletedValues :
                                      index == 3 ? cont.completedIdPendingValues :
                                      index == 4 ? cont.completedNotBilledValues :
                                      index == 5 ? cont.workOnHoldValues :
                                      index == 6 ? cont.submittedForCheckingValues : cont.allTasksCompletedValues,

                                      animationDuration: const Duration(milliseconds: 800),
                                      chartLegendSpacing: 32,
                                      chartRadius: MediaQuery.of(context).size.width / 2.5,

                                      colorList: index == 0 ? cont.triggerNotAllottedColors :
                                      index == 1 ? cont.allottedNotStartedColors :
                                      index == 2 ? cont.startedNotCompletedColors :
                                      index == 3 ? cont.completedIdPendingColors :
                                      index == 4 ? cont.completedNotBilledColors :
                                      index == 5 ? cont.workOnHoldColors:
                                      index == 6 ? cont.submittedForCheckingColors :cont.allTasksCompletedColors,

                                      initialAngleInDegree: 0,
                                      chartType: ChartType.ring,
                                      ringStrokeWidth: 42,

                                      centerText: index == 0 ? cont.triggerNotAllottedTotal :
                                      index == 1 ? cont.allottedNotStartedTotal :
                                      index == 2 ? cont.startedNotCompletedTotal :
                                      index == 3 ? cont.completedIdPendingTotal :
                                      index == 4 ? cont.completedNotBilledTotal :
                                      index == 5 ? cont.workOnHoldTotal :
                                      index == 6 ? cont.submittedForCheckingTotal : cont.allTasksCompletedTotal,

                                      centerTextStyle: const TextStyle(color: primaryColor,fontSize: 20.0,fontWeight: FontWeight.bold),
                                      legendOptions: const LegendOptions(
                                        showLegendsInRow: false,
                                        legendPosition: LegendPosition.bottom,
                                        showLegends: false,
                                        legendShape: BoxShape.circle,
                                        legendTextStyle: TextStyle(fontWeight: FontWeight.bold,height: 2.0),
                                      ),
                                      chartValuesOptions: const ChartValuesOptions(
                                        showChartValueBackground: true,
                                        showChartValues: false,
                                        showChartValuesInPercentage: false,
                                        showChartValuesOutside: true,
                                        decimalPlaces: 1,
                                      ),
                                    ),

                                    const Spacer(),
                                    GestureDetector(
                                      onTap: (){cont.goToNextSlider();},
                                      child: const Icon(Icons.arrow_forward_ios,color: primaryColor,),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20.0,),
                              buildTextBoldWidget(index == 0 ? "Services triggered but not allotted" :
                              index == 1 ? "Allotted but not started" :
                              index == 2 ? "Started but not completed" :
                              index == 3 ? "Completed but UDIN pending":
                              index == 4 ? "Completed but not billed" :
                              index == 5 ? "Work On Hold" :
                              index == 6 ? "Submitted for checking" : "All tasks completed",
                                  primaryColor, context, 18.0,align: TextAlign.center),

                              ///table
                              index == 0 || index == 4
                                  ? Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child:  Center(
                                    child: Table(
                                      children: [
                                        TableRow(
                                            children: [
                                              index == 0
                                                  ? ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: cont.triggerNotAllottedValues.length,
                                                  itemBuilder: (context,index){
                                                    return Padding(
                                                        padding: const EdgeInsets.all(2.0),
                                                        child: Card(
                                                          child: Padding(
                                                              padding:const EdgeInsets.all(5.0),
                                                              child:Column(
                                                                children: [
                                                                  buildTextBoldWidget(cont.chartDetails[index], cont.chartColors[index], context, 16.0),
                                                                  buildTextBoldWidget(cont.triggeredNotAllotted.isEmpty?"":cont.triggeredNotAllotted[index].toString(), blackColor, context, 16.0),
                                                                ],
                                                              )
                                                          ),
                                                        )
                                                    );
                                                  })
                                                  : ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: cont.completedNotBilled.length,
                                                  itemBuilder: (context,index){
                                                    return Padding(
                                                        padding: const EdgeInsets.all(2.0),
                                                        child: GestureDetector(
                                                          onTap: (){
                                                            cont.callDueDataForCompletedNotBilled("Total",cont.completedNotBilled[index].toString());
                                                          },
                                                          child:Card(
                                                            child: Padding(
                                                              padding:const EdgeInsets.all(10.0),
                                                              child: buildTextBoldWidget(cont.completedNotBilled[index].toString(), blackColor, context, 16.0,align: TextAlign.center),
                                                            ),
                                                          )
                                                        )
                                                    );
                                                  })
                                            ]
                                        )
                                      ],
                                    ),
                                  )
                              )
                                  : Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child:Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ///chart table values
                                      Flexible(child:
                                      Padding(
                                          padding: const EdgeInsets.only(top:5.0),
                                          child:
                                          Column(
                                            children: [
                                              index == 1
                                                  ? cont.allottedNotStartedValues.isEmpty ? const Text(""):ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: cont.allottedNotStartedValues.length,
                                                  itemBuilder: (context,index){
                                                    return Padding(
                                                      padding: const EdgeInsets.all(2.0),
                                                      child:Card(
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(5.0),
                                                            child: Column(
                                                              children: [
                                                                buildTextBoldWidget(cont.allottedNotStartedDetails[index], cont.allottedNotStartedColors[index], context, 16.0),
                                                                const SizedBox(height: 5.0,),
                                                                // cont.ownAllottedNotStarted[index] == 0 && cont.teamAllottedNotStarted[index] == 0
                                                                // ? const Opacity(opacity: 0.0):
                                                                IntrinsicHeight(
                                                                  child: Row(
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      RichText(
                                                                        text: TextSpan(
                                                                            text: 'Own - ',
                                                                            style: const TextStyle(fontWeight: FontWeight.normal,color: blackColor,fontSize: 16.0),
                                                                            children: <TextSpan>[
                                                                              TextSpan(
                                                                                  text: cont.ownAllottedNotStarted.isEmpty ? "" :cont.ownAllottedNotStarted[index].toString(),
                                                                                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0)),
                                                                            ],
                                                                            recognizer: TapGestureRecognizer()..onTap= () {
                                                                              cont.callDueDataApi(cont.allottedNotStartedDetails[index],"Own",cont.ownAllottedNotStarted[index].toString());
                                                                            }
                                                                        ),
                                                                      ),
                                                                      const VerticalDivider(
                                                                        color: grey,
                                                                        thickness: 2,
                                                                      ),
                                                                      RichText(
                                                                        text: TextSpan(
                                                                          text: 'Team - ',
                                                                          style: const TextStyle(fontWeight: FontWeight.normal,color: blackColor,fontSize: 16.0),
                                                                          children: <TextSpan>[
                                                                            TextSpan(
                                                                                text: cont.teamAllottedNotStarted.isEmpty ? "" :cont.teamAllottedNotStarted[index].toString(),
                                                                                style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0)),
                                                                          ],
                                                                            recognizer: TapGestureRecognizer()..onTap= () {
                                                                              cont.callDueDataApi(cont.allottedNotStartedDetails[index],"Team",cont.teamAllottedNotStarted[index].toString());
                                                                            }
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                      ),
                                                    );
                                                  }) :
                                              index == 2
                                                  ? cont.startedNotCompletedValues.isEmpty ? const Text(""):ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: cont.startedNotCompletedValues.length,
                                                  itemBuilder: (context,index){
                                                    return Padding(
                                                        padding: const EdgeInsets.all(2.0),
                                                        child:Card(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(5.0),
                                                              child: Column(
                                                                children: [
                                                                  buildTextBoldWidget(cont.startedNotCompletedDetails[index], cont.startedNotCompletedColors[index], context, 16.0),
                                                                  const SizedBox(height: 5.0,),
                                                                  IntrinsicHeight(
                                                                    child: Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        RichText(
                                                                          text: TextSpan(
                                                                            text: 'Own - ',
                                                                            style: const TextStyle(fontWeight: FontWeight.normal,color: blackColor,fontSize: 16.0),
                                                                            children: <TextSpan>[
                                                                              TextSpan(
                                                                                  text: cont.ownStartedNotCompleted[index].toString(),
                                                                                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0)),
                                                                            ],
                                                                              recognizer: TapGestureRecognizer()..onTap= () {
                                                                                cont.callDueDataForStartedNotCompletedApi(cont.startedNotCompletedDetails[index],"Own",cont.ownStartedNotCompleted[index].toString());
                                                                              }
                                                                          ),
                                                                        ),
                                                                        const VerticalDivider(
                                                                          color: grey,
                                                                          thickness: 2,
                                                                        ),
                                                                        RichText(
                                                                          text: TextSpan(
                                                                            text: 'Team - ',
                                                                            style: const TextStyle(fontWeight: FontWeight.normal,color: blackColor,fontSize: 16.0),
                                                                            children: <TextSpan>[
                                                                              TextSpan(
                                                                                  text: cont.teamStartedNotCompleted[index].toString(),
                                                                                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0)),
                                                                            ],
                                                                              recognizer: TapGestureRecognizer()..onTap= () {
                                                                                cont.callDueDataForStartedNotCompletedApi(cont.startedNotCompletedDetails[index],"Team",cont.teamStartedNotCompleted[index].toString());
                                                                              }
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                        )
                                                    );
                                                  }) :
                                              index == 3
                                                  ? cont.completedIdPendingValues.isEmpty ? const Text(""):ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: cont.completedIdPendingValues.length,
                                                  itemBuilder: (context,index){
                                                    return Padding(
                                                        padding: const EdgeInsets.all(2.0),
                                                        child:Card(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(5.0),
                                                              // child: Column(
                                                              //   children: [
                                                              //     buildTextBoldWidget(cont.chartDetails[index], cont.chartColors[index], context, 14.0),
                                                              //     const SizedBox(height: 5.0,),
                                                              //     IntrinsicHeight(
                                                              //       child: Row(
                                                              //         crossAxisAlignment: CrossAxisAlignment.center,
                                                              //         mainAxisAlignment: MainAxisAlignment.center,
                                                              //         children: [
                                                              //           RichText(
                                                              //             text: TextSpan(
                                                              //               text: 'Own - ',
                                                              //               style: const TextStyle(fontWeight: FontWeight.normal,color: blackColor,fontSize: 14.0),
                                                              //               children: <TextSpan>[
                                                              //                 TextSpan(
                                                              //                     text: cont.ownCompletedUdinPending[index].toString(),
                                                              //                     style: const TextStyle(fontWeight: FontWeight.bold)),
                                                              //               ],
                                                              //             ),
                                                              //           ),
                                                              //           const VerticalDivider(
                                                              //             color: grey,
                                                              //             thickness: 2,
                                                              //           ),
                                                              //            RichText(
                                                              //             text: TextSpan(
                                                              //               text: 'Team - ',
                                                              //               style: const TextStyle(fontWeight: FontWeight.normal,color: blackColor,fontSize: 14.0),
                                                              //               children: <TextSpan>[
                                                              //                 TextSpan(
                                                              //                     text: cont.teamCompletedUdinPending[index].toString(),
                                                              //                     style: const TextStyle(fontWeight: FontWeight.bold)),
                                                              //               ],
                                                              //             ),
                                                              //           ),
                                                              //         ],
                                                              //       ),
                                                              //     ),
                                                              //   ],
                                                              // ),
                                                              child: IntrinsicHeight(
                                                                child: Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap: (){
                                                                        cont.callDueDataForCompletedUdinPendingApi("Completed but Udin pending","Own",cont.ownCompletedUdinPending[0].toString());
                                                                      },
                                                                      child:Column(
                                                                        children: [
                                                                          buildTextRegularWidget("Own", blackColor, context, 16.0),
                                                                          buildTextBoldWidget(cont.ownCompletedUdinPending[0].toString(), blackColor, context, 16.0),
                                                                        ],
                                                                      )
                                                                    ),
                                                                    const VerticalDivider(
                                                                      color: grey,
                                                                      thickness: 2,
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap: (){
                                                                        cont.callDueDataForCompletedUdinPendingApi("Completed but Udin pending","Team",cont.teamCompletedUdinPending[0].toString());
                                                                      },
                                                                      child: Column(
                                                                        children: [
                                                                          buildTextRegularWidget("Team", blackColor, context, 16.0),
                                                                          buildTextBoldWidget(cont.teamCompletedUdinPending[0].toString(), blackColor, context, 16.0),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                        )
                                                    );
                                                  }) :
                                              index == 5
                                                  ? cont.workOnHoldValues.isEmpty ? const Text(""):
                                              // ListView.builder(
                                              //     shrinkWrap: true,
                                              //     physics: const NeverScrollableScrollPhysics(),
                                              //     itemCount: cont.workOnHoldValues.length,
                                              //     itemBuilder: (context,index){
                                              //       return Padding(
                                              //           padding: const EdgeInsets.all(2.0),
                                              //           child:Card(
                                              //               child: Padding(
                                              //                 padding: const EdgeInsets.all(5.0),
                                              //                 child: IntrinsicHeight(
                                              //                   child: Row(
                                              //                     crossAxisAlignment: CrossAxisAlignment.center,
                                              //                     mainAxisAlignment: MainAxisAlignment.center,
                                              //                     children: [
                                              //                       Column(
                                              //                         children: [
                                              //                           buildTextRegularWidget("Own", blackColor, context, 16.0),
                                              //                           buildTextBoldWidget(cont.ownWorkOnHold.isEmpty?"":cont.ownWorkOnHold[index].toString(), blackColor, context, 16.0),
                                              //                         ],
                                              //                       ),
                                              //                       const VerticalDivider(
                                              //                         color: grey,
                                              //                         thickness: 2,
                                              //                       ),
                                              //                       Column(
                                              //                         children: [
                                              //                           buildTextRegularWidget("Team", blackColor, context, 16.0),
                                              //                           buildTextBoldWidget(cont.teamWorkOnHold.isEmpty?"":cont.teamWorkOnHold[index].toString(), blackColor, context, 16.0),
                                              //                         ],
                                              //                       ),
                                              //                     ],
                                              //                   ),
                                              //                 ),
                                              //               )
                                              //           )
                                              //       );
                                              //     })

                                              Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child:Card(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: IntrinsicHeight(
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: (){
                                                                  cont.callDueDataForWorkOnHold("Work On Hold","Own",cont.ownWorkOnHold[0].toString());
                                                                },
                                                                child: Column(
                                                                  children: [
                                                                    buildTextRegularWidget("Own", blackColor, context, 16.0),
                                                                    buildTextBoldWidget(cont.ownWorkOnHold.isEmpty?"":cont.ownWorkOnHold[0].toString(), blackColor, context, 16.0),
                                                                  ],
                                                                ),
                                                              ),
                                                              const VerticalDivider(
                                                                color: grey,
                                                                thickness: 2,
                                                              ),
                                                              GestureDetector(
                                                              onTap: (){
                                                              cont.callDueDataForWorkOnHold("Work On Hold","Team",cont.teamWorkOnHold[0].toString());
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  buildTextRegularWidget("Team", blackColor, context, 16.0),
                                                                  buildTextBoldWidget(cont.teamWorkOnHold.isEmpty?"":cont.teamWorkOnHold[0].toString(), blackColor, context, 16.0),
                                                                ],
                                                              ),)
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                  )
                                              )

                                                  :
                                              index == 6
                                                  ? cont.submittedForCheckingValues.isEmpty ? const Text(""):
                                              // ListView.builder(
                                              //     shrinkWrap: true,
                                              //     physics: const NeverScrollableScrollPhysics(),
                                              //     itemCount: cont.submittedForCheckingValues.length,
                                              //     itemBuilder: (context,index){
                                              //       return Padding(
                                              //           padding: const EdgeInsets.all(2.0),
                                              //           child:Card(
                                              //               child: Padding(
                                              //                 padding: const EdgeInsets.all(5.0),
                                              //                 // child: Column(
                                              //                 //   children: [
                                              //                 //     buildTextBoldWidget(cont.chartDetails[index], cont.submittedForCheckingColors[index], context, 14.0),
                                              //                 //     const SizedBox(height: 5.0,),
                                              //                 //     IntrinsicHeight(
                                              //                 //       child: Row(
                                              //                 //         crossAxisAlignment: CrossAxisAlignment.center,
                                              //                 //         mainAxisAlignment: MainAxisAlignment.center,
                                              //                 //         children: [
                                              //                 //           RichText(
                                              //                 //             text: TextSpan(
                                              //                 //               text: 'Own - ',
                                              //                 //               style: const TextStyle(fontWeight: FontWeight.normal,color: blackColor,fontSize: 14.0),
                                              //                 //               children: <TextSpan>[
                                              //                 //                 TextSpan(
                                              //                 //                     text: cont.ownSubmittedForChecking[index].toString(),
                                              //                 //                     style: const TextStyle(fontWeight: FontWeight.bold)),
                                              //                 //               ],
                                              //                 //             ),
                                              //                 //           ),
                                              //                 //           const VerticalDivider(
                                              //                 //             color: grey,
                                              //                 //             thickness: 2,
                                              //                 //           ),
                                              //                 //           RichText(
                                              //                 //             text: TextSpan(
                                              //                 //               text: 'Team - ',
                                              //                 //               style: const TextStyle(fontWeight: FontWeight.normal,color: blackColor,fontSize: 14.0),
                                              //                 //               children: <TextSpan>[
                                              //                 //                 TextSpan(
                                              //                 //                     text: cont.teamSubmittedForChecking[index].toString(),
                                              //                 //                     style: const TextStyle(fontWeight: FontWeight.bold)),
                                              //                 //               ],
                                              //                 //             ),
                                              //                 //           ),
                                              //                 //         ],
                                              //                 //       ),
                                              //                 //     ),
                                              //                 //   ],
                                              //                 // ),
                                              //                 child: IntrinsicHeight(
                                              //                   child: Row(
                                              //                     crossAxisAlignment: CrossAxisAlignment.center,
                                              //                     mainAxisAlignment: MainAxisAlignment.center,
                                              //                     children: [
                                              //                       Column(
                                              //                         children: [
                                              //                           buildTextRegularWidget("Own", blackColor, context, 16.0),
                                              //                           buildTextBoldWidget(cont.ownSubmittedForChecking[index].toString(), blackColor, context, 16.0),
                                              //                         ],
                                              //                       ),
                                              //                       const VerticalDivider(
                                              //                         color: grey,
                                              //                         thickness: 2,
                                              //                       ),
                                              //                       Column(
                                              //                         children: [
                                              //                           buildTextRegularWidget("Team", blackColor, context, 16.0),
                                              //                           buildTextBoldWidget(cont.teamSubmittedForChecking[index].toString(), blackColor, context, 16.0),
                                              //                         ],
                                              //                       ),
                                              //                     ],
                                              //                   ),
                                              //                 ),
                                              //               )
                                              //           )
                                              //       );
                                              //     })
                                              Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child:Card(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        child: IntrinsicHeight(
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: (){
                                                                  cont.callDueDataForSubmittedForChecking("Submitted for checking","Own",cont.ownSubmittedForChecking[0].toString());
                                                                },
                                                                child: Column(
                                                                  children: [
                                                                    buildTextRegularWidget("Own", blackColor, context, 16.0),
                                                                    buildTextBoldWidget(cont.ownSubmittedForChecking.isEmpty?"":cont.ownSubmittedForChecking[0].toString(), blackColor, context, 16.0),
                                                                  ],
                                                                ),
                                                              ),
                                                              const VerticalDivider(
                                                                color: grey,
                                                                thickness: 2,
                                                              ),
                                                              GestureDetector(
                                                                onTap: (){
                                                                  cont.callDueDataForSubmittedForChecking("Submitted for checking","Team",cont.teamSubmittedForChecking[0].toString());
                                                                },
                                                                child: Column(
                                                                  children: [
                                                                    buildTextRegularWidget("Team", blackColor, context, 16.0),
                                                                    buildTextBoldWidget(cont.teamSubmittedForChecking.isEmpty?"":cont.teamSubmittedForChecking[0].toString(), blackColor, context, 16.0),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                  )
                                              )

                                                  :
                                              cont.allTasksCompletedValues.isEmpty ? const Text("") :
                                              // ListView.builder(
                                              //     shrinkWrap: true,
                                              //     physics: const NeverScrollableScrollPhysics(),
                                              //     itemCount: cont.allTasksCompletedValues.length,
                                              //     itemBuilder: (context,index){
                                              //       return Padding(
                                              //           padding: const EdgeInsets.all(2.0),
                                              //           child:Card(
                                              //               child: Padding(
                                              //                 padding: const EdgeInsets.all(5.0),
                                              //                 // child: Column(
                                              //                 //   children: [
                                              //                 //     buildTextBoldWidget(cont.chartDetails[index], cont.chartColors[index], context, 14.0),
                                              //                 //     const SizedBox(height: 5.0,),
                                              //                 //     IntrinsicHeight(
                                              //                 //       child: Row(
                                              //                 //         crossAxisAlignment: CrossAxisAlignment.center,
                                              //                 //         mainAxisAlignment: MainAxisAlignment.center,
                                              //                 //         children: [
                                              //                 //           RichText(
                                              //                 //             text: TextSpan(
                                              //                 //               text: 'Own - ',
                                              //                 //               style: const TextStyle(fontWeight: FontWeight.normal,color: blackColor,fontSize: 14.0),
                                              //                 //               children: <TextSpan>[
                                              //                 //                 TextSpan(
                                              //                 //                     text: cont.ownAllTaskCompleted.isEmpty ? "" :cont.ownAllTaskCompleted[index].toString(),
                                              //                 //                     style: const TextStyle(fontWeight: FontWeight.bold)),
                                              //                 //               ],
                                              //                 //             ),
                                              //                 //           ),
                                              //                 //           //buildTextRegularWidget("Own - ${cont.ownAllottedNotStarted[index].toString()}", blackColor, context, 14.0),
                                              //                 //           const VerticalDivider(
                                              //                 //             color: grey,
                                              //                 //             thickness: 2,
                                              //                 //           ),
                                              //                 //           //buildTextRegularWidget("Team - ${cont.teamAllottedNotStarted[index].toString()}", blackColor, context, 14.0),
                                              //                 //           RichText(
                                              //                 //             text: TextSpan(
                                              //                 //               text: 'Team - ',
                                              //                 //               style: const TextStyle(fontWeight: FontWeight.normal,color: blackColor,fontSize: 14.0),
                                              //                 //               children: <TextSpan>[
                                              //                 //                 TextSpan(
                                              //                 //                     text: cont.teamAllTaskCompleted.isEmpty?"":cont.teamAllTaskCompleted[index].toString(),
                                              //                 //                     style: const TextStyle(fontWeight: FontWeight.bold)),
                                              //                 //               ],
                                              //                 //             ),
                                              //                 //           ),
                                              //                 //         ],
                                              //                 //       ),
                                              //                 //     ),
                                              //                 //   ],
                                              //                 // ),
                                              //                 child: IntrinsicHeight(
                                              //                   child: Row(
                                              //                     crossAxisAlignment: CrossAxisAlignment.center,
                                              //                     mainAxisAlignment: MainAxisAlignment.center,
                                              //                     children: [
                                              //                       Column(
                                              //                         children: [
                                              //                           buildTextBoldWidget("Own", blackColor, context, 16.0),
                                              //                           buildTextRegularWidget(cont.ownAllTaskCompleted[0].toString(), blackColor, context, 16.0),
                                              //                         ],
                                              //                       ),
                                              //                       const VerticalDivider(
                                              //                         color: grey,
                                              //                         thickness: 2,
                                              //                       ),
                                              //                       Column(
                                              //                         children: [
                                              //                           buildTextBoldWidget("Team", blackColor, context, 16.0),
                                              //                           buildTextRegularWidget(cont.teamAllTaskCompleted[0].toString(), blackColor, context, 16.0),
                                              //                         ],
                                              //                       ),
                                              //                     ],
                                              //                   ),
                                              //                 ),
                                              //               )
                                              //           )
                                              //       );
                                              //     }),

                                              Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child:Card(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(5.0),
                                                        ///1
                                                        // child: Column(
                                                        //   children: [
                                                        //     buildTextBoldWidget(cont.chartDetails[index], cont.chartColors[index], context, 14.0),
                                                        //     const SizedBox(height: 5.0,),
                                                        //     IntrinsicHeight(
                                                        //       child: Row(
                                                        //         crossAxisAlignment: CrossAxisAlignment.center,
                                                        //         mainAxisAlignment: MainAxisAlignment.center,
                                                        //         children: [
                                                        //           RichText(
                                                        //             text: TextSpan(
                                                        //               text: 'Own - ',
                                                        //               style: const TextStyle(fontWeight: FontWeight.normal,color: blackColor,fontSize: 14.0),
                                                        //               children: <TextSpan>[
                                                        //                 TextSpan(
                                                        //                     text: cont.ownAllTaskCompleted.isEmpty ? "" :cont.ownAllTaskCompleted[index].toString(),
                                                        //                     style: const TextStyle(fontWeight: FontWeight.bold)),
                                                        //               ],
                                                        //             ),
                                                        //           ),
                                                        //           //buildTextRegularWidget("Own - ${cont.ownAllottedNotStarted[index].toString()}", blackColor, context, 14.0),
                                                        //           const VerticalDivider(
                                                        //             color: grey,
                                                        //             thickness: 2,
                                                        //           ),
                                                        //           //buildTextRegularWidget("Team - ${cont.teamAllottedNotStarted[index].toString()}", blackColor, context, 14.0),
                                                        //           RichText(
                                                        //             text: TextSpan(
                                                        //               text: 'Team - ',
                                                        //               style: const TextStyle(fontWeight: FontWeight.normal,color: blackColor,fontSize: 14.0),
                                                        //               children: <TextSpan>[
                                                        //                 TextSpan(
                                                        //                     text: cont.teamAllTaskCompleted.isEmpty?"":cont.teamAllTaskCompleted[index].toString(),
                                                        //                     style: const TextStyle(fontWeight: FontWeight.bold)),
                                                        //               ],
                                                        //             ),
                                                        //           ),
                                                        //         ],
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                        ///2
                                                        // child: IntrinsicHeight(
                                                        //   child: Row(
                                                        //     crossAxisAlignment: CrossAxisAlignment.center,
                                                        //     mainAxisAlignment: MainAxisAlignment.center,
                                                        //     children: [
                                                        //       Column(
                                                        //         children: [
                                                        //           buildTextBoldWidget("Own", blackColor, context, 16.0),
                                                        //           buildTextRegularWidget(cont.ownAllTaskCompleted.isEmpty ? "" :cont.ownAllTaskCompleted[0].toString(), blackColor, context, 16.0),
                                                        //         ],
                                                        //       ),
                                                        //       const VerticalDivider(
                                                        //         color: grey,
                                                        //         thickness: 2,
                                                        //       ),
                                                        //       Column(
                                                        //         children: [
                                                        //           buildTextBoldWidget("Team", blackColor, context, 16.0),
                                                        //           buildTextRegularWidget(cont.teamAllTaskCompleted.isEmpty ? "" :cont.teamAllTaskCompleted[0].toString(), blackColor, context, 16.0),
                                                        //         ],
                                                        //       ),
                                                        //     ],
                                                        //   ),
                                                        // ),
                                                        ///3
                                                        child: IntrinsicHeight(
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: (){
                                                                  cont.callDueDataForAllTasks("All Tasks","Own",cont.ownAllTaskCompleted[0].toString());
                                                                },
                                                                child: Column(
                                                                  children: [
                                                                    buildTextRegularWidget("Own", blackColor, context, 16.0),
                                                                    buildTextBoldWidget(cont.ownAllTaskCompleted.isEmpty ? "" :cont.ownAllTaskCompleted[0].toString(), blackColor, context, 16.0),
                                                                  ],
                                                                ),
                                                              ),
                                                              const VerticalDivider(
                                                                color: grey,
                                                                thickness: 2,
                                                              ),
                                                              GestureDetector(
                                                                onTap: (){
                                                                  cont.callDueDataForAllTasks("All Tasks","Team",cont.teamAllTaskCompleted[0].toString());
                                                                },
                                                                child: Column(
                                                                  children: [
                                                                    buildTextRegularWidget("Team", blackColor, context, 16.0),
                                                                    buildTextBoldWidget(cont.teamAllTaskCompleted.isEmpty ? "" :cont.teamAllTaskCompleted[0].toString(), blackColor, context, 16.0),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                  )
                                              ),
                                              //  Padding(
                                              //   padding: const EdgeInsets.all(2.0),
                                              //   child: Card(
                                              //       elevation: 1.0,
                                              //       child: Padding(
                                              //         padding: const EdgeInsets.all(5.0),
                                              //         child: Column(
                                              //           crossAxisAlignment: CrossAxisAlignment.center,
                                              //           mainAxisAlignment: MainAxisAlignment.center,
                                              //           children: [
                                              //             buildTextBoldWidget("Total", blackColor, context, 14.0),
                                              //             IntrinsicHeight(
                                              //               child: Row(
                                              //                 crossAxisAlignment: CrossAxisAlignment.center,
                                              //                 mainAxisAlignment: MainAxisAlignment.center,
                                              //                 children: [
                                              //                   RichText(
                                              //                     text: TextSpan(
                                              //                       text: 'Own - ',
                                              //                       style: const TextStyle(fontWeight: FontWeight.normal,color: blackColor,fontSize: 14.0),
                                              //                       children: <TextSpan>[
                                              //                         TextSpan(text:
                                              //                           index == 1 ? cont.allottedOwnTotal.toString() :
                                              //                           index == 2 ? cont.startedNotCompletedOwnTotal.toString() :
                                              //                           index == 3 ? cont.completedIdPendingOwnTotal.toString() :
                                              //                           index == 5 ? cont.workOnHoldOwnTotal.toString() :
                                              //                           index == 6 ? cont.submittedForCheckingOwnTotal.toString() :
                                              //                           cont.allTaskCompletedOwnTotal.toString(),
                                              //                             style: const TextStyle(fontWeight: FontWeight.bold)),
                                              //                       ],
                                              //                     ),
                                              //                   ),
                                              //                   //buildTextRegularWidget("Own - ${cont.allottedOwnTotal.toString()}", blackColor, context, 14.0),
                                              //                   const VerticalDivider(
                                              //                     color: grey,
                                              //                     thickness: 2,
                                              //                   ),
                                              //                   RichText(
                                              //                     text: TextSpan(
                                              //                       text: 'Team - ',
                                              //                       style: const TextStyle(fontWeight: FontWeight.normal,color: blackColor,fontSize: 14.0),
                                              //                       children: <TextSpan>[
                                              //                         TextSpan(
                                              //                             text: index == 1 ? cont.allottedTeamTotal.toString() :
                                              //                                 index == 2 ? cont.startedNotCompletedTeamTotal.toString() :
                                              //                                 index == 3 ? cont.completedIdPendingTeamTotal.toString() :
                                              //                                 index == 5 ? cont.workOnHoldTeamTotal.toString() :
                                              //                                 index == 6 ? cont.submittedForCheckingTeamTotal.toString() :
                                              //                                 cont.allTaskCompletedTeamTotal.toString(),
                                              //                             style: const TextStyle(fontWeight: FontWeight.bold)),
                                              //                       ],
                                              //                     ),
                                              //                   ),
                                              //                   //buildTextRegularWidget("Team - ${cont.allottedTeamTotal.toString()}", blackColor, context, 14.0),
                                              //                 ],
                                              //               ),
                                              //             ),
                                              //             const SizedBox(height: 10.0,),
                                              //           ],
                                              //         ),
                                              //       )
                                              //   ),
                                              // )
                                            ],
                                          )
                                      )),
                                    ],
                                  )
                              ),
                            ],
                          ),
                        );
                      }
                  )
              ))),
        ));
    });
  }
}

