import 'package:biznew/constant/provider/custom_exception.dart';
import 'package:biznew/screens/calender/calender_controller.dart';
import 'package:biznew/screens/calender/event_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';

class TableEventsExample extends StatefulWidget {
  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<TableEventsExample> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalenderViewController>(builder: (cont)
    {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar - Events'),
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: cont.kFirstDay,
            lastDay: cont.kLastDay,
            focusedDay: cont.focusedDay,
            selectedDayPredicate: (day) => isSameDay(cont.selectedDay, day),
            rangeStartDay: cont.rangeStart,
            rangeEndDay: cont.rangeEnd,
            calendarFormat: cont.calendarFormat,
            rangeSelectionMode: cont.rangeSelectionMode,
            eventLoader: cont.getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: cont.onDaySelected,
            onRangeSelected: cont.onRangeSelected,
            onFormatChanged: (format) {
              if (cont.calendarFormat != format) {
                setState(() {
                  cont.calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              cont.focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: cont.selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
    });
  }
}
