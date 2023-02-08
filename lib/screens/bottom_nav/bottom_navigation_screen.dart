import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      builder: (cont) {
        return WillPopScope(
            onWillPop: () async{
              return await cont.showExitDialog(context);
            },
        child:Scaffold(
          body: SafeArea(
            child: cont.buildWidget(),
          ),
          bottomNavigationBar: bottomNavigationBar(cont),
        )
        );
      }
    );
  }

  bottomNavigationBar(BottomNavController cont){
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(color: grey.withOpacity(0.2),
      borderRadius: const BorderRadius.only(topRight: Radius.circular(25.0),topLeft: Radius.circular(25.0))),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          currentIndex: cont.selectedTabIndex,
          onTap: (int index){
             cont.checkLoggedInUser(index);
          },
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: <BottomNavigationBarItem>[
            buildItem(Icons.dashboard, "Dashboard",0,cont),
            buildItem(Icons.timer, "Timesheet",1,cont),
            buildItem(Icons.filter_frames, "Claim",2,cont),
            buildItem(Icons.calendar_today, "Leaves",3,cont),
          ],
          selectedItemColor: primaryColor,
          unselectedItemColor: subTitleTextColor,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedLabelStyle: GoogleFonts.rubik(textStyle: const TextStyle(fontWeight: FontWeight.w500),),
          unselectedLabelStyle: GoogleFonts.rubik(textStyle: const TextStyle(fontWeight: FontWeight.w400),),
        ),
      ),
    );
  }

  buildItem(IconData image, String title,int index, BottomNavController cont,){
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 3.0),
        child: CircleAvatar(
            radius: 20.0,
            backgroundColor: whiteColor,
            child:Center(child:Icon(image,color: cont.selectedTabIndex == index ? primaryColor : subTitleTextColor,))
        ),
      ),
      label: title,
    );
  }
}
