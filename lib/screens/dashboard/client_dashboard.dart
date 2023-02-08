import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/screens/dashboard/dashboard_controller.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientDashboard extends StatefulWidget {
  const ClientDashboard({Key? key}) : super(key: key);

  @override
  State<ClientDashboard> createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (cont)
    {
      return WillPopScope(
          onWillPop: () async{
            return cont.onWillPopBack();
          },
          child:Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: buildTextMediumWidget("Client Dashboard", whiteColor,context, 16,align: TextAlign.center),
              ),
              drawer: Drawer(
                child: SizedBox(
                    height: double.infinity,
                    child: ListView(
                      children: [
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildDrawer(context,cont.name),
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0,left: 10.0,bottom: 30.0,right: 10.0),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        showDashboardDialog(context,"Confirm Logout...!!!","Do you want to logout from an app?",logoutFeature:true,cont);
                                      },
                                      child: const Icon(Icons.logout),
                                    ),
                                    const SizedBox(width: 7.0,),
                                    GestureDetector(
                                        onTap:(){
                                          showDashboardDialog(context,"Confirm Logout...!!!","Do you want to logout from an app?",logoutFeature:true,cont);
                                        },
                                        child:buildTextBoldWidget("Logout", blackColor, context, 15.0)
                                    ),const Spacer(),
                                    GestureDetector(
                                      onTap:(){
                                      },
                                      child: buildTextRegularWidget("App Version 1.0", grey, context, 14.0),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
              ),
              body: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: cont.employeeList.length,
                        itemBuilder: (context,index){
                          final item = cont.employeeList[index];
                          return Padding(padding: const EdgeInsets.only(left:10.0,right: 10.0,bottom: 2.0),
                              child:Card(
                                  color: faintGrey,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0),
                                      side: const BorderSide(color: grey)),
                                  child: Padding(
                                    padding:const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 5.0,),
                                        Row(
                                          children: [
                                            buildTextBoldWidget("Test", blackColor, context, 14.0),const Spacer(),
                                            buildTextRegularWidget("28/06/2019 12.00 AM", blackColor, context, 14.0),
                                          ],
                                        ),
                                        const Divider(color: primaryColor,),
                                        const SizedBox(height: 5.0,),
                                        buildTextBoldWidget("Anil Joshi", primaryColor, context, 14.0),
                                        const SizedBox(height: 5.0,),
                                        buildTextRegularWidget("INR 123", blackColor, context, 14.0),
                                        const SizedBox(height: 5.0,),
                                        Row(
                                          children: [
                                            buildTextRegularWidget("123", blackColor, context, 14.0),const Spacer(),
                                            const Icon(Icons.arrow_forward_ios,color: blackColor,),
                                          ],
                                        ),
                                        const SizedBox(height: 5.0,),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: buildTextRegularWidget("Paid To : Aniket Joshi", blackColor, context, 14.0),
                                        )
                                      ],
                                    ),
                                  )
                              ));
                        }),
                  ))
          ));
    });
  }
}
