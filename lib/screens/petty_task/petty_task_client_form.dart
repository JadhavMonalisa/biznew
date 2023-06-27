import 'package:biznew/common_widget/error_text.dart';
import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/screens/petty_task/petty_task_controller.dart';
import 'package:biznew/screens/petty_task/petty_task_model.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PettyTaskClientForm extends StatefulWidget {
  const PettyTaskClientForm({Key? key}) : super(key: key);

  @override
  State<PettyTaskClientForm> createState() => _PettyTaskClientFormState();
}

class _PettyTaskClientFormState extends State<PettyTaskClientForm> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PettyTaskController>(builder: (cont) {
      return WillPopScope(
          onWillPop: () async {
            return cont.navigateFromAddClient();
          },
          child: Scaffold(
              backgroundColor: primaryColor,
              appBar: AppBar(
                centerTitle: true,
                elevation: 0.0,
                title: buildTextMediumWidget(
                    "Add Client", whiteColor, context, 16,
                    align: TextAlign.center),
              ),
              drawer: Drawer(
                child: SizedBox(
                    height: double.infinity,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Center(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 1.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildDrawer(context, cont.name),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30.0,
                                      left: 10.0,
                                      bottom: 50.0,
                                      right: 10.0),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showWarningOnPettyTaskDialog(
                                              context,
                                              "Confirm Logout...!!!",
                                              "Do you want to logout from an app?",
                                              logoutFeature: true,
                                              cont);
                                        },
                                        child: const Icon(Icons.logout),
                                      ),
                                      const SizedBox(
                                        width: 7.0,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            showWarningOnPettyTaskDialog(
                                                context,
                                                "Confirm Logout...!!!",
                                                "Do you want to logout from an app?",
                                                logoutFeature: true,
                                                cont);
                                          },
                                          child: buildTextBoldWidget("Logout",
                                              blackColor, context, 15.0)),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {},
                                        child: buildTextRegularWidget(
                                            "App Version 1.0",
                                            grey,
                                            context,
                                            14.0),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              body: cont.loader == true
                  ? Center(
                      child: buildCircularIndicator(),
                    )
                  : Container(
                      color: whiteColor,
                      padding: const EdgeInsets.all(20.0),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        physics: const ScrollPhysics(),
                        children: [
                          ///constitution
                          buildTimeSheetTitle(context, "Constitution"),
                          Container(
                              height: 40.0,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                    color: cont.addClientValidateConstitution
                                        ? errorColor
                                        : grey),
                              ),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                child: DropdownButton(
                                  hint: buildTextRegularWidget(
                                      cont.selectedConstitution == ""
                                          ? "Constitution name"
                                          : cont.selectedConstitution,
                                      cont.selectedConstitution == ""
                                          ? grey
                                          : blackColor,
                                      context,
                                      15.0),
                                  isExpanded: true,
                                  underline: Container(),
                                  iconEnabledColor:
                                      cont.selectedConstitution == ""
                                          ? grey
                                          : blackColor,
                                  items: cont.constitutionList.isEmpty
                                      ? cont.noDataList.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList()
                                      : cont.constitutionList
                                          .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                            onTap: () {
                                              cont.updateSelectedConstitution(
                                                  value);
                                            },
                                          );
                                        }).toList(),
                                  onChanged: (val) {
                                    cont.checkConstitutionValidation(val!);
                                  },
                                ),
                              ))),
                          cont.addClientValidateConstitution == true
                              ? ErrorText(
                                  errorMessage: "Please select constitution",
                                )
                              : const Opacity(opacity: 0.0),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///client code
                          buildTimeSheetTitle(context, "Client Code"),
                          Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: cont.addClientValidateClientCode
                                      ? errorColor
                                      : grey),
                            ),
                            child: TextFormField(
                              controller: cont.clientCode,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              textCapitalization: TextCapitalization.words,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              onTap: () {},
                              style: const TextStyle(fontSize: 15.0),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Client Code",
                                hintStyle: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: cont.addClientValidateClientCode
                                        ? blackColor
                                        : grey,
                                    fontSize: 15,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                cont.checkClientCodeValidation(context);
                              },
                            ),
                          ),
                          cont.addClientValidateClientCode == true
                              ? ErrorText(
                                  errorMessage: "Please enter client code",
                                )
                              : const Opacity(opacity: 0.0),

                          ///company name
                          buildTimeSheetTitle(context, "Company Name"),
                          Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: cont.addClientValidateCompanyName
                                      ? errorColor
                                      : grey),
                            ),
                            child: TextFormField(
                              controller: cont.companyName,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              textCapitalization: TextCapitalization.words,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              onTap: () {},
                              style: const TextStyle(fontSize: 15.0),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Company Name",
                                hintStyle: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: cont.addClientValidateCompanyName
                                        ? blackColor
                                        : grey,
                                    fontSize: 15,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                cont.checkCompanyNameValidation(context);
                              },
                            ),
                          ),
                          cont.addClientValidateCompanyName == true
                              ? ErrorText(
                                  errorMessage: "Please enter company name",
                                )
                              : const Opacity(opacity: 0.0),

                          ///branch name
                          buildTimeSheetTitle(context, "Branch name"),
                          Container(
                              height: 40.0,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                    color: cont.validateBranchName
                                        ? errorColor
                                        : grey),
                              ),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                child: DropdownButton(
                                  hint: buildTextRegularWidget(
                                      cont.selectedBranchName == ""
                                          ? "Branch name"
                                          : cont.selectedBranchName,
                                      cont.selectedBranchName == ""
                                          ? grey
                                          : blackColor,
                                      context,
                                      15.0),
                                  isExpanded: true,
                                  underline: Container(),
                                  iconEnabledColor:
                                      cont.selectedBranchName == ""
                                          ? grey
                                          : blackColor,
                                  items: cont.branchNameList.isEmpty
                                      ? cont.noDataList.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList()
                                      : cont.branchNameList
                                          .map((Branchlist value) {
                                          return DropdownMenuItem<String>(
                                            value: value.name,
                                            child: Text(value.name!),
                                            onTap: () {
                                              cont.updateSelectedBranchId(
                                                  value.id!);
                                            },
                                          );
                                        }).toList(),
                                  onChanged: (val) {
                                    cont.checkBranchNameValidation(val!);
                                  },
                                ),
                              ))),
                          cont.validateBranchName == true
                              ? ErrorText(
                                  errorMessage: "Please select branch name",
                                )
                              : const Opacity(opacity: 0.0),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///client group
                          buildTimeSheetTitle(context, "Client Group"),
                          Container(
                              height: 40.0,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                    color: cont.validateClientGroup
                                        ? errorColor
                                        : grey),
                              ),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                child: DropdownButton(
                                  hint: buildTextRegularWidget(
                                      cont.selectedClientGroupName == ""
                                          ? "Select"
                                          : cont.selectedClientGroupName,
                                      cont.validateClientGroup
                                          ? grey
                                          : blackColor,
                                      context,
                                      15.0),
                                  isExpanded: true,
                                  underline: Container(),
                                  iconEnabledColor:
                                      cont.selectedClientGroupName == ""
                                          ? grey
                                          : blackColor,
                                  items: cont.groupList.isEmpty
                                      ? cont.noDataList.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList()
                                      : cont.groupList.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                            onTap: () {
                                              cont.updateSelectedClientGroup(
                                                  value);
                                            },
                                          );
                                        }).toList(),
                                  onChanged: (val) {
                                    cont.checkClientGroupValidation(val!);
                                  },
                                ),
                              ))),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///parent company
                          buildTimeSheetTitle(context, "Parent Company"),
                          Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: cont.validateParentCompany
                                      ? errorColor
                                      : grey),
                            ),
                            child: TextFormField(
                              controller: cont.parentCompanyName,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              textCapitalization: TextCapitalization.words,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              onTap: () {},
                              style: const TextStyle(fontSize: 15.0),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Parent Company",
                                hintStyle: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: cont.validateParentCompany
                                        ? blackColor
                                        : grey,
                                    fontSize: 15,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                cont.checkParentNameValidation(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///erstwhile
                          buildTimeSheetTitle(context, "Erstwhile Name"),
                          Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: cont.validateErstwhileName
                                      ? errorColor
                                      : grey),
                            ),
                            child: TextFormField(
                              controller: cont.erstWhileName,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              textCapitalization: TextCapitalization.words,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              onTap: () {},
                              style: const TextStyle(fontSize: 15.0),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Erstwhile Name",
                                hintStyle: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: cont.validateErstwhileName
                                        ? blackColor
                                        : grey,
                                    fontSize: 15,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                cont.checkErstwhileValidation(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///client cin
                          buildTimeSheetTitle(context, "Client CIN"),
                          Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: cont.validateClientCin
                                      ? errorColor
                                      : grey),
                            ),
                            child: TextFormField(
                              controller: cont.clientCin,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              textCapitalization: TextCapitalization.words,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              onTap: () {},
                              style: const TextStyle(fontSize: 15.0),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Client CIN",
                                hintStyle: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: cont.validateClientCin
                                        ? blackColor
                                        : grey,
                                    fontSize: 15,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                cont.checkClientCinValidation(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///client pan
                          buildTimeSheetTitle(context, "Client PAN"),
                          Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: cont.validateClientPan
                                      ? errorColor
                                      : grey),
                            ),
                            child: TextFormField(
                              controller: cont.clientPan,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              textCapitalization: TextCapitalization.words,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              onTap: () {},
                              style: const TextStyle(fontSize: 15.0),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Client PAN",
                                hintStyle: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: cont.validateClientPan
                                        ? blackColor
                                        : grey,
                                    fontSize: 15,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                cont.checkClientPanValidation(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///client tan
                          buildTimeSheetTitle(context, "Client TAN"),
                          Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: cont.validateClientTan
                                      ? errorColor
                                      : grey),
                            ),
                            child: TextFormField(
                              controller: cont.clientTan,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              textCapitalization: TextCapitalization.words,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              onTap: () {},
                              style: const TextStyle(fontSize: 15.0),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Client TAN",
                                hintStyle: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: cont.validateClientTan
                                        ? blackColor
                                        : grey,
                                    fontSize: 15,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                cont.checkClientTanValidation(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///client gstin
                          buildTimeSheetTitle(context, "Client GSTIN"),
                          Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: cont.validateClientGstin
                                      ? errorColor
                                      : grey),
                            ),
                            child: TextFormField(
                              controller: cont.clientGstin,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              textCapitalization: TextCapitalization.words,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              onTap: () {},
                              style: const TextStyle(fontSize: 15.0),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Client GSTIN",
                                hintStyle: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: cont.validateClientGstin
                                        ? blackColor
                                        : grey,
                                    fontSize: 15,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                cont.checkClientGstinValidation(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///industry
                          buildTimeSheetTitle(context, "Industry"),
                          Container(
                              height: 40.0,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                    color: cont.validateIndustry
                                        ? errorColor
                                        : grey),
                              ),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                child: DropdownButton(
                                  hint: buildTextRegularWidget(
                                      cont.selectedIndustryName == ""
                                          ? "Select"
                                          : cont.selectedIndustryName,
                                      cont.validateIndustry == ""
                                          ? grey
                                          : blackColor,
                                      context,
                                      15.0),
                                  isExpanded: true,
                                  underline: Container(),
                                  iconEnabledColor:
                                      cont.validateIndustry ? grey : blackColor,
                                  items: cont.industryList.isEmpty
                                      ? cont.noDataList.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList()
                                      : cont.industryList.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                            onTap: () {
                                              cont.updateSelectedBranchId(
                                                  value);
                                            },
                                          );
                                        }).toList(),
                                  onChanged: (val) {
                                    cont.checkIndustryValidation(val!);
                                  },
                                ),
                              ))),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///business nature
                          buildTimeSheetTitle(context, "Business Nature"),
                          Container(
                              height: 40.0,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                    color: cont.validateBusinessNature
                                        ? errorColor
                                        : grey),
                              ),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                child: DropdownButton(
                                  hint: buildTextRegularWidget(
                                      cont.selectedBusinessNature == ""
                                          ? "Select"
                                          : cont.selectedIndustryName,
                                      cont.validateBusinessNature
                                          ? grey
                                          : blackColor,
                                      context,
                                      15.0),
                                  isExpanded: true,
                                  underline: Container(),
                                  iconEnabledColor: cont.validateBusinessNature
                                      ? grey
                                      : blackColor,
                                  items: cont.businessNatureList.isEmpty
                                      ? cont.noDataList.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList()
                                      : cont.businessNatureList
                                          .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                            onTap: () {
                                              cont.updateSelectedBusinessNature(
                                                  value);
                                            },
                                          );
                                        }).toList(),
                                  onChanged: (val) {
                                    cont.checkBusinessNatureValidation(val!);
                                  },
                                ),
                              ))),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///birth date
                          buildTimeSheetTitle(context, "Birth date"),
                          GestureDetector(
                            onTap: () {
                              cont.selectDate(context, "birthDate");
                            },
                            child: Container(
                                height: 40.0,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  border: Border.all(
                                      color: cont.validateBirthDate
                                          ? errorColor
                                          : grey),
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Icon(
                                      Icons.calendar_today,
                                      color: cont.selectedBirthDate == ""
                                          ? grey
                                          : blackColor,
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    buildTextRegularWidget(
                                        cont.selectedBirthDate == ""
                                            ? "Select Date"
                                            : cont.selectedBirthDate,
                                        cont.validateBirthDate
                                            ? grey
                                            : blackColor,
                                        context,
                                        15.0)
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///trade name
                          buildTimeSheetTitle(context, "Trade Name"),
                          Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: cont.validateTradeName
                                      ? errorColor
                                      : grey),
                            ),
                            child: TextFormField(
                              controller: cont.tradeName,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              textCapitalization: TextCapitalization.words,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              onTap: () {},
                              style: const TextStyle(fontSize: 15.0),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Trade Name",
                                hintStyle: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: cont.validateTradeName
                                        ? blackColor
                                        : grey,
                                    fontSize: 15,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                cont.checkTradeNameValidation(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///date of incorporation
                          buildTimeSheetTitle(context, "Date of Incorporation"),
                          GestureDetector(
                            onTap: () {
                              cont.selectDate(context, "incorporationDate");
                            },
                            child: Container(
                                height: 40.0,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  border: Border.all(
                                      color: cont.validateDateOfIncorporation
                                          ? errorColor
                                          : grey),
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Icon(
                                      Icons.calendar_today,
                                      color: cont.validateDateOfIncorporation
                                          ? grey
                                          : blackColor,
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    buildTextRegularWidget(
                                        cont.selectedIncorporationDate == ""
                                            ? "Select Date"
                                            : cont.selectedIncorporationDate,
                                        cont.validateDateOfIncorporation
                                            ? grey
                                            : blackColor,
                                        context,
                                        15.0)
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///address line 1
                          buildTimeSheetTitle(context, "Address Line 1"),
                          Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: cont.validateAddressLine1
                                      ? errorColor
                                      : grey),
                            ),
                            child: TextFormField(
                              controller: cont.addressLine1,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              textCapitalization: TextCapitalization.words,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              onTap: () {},
                              style: const TextStyle(fontSize: 15.0),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Address Line 1",
                                hintStyle: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: cont.validateAddressLine1
                                        ? blackColor
                                        : grey,
                                    fontSize: 15,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                cont.checkAddressLine1Validation(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///address line 2
                          buildTimeSheetTitle(context, "Address Line 2"),
                          Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: cont.validateAddressLine2
                                      ? errorColor
                                      : grey),
                            ),
                            child: TextFormField(
                              controller: cont.addressLine2,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              textCapitalization: TextCapitalization.words,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              onTap: () {},
                              style: const TextStyle(fontSize: 15.0),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Address Line 2",
                                hintStyle: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: cont.validateAddressLine2
                                        ? blackColor
                                        : grey,
                                    fontSize: 15,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                cont.checkAddressLine2Validation(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///area
                          buildTimeSheetTitle(context, "Area"),
                          Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: cont.validateArea ? errorColor : grey),
                            ),
                            child: TextFormField(
                              controller: cont.area,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              textCapitalization: TextCapitalization.words,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              onTap: () {},
                              style: const TextStyle(fontSize: 15.0),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Area",
                                hintStyle: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color:
                                        cont.validateArea ? blackColor : grey,
                                    fontSize: 15,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                cont.checkAreaValidation(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///city
                          buildTimeSheetTitle(context, "City"),
                          Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: cont.validateCity ? errorColor : grey),
                            ),
                            child: TextFormField(
                              controller: cont.city,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              textCapitalization: TextCapitalization.words,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              onTap: () {},
                              style: const TextStyle(fontSize: 15.0),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "City",
                                hintStyle: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color:
                                        cont.validateCity ? blackColor : grey,
                                    fontSize: 15,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                cont.checkCityValidation(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///state
                          buildTimeSheetTitle(context, "State"),
                          Container(
                              height: 40.0,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                    color:
                                        cont.validateState ? errorColor : grey),
                              ),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                child: DropdownButton(
                                  hint: buildTextRegularWidget(
                                      cont.selectedState == ""
                                          ? "Select"
                                          : cont.selectedState,
                                      cont.validateState ? grey : blackColor,
                                      context,
                                      15.0),
                                  isExpanded: true,
                                  underline: Container(),
                                  iconEnabledColor:
                                      cont.validateState ? grey : blackColor,
                                  items: cont.stateList.isEmpty
                                      ? cont.noDataList.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList()
                                      : cont.stateList.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                            onTap: () {
                                              cont.updateSelectedState(value);
                                            },
                                          );
                                        }).toList(),
                                  onChanged: (val) {
                                    cont.checkStateValidation(val!);
                                  },
                                ),
                              ))),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///district
                          buildTimeSheetTitle(context, "District"),
                          Container(
                              height: 40.0,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                    color: cont.validateDistrict
                                        ? errorColor
                                        : grey),
                              ),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0),
                                child: DropdownButton(
                                  hint: buildTextRegularWidget(
                                      cont.selectedDistrict == ""
                                          ? "Select"
                                          : cont.selectedDistrict,
                                      cont.validateDistrict ? grey : blackColor,
                                      context,
                                      15.0),
                                  isExpanded: true,
                                  underline: Container(),
                                  iconEnabledColor:
                                      cont.validateDistrict ? grey : blackColor,
                                  items: cont.districtList.isEmpty
                                      ? cont.noDataList.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList()
                                      : cont.districtList.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                            onTap: () {
                                              cont.updateSelectedDistrict(
                                                  value);
                                            },
                                          );
                                        }).toList(),
                                  onChanged: (val) {
                                    cont.checkDistrictValidation(val!);
                                  },
                                ),
                              ))),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///pincode
                          buildTimeSheetTitle(context, "Pincode"),
                          Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color:
                                      cont.validatePincode ? errorColor : grey),
                            ),
                            child: TextFormField(
                              controller: cont.pincode,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              textCapitalization: TextCapitalization.words,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              onTap: () {},
                              style: const TextStyle(fontSize: 15.0),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Pincode",
                                hintStyle: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: cont.validatePincode
                                        ? blackColor
                                        : grey,
                                    fontSize: 15,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                cont.checkPincodeValidation(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///landline no
                          buildTimeSheetTitle(context, "Landline No"),
                          Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: cont.validateLandlineNo
                                      ? errorColor
                                      : grey),
                            ),
                            child: TextFormField(
                              controller: cont.landlineNo,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              textCapitalization: TextCapitalization.words,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              onTap: () {},
                              style: const TextStyle(fontSize: 15.0),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Landline No",
                                hintStyle: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: cont.validateLandlineNo
                                        ? blackColor
                                        : grey,
                                    fontSize: 15,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                cont.checkLandlineNoValidation(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          ///no of plants
                          buildTimeSheetTitle(context, "No of Plants"),
                          Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: cont.validateNoOfPlants
                                      ? errorColor
                                      : grey),
                            ),
                            child: TextFormField(
                              controller: cont.noOfPlants,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              textCapitalization: TextCapitalization.words,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              onTap: () {},
                              style: const TextStyle(fontSize: 15.0),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "No of Plants",
                                hintStyle: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: cont.validateNoOfPlants
                                        ? blackColor
                                        : grey,
                                    fontSize: 15,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                cont.checkNoOfPlantsValidation(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          buildTimeSheetTitle(context, "WhatsApp No"),
                          Row(
                            children: [
                              Flexible(
                                child: Container(
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    border: Border.all(color: grey),
                                  ),
                                  child: const Center(
                                    child: CountryCodePicker(
                                      onChanged: print,
                                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                      initialSelection: 'IN',
                                      //favorite: ['+39','FR'],
                                      // optional. Shows only country name and flag
                                      showCountryOnly: false,
                                      // optional. Shows only country name and flag when popup is closed.
                                      showOnlyCountryWhenClosed: false,
                                      // optional. aligns the flag and the Text left
                                      alignLeft: false,
                                      showFlag: false,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Flexible(
                                flex: 5,
                                child: Container(
                                  height: 40.0,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    border: Border.all(
                                        color: cont.validateWhatsAppNo
                                            ? errorColor
                                            : grey),
                                  ),
                                  child: TextFormField(
                                    controller: cont.whatsAppNo,
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.left,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    textAlignVertical: TextAlignVertical.center,
                                    textInputAction: TextInputAction.done,
                                    onTap: () {},
                                    style: const TextStyle(fontSize: 15.0),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(10),
                                      hintText: "WhatsApp No",
                                      hintStyle: GoogleFonts.rubik(
                                        textStyle: TextStyle(
                                          color: cont.validateWhatsAppNo
                                              ? blackColor
                                              : grey,
                                          fontSize: 15,
                                        ),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (text) {
                                      cont.checkWhatsAppNoValidation(context);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          buildTimeSheetTitle(context, "Client Email"),
                          Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: cont.validateClientEmail
                                      ? errorColor
                                      : grey),
                            ),
                            child: TextFormField(
                              controller: cont.clientEmail,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              textCapitalization: TextCapitalization.words,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              onTap: () {},
                              style: const TextStyle(fontSize: 15.0),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Client Email",
                                hintStyle: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    color: cont.validateClientEmail
                                        ? blackColor
                                        : grey,
                                    fontSize: 15,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                cont.checkClientEmailValidation(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
              bottomNavigationBar: cont.loader == true
                  ? const Opacity(opacity: 0.0)
                  : Container(
                      color: whiteColor,
                      child: Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              cont.checkValidation(context);
                            },
                            child: buildButtonWidget(context, "Save",
                                radius: 5.0, height: 50.0),
                          )))));
    });
  }
}
