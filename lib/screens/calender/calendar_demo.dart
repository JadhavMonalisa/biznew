// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/constant/repository/api_repository.dart';
import 'package:biznew/screens/calender/calender_controller.dart';
import 'package:biznew/screens/calender/calender_model.dart';
import 'package:biznew/screens/calender/event_model.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/cupertino.dart';

import '../../theme/app_colors.dart';

class TableEventsExample extends StatefulWidget {
  const TableEventsExample({super.key});

  @override
  TableEventsExampleState createState() => TableEventsExampleState();
}

class TableEventsExampleState extends State<TableEventsExample> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  String selectedDate = "";

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));

    //callCalender();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  List<CalenderData> calenderDataList = [];
  ApiRepository? repository;

  // void callCalender() async {
  //   print("api call");
  //   calenderDataList.clear();
  //
  //   try {
  //     CalenderModel? response = (await repository!.getCalender("2023"));
  //
  //     if (response.success!) {
  //       calenderDataList.addAll(response.calenderData!);
  //
  //       print("calenderDataList.length");
  //       print(calenderDataList.length);
  //     } else {
  //       print("else");
  //     }
  //   } on CustomException {
  //     print("exception");
  //   } catch (error) {
  //     print(error);
  //   }
  // }
  // void callCalender() async {
  //   print("api call");
  //   calenderDataList.clear();
  //
  //   Map<String, String> headers = { "Content-Type": "text/html;charset=UTF-8"};
  //   var params= {
  //     "firm_id":"124","mast_id":"756","year":"2023"
  //   };
  //   dioFormData.FormData formData = dioFormData.FormData.fromMap(params);
  //
  //   try {
  //
  //     var dio = Dio();
  //     final res = await dio.post(ApiEndpoint.calenderUrl, data: formData,
  //       options: Options(
  //         followRedirects: false,
  //         // will not throw errors
  //         validateStatus: (status) => true,
  //         headers: headers,
  //       ),
  //     );
  //     final response = res.data as Map<String, dynamic>;
  //
  //     response["data"].forEach((element){
  //       calenderDataList.add(CalenderData(
  //         start: element["start"],
  //         constraint: element["constraint"],
  //       ));
  //     });
  //
  //     setState(() {
  //       print("calenderDataList");
  //       print(calenderDataList.length);
  //     });
  //   } on CustomException {
  //     print("exception");
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'GlobalKey');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalenderViewController>(builder: (cont) {
      return WillPopScope(
          onWillPop: () async {
            return await cont.navigateToBottomScreen();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: whiteColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: primaryColor,
              centerTitle: true,
              title: buildTextMediumWidget("Calendar", whiteColor, context, 16,
                  align: TextAlign.center),
              leading: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                    child: const Icon(Icons.dehaze)),
              ),
            ),
            drawer: Drawer(
              child: SizedBox(
                  height: double.infinity,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Center(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 1.1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildDrawer(context, cont.name),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30.0,
                                    left: 10.0,
                                    bottom: 50.0,
                                    right: 10.0),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showCalenderDialog(
                                            context,
                                            "Confirm Logout...!!!",
                                            "Do you want to logout from an app?",
                                            logoutFeature: true,
                                            cont);
                                      },
                                      child: const Icon(Icons.logout),
                                    ),
                                    const SizedBox(
                                      width: 7.0,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          showCalenderDialog(
                                              context,
                                              "Confirm Logout...!!!",
                                              "Do you want to logout from an app?",
                                              logoutFeature: true,
                                              cont);
                                        },
                                        child: buildTextBoldWidget("Logout",
                                            blackColor, context, 15.0)),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {},
                                      child: buildTextRegularWidget(
                                          "App Version 1.0",
                                          grey,
                                          context,
                                          14.0),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            body: cont.isLoading
                ? buildCircularIndicator()
                : Column(
                    children: [
                      TableCalendar<Event>(
                        firstDay: kFirstDay,
                        lastDay: kLastDay,
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        rangeStartDay: _rangeStart,
                        rangeEndDay: _rangeEnd,
                        calendarFormat: _calendarFormat,
                        rangeSelectionMode: _rangeSelectionMode,
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (BuildContext context, date, events) {
                            String formattedDate = "${date.year}-"
                                "${date.month.toString().length == 1 ? "0${date.month.toString()}" : date.month.toString()}-"
                                "${date.day.toString().length == 1 ? "0${date.day.toString()}" : date.day.toString()}";

                            if (cont.calenderDataList.isEmpty)
                              return const SizedBox();
                            return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: cont.calenderDataList.length,
                                itemBuilder: (context, index) {
                                  return cont.calenderDataList[index].start ==
                                          formattedDate
                                      ? Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          padding: const EdgeInsets.all(1),
                                          child: Container(
                                            height: 7,
                                            width: 7,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                //color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
                                                //color: cont.calenderDataList[index].formattedColor
                                                color: Color(cont
                                                    .calenderDataList[index]
                                                    .newColor!)),
                                          ),
                                        )
                                      : const Opacity(opacity: 0.0);
                                });
                          },
                          defaultBuilder: (context, day, focusedDay) {
                            String selectedFormattedDate = "${day.year}-"
                                "${day.month.toString().length == 1 ? "0${day.month.toString()}" : day.month.toString()}-"
                                "${day.day.toString().length == 1 ? "0${day.day.toString()}" : day.day.toString()}";
                            //

                            return selectedFormattedDate == selectedDate
                                ? Container(
                                    decoration: const BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${day.day}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: const BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${day.day}',
                                        style:
                                            const TextStyle(color: blackColor),
                                      ),
                                    ),
                                  );
                          },
                        ),
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        calendarStyle: const CalendarStyle(
                          // Use `CalendarStyle` to customize the UI
                          outsideDaysVisible: false,
                          isTodayHighlighted: true,
                        ),
                        //onDaySelected: _onDaySelected,
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                        ),
                        onDaySelected: (selection1, selection2) {
                          setState(() {
                            cont.isLoading = true;
                            selectedDate = "${selection1.year}-"
                                "${selection1.month.toString().length == 1 ? "0${selection1.month.toString()}" : selection1.month.toString()}-"
                                "${selection1.day.toString().length == 1 ? "0${selection1.day.toString()}" : selection1.day.toString()}";
                            cont.isLoading = false;
                          });
                        },
                        onRangeSelected: _onRangeSelected,
                        onFormatChanged: (format) {
                          if (_calendarFormat != format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                          if (cont.selectedYear.toString() ==
                              focusedDay.year.toString()) {
                          } else {
                            cont.selectedYear = focusedDay.year.toString();
                            cont.callCalender();
                          }
                        },
                      ),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: ListView.builder(
                          itemCount: cont.calenderDataList.length,
                          itemBuilder: (context, index) {
                            //int formatColor = int.parse("0xFF${cont.calenderDataList[index].color.toString().replaceAll("#", "")}");

                            String focusDate = "${_focusedDay.year}-"
                                "${_focusedDay.month.toString().length == 1 ? "0${_focusedDay.month.toString()}" : _focusedDay.month.toString()}-"
                                "${_focusedDay.day.toString().length == 1 ? "0${_focusedDay.day.toString()}" : _focusedDay.day.toString()}";

                            String dateToCompare =
                                selectedDate == "" || selectedDate.isEmpty
                                    ? focusDate
                                    : selectedDate;

                            return cont.calenderDataList[index].start ==
                                    dateToCompare
                                ? Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 4.0,
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        //color: cont.calenderDataList[index].ranColor
                                        //color: cont.calenderDataList[index].formattedColor
                                        color: Color(cont
                                            .calenderDataList[index]
                                            .newColor!)),
                                    child: ListTile(
                                      onTap: () {
                                        cont.navigateToCalenderDetailScreen(
                                            cont.calenderDataList[index]
                                                .constraint!,
                                            cont.calenderDataList[index]
                                                .start!);
                                      },
                                      //title: Text('${value[index]}'),
                                      title: buildTextBoldWidget(
                                          cont.calenderDataList[index].start!,
                                          whiteColor,
                                          context,
                                          14.0),
                                      subtitle: buildTextBoldWidget(
                                          cont.calenderDataList[index].title!,
                                          whiteColor,
                                          context,
                                          14.0,
                                          align: TextAlign.left),
                                    ),
                                  )
                                : const Opacity(
                                    opacity: 0.0,
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
          ));
    });
  }
}

// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

/// Example event class.
// class Event {
//   final String title;
//
//   const Event(this.title);
//
//   @override
//   String toString() => title;
// }

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

// final _kEventSource = { for (var item in List.generate(50, (index) => index)) DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5) : List.generate(
//         item % 4 + 1, (index) => Event('Event $item | ${index + 1}')) }
//   ..addAll({
//     kToday: [
//       const Event('Today\'s Event 1'),
//       const Event('Today\'s Event 2'),
//     ],
//   });

final _kEventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(2023, 6, 8): List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}'))
}..addAll({
    kToday: [
      const Event('Today\'s Event 1'),
      const Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(2023, 01, 01);
final kLastDay = DateTime(2050, kToday.month, kToday.day);
