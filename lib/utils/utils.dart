import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Utils {
  static void back(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  static String convertEpochToMonth(int dateTime) {
    //print("epoch $dateTime");
    // ignore: unnecessary_null_comparison
    if (dateTime == null) return "";
    DateTime localTime = DateTime.fromMillisecondsSinceEpoch(dateTime);
    return "${DateFormat("MMM").format(localTime)} ${localTime.year}"
        .toUpperCase();
  }

  static String convertEpochDate(int? dateTime) {
    //print("epoch $dateTime");
    if (dateTime == null) return "";
    DateTime localTime = DateTime.fromMillisecondsSinceEpoch(dateTime);
    return DateFormat("MMMM d yyyy").format(localTime).toUpperCase();
  }

  static String convertEpochTime(int? dateTime) {
    //print("epoch $dateTime");
    if (dateTime == null) return "";
    DateTime localTime = DateTime.fromMillisecondsSinceEpoch(dateTime);
    return DateFormat("hh:mm").format(localTime).toUpperCase();
  }

  static String convertEpochDateTime(int? dateTime) {
    //print("epoch $dateTime");
    if (dateTime == null) return "";
    DateTime localTime = DateTime.fromMillisecondsSinceEpoch(dateTime);
    return DateFormat("MMMM d yyyy hh:mm").format(localTime).toUpperCase();
  }

  static String convertEpochDateTimeForChat(int? dateTime) {
    //print("epoch $dateTime");
    if (dateTime == null) return "";
    DateTime localTime = DateTime.fromMillisecondsSinceEpoch(dateTime);
    return DateFormat("MMMM d yyyy").format(localTime).toUpperCase();
  }

  static void setStatusBarColor(Color color) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
    ));
  }

  static Future<bool> isConnectedToInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  static void showLoadingDialog() {
    Get.generalDialog(
        barrierColor: Colors.white.withOpacity(0.2),
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 0),
        pageBuilder: (context, animation, secondaryAnimation) =>
            SizedBox.expand(
              // makes widget fullscreen
              child: Center(
                child: Card(
                    color: Colors.white.withOpacity(.9),
                    elevation: 4,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    )),
              ),
            ));
  }

  static void dismissLoadingDialog() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  static void showErrorSnackBar(String? error, {bool instantInit = true}) {
    Get.snackbar("Error", error!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        instantInit: instantInit,
        colorText: whiteColor,
        margin: const EdgeInsets.only(bottom: 200, left: 10, right: 10));
  }
  static void showSnackBar(String? error, {bool instantInit = true}) {
    Get.snackbar(error!,"",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        instantInit: instantInit,
        colorText: whiteColor,
        margin: const EdgeInsets.only(bottom: 200, left: 10, right: 10));
  }

  static void showAlertSnackBar(String error, {bool instantInit = true}) {
    Get.snackbar(
      "Alert", error,
      colorText: Colors.black,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.yellow,
      instantInit: instantInit,
      margin: const EdgeInsets.only(bottom: 200, left: 10, right: 10),
    );
  }

  static void showSuccessSnackBar(String? error) {
    Get.snackbar(
      "Success", error!,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: whiteColor,
      margin: const EdgeInsets.only(bottom: 200, left: 10, right: 10),
    );
  }

  static DateTime convertTimeToDateTime(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    return DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  }

  static DateTime convertDateTimeAndAddTime(
      DateTime dateTime, int hours, int minute) {
    return DateTime(
        dateTime.year, dateTime.month, dateTime.day, hours, minute);
  }

  static Widget getCircularProgressIndicator() {
    return const SizedBox(
        height: 40,
        width: 40,
        child: Center(child: CircularProgressIndicator()));
  }

  static Widget getNoDataWidget(BuildContext context) {
    return Center(
        child: buildTextMediumWidget("No Data Found",Colors.black,context, 18,
    ));
  }

  static void dismissKeyboard() {
    Get.focusScope!.unfocus();
  }

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static String getFileExtension(File file) {
    return file.path.split('.').last.toLowerCase();
  }

  static bool isFileImageOrVideo(File file) {
    var extension = getFileExtension(file);
    if (extension.contains("jpg") ||
        extension.contains("jpeg") ||
        extension.contains("png") ||
        extension.contains("mp4") ||
        extension.contains("mkv") ||
        extension.contains("mov")) {
      return true;
    }
    return false;
  }

  static bool isFileImage(File file) {
    var extension = getFileExtension(file);
    if (extension.contains("jpg") ||
        extension.contains("jpeg") ||
        extension.contains("png")) {
      return true;
    }
    return false;
  }

  static formatVideoDuration(double time) {
    var duration = Duration(milliseconds: time.toInt());
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static String getMediaType(File file) {
    var data = isFileImage(file);
    if (data) {
      return "Image";
    }
    return "Video";
  }

  static int getRandomNumber() {
    int max = 5;

    return Random().nextInt(max) + 1;
  }

  static double getLength(String? text, double fontSize, String fontFamily) {
    const constraints = BoxConstraints(
      maxWidth: 800.0, // maxwidth calculated
      minHeight: 0.0,
      minWidth: 0.0,
    );

    RenderParagraph renderParagraph = RenderParagraph(
      TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily,
        ),
      ),
      maxLines: 1,
      textDirection: ui.TextDirection.ltr,
    );
    renderParagraph.layout(constraints);
    double textlen =
        renderParagraph.getMinIntrinsicWidth(fontSize).ceilToDouble();
    return textlen;
  }

  static String? convertDateIntoDisplayStringPLan(DateTime date) {
    var format = DateFormat.yMMMd();
    return format.format(date);
  }

  static String convertDateIntoDisplayString(DateTime date) {
    var format = DateFormat.yMMMEd();
    return format.format(date);
  }

  static String convertDateIntoFormattedString(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  static String convertDateIntoMMYYYYString(DateTime date) {
    return "${date.month}/${date.year}";
  }

  static String convertDateIntoFormattedTime(DateTime date) {
    DateTime tempDate = DateFormat("hh:mm")
        .parse("${date.hour}:${date.minute}");
    var dateFormat = DateFormat("h:mm a");

    return dateFormat.format(tempDate);
  }

  static String convertDateIntoFormattedBidString(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  static formatFoodType(String type) {
    var foodtype = "";
    if (type == "1") {
      foodtype = "Veg";
    } else if (type == "2") {
      foodtype = "Nonveg";
    } else if (type == "3") {
      foodtype = "Eggetarian";
    } else {
      foodtype = "Vegan";
    }
    return foodtype;
  }

  static String getChatInvitationText(int status) {
    var result = "Invite";

    if (status == 0) {
      result = "Invite";
    } else if (status == 1) {
      result = "Invited";
    } else if (status == 2) {
      result = "Accept";
    } else {
      result = "Message";
    }

    return result;
  }

  String formatTimeOfDay(TimeOfDay tod) {
    // ignore: unnecessary_null_comparison
    if (tod == null) return "";
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  String formatWaterTimeOfDay(TimeOfDay tod) {
    // ignore: unnecessary_null_comparison
    if (tod == null) return "";
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.Hms(); //"6:00 AM"
    return format.format(dt);
  }

  String getQuatityType(int quantityType) {
    String qtyType = "";
    if (quantityType == 1) {
      qtyType = "gm";
    } else if (quantityType == 2) {
      qtyType = "mg";
    } else if (quantityType == 3) {
      qtyType = "kg";
    } else if (quantityType == 4) {
      qtyType = "ml";
    } else if (quantityType == 5) {
      qtyType = "L";
    } else if (quantityType == 6) {
      qtyType = "piece";
    }
    return qtyType;
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  String getCoachExp(int expLevel) {
    String coachExp = "Basic";
    switch (expLevel) {
      case 1:
        coachExp = "Basic";
        break;
      case 2:
        coachExp = "Standard";
        break;
      case 5:
        coachExp = "Advanced";
        break;
      case 3:
        coachExp = "Proficient";
        break;
      case 4:
        coachExp = "Expert";
        break;
    }
    return coachExp;
  }

  // static Future<DetailsResponse?> getLatLongFromAddress(String placeId) async {
  //   print("adderss : $placeId");
  //   try {
  //     GooglePlace googlePlace = GooglePlace(Strings.apiKey);
  //     DetailsResponse? detail = await googlePlace.details.get(placeId);
  //     return detail;
  //   } catch (e) {
  //     print("========error======= ${e.toString()}");
  //     return null;
  //   }
  // }

}


