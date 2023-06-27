import 'package:biznew/constant/strings.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import 'bottom_nav_controller.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(builder: (cont) {
      return WillPopScope(
          onWillPop: () async {
            return await cont.showExitDialog(context);
          },
          child: Scaffold(
            body: SafeArea(
              child: cont.buildWidget(),
            ),
            floatingActionButtonLocation: ExpandableFab.location,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ExpandableFab(
                  key: _key,
                  type: ExpandableFabType.up,
                  distance: 70.0,
                  children: [
                    SizedBox(
                      width: 130.0,
                      child: FloatingActionButton.extended(
                        heroTag: "btn1",
                        onPressed: () {
                          Get.toNamed(AppRoutes.leaveList,
                              arguments: ["Leaves"]);
                        },
                        icon: const Icon(Icons.calendar_today),

                        backgroundColor: primaryColor,
                        label: buildTextBoldWidget(
                            "Leaves", whiteColor, context, 12.0),

                        //child:buildTextRegularWidget("Petty Task", whiteColor, context, 11.0)
                      ),
                    ),
                    SizedBox(
                      width: 130.0,
                      height: 45.0,
                      child: FloatingActionButton(
                        heroTag: "btn2",
                        onPressed: () {
                          Get.toNamed(AppRoutes.claimList,
                              arguments: ["Claim"]);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                        backgroundColor: primaryColor,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildTextBoldWidget(
                                Strings.rupees, whiteColor, context, 16.0),
                            buildTextBoldWidget(
                                "Claims", whiteColor, context, 12.0),
                          ],
                        ),
                        //label: buildRichTextWidget("${Strings.rupees}","Claim",
                        // title1Size: 16.0,title2Size: 13.0,
                        //   title1Weight: FontWeight.bold,title2Weight: FontWeight.w900,
                        //   title1Color: whiteColor,title2Color: whiteColor
                        // ),
                        //label: buildTextBoldWidget("${Strings.rupees} Claim", whiteColor, context, 12.0),
                        //child:buildTextRegularWidget("Petty Task", whiteColor, context, 11.0)
                      ),
                    ),
                    SizedBox(
                      width: 130.0,
                      child: FloatingActionButton.extended(
                        heroTag: "btn3",
                        onPressed: () {
                          Get.toNamed(AppRoutes.pettyTaskFrom,
                              arguments: ["Petty Task"]);
                        },
                        icon: const Icon(Icons.task),
                        backgroundColor: primaryColor,
                        label: buildTextBoldWidget(
                            "Petty Task", whiteColor, context, 12.0),
                        //child:buildTextRegularWidget("Petty Task", whiteColor, context, 11.0)
                      ),
                    )
                  ]),
            ),
            bottomNavigationBar: bottomNavigationBar(cont),
          ));
    });
  }

  bottomNavigationBar(BottomNavController cont) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: grey.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(25.0), topLeft: Radius.circular(25.0))),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          currentIndex: cont.selectedTabIndex,
          onTap: (int index) {
            cont.checkLoggedInUser(index);
          },
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: <BottomNavigationBarItem>[
            buildItem(Icons.dashboard, "Dashboard\n", 0, cont),
            buildItem(Icons.badge, "Employee\nDashboard", 1, cont),
            buildItem(Icons.person_pin_outlined, "Client\nDashboard", 2, cont),
            buildItem(Icons.timer, "Timesheet\n", 3, cont),
          ],
          selectedItemColor: primaryColor,
          unselectedItemColor: subTitleTextColor,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedLabelStyle: GoogleFonts.rubik(
              textStyle: const TextStyle(fontWeight: FontWeight.w500)),
          unselectedLabelStyle: GoogleFonts.rubik(
            textStyle: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  buildItem(
    IconData image,
    String title,
    int index,
    BottomNavController cont,
  ) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 3.0),
        child: CircleAvatar(
            radius: 20.0,
            backgroundColor: whiteColor,
            child: Center(
                child: Icon(
              image,
              color: cont.selectedTabIndex == index
                  ? primaryColor
                  : subTitleTextColor,
            ))),
      ),
      label: title,
    );
  }

  buildClaimItem(
    String image,
    String title,
    int index,
    BottomNavController cont,
  ) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 3.0),
        child: CircleAvatar(
            radius: 20.0,
            backgroundColor: whiteColor,
            child: Center(
                child: buildTextBoldWidget(
                    image,
                    cont.selectedTabIndex == index
                        ? primaryColor
                        : subTitleTextColor,
                    context,
                    22.0,
                    align: TextAlign.center))),
      ),
      label: title,
    );
  }
}
