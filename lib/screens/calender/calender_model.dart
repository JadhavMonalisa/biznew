import 'dart:math';

import 'package:flutter/material.dart';

class CalenderModel {
  String? message;
  bool? success;
  List<CalenderData>? calenderData;

  CalenderModel({this.message, this.success, this.calenderData});

  CalenderModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['data'] != null) {
      calenderData = <CalenderData>[];
      json['data'].forEach((v) {
        calenderData!.add(CalenderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (calenderData != null) {
      data['data'] = calenderData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

//Color formattedColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

class CalenderData {
  String? title;
  String? start;
  String? constraint;
  String? color;
  int? newColor;
  //Color? ranColor;
  Color? formattedColor;

  CalenderData(
      {this.title,
      this.start,
      this.constraint,
      this.color,
      this.newColor,
      this.formattedColor});

  CalenderData.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    start = json['start'] ?? '';
    constraint = json['constraint'] ?? "";
    color = json['color'] ?? "";
    newColor = int.parse("0xFF${json['color'].toString().replaceAll("#", "")}");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['start'] = start;
    data['constraint'] = constraint;
    data['color'] = color;
    return data;
  }
}

class CalendarDueDateModel {
  String? message;
  bool? success;
  List<CalendarDueData>? data;

  CalendarDueDateModel({this.message, this.success, this.data});

  CalendarDueDateModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['data'] != null) {
      data = <CalendarDueData>[];
      json['data'].forEach((v) {
        data!.add(CalendarDueData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CalendarDueData {
  String? name;
  String? service;
  String? client;
  String? clientCode;
  String? triggerDate;
  String? targetDate;
  String? satDate;
  String? priority;
  String? status;
  String? completion;
  int? total;

  CalendarDueData(
      {this.name,
      this.service,
      this.client,
      this.clientCode,
      this.triggerDate,
      this.targetDate,
      this.satDate,
      this.priority,
      this.status,
      this.completion,
      this.total});

  CalendarDueData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    service = json['service'];
    client = json['client'];
    clientCode = json['client_code'];
    triggerDate = json['trigger_date'];
    targetDate = json['target_date'];
    satDate = json['sat_date'];
    priority = json['priority'];
    status = json['status'];
    completion = json['completion'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['service'] = service;
    data['client'] = client;
    data['client_code'] = clientCode;
    data['trigger_date'] = triggerDate;
    data['target_date'] = targetDate;
    data['sat_date'] = satDate;
    data['priority'] = priority;
    data['status'] = status;
    data['completion'] = completion;
    data['total'] = total;
    return data;
  }
}
