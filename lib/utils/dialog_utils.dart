//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../theme/app_colors.dart';
//
// class DialogUtils {
//   static showAlertDialog(var message,
//       {var heading, Color? color, bool? showError, bool goBack = false}) {
//     var scrollController = ScrollController();
//     var actionScrollController = ScrollController();
//     var child = CupertinoAlertDialog(
//       title: Text(heading ?? "Alert",
//           textScaleFactor: 1.0, style: TextStyle(color: color ?? hintColor)),
//       content: Text(message,
//           textScaleFactor: 1.0, style: TextStyle(color: color ?? hintColor)),
//       actions: <Widget>[
//         CupertinoDialogAction(
//           child: Text("OK",
//               textScaleFactor: 1.0, style: TextStyle(color: hintColor)),
//           onPressed: () {
//             Get.back();
//           },
//           isDefaultAction: false,
//           isDestructiveAction: false,
//         ),
//       ],
//       scrollController: scrollController,
//       actionScrollController: actionScrollController,
//     );
//
//     Get.dialog(child, barrierDismissible: false);
//   }
//
//   static void referralDialog() {
//     Get.generalDialog(
//       transitionDuration: Duration(milliseconds: 0),
//       pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
//         contentPadding: const EdgeInsets.only(bottom: 22),
//         content: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Align(
//                 alignment: Alignment.topRight,
//                 child: GestureDetector(
//                   child: Icon(
//                     Icons.cancel_rounded,
//                     color: closeColor,
//                     size: 26,
//                   ),
//                   onTap: () => Get.back(),
//                 ),
//               ),
//               SizedBox(
//                 height: 24,
//               ),
//               SvgIconWidget(
//                 icon: Assets.like,
//               ),
//               SizedBox(
//                 height: 34,
//               ),
//               CustomText(
//                 text: "Referral Code info",
//                 size: 20,
//                 color: titleBlackColor,
//                 fontWeight: FontWeight.w600,
//               ),
//               SizedBox(
//                 height: 9,
//               ),
//               CustomText(
//                 text:
//                     "Get referred by someone and grab AplifyCash in the wallet by using the referral code at the time of sign-up. This cash can be redeemed in various forms while using the app.",
//                 size: 14,
//                 textAlign: TextAlign.center,
//                 color: descriptionColor,
//                 maxLines: 8,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   static void communityInfoDialog(String? description) {
//     Get.generalDialog(
//       transitionDuration: Duration(milliseconds: 0),
//       pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
//         contentPadding: const EdgeInsets.only(bottom: 22),
//         content: Container(
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Align(
//                 alignment: Alignment.topRight,
//                 child: GestureDetector(
//                   child: Icon(
//                     Icons.cancel_rounded,
//                     color: closeColor,
//                     size: 26,
//                   ),
//                   onTap: () => Get.back(),
//                 ),
//               ),
//               SizedBox(
//                 height: 24,
//               ),
//               CustomText(
//                 text: "Community Info",
//                 size: 20,
//                 color: titleBlackColor,
//                 fontWeight: FontWeight.w600,
//               ),
//               SizedBox(
//                 height: 9,
//               ),
//               CustomText(
//                 text: description,
//                 size: 14,
//                 textAlign: TextAlign.center,
//                 color: descriptionColor,
//                 maxLines: 18,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   static Future<bool> logoutDialog() async {
//     return await Get.generalDialog(
//       transitionDuration: Duration(milliseconds: 0),
//       pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
//         contentPadding: const EdgeInsets.only(bottom: 22),
//         content: Container(
//           padding: const EdgeInsets.all(40),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CustomText(
//                 text: "Logout",
//                 size: 20,
//                 color: titleBlackColor,
//                 fontWeight: FontWeight.w600,
//               ),
//               SizedBox(
//                 height: 9,
//               ),
//               CustomText(
//                 text: "Are you sure you want to logout?",
//                 size: 14,
//                 textAlign: TextAlign.center,
//                 color: descriptionColor,
//               ),
//               SizedBox(
//                 height: 45,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   FlatButton(
//                     color: primaryColor,
//                     onPressed: () => Get.back(result: true),
//                     child: CustomText(
//                       text: "Yes, Logout",
//                       color: Colors.white,
//                       size: 14,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 7,
//                   ),
//                   // OutlineButton(
//                   //   borderSide: BorderSide(color: primaryColor),
//                   //   color: Colors.white,
//                   //   onPressed: () => Get.back(result: false),
//                   //   child: CustomText(
//                   //     text: "Cancel",
//                   //     color: primaryColor,
//                   //     size: 14,
//                   //     fontWeight: FontWeight.w600,
//                   //   ),
//                   // ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   static Future<bool> customDialog(
//       {required String title,
//       required String description,
//       required String firstButtonTitle,
//       required String secondButtonTitle}) async {
//     return await Get.generalDialog(
//       transitionDuration: Duration(milliseconds: 0),
//       pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
//         contentPadding: const EdgeInsets.only(bottom: 22),
//         content: Container(
//           padding:
//               const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CustomText(
//                 text: "$title",
//                 size: 20,
//                 color: titleBlackColor,
//                 fontWeight: FontWeight.w600,
//               ),
//               SizedBox(
//                 height: 45,
//               ),
//               CustomText(
//                 text: "$description",
//                 size: 14,
//                 maxLines: 3,
//                 textAlign: TextAlign.center,
//                 color: descriptionColor,
//               ),
//               SizedBox(
//                 height: 45,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   FlatButton(
//                     color: primaryColor,
//                     onPressed: () => Get.back(result: true),
//                     child: CustomText(
//                       text: "$firstButtonTitle",
//                       color: Colors.white,
//                       size: 14,
//                     ),
//                   ),
//                   // OutlineButton(
//                   //   borderSide: BorderSide(color: primaryColor),
//                   //   color: Colors.white,
//                   //   onPressed: () => Get.back(result: false),
//                   //   child: CustomText(
//                   //     text: "$secondButtonTitle",
//                   //     color: primaryColor,
//                   //     size: 14,
//                   //     fontWeight: FontWeight.w600,
//                   //   ),
//                   // ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   static Future<bool> profileDialog({
//     required String icon,
//     required String title,
//     required String description,
//   }) async {
//     return await Get.generalDialog(
//       transitionDuration: Duration(milliseconds: 0),
//       pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
//         contentPadding: const EdgeInsets.only(bottom: 22),
//         content: Container(
//           padding:
//               const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Align(
//                 alignment: Alignment.topRight,
//                 child: InkWell(
//                     onTap: () {
//                       Get.back();
//                     },
//                     child: Icon(
//                       Icons.close,
//                     )),
//               ),
//               Image.asset(
//                 icon,
//                 width: 30,
//                 height: 30,
//                 fit: BoxFit.fill,
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               CustomText(
//                 text: "$title",
//                 size: 20,
//                 maxLines: 3,
//                 textAlign: TextAlign.center,
//                 color: FF1F080D,
//                 fontWeight: FontWeight.w700,
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               CustomText(
//                 text: "$description",
//                 size: 14,
//                 maxLines: 13,
//                 textAlign: TextAlign.center,
//                 color: FF7F7779,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   static Future<bool> mediaDialog() async {
//     return await Get.generalDialog(
//       transitionDuration: Duration(milliseconds: 0),
//       pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
//         content: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CustomText(
//                 text: "Confirm",
//                 size: 20,
//                 color: titleBlackColor,
//                 fontWeight: FontWeight.w600,
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               CustomText(
//                 text: "Do you want to send image?",
//                 size: 14,
//                 textAlign: TextAlign.center,
//                 color: descriptionColor,
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   FlatButton(
//                     color: primaryColor,
//                     onPressed: () => Get.back(result: true),
//                     child: CustomText(
//                       text: "Yes",
//                       color: Colors.white,
//                       size: 14,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 7,
//                   ),
//                   // OutlineButton(
//                   //   borderSide: BorderSide(color: primaryColor),
//                   //   color: Colors.white,
//                   //   onPressed: () => Get.back(result: false),
//                   //   child: CustomText(
//                   //     text: "Cancel",
//                   //     color: primaryColor,
//                   //     size: 14,
//                   //     fontWeight: FontWeight.w600,
//                   //   ),
//                   // ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
