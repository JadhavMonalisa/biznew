import 'package:biznew/screens/timesheet_new/timesheet_new_controller.dart';
import 'package:biznew/screens/timesheet_new/timesheet_new_model.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TextEditingForAllotted extends StatefulWidget {
  TextEditingController? controller;
  int? indexForService;
  int? indexForTask;
  bool? enabled;
  TextEditingForAllotted({Key? key,this.controller,this.indexForService,this.indexForTask,this.enabled}) : super(key: key);

  @override
  State<TextEditingForAllotted> createState() => _TextEditingForAllottedState();
}

class _TextEditingForAllottedState extends State<TextEditingForAllotted> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TimesheetNewFormController>(builder: (cont)
    {
      return TextFormField(
        //controller: cont.detailsControllerList[taskDetailsIndex],
        controller: widget.controller,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.done,
        onTap: () {},
        enabled: widget.enabled,
        style: const TextStyle(fontSize: 15.0),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          hintText: "Details",
          hintStyle: GoogleFonts.rubik(
            textStyle: TextStyle(
              color: widget.enabled == true ? blackColor : grey,
              fontSize: 15,
            ),
          ),
          border: InputBorder.none,
        ),
        onChanged: (value) {
          print("value");
          print(value);
          // cont.timesheetTaskListData[widget.indexForService!]
          //     .timesheetTaskDetailsData!.removeWhere((element) {
          //   element.
          // });
          //
          //
          // cont.timesheetTaskListData[widget.indexForService!]
          //     .timesheetTaskDetailsData!.insert(widget.indexForTask!,TimesheetTaskDetailsData(
          //   testTaskDetails: TextEditingController(text: value)
          // ));

          //cont.dataList.removeAt(widget.indexForTask!);
          //
          // cont.dataList.add(value);
          // print("cont.dataList");
          // print(cont.dataList);

          if (cont.dataList.asMap().containsKey(widget.indexForTask!)) {
            cont.dataList.removeAt(widget.indexForTask!);
            cont.dataList.insert(widget.indexForTask!, value);
          } else {
            cont.dataList.add(value);
          }
              print("cont.dataList");
              print(cont.dataList);
          // cont.timesheetTaskListData[widget.indexForService!]
          //     .timesheetTaskDetailsData![widget.indexForTask!].testTaskDetails!.text = value;
        },
      );
    });
  }
}
