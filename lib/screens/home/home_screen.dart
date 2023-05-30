import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/home/home_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:biznew/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: 'GlobalKey');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (cont)
    {
      return WillPopScope(
          onWillPop: () async {
            return await Get.toNamed(AppRoutes.bottomNav);
          },
          child: Scaffold(
              key: scaffoldKey,
              backgroundColor: whiteColor,
            appBar: AppBar(
              elevation: 0, backgroundColor: primaryColor, centerTitle: true,
              title: buildTextMediumWidget("Home", whiteColor,context, 16,align: TextAlign.center),
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
                            },
                    child: const Icon(Icons.logout),
                  ),
                )
              ],
            ),
            drawer: Drawer(
                child: SizedBox(
                    height: double.infinity,
                    child: ListView(
                      physics:const NeverScrollableScrollPhysics(),
                      children: [
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height/1.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildDrawer(context,cont.name),Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0,left: 10.0,bottom: 50.0,right: 10.0),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                         },
                                        child: const Icon(Icons.logout),
                                      ),
                                      const SizedBox(width: 7.0,),
                                      GestureDetector(
                                          onTap:(){
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
            body: cont.loader == true ? Center(child: buildCircularIndicator(),) :
            SingleChildScrollView(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0,),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                      itemCount: cont.menuNameList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, indexGrid) {
                        final menuName = cont.menuNameList[indexGrid];
                        final menuIcons = cont.menuIconList[indexGrid];
                        final menuDescription = cont.menuDescriptionList[indexGrid];
                        return GestureDetector(
                          onTap: (){
                            cont.navigateFromMenuScreen(menuName);
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            child: Stack(
                              children: [
                                Container(
                                    height: 160.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),color: grey.withOpacity(0.2),
                                    ),
                                    child:Align(
                                        alignment: Alignment.topCenter,
                                        child:Padding(
                                          padding:const EdgeInsets.only(top:15.0),
                                          child:CircleAvatar(
                                            radius: 40.0,
                                            backgroundColor: whiteColor,
                                            child:Center(child:Icon(menuIcons,color: primaryColor,size: 50.0,))
                                          ),
                                        )
                                    )
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                      height: 65.0,width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          buildTextRegularWidget(menuName, blackColor, context, 14.0,align: TextAlign.center,fontWeight: FontWeight.bold),
                                          buildTextRegularWidget(menuDescription, blackColor, context, 12.0,align: TextAlign.center,fontWeight: FontWeight.normal,maxLines: 2),
                                        ],
                                      ) ),
                                ),
                              ],
                            ),
                          ),
                        );},
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, crossAxisSpacing: 8,
                        mainAxisSpacing: 12, childAspectRatio: 2,
                        mainAxisExtent: 170,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: buildTextBoldWidget("Calender dummy", blackColor, context, 14.0),
                  ),
                  const SizedBox(height: 10.0,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SfCalendar(
                        view: CalendarView.month,
                        firstDayOfWeek: 1,
                        monthViewSettings:const MonthViewSettings(
                          showAgenda: true,
                          showTrailingAndLeadingDates: false,
                          appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                        ),
                      ),
                    )
                  ),
                ],
              )
            )
          )
      );
    });
  }
}
