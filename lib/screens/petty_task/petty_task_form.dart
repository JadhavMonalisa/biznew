import 'package:biznew/common_widget/error_text.dart';
import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/screens/petty_task/petty_task_controller.dart';
import 'package:biznew/screens/petty_task/petty_task_model.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PettyTaskForm extends StatefulWidget {
  const PettyTaskForm({Key? key}) : super(key: key);

  @override
  State<PettyTaskForm> createState() => _PettyTaskFormState();
}

class _PettyTaskFormState extends State<PettyTaskForm> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PettyTaskController>(builder: (cont)
    {
      return WillPopScope(
          onWillPop: () async{
            return cont.onWillPopBack();
          },
          child: Scaffold(
              backgroundColor: primaryColor,
              appBar: AppBar(
                centerTitle: true,elevation: 0.0,
                title: buildTextMediumWidget("Petty Task", whiteColor,context, 16,align: TextAlign.center),
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
                                        showWarningOnPettyTaskDialog(context,"Confirm Logout...!!!","Do you want to logout from an app?",logoutFeature:true,cont);
                                      },
                                      child: const Icon(Icons.logout),
                                    ),
                                    const SizedBox(width: 7.0,),
                                    GestureDetector(
                                        onTap:(){
                                          showWarningOnPettyTaskDialog(context,"Confirm Logout...!!!","Do you want to logout from an app?",logoutFeature:true,cont);
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
              body:  cont.loader == true ? Center(child: buildCircularIndicator(),) :
              Stack(
                children: [
                  Container(
                    color:primaryColor,
                    height: MediaQuery.of(context).size.height * 0.128,width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: CircleAvatar(
                          radius: 40.0,
                          backgroundColor: whiteColor,
                          child:Center(child:Icon(Icons.task,color: primaryColor,size: 50.0,))
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14,),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(25.0), topLeft: Radius.circular(25.0),),
                          color: whiteColor,
                        ),
                        padding: const EdgeInsets.all(20.0),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          physics: const ScrollPhysics(),
                          children: [

                            ///branch name
                            buildTimeSheetTitle(context,"Branch name"),
                            Container(
                                height: 40.0,width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: cont.validateBranchName?errorColor:grey),),
                                child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                      child: DropdownButton(
                                        hint: buildTextRegularWidget(cont.selectedBranchName==""?"Branch name":cont.selectedBranchName,
                                            cont.selectedBranchName==""?grey:blackColor, context, 15.0),
                                        isExpanded: true,
                                        underline: Container(),
                                        iconEnabledColor: cont.selectedBranchName==""?grey:blackColor,
                                        items:
                                        cont.branchNameList.isEmpty
                                            ?
                                        cont.noDataList.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList()
                                            : cont.branchNameList.map((Branchlist value) {
                                          return DropdownMenuItem<String>(
                                            value: value.name,
                                            child: Text(value.name!),
                                            onTap: (){
                                              cont.updateSelectedBranchId(value.id!);
                                            },
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          cont.checkBranchNameValidation(val!);
                                        },
                                      ),
                                    )
                                )
                            ),
                            cont.validateBranchName == true
                                ? ErrorText(errorMessage: "Please select branch name",)
                                : const Opacity(opacity: 0.0),
                            const SizedBox(height: 10.0,),

                            ///client name
                            buildTimeSheetTitle(context,"Client name"),
                            Container(
                                height: 40.0,width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: cont.validateClientName?errorColor:grey),),
                                child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                      child: DropdownButton(
                                        hint: buildTextRegularWidget(cont.selectedClientName==""?"Client name":cont.selectedClientName,
                                            cont.selectedClientName==""?grey:blackColor, context, 15.0),
                                        isExpanded: true,
                                        underline: Container(),
                                        iconEnabledColor: cont.selectedClientName==""?grey:blackColor,
                                        items:
                                        cont.clientNameList.isEmpty
                                            ?
                                        cont.noDataList.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList()
                                            : cont.clientNameList.map((Clientslist value) {
                                          return DropdownMenuItem<String>(
                                            value: value.firmClientFirmName,
                                            child: Text(value.firmClientFirmName!),
                                            onTap: (){
                                              cont.updateSelectedClientId(value.firmClientId!,context);
                                            },
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          //cont.updateSelectedClientName(val!,context);
                                          cont.checkClientNameValidation(val!,context);
                                        },
                                      ),
                                    )
                                )
                            ),
                            cont.validateClientName == true
                                ? ErrorText(errorMessage: "Please select client name",)
                                : const Opacity(opacity: 0.0),
                            const SizedBox(height:10.0,),

                            ///employee name
                            buildTimeSheetTitle(context,"Employee name"),
                            Container(
                                height: 40.0,width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: cont.validateEmployeeName?errorColor:grey),),
                                child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                      child: DropdownButton(
                                        hint: buildTextRegularWidget(cont.selectedEmployeeName==""?"Employee name":cont.selectedEmployeeName,
                                            cont.selectedEmployeeName==""?grey:blackColor, context, 15.0),
                                        isExpanded: true,
                                        underline: Container(),
                                        iconEnabledColor: cont.selectedEmployeeName==""?grey:blackColor,
                                        items:
                                        cont.employeeNameList.isEmpty
                                            ?
                                        cont.noDataList.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList()
                                            : cont.employeeNameList.map((EmplyeeList value) {
                                          return DropdownMenuItem<String>(
                                            value: value.firmEmployeeName,
                                            child: Text(value.firmEmployeeName!),
                                            onTap: (){
                                              cont.updateSelectedEmpId(value.mastId!,context);
                                            },
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          cont.checkEmployeeNameValidation(val!,context);
                                        },
                                      ),
                                    )
                                )
                            ),
                            cont.validateEmployeeName == true
                                ? ErrorText(errorMessage: "Please select employee name",)
                                : const Opacity(opacity: 0.0),
                            const SizedBox(height:10.0,),

                            ///trigger date
                            buildTimeSheetTitle(context,"Trigger date"),
                            GestureDetector(
                              onTap: (){cont.selectDate(context,"triggerDate");},
                              child: Container(
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color:  cont.validateTriggerDate?errorColor:grey),),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10.0,),
                                      Icon(Icons.calendar_today,color: cont.selectedTriggerDate==""?grey:blackColor,),
                                      const SizedBox(width: 10.0,),
                                      buildTextRegularWidget(cont.selectedTriggerDate==""?"Select Date":cont.selectedTriggerDate,
                                          cont.selectedTriggerDate==""?grey:blackColor, context, 15.0)
                                    ],
                                  )
                              ),
                            ),
                            cont.validateTriggerDate == true
                                ? ErrorText(errorMessage: "Please select trigger date",)
                                : const Opacity(opacity: 0.0),
                            const SizedBox(height:10.0,),

                            ///target date
                            buildTimeSheetTitle(context,"Target date"),
                            GestureDetector(
                              onTap: (){cont.selectDate(context,"targetDate");},
                              child: Container(
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color:  cont.validateTargetDate?errorColor:grey),),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10.0,),
                                      Icon(Icons.calendar_today,color: cont.selectedTargetDate==""?grey:blackColor,),
                                      const SizedBox(width: 10.0,),
                                      buildTextRegularWidget(cont.selectedTargetDate==""?"Select Date":cont.selectedTargetDate,
                                          cont.selectedTargetDate==""?grey:blackColor, context, 15.0)
                                    ],
                                  )
                              ),
                            ),
                            cont.validateTargetDate == true
                                ? ErrorText(errorMessage: "Please select target date",)
                                : const Opacity(opacity: 0.0),
                            const SizedBox(height:10.0,),

                            ///task
                            buildTimeSheetTitle(context,"Task"),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: cont.validateTask?errorColor:grey),),
                                child: TextFormField(
                                  controller: cont.task,
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.left,
                                  textCapitalization: TextCapitalization.words,
                                  textAlignVertical: TextAlignVertical.center,
                                  textInputAction: TextInputAction.done,
                                  onTap: () {},
                                  maxLines: 3,
                                  style:const TextStyle(fontSize: 15.0),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    hintText: "Enter task",
                                    hintStyle: GoogleFonts.rubik(textStyle: TextStyle(
                                      color: cont.validateTask?blackColor:grey, fontSize: 15,),),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (text) {
                                    cont.checkTaskValidation(context);
                                  },
                                ),
                            ),
                            cont.validateTask == true
                                ? ErrorText(errorMessage: "Please enter task",)
                                : const Opacity(opacity: 0.0),
                            const SizedBox(height:10.0,),
                          ],
                        ),
                      )
                  )
                ],
              ),
              bottomNavigationBar: cont.loader == true ? const Opacity(opacity:0.0):
              Container(
                  color: whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                    child:GestureDetector(
                      onTap: (){
                        cont.checkValidation(context);
                      },
                      child: buildButtonWidget(context, "Submit",radius: 5.0,height: 50.0),
                    ))
              )
          )
      );
    });
  }
}
