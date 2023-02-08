import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/calender/calender_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: 'GlobalKey');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalenderViewController>(builder: (cont)
    {
      return WillPopScope(
          onWillPop: () async {
            //return await Get.toNamed(AppRoutes.bottomNav);
            return await cont.navigateToBottomScreen();
          },
          child: Scaffold(
              key: scaffoldKey,
              backgroundColor: whiteColor,
              appBar: AppBar(
                elevation: 0, backgroundColor: primaryColor, centerTitle: true,
                title: buildTextMediumWidget("Calender", whiteColor,context, 16,align: TextAlign.center),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: GestureDetector(
                      onTap:(){
                        scaffoldKey.currentState?.openDrawer();
                      },
                      child:const Icon(Icons.dehaze)
                  ),
                ),
              ),
              drawer: Drawer(
                child: SizedBox(
                    height: double.infinity,
                    child: ListView(
                      children: [
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildDrawer(context,cont.name),
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0,left: 10.0,bottom: 30.0,right: 10.0),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        showCalenderDialog(context,"Confirm Logout...!!!","Do you want to logout from an app?",logoutFeature:true,cont);
                                      },
                                      child: const Icon(Icons.logout),
                                    ),
                                    const SizedBox(width: 7.0,),
                                    GestureDetector(
                                        onTap:(){
                                          showCalenderDialog(context,"Confirm Logout...!!!","Do you want to logout from an app?",logoutFeature:true,cont);
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
              body:
              cont.loader == true ? Center(child: buildCircularIndicator(),) :
              SingleChildScrollView(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SfCalendar(
                              view: CalendarView.month,
                              firstDayOfWeek: 1,
                              dataSource: cont.getCalendarDataSource(),
                              onViewChanged: (ViewChangedDetails viewChangedDetails)
                              {
                                //cont.viewChanged(viewChangedDetails);
                                cont.selectedYear = viewChangedDetails.visibleDates[0].year.toString();
                                cont.callCalender();
                              },
                              appointmentBuilder: (BuildContext context,
                                  CalendarAppointmentDetails calendarAppointmentDetails){
                                final Appointment appointment = calendarAppointmentDetails.appointments.first;

                                return GestureDetector(
                                  onTap: (){
                                    cont.addParameter(appointment.location!, appointment.notes!);
                                  },
                                  child: Container(
                                    width: calendarAppointmentDetails.bounds.width,
                                    height: calendarAppointmentDetails.bounds.height / 2,
                                    decoration: BoxDecoration(color: appointment.color,borderRadius: BorderRadius.circular(10.0)),
                                    child: Center(
                                      child: buildTextBoldWidget(appointment.subject, whiteColor, context, 14.0),
                                    )
                                  ),
                                );
                              },
                              controller: cont.canController,
                              monthViewSettings:const MonthViewSettings(
                                showAgenda: true,
                                showTrailingAndLeadingDates: false,
                                agendaItemHeight: 70.0,
                                agendaViewHeight: 230.0,
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

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor ?? const Color(0xFF34568B),
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}

