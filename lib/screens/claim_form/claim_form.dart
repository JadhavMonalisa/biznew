import 'package:biznew/common_widget/error_text.dart';
import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/constant/strings.dart';
import 'package:biznew/screens/claim_form/claim_form_controller.dart';
import 'package:biznew/screens/claim_form/claim_model.dart';
import 'package:biznew/theme/app_colors.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ClaimForm extends StatefulWidget {
  const ClaimForm({Key? key}) : super(key: key);

  @override
  State<ClaimForm> createState() => _ClaimFormState();
}

class _ClaimFormState extends State<ClaimForm> {
  String screenFor = Get.arguments[0];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClaimFormController>(builder: (cont) {
      return WillPopScope(
          onWillPop: () async {
            return cont.onWillPopBack();
          },
          child: Scaffold(
              backgroundColor: primaryColor,
              appBar: AppBar(
                centerTitle: true,
                elevation: 0.0,
                title: buildTextMediumWidget(
                    "Claim Form", whiteColor, context, 16,
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
                                          showWarningOnClaimFormDialog(
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
                                            showWarningOnClaimFormDialog(
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
                  : Stack(
                      children: [
                        Container(
                          color: primaryColor,
                          height: MediaQuery.of(context).size.height * 0.128,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: CircleAvatar(
                                radius: 40.0,
                                backgroundColor: whiteColor,
                                child: Center(
                                    child: buildTextBoldWidget(Strings.rupees,
                                        primaryColor, context, 50.0,
                                        align: TextAlign.center))),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.14,
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25.0),
                                  topLeft: Radius.circular(25.0),
                                ),
                                color: whiteColor,
                              ),
                              padding: const EdgeInsets.all(20.0),
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: ListView(
                                physics: const ScrollPhysics(),
                                children: [
                                  ///claim date
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: [
                                      buildTextRegularWidget("Claim Date  ",
                                          blackColor, context, 15.0),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      screenFor == "add"
                                          ? buildTextRegularWidget(
                                              cont.todayDateToShow,
                                              blackColor,
                                              context,
                                              15.0)
                                          : GestureDetector(
                                              onTap: () {
                                                cont.selectDate(
                                                    context, "claim");
                                              },
                                              child: buildTextRegularWidget(
                                                  cont.selectedClaimDateToShow ==
                                                          ""
                                                      ? cont.todayDateToShow
                                                      : cont
                                                          .selectedClaimDateToShow,
                                                  blackColor,
                                                  context,
                                                  15.0),
                                            )
                                    ],
                                  ),

                                  ///claim type
                                  Row(
                                    children: [
                                      buildTextRegularWidget("Claim Type  ",
                                          blackColor, context, 15.0),
                                      Radio<int>(
                                        value: 0,
                                        groupValue: cont.selectedClaimType,
                                        activeColor: primaryColor,
                                        onChanged: (int? value) {
                                          cont.updateSelectedClaimType(
                                              value!, context);
                                        },
                                      ),
                                      buildTextRegularWidget(
                                          "Office", blackColor, context, 15.0),
                                      Radio<int>(
                                        value: 1,
                                        groupValue: cont.selectedClaimType,
                                        activeColor: primaryColor,
                                        onChanged: (int? value) {
                                          cont.updateSelectedClaimType(
                                              value!, context);
                                        },
                                      ),
                                      buildTextRegularWidget(
                                          "Client", blackColor, context, 15.0),
                                    ],
                                  ),
                                  cont.validateClaimType == true
                                      ? ErrorText(
                                          errorMessage:
                                              "Please select claim type",
                                        )
                                      : const Opacity(opacity: 0.0),

                                  ///nature of claim
                                  Container(
                                      height: 40.0,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            color: cont.validateNatureOfClaim
                                                ? errorColor
                                                : grey),
                                      ),
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, right: 15.0),
                                        child: DropdownButton(
                                          hint: buildTextRegularWidget(
                                              cont.natureOfClaim == ""
                                                  ? "Nature Of Claim"
                                                  : cont.natureOfClaim,
                                              blackColor,
                                              context,
                                              15.0),
                                          isExpanded: true,
                                          underline: Container(),
                                          items: cont.natureOfClaimList.isEmpty
                                              ? cont.noDataList
                                                  .map((claimNature) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: claimNature,
                                                    child: Text(claimNature),
                                                  );
                                                }).toList()
                                              : cont.natureOfClaimList.map(
                                                  (NatureOfClaimList
                                                      claimNature) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: claimNature.name,
                                                    child:
                                                        Text(claimNature.name!),
                                                    onTap: () {
                                                      cont.updateSelectedNatureOfClaimId(
                                                          claimNature.id!);
                                                    },
                                                  );
                                                }).toList(),
                                          onChanged: (val) {
                                            cont.updateSelectedNatureOfClaim(
                                                val!, context);
                                          },
                                        ),
                                      ))),
                                  cont.validateNatureOfClaim == true
                                      ? ErrorText(
                                          errorMessage:
                                              "Please select nature of claim",
                                        )
                                      : const Opacity(opacity: 0.0),

                                  ///particular
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            color: cont.validateClaimParticular
                                                ? errorColor
                                                : grey),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 5.0, left: 5.0),
                                            child: Icon(
                                              Icons.backup_table,
                                              color: blackColor,
                                            ),
                                          ),
                                          Flexible(
                                            child: TextFormField(
                                              controller: cont.claimParticular,
                                              keyboardType: TextInputType.text,
                                              textAlign: TextAlign.left,
                                              textCapitalization:
                                                  TextCapitalization.words,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              textInputAction:
                                                  TextInputAction.done,
                                              onTap: () {},
                                              maxLines: 3,
                                              style: const TextStyle(
                                                  fontSize: 15.0),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.all(10),
                                                hintText: "Particulars",
                                                hintStyle: GoogleFonts.rubik(
                                                  textStyle: const TextStyle(
                                                    color: blackColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                border: InputBorder.none,
                                              ),
                                              onChanged: (text) {
                                                //cont.addParticular(text);
                                                cont.checkClaimParticularValidation(
                                                    context);
                                              },
                                            ),
                                          )
                                        ],
                                      )),
                                  cont.validateClaimParticular == true
                                      ? ErrorText(
                                          errorMessage:
                                              "Please enter valid particular",
                                        )
                                      : const Opacity(opacity: 0.0),

                                  ///travel form
                                  cont.natureOfClaim ==
                                          "Travelling / Local Conveyance"
                                      ? const SizedBox(
                                          height: 15,
                                        )
                                      : const Opacity(opacity: 0.0),
                                  cont.natureOfClaim ==
                                          "Travelling / Local Conveyance"
                                      ? Container(
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            color: grey.withOpacity(0.2),
                                            border: Border.all(
                                                color: cont.validateTravelFrom
                                                    ? errorColor
                                                    : grey),
                                          ),
                                          child: TextFormField(
                                            controller: cont.claimTravelFrom,
                                            keyboardType: TextInputType.text,
                                            textAlign: TextAlign.left,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            textCapitalization:
                                                TextCapitalization.words,
                                            textInputAction:
                                                TextInputAction.done,
                                            onTap: () {},
                                            enabled: true,
                                            style:
                                                const TextStyle(fontSize: 15.0),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(10),
                                              hintText: "Travel From",
                                              hintStyle: GoogleFonts.rubik(
                                                textStyle: TextStyle(
                                                  color: subTitleTextColor,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              prefixIcon: const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 2),
                                                  child: Icon(
                                                    Icons.local_taxi,
                                                  )),
                                              border: InputBorder.none,
                                            ),
                                            onChanged: (text) {
                                              cont.checkClaimTravelFormValidation(
                                                  context);
                                            },
                                          ),
                                        )
                                      : const Opacity(opacity: 0.0),
                                  cont.validateTravelFrom == true
                                      ? ErrorText(
                                          errorMessage:
                                              "Please enter valid travel form",
                                        )
                                      : const Opacity(opacity: 0.0),

                                  ///travel to
                                  cont.natureOfClaim ==
                                          "Travelling / Local Conveyance"
                                      ? const SizedBox(
                                          height: 15,
                                        )
                                      : const Opacity(opacity: 0.0),
                                  cont.natureOfClaim ==
                                          "Travelling / Local Conveyance"
                                      ? Container(
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            color: grey.withOpacity(0.2),
                                            border: Border.all(
                                                color: cont.validateTravelTo
                                                    ? errorColor
                                                    : grey),
                                          ),
                                          child: TextFormField(
                                            controller: cont.claimTravelTo,
                                            keyboardType: TextInputType.text,
                                            textAlign: TextAlign.left,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            textCapitalization:
                                                TextCapitalization.words,
                                            textInputAction:
                                                TextInputAction.done,
                                            onTap: () {},
                                            enabled: true,
                                            style:
                                                const TextStyle(fontSize: 15.0),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(10),
                                              hintText: "Travel To",
                                              hintStyle: GoogleFonts.rubik(
                                                textStyle: TextStyle(
                                                  color: subTitleTextColor,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              prefixIcon: const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 2),
                                                  child: Icon(
                                                    Icons.local_taxi,
                                                  )),
                                              border: InputBorder.none,
                                            ),
                                            onChanged: (text) {
                                              cont.checkClaimTravelToValidation(
                                                  context);
                                            },
                                          ),
                                        )
                                      : const Opacity(opacity: 0.0),
                                  cont.validateTravelTo == true
                                      ? ErrorText(
                                          errorMessage:
                                              "Please enter valid travel to",
                                        )
                                      : const Opacity(opacity: 0.0),

                                  ///kms
                                  cont.natureOfClaim ==
                                          "Travelling / Local Conveyance"
                                      ? const SizedBox(
                                          height: 15,
                                        )
                                      : const Opacity(opacity: 0.0),
                                  cont.natureOfClaim ==
                                          "Travelling / Local Conveyance"
                                      ? Container(
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            color: grey.withOpacity(0.2),
                                            border: Border.all(
                                                color: cont.validateKms
                                                    ? errorColor
                                                    : grey),
                                          ),
                                          child: TextFormField(
                                            controller: cont.claimKms,
                                            keyboardType: TextInputType.text,
                                            textAlign: TextAlign.left,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            textInputAction:
                                                TextInputAction.done,
                                            onTap: () {},
                                            enabled: true,
                                            style:
                                                const TextStyle(fontSize: 15.0),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(10),
                                              hintText: "KMS",
                                              hintStyle: GoogleFonts.rubik(
                                                textStyle: TextStyle(
                                                  color: subTitleTextColor,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              prefixIcon: const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 2),
                                                  child: Icon(
                                                    Icons.numbers,
                                                  )),
                                              border: InputBorder.none,
                                            ),
                                            onChanged: (text) {
                                              cont.checkClaimKmsValidation(
                                                  context);
                                            },
                                          ),
                                        )
                                      : const Opacity(opacity: 0.0),
                                  cont.validateKms == true
                                      ? ErrorText(
                                          errorMessage:
                                              "Please enter valid KMS",
                                        )
                                      : const Opacity(opacity: 0.0),

                                  ///challan no
                                  cont.natureOfClaim == "Govt Fees / Challans"
                                      ? const SizedBox(
                                          height: 15,
                                        )
                                      : const Opacity(opacity: 0.0),
                                  cont.natureOfClaim == "Govt Fees / Challans"
                                      ? Container(
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            color: grey.withOpacity(0.2),
                                            border: Border.all(
                                                color: cont.validateChallanNo
                                                    ? errorColor
                                                    : grey),
                                          ),
                                          child: TextFormField(
                                            controller: cont.claimChallanNo,
                                            keyboardType: TextInputType.text,
                                            textAlign: TextAlign.left,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            textInputAction:
                                                TextInputAction.done,
                                            onTap: () {},
                                            enabled: true,
                                            style:
                                                const TextStyle(fontSize: 15.0),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(10),
                                              hintText: "Challan No",
                                              hintStyle: GoogleFonts.rubik(
                                                textStyle: TextStyle(
                                                  color: subTitleTextColor,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              prefixIcon: const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 2),
                                                  child: Icon(
                                                    Icons.format_list_numbered,
                                                  )),
                                              border: InputBorder.none,
                                            ),
                                            onChanged: (text) {
                                              cont.checkClaimChallanNoValidation(
                                                  context);
                                            },
                                          ),
                                        )
                                      : const Opacity(opacity: 0.0),
                                  cont.validateChallanNo == true
                                      ? ErrorText(
                                          errorMessage:
                                              "Please enter valid challan no",
                                        )
                                      : const Opacity(opacity: 0.0),

                                  ///client->name
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  cont.selectedClaimType == 1
                                      ? Container(
                                          height: 40.0,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            border: Border.all(
                                                color: cont.validateClientName
                                                    ? errorColor
                                                    : grey),
                                          ),
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, right: 15.0),
                                            child: DropdownButton<String>(
                                              hint: buildTextRegularWidget(
                                                  cont.selectedClientName == ""
                                                      ? "Client Name"
                                                      : cont.selectedClientName,
                                                  blackColor,
                                                  context,
                                                  15.0),
                                              isExpanded: true,
                                              underline: Container(),
                                              items: cont.clientNameList.isEmpty
                                                  ? cont.noDataList
                                                      .map((value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList()
                                                  : cont.clientNameList
                                                      .map((NameList value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value
                                                            .firmClientFirmName,
                                                        child: Text(value
                                                            .firmClientFirmName!),
                                                        onTap: () {
                                                          cont.updateSelectedClientId(
                                                              value
                                                                  .firmClientClientCode!,
                                                              value
                                                                  .firmClientId!);
                                                        },
                                                      );
                                                    }).toList(),
                                              onChanged: (val) {
                                                cont.updateSelectedClientName(
                                                    val!, context);
                                              },
                                            ),
                                          )))
                                      : const Opacity(opacity: 0.0),
                                  cont.validateClientName == true
                                      ? ErrorText(
                                          errorMessage:
                                              "Please select client name",
                                        )
                                      : const Opacity(opacity: 0.0),

                                  ///client->year
                                  cont.selectedClaimType == 1
                                      ? const SizedBox(
                                          height: 15,
                                        )
                                      : const Opacity(opacity: 0.0),
                                  cont.selectedClaimType == 1
                                      ? Container(
                                          height: 40.0,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            border: Border.all(
                                                color: cont.validateClientYear
                                                    ? errorColor
                                                    : grey),
                                          ),
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, right: 15.0),
                                            child: DropdownButton<String>(
                                              hint: buildTextRegularWidget(
                                                  cont.selectedYear == ""
                                                      ? "F.Y."
                                                      : cont.selectedYear,
                                                  blackColor,
                                                  context,
                                                  15.0),
                                              isExpanded: true,
                                              underline: Container(),
                                              items: cont.claimYearList.isEmpty
                                                  ? cont.noDataList
                                                      .map((value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList()
                                                  : cont.claimYearList
                                                      .map((YearList value) {
                                                      String year =
                                                          "${value.finanacialYearStartDate} - ${value.finanacialYearEndDate!}";
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: year,
                                                        child: Text(
                                                            "${value.finanacialYearStartDate!} - ${value.finanacialYearEndDate!}"),
                                                        onTap: () {
                                                          cont.updateSelectedYearId(
                                                              value
                                                                  .financialYearId!);
                                                        },
                                                      );
                                                    }).toList(),
                                              onChanged: (val) {
                                                cont.updateSelectedYear(
                                                    val!, context);
                                              },
                                            ),
                                          )))
                                      : const Opacity(opacity: 0.0),
                                  cont.validateClientYear == true
                                      ? ErrorText(
                                          errorMessage: "Please select year",
                                        )
                                      : const Opacity(opacity: 0.0),

                                  ///client->service
                                  cont.selectedClaimType == 1
                                      ? const SizedBox(
                                          height: 15,
                                        )
                                      : const Opacity(opacity: 0.0),
                                  cont.selectedClaimType == 1
                                      ? Container(
                                          height: 40.0,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            border: Border.all(
                                                color:
                                                    cont.validateClientService
                                                        ? errorColor
                                                        : grey),
                                          ),
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, right: 15.0),
                                            child: DropdownButton<String>(
                                              hint: buildTextRegularWidget(
                                                  cont.selectedService == ""
                                                      ? "Service"
                                                      : cont.selectedService,
                                                  blackColor,
                                                  context,
                                                  15.0),
                                              isExpanded: true,
                                              underline: Container(),
                                              items: cont
                                                      .claimServiceList.isEmpty
                                                  ? cont.noDataList
                                                      .map((value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList()
                                                  : cont.claimServiceList.map(
                                                      (ClaimServiceList value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value:
                                                            value.serviceName,
                                                        child: Text(
                                                            value.serviceName!),
                                                        onTap: () {
                                                          cont.updateSelectedServiceId(
                                                              value.serviceId!,
                                                              value.id!);
                                                        },
                                                      );
                                                    }).toList(),
                                              onChanged: (val) {
                                                cont.updateSelectedService(
                                                    val!, context);
                                              },
                                            ),
                                          )))
                                      : const Opacity(opacity: 0.0),
                                  cont.validateClientService == true
                                      ? ErrorText(
                                          errorMessage: "Please select service",
                                        )
                                      : const Opacity(opacity: 0.0),

                                  ///client->task
                                  cont.selectedClaimType == 1
                                      ? const SizedBox(
                                          height: 15,
                                        )
                                      : const Opacity(opacity: 0.0),
                                  cont.selectedClaimType == 1
                                      ? Container(
                                          height: 40.0,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            border: Border.all(
                                                color: cont.validateClientTask
                                                    ? errorColor
                                                    : grey),
                                          ),
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, right: 15.0),
                                            child: DropdownButton<String>(
                                              hint: buildTextRegularWidget(
                                                  cont.selectedTask == ""
                                                      ? "Task"
                                                      : cont.selectedTask,
                                                  blackColor,
                                                  context,
                                                  15.0),
                                              isExpanded: true,
                                              underline: Container(),
                                              items: cont.claimTaskList.isEmpty
                                                  ? cont.noDataList
                                                      .map((value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList()
                                                  : cont.claimTaskList.map(
                                                      (ClaimTaskList task) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: task.taskName,
                                                        child: Text(
                                                            task.taskName!),
                                                        onTap: () {
                                                          cont.updateSelectedTaskId(
                                                              task.taskId!);
                                                        },
                                                      );
                                                    }).toList(),
                                              onChanged: (val) {
                                                cont.updateSelectedTask(
                                                    val!, context);
                                              },
                                            ),
                                          )))
                                      : const Opacity(opacity: 0.0),
                                  cont.validateClientTask == true
                                      ? ErrorText(
                                          errorMessage: "Please select task",
                                        )
                                      : const Opacity(opacity: 0.0),

                                  ///bill no
                                  cont.selectedClaimType == 1
                                      ? const SizedBox(
                                          height: 15,
                                        )
                                      : const Opacity(opacity: 0.0),
                                  Container(
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      color: whiteColor,
                                      border: Border.all(color: grey),
                                    ),
                                    child: TextFormField(
                                      controller: cont.claimBillNo,
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.left,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      textInputAction: TextInputAction.done,
                                      onTap: () {},
                                      enabled: true,
                                      style: const TextStyle(fontSize: 15.0),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        hintText: "Bill No",
                                        hintStyle: GoogleFonts.rubik(
                                          textStyle: TextStyle(
                                            color: subTitleTextColor,
                                            fontSize: 15,
                                          ),
                                        ),
                                        prefixIcon: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Icon(
                                              Icons.format_list_numbered,
                                              color: cont.claimBillNo.text == ""
                                                  ? grey
                                                  : blackColor,
                                            )),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (text) {
                                        //cont.checkClaimBillNoValidation(context);
                                      },
                                    ),
                                  ),
                                  // cont.validateBillNo == true
                                  //     ? ErrorText(errorMessage: "Please enter valid bill no",)
                                  //     : const Opacity(opacity: 0.0),

                                  ///date
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      cont.selectDate(context, "bill");
                                    },
                                    child: Container(
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                          border: Border.all(
                                              color: cont.validateSelectedDate
                                                  ? errorColor
                                                  : grey),
                                        ),
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            const Icon(Icons.calendar_today),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            buildTextRegularWidget(
                                                cont.selectedBillDateToShow ==
                                                        ""
                                                    ? cont.todayDateToShow
                                                    : cont
                                                        .selectedBillDateToShow,
                                                blackColor,
                                                context,
                                                15.0)
                                          ],
                                        )),
                                  ),
                                  cont.validateSelectedDate == true
                                      ? ErrorText(
                                          errorMessage:
                                              "Please enter valid date",
                                        )
                                      : const Opacity(opacity: 0.0),

                                  ///claim amount
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      border: Border.all(
                                          color: cont.validateClaimAmount
                                              ? errorColor
                                              : grey),
                                    ),
                                    child: TextFormField(
                                      controller: cont.claimAmount,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.left,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      textInputAction: TextInputAction.done,
                                      style: const TextStyle(fontSize: 15.0),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        hintText: "Claim Amount",
                                        hintStyle: GoogleFonts.rubik(
                                          textStyle: const TextStyle(
                                            color: blackColor,
                                            fontSize: 15,
                                          ),
                                        ),
                                        prefixIcon: const Padding(
                                            padding: EdgeInsets.only(top: 2),
                                            child: Icon(
                                              Icons.monetization_on_outlined,
                                              color: blackColor,
                                            )),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (text) {
                                        cont.checkClaimAmountValidation(
                                            context);
                                      },
                                    ),
                                  ),
                                  cont.validateClaimAmount == true
                                      ? ErrorText(
                                          errorMessage:
                                              "Please enter valid amount",
                                        )
                                      : const Opacity(opacity: 0.0),

                                  ///claim submitted
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                      height: 40.0,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            color: cont.validateClaimSubmittedBy
                                                ? errorColor
                                                : grey),
                                      ),
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, right: 15.0),
                                        child: DropdownButton<String>(
                                          hint: buildTextRegularWidget(
                                              cont.claimSubmittedBy == ""
                                                  ? "Claim Submitted By"
                                                  : cont.claimSubmittedBy,
                                              blackColor,
                                              context,
                                              15.0),
                                          isExpanded: true,
                                          underline: Container(),
                                          items: cont
                                                  .claimSubmittedByList.isEmpty
                                              ? cont.noDataList.map((value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList()
                                              : cont.claimSubmittedByList.map(
                                                  (ClaimSubmittedByList value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value:
                                                        value.firmEmployeeName,
                                                    child: Text(value
                                                        .firmEmployeeName!),
                                                    onTap: () {
                                                      cont.updateSelectedClaimSubmittedById(
                                                          value.mastId!);
                                                    },
                                                  );
                                                }).toList(),
                                          onChanged: (val) {
                                            cont.updateSelectedClaimSubmittedBy(
                                                val!, context);
                                          },
                                        ),
                                      ))),
                                  cont.validateClaimSubmittedBy == true
                                      ? ErrorText(
                                          errorMessage:
                                              "Please select claim submitted by",
                                        )
                                      : const Opacity(opacity: 0.0),

                                  ///claim image
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      border: Border.all(
                                          color: cont.validateClaimImage
                                              ? errorColor
                                              : grey),
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            cont.openGallery(context);
                                          },
                                          child: Container(
                                              height: 50.0,
                                              color: grey.withOpacity(0.2),
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, right: 10.0),
                                              child: Center(
                                                child: buildTextRegularWidget(
                                                    "Choose File",
                                                    blackColor,
                                                    context,
                                                    15.0),
                                              )),
                                        ),
                                        cont.claimFileName == ""
                                            ? const Opacity(opacity: 0.0)
                                            : Flexible(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          right: 10.0),
                                                  child: buildTextRegularWidget(
                                                      cont.claimFileName,
                                                      blackColor,
                                                      context,
                                                      15.0,
                                                      maxLines: 2),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                  cont.validateClaimImage == true
                                      ? ErrorText(
                                          errorMessage:
                                              "Please add claim image",
                                        )
                                      : const Opacity(opacity: 0.0),

                                  ///client billable
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  cont.selectedClaimType == 1
                                      ? Row(
                                          children: [
                                            buildTextRegularWidget("Billable  ",
                                                blackColor, context, 15.0),
                                            Radio<int>(
                                              value: 0,
                                              groupValue: cont.selectedBillable,
                                              activeColor: primaryColor,
                                              onChanged: (int? value) {
                                                cont.updateSelectedBillable(
                                                    value!, context);
                                              },
                                            ),
                                            buildTextRegularWidget("Yes",
                                                blackColor, context, 15.0),
                                            Radio<int>(
                                              value: 1,
                                              groupValue: cont.selectedBillable,
                                              activeColor: primaryColor,
                                              onChanged: (int? value) {
                                                cont.updateSelectedBillable(
                                                    value!, context);
                                              },
                                            ),
                                            buildTextRegularWidget("No",
                                                blackColor, context, 15.0),
                                          ],
                                        )
                                      : const Opacity(opacity: 0.0),
                                  cont.selectedClaimType == 1 &&
                                          cont.validateBillable == true
                                      ? ErrorText(
                                          errorMessage:
                                              "Please select billable",
                                        )
                                      : const Opacity(opacity: 0.0),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
              bottomNavigationBar: cont.loader == true
                  ? const Opacity(opacity: 0.0)
                  : Container(
                      color: whiteColor,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: screenFor == "add"
                            ? GestureDetector(
                                onTap: () {
                                  cont.checkClaimValidation(context);
                                },
                                child: buildButtonWidget(context, "Submit",
                                    radius: 5.0, height: 40.0),
                              )
                            : GestureDetector(
                                onTap: () {
                                  cont.callUpdateClaimForm();
                                },
                                child: buildButtonWidget(context, "Update",
                                    radius: 5.0, height: 40.0),
                              ),
                      ))));
    });
  }
}
