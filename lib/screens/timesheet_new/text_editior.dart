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
  String? taskId;
  TextEditingForAllotted({Key? key,this.controller,this.indexForService,this.indexForTask,this.enabled,this.taskId}) : super(key: key);

  @override
  State<TextEditingForAllotted> createState() => _TextEditingForAllottedState();

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   return GetBuilder<TimesheetNewFormController>(builder: (cont)
  //   {
  //     return TextFormField(
  //       controller: controller,
  //       keyboardType: TextInputType.text,
  //       textAlign: TextAlign.left,
  //       textAlignVertical: TextAlignVertical.center,
  //       textInputAction: TextInputAction.done,
  //       onTap: () {},
  //       enabled: enabled,
  //       style: const TextStyle(fontSize: 15.0),
  //       decoration: InputDecoration(
  //         contentPadding: const EdgeInsets.all(10),
  //         hintText: "Details",
  //         hintStyle: GoogleFonts.rubik(
  //           textStyle: TextStyle(
  //             color: enabled == true ? blackColor : grey,
  //             fontSize: 15,
  //           ),
  //         ),
  //         border: InputBorder.none,
  //       ),
  //       onChanged: (value) {
  //         ///add task id
  //         if(cont.taskIdList.contains(taskId)){}
  //         else{
  //           cont.taskIdList.add(taskId!);
  //         }
  //
  //         if(cont.dataList.isEmpty){
  //           cont.dataList.add(value);
  //         }
  //         else{
  //           cont.dataList.clear();
  //           if (cont.dataList.asMap().containsKey(indexForTask!)) {
  //             print("Before remove");
  //             print(cont.dataList);
  //             cont.dataList.removeAt(indexForTask!);
  //             print("After remove");
  //             print(cont.dataList);
  //             cont.dataList.insert(indexForTask!, value);
  //
  //             print("In if text");
  //             print(cont.dataList);
  //             cont.isDetailsAdd = true;
  //           } else {
  //             cont.dataList.add(value);
  //             print("In else text");
  //             print(cont.dataList);
  //             cont.isDetailsAdd = true;
  //           }
  //         }
  //
  //         // if(addedTextIndex.contains(widget.indexForTask)){
  //         //   addedTextIndex.remove(widget.indexForTask);
  //         //   addedTextIndex.insert(widget.indexForTask!,widget.indexForTask!);
  //         // }
  //         // else{
  //         //   addedTextIndex.add(widget.indexForTask!);
  //         // }
  //
  //         if(cont.hrList.isEmpty || cont.hrList[indexForTask!].toString().contains("")){
  //           cont.isTimeSpentAdd = false;
  //         }
  //         else{
  //           cont.isTimeSpentAdd = true;
  //         }
  //         print("widget.indexForTask");
  //         print(indexForTask);
  //         //cont.onDetailsTextChange(value,widget.taskId!,widget.indexForTask!);
  //       },
  //     );
  //   });
  // }
}

class _TextEditingForAllottedState extends State<TextEditingForAllotted> {

  List<String> addedTextIndex = [];
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
          ///add task id
          if(cont.taskIdList.contains(widget.taskId)){}
          else{
            cont.taskIdList.add(widget.taskId!);
          }

        if(cont.dataList.isEmpty){
          cont.dataList.add(value);
        }
        else{
          // if (cont.dataList.asMap().containsKey(widget.indexForTask!)) {
          //   print("Before remove");
          //   print(cont.dataList);
          //   cont.dataList.removeAt(widget.indexForTask!);
          //   print("After remove");
          //   print(cont.dataList);
          //   cont.dataList.insert(widget.indexForTask!, value);
          //
          //   print("In if text");
          //   print(cont.dataList);
          //   cont.isDetailsAdd = true;
          // } else {
          //   cont.dataList.add(value);
          //   print("In else text");
          //   print(cont.dataList);
          //   cont.isDetailsAdd = true;
          // }
          if (cont.dataList.asMap().containsKey(widget.indexForTask!)) {
            print("Before remove");
            print(cont.dataList);
            cont.dataList.removeAt(widget.indexForTask!);
            print("After remove");
            print(cont.dataList);
            cont.dataList.insert(widget.indexForTask!, value);

            print("In if text");
            print(cont.dataList);
            cont.isDetailsAdd = true;
          } else {
            cont.dataList.add(value);
            print("In else text");
            print(cont.dataList);
            cont.isDetailsAdd = true;
          }
        }

          // if(addedTextIndex.contains(widget.indexForTask)){
          //   addedTextIndex.remove(widget.indexForTask);
          //   addedTextIndex.insert(widget.indexForTask!,widget.indexForTask!);
          // }
          // else{
          //   addedTextIndex.add(widget.indexForTask!);
          // }

         if(cont.hrList.isEmpty || cont.hrList[widget.indexForTask!].toString().contains("")
         || cont.hrList[widget.indexForTask!].toString() == ""){
           cont.isTimeSpentAdd = false;
         }
         else{
           cont.isTimeSpentAdd = true;
         }
         print("widget.indexForTask");
         print(widget.indexForTask);
         //cont.onDetailsTextChange(value,widget.taskId!,widget.indexForTask!);
        },
      );
    });
  }
}
