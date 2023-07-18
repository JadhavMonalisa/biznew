import 'package:biznew/screens/timesheet_new/timesheet_new_controller.dart';
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
         if (cont.dataList.asMap().containsKey(widget.indexForTask!)) {
            cont.dataList.removeAt(widget.indexForTask!);
            cont.dataList.insert(widget.indexForTask!, value);
            cont.isDetailsAdd = true;
          } else {
            cont.dataList.add(value);
            //cont.isDetailsAdd = true;
            cont.isDetailsAdd = true;
          }

         if(cont.hrList.isEmpty || cont.hrList[widget.indexForTask!].toString().contains("")){
           cont.isTimeSpentAdd = false;
         }
         else{
           cont.isTimeSpentAdd = true;
         }
        },
      );
    });
  }
}
