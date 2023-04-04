import 'dart:convert';
import 'dart:io';

import 'package:biznew/constant/provider/custom_exception.dart';
import 'package:biznew/constant/repository/api_repository.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/claim_form/claim_model.dart';
import 'package:biznew/screens/claim_form/export_poc.dart';
import 'package:biznew/screens/dashboard/dashboard_model.dart';
import 'package:biznew/utils/custom_response.dart';
import 'package:biznew/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class ClaimFormController extends GetxController {
  final ApiRepository repository;

  // ignore: unnecessary_null_comparison
  ClaimFormController({required this.repository}) : assert(repository != null);

  ///common
  String userId="";
  String userName="";
  String name="";
  bool loader = false;
  ///claim form
  DateTime todayDate = DateTime.now();
  String todayDateToShow = "";
  String todayDateToShowToSend = "";
  //String todayDateToSendApi = "";
  //List<String> natureOfClaimList = ["Digital Signature","Food","Govt Fees / Challans","Lodging","Miscellaneous","Printing / Stationary / Photocopy","Stamp Papers","Travelling / Local Conveyance"];
  List<ClaimSubmittedByList> claimSubmittedByList = [];
  TextEditingController claimParticular = TextEditingController();
  TextEditingController claimTravelFrom = TextEditingController();
  TextEditingController claimTravelTo = TextEditingController();
  TextEditingController claimKms = TextEditingController();
  TextEditingController claimChallanNo = TextEditingController();
  TextEditingController claimBillNo = TextEditingController();
  TextEditingController claimDate = TextEditingController();
  TextEditingController claimAmount = TextEditingController();
  int selectedClaimType = 0;
  String natureOfClaim = "";
  String natureOfClaimId = "";
  String claimSubmittedBy = "";
  String claimSubmittedById = "";
  DateTime selectedDate = DateTime.now();
  String selectedClaimDateToShow = "";
  String selectedClaimDateToSend = "";
  String selectedBillDateToShow = "";
  String selectedBillDateToSend = "";
  final ImagePicker imagePicker = ImagePicker();
  XFile selectedClaimImage = XFile("");
  String claimFileName = "";
  String selectedClientName = "";
  String selectedClientId = "";
  String clientFirmId = "";
  String selectedYear = "";
  String selectedClaimYearId = "";
  String selectedService = "";
  String selectedServiceId = "";
  String clientServiceId = "";
  String selectedTask = "";
  String selectedTaskId = "";
  int selectedBillable = 0;
  String addedParticular = "";
  bool validateClaimType = false;
  bool validateNatureOfClaim = false;
  bool validateClaimParticular = false;
  bool validateTravelFrom = false;
  bool validateTravelTo = false;
  bool validateKms = false;
  bool validateChallanNo = false;
  //bool validateBillNo = false;
  bool validateSelectedDate = false;
  bool validateClaimAmount = false;
  bool validateClaimSubmittedBy = false;
  bool validateClaimImage = false;
  bool validateBillable = false;
  bool validateClientName = false;
  bool validateClientYear = false;
  bool validateClientService = false;
  bool validateClientTask = false;
  TextEditingController remark = TextEditingController();

  String firmId = "";
  List<NatureOfClaimList> natureOfClaimList = [];
  List<NameList> clientNameList = [];
  List<YearList> claimYearList = [];
  List<ClaimSubmittedByList> claimSubmittedList = [];
  List<ClaimTaskList> claimTaskList = [];
  List<ClaimServiceList> claimServiceList = [];
  List<ClaimClientListDetails> claimClientList = [];
  List<String> noDataList = ["No Data Found!"];
  String selectedClaimId="";

  ///export
  List<String> columnNames = ["Id","Name","Claim Date","Amount"];
  List<ClaimClientListDetails> claimListForExport = <ClaimClientListDetails>[];
  late ClaimDataSource claimDataSource;

  String reportingHead="";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    todayDateToShow = "${todayDate.day}-${todayDate.month}-${todayDate.year}";
    todayDateToShowToSend = "${todayDate.year}-${todayDate.month}-${todayDate.day}";
    userId = GetStorage().read("userId")??"";
    userName = GetStorage().read("userName")??"";
    name = GetStorage().read("name")??"";
    firmId = GetStorage().read("firmId")??"";
    reportingHead = GetStorage().read("reportingHead")??"";
    repository.getData();

    callNatureOfClaimList();
    callClientNameList();
    callClaimYearList();
    callClaimSubmittedByList();
    callClaimList();

    claimListForExport = getEmployeeData();
    claimDataSource = ClaimDataSource(claimData: claimListForExport);
  }

  navigateToClaimEdit(String claimId,String screenFrom){
    updateLoader(true);
    selectedClaimId = claimId;
    callClaimEditList();
    screenFrom == "form" ? Get.toNamed(AppRoutes.claimForm,arguments: ["edit"])
        : Get.toNamed(AppRoutes.claimDetails);
    update();
  }
  ///loading
  updateLoader(bool val) { loader = val; update(); }
  ///radio selection for claim type
  updateSelectedClaimType(int val,BuildContext context){ selectedClaimType = val;checkClaimTypeValidation(context); update();}
  ///dropdown for nature of claim
  updateSelectedNatureOfClaim(String val,BuildContext context){
    if(natureOfClaimList.isNotEmpty){
      natureOfClaim = val; checkNatureOfClaimValidation(context);update();
    }
    }
  updateSelectedNatureOfClaimId(String val){
    if(natureOfClaimList.isNotEmpty){
      natureOfClaimId = val; update();
    }
  }
  ///dropdown for claim submitted
  updateSelectedClaimSubmittedBy(String val,BuildContext context){
    if(claimSubmittedByList.isNotEmpty){
      claimSubmittedBy = val; checkClaimSubmittedByValidation(context);update();
    }
  }
  updateSelectedClaimSubmittedById(String val){
    if(claimSubmittedByList.isNotEmpty){
      claimSubmittedById = val; update();
    }
  }
  ///dropdown for client name
  updateSelectedClientName(String val,BuildContext context){
    if(clientNameList.isNotEmpty){
      selectedClientName= val;checkClientNameValidation(context); update();
    }
  }
  updateSelectedClientId(String valId,String id){
    if(clientNameList.isNotEmpty){
      clientFirmId = id;selectedClientId = valId;update();
    }
  }
  ///dropdown for year
  updateSelectedYear(String val,BuildContext context){
    if(claimYearList.isNotEmpty){selectedYear= val; checkClientYearValidation(context); update();}
    }
  updateSelectedYearId(String valId){
    if(claimYearList.isNotEmpty){
      selectedClaimYearId = valId;callClaimServicesList();update();
    }
  }
  ///dropdown for service
  updateSelectedService(String val,BuildContext context){
    if(claimServiceList.isNotEmpty){selectedService= val; checkClientServiceValidation(context); update();}
  }
  updateSelectedServiceId(String valId,String id){
    if(claimServiceList.isNotEmpty){
      clientServiceId = id;selectedServiceId = valId;
      callClaimTaskList();update();
    }
   }
  ///dropdown for task
  updateSelectedTask(String val,BuildContext context){
    if(claimTaskList.isNotEmpty){
      selectedTask= val;checkClientTaskValidation(context); update();
    }
  }
  updateSelectedTaskId(String val){
    if(claimTaskList.isNotEmpty){
      selectedTaskId= val;update();
    }
  }
  ///radio selection for billable
  updateSelectedBillable(int val,BuildContext context){ selectedBillable = val; checkBillableValidation(context);update();}

  ///validations
  checkClaimTypeValidation(BuildContext context){
    if(selectedClaimType==0){validateClaimType = false; update(); }
    else if(selectedClaimType==1){validateClaimType = false; update(); }
    else{validateClaimType = true; update(); }
  }

  checkNatureOfClaimValidation(BuildContext context){
    if(natureOfClaim.isEmpty){ validateNatureOfClaim = true; update(); }
    else{validateNatureOfClaim = false; update(); }
  }

  checkClaimParticularValidation(BuildContext context){
    if(claimParticular.text.isEmpty){ validateClaimParticular = true; update(); }
    else{validateClaimParticular = false; update(); }
  }

  checkClaimTravelFormValidation(BuildContext context){
    if(claimTravelFrom.text.isEmpty){ validateTravelFrom = true; update(); }
    else{validateTravelFrom = false; update(); }
  }

  checkClaimTravelToValidation(BuildContext context){
    if(claimTravelTo.text.isEmpty){ validateTravelTo = true; update(); }
    else{validateTravelTo = false; update(); }
  }

  checkClaimKmsValidation(BuildContext context){
    if(claimKms.text.isEmpty){ validateKms = true; update(); }
    else{validateKms = false; update(); }
  }

  checkClaimChallanNoValidation(BuildContext context){
    if(claimChallanNo.text.isEmpty){ validateChallanNo = true; update(); }
    else{validateChallanNo = false; update(); }
  }

  // checkClaimBillNoValidation(BuildContext context){
  //   if(claimBillNo.text.isEmpty){ validateBillNo = true; update(); }
  //   else{validateBillNo = false; update(); }
  // }

  checkClientNameValidation(BuildContext context){
    if(selectedClientName.isEmpty){ validateClientName = true; update(); }
    else{validateClientName = false; update(); }
  }

  checkClientYearValidation(BuildContext context){
    if(selectedYear.isEmpty){ validateClientYear = true; update(); }
    else{validateClientYear = false; update(); }
  }

  checkClientServiceValidation(BuildContext context){
    if(selectedService.isEmpty){ validateClientService = true; update(); }
    else{validateClientService = false; update(); }
  }

  checkClientTaskValidation(BuildContext context){
    if(selectedTask.isEmpty){ validateClientTask = true; update(); }
    else{validateClientTask = false; update(); }
  }

  checkClaimAmountValidation(BuildContext context){
    if(claimAmount.text.isEmpty){ validateClaimAmount = true; update(); }
    else{validateClaimAmount = false; update(); }
  }

  checkClaimSubmittedByValidation(BuildContext context){
    if(claimSubmittedBy.isEmpty){ validateClaimSubmittedBy = true; update(); }
    else{validateClaimSubmittedBy = false; update(); }
  }

  checkClaimImageValidation(BuildContext context){
    if(claimFileName==""){ validateClaimImage = true; update(); }
    else{validateClaimImage = false; update(); }
  }

  checkBillableValidation(BuildContext context){
    if(selectedBillable==0){ validateBillable = false; update(); }
    else if (selectedBillable==1){validateBillable = false; update();}
    else{validateBillable = true; update(); }
  }
  ///submit button validations
  checkClaimValidation(BuildContext context){
    updateLoader(true);
    if(claimParticular.text.isEmpty
        || (natureOfClaim == "Travelling / Local Conveyance\r\n\r\n" && claimTravelFrom.text.isEmpty)
        || (natureOfClaim == "Travelling / Local Conveyance\r\n\r\n" && claimTravelTo.text.isEmpty)
        || (natureOfClaim == "Travelling / Local Conveyance\r\n\r\n" && claimKms.text.isEmpty)
        || (natureOfClaim == "Govt Fees / Challans" && claimChallanNo.text.isEmpty)
        || claimAmount.text.isEmpty || natureOfClaim.isEmpty || claimSubmittedBy.isEmpty
        || selectedClaimType==1 && selectedClientName.isEmpty || selectedClaimType==1 && selectedYear.isEmpty
        || selectedClaimType==1 && selectedService.isEmpty || selectedClaimType==1 && selectedTask.isEmpty
        || claimFileName==""
        //|| (selectedClaimType==1 && selectedBillable!=0) || (selectedClaimType==1 && selectedBillable!=1)
    ){
      //selectedClaimType==0 || selectedClaimType==1 ? validateClaimType = false: validateClaimType = true;
      //selectedClaimType==1 ? validateClaimType = false: validateClaimType = true;
      claimParticular.text.isEmpty ? validateClaimParticular = true : validateClaimParticular = false;

      (natureOfClaim == "Travelling / Local Conveyance\r\n\r\n" && claimTravelFrom.text.isEmpty)
          ? validateTravelFrom = true : validateTravelFrom = false;
      (natureOfClaim == "Travelling / Local Conveyance\r\n\r\n" && claimTravelTo.text.isEmpty)
          ? validateTravelTo = true : validateTravelTo = false;
      (natureOfClaim == "Travelling / Local Conveyance\r\n\r\n" && claimKms.text.isEmpty)
          ? validateKms = true : validateKms = false;

      (natureOfClaim == "Govt Fees / Challans" && claimChallanNo.text.isEmpty)
          ? validateChallanNo = true : validateChallanNo = false;

      //claimBillNo.text.isEmpty ? validateBillNo = true : validateBillNo = false;
      claimAmount.text.isEmpty ? validateClaimAmount = true : validateClaimAmount = false;
      natureOfClaim.isEmpty ? validateNatureOfClaim = true : validateNatureOfClaim = false;
      claimSubmittedBy.isEmpty ? validateClaimSubmittedBy = true : validateClaimSubmittedBy = false;
      claimFileName=="" ? validateClaimImage = true : validateClaimImage = false;

      selectedClaimType==1 && selectedClientName.isEmpty ? validateClientName = true: validateClientName = false;
      selectedClaimType==1 && selectedYear.isEmpty ? validateClientYear = true: validateClientYear = false;
      selectedClaimType==1 && selectedService.isEmpty ? validateClientService = true: validateClientService = false;
      selectedClaimType==1 && selectedTask.isEmpty ? validateClientTask = true: validateClientTask = false;
      // selectedClaimType==1 && selectedBillable==0 ? validateBillable = false: validateBillable = true;
      // selectedClaimType==1 && selectedBillable==1 ? validateBillable = false: validateBillable = true;
      updateLoader(false);
      update();
    }else{
      updateLoader(false);
      callAddClaimForm();
    }
    update();
  }
  ///calender view
  Future<void> selectDate(BuildContext context,String forWhat) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1700, 1),
        lastDate: DateTime(2100, 1));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
    if(forWhat == "claim"){
      selectedClaimDateToShow = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      selectedClaimDateToSend = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
      update();
    }
    else{
      selectedBillDateToShow = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      selectedBillDateToSend = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
      update();
    }
  }

  openGallery(BuildContext buildContext) async {
    updateLoader(true);
    selectedClaimImage = (await imagePicker.pickImage(source: ImageSource.gallery))!;
    //selectedClaimFile = File(result!.files.single.path!);
    //claimFileName = selectedClaimFile!.path.split("/").last;
    claimFileName = selectedClaimImage.path.split('/').last;

    print("selected");
    print(selectedClaimImage.path);
    print(claimFileName);

    validateClaimImage=false;
    updateLoader(false);
    update();
  }

  // FilePickerResult? result;
  // File? selectedClaimFile;

  // openGallery(BuildContext buildContext) async {
  //    result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['jpg', 'pdf', 'doc'],
  //   );
  //   selectedClaimFile = File(result!.files.single.path!);
  //   claimFileName = selectedClaimFile!.path.split("/").last;
  //
  //   print("selected");
  //   print(selectedClaimFile);
  //   print(claimFileName);
  //selected
  // File: '/data/user/0/com.biz.biznew/cache/file_picker/IMG-20230328-WA0000.jpeg'
  // IMG-20230328-WA0000.jpeg
  //   validateClaimImage=false; updateLoader(false); update();
  // }

  /// nature of claim list
  void callNatureOfClaimList() async {
    natureOfClaimList.clear();
    try {
      ClaimTypeModel? response = (await repository.getNatureOfClaimList());

      if (response.success!) {
        if (response.natureOfClaim!.isEmpty) {
        }
        else{
          natureOfClaimList.addAll(response.natureOfClaim!);
        }
        update();
      } else {
        update();
      }
    } on CustomException {
      update();
    } catch (error) {
      update();
    }
  }

  /// client name list
  void callClientNameList() async {
    clientNameList.clear();
    try {
      ClientNameModel? response = (await repository.getClientNameList());

      if (response.success!) {
        if (response.nameList!.isEmpty) {
        }
        else{
          clientNameList.addAll(response.nameList!);
        }
        update();
      } else {
        update();
      }
    } on CustomException {
      update();
    } catch (error) {
      update();
    }
  }
  /// claim year list
  void callClaimYearList() async {
    claimYearList.clear();
    //updateLoader(true);
    try {
      ClaimYearModel? response = (await repository.getClaimYearList());

      if (response.success!) {
        if (response.yearList!.isEmpty) {
        }
        else{
          claimYearList.addAll(response.yearList!);
        }
        //updateLoader(false);
        update();
      } else {
        //updateLoader(false);
        update();
      }
    } on CustomException {
      //updateLoader(false);
      update();
    } catch (error) {
      //updateLoader(false);
      update();
    }
  }
  /// claim services list
  void callClaimServicesList() async {
    claimServiceList.clear();
    //updateLoader(true);
    try {
      ClaimServiceResponse? response = (await repository.getClaimServicesList(clientFirmId,selectedClaimYearId));
      print("Claim service");
      print(clientFirmId);
      print(selectedClaimYearId);
      if (response.success!) {
        if (response.serviceList!.isEmpty) {
        }
        else{
          claimServiceList.addAll(response.serviceList!);
        }
        //updateLoader(false);
        update();
      } else {
        //updateLoader(false);
        update();
      }
    } on CustomException {
      //updateLoader(false);
      update();
    } catch (error) {
      //updateLoader(false);
      update();
    }
  }
  ///claim task list
  void callClaimTaskList() async {
    claimTaskList.clear();
    //updateLoader(true);
    try {
      ClaimTaskResponse? response = (await repository.getClaimTaskList(selectedServiceId));

      if (response.success!) {
        if (response.taskList!.isEmpty) {
        }
        else{
          claimTaskList.addAll(response.taskList!);
        }
        //updateLoader(false);
        update();
      } else {
        //updateLoader(false);
        update();
      }
    } on CustomException {
      //updateLoader(false);
      update();
    } catch (error) {
      //updateLoader(false);
      update();
    }
  }
  ///claim submitted by
  void callClaimSubmittedByList() async {
    claimSubmittedByList.clear();
    updateLoader(true);
    try {
      ClaimSubmittedByResponse? response = (await repository.getClaimSubmittedByList());

      if (response.success!) {
        if (response.claimSubmittedByListDetails!.isEmpty) {
        }
        else{
          claimSubmittedByList.addAll(response.claimSubmittedByListDetails!);
        }
        updateLoader(false);
        update();
      } else {
        updateLoader(false);
        update();
      }
    } on CustomException {
      updateLoader(false);
      update();
    } catch (error) {
      updateLoader(false);
      update();
    }
  }
  /// add claim form
  void callAddClaimForm() async {
    //updateLoader(true);
    String message = "";
    var responseDecode;
    try {
      Utils.dismissKeyboard();
      Utils.showLoadingDialog();

      var response = (await repository.getAddClaimForm(
          taskName : selectedTask??"",
          claimDate: todayDateToShowToSend??"",
          claimType: selectedClaimType==0?"1":"0",
          natureOfClaim:  natureOfClaimId??"",
          particulars: claimParticular.text??"",
          clientName: selectedClientId??"",
          year:  selectedClaimYearId??"",
          service: selectedServiceId??"",
          task: selectedTaskId??"",
          date:  selectedClaimDateToSend==""? todayDateToShowToSend : selectedClaimDateToSend,
          amount: claimAmount.text??"",
          claimSubmittedBy: claimSubmittedById??"",
          claimImage: selectedClaimImage.path==""?"": selectedClaimImage.path,
          billable: selectedBillable==0?"Yes":"No",
          travelFrom: claimTravelFrom.text??"",
          travelTo: claimTravelTo.text??"",
          kms: claimKms.text??"",
          challanNo: claimChallanNo.text??"",
          clientServiceId:clientServiceId,
          billNo: claimBillNo.text??"",
      ));
      Utils.dismissLoadingDialog();
      response.listen((value) {
        responseDecode = json.decode(value);
        if(responseDecode['Success'] == true){
          clearClaimForm();
          Utils.showSuccessSnackBar(responseDecode['Message']);
          updateLoader(false);
          Get.toNamed(AppRoutes.claimList);
          update();
        }
        else if (responseDecode['Success'] == false){
          Utils.showErrorSnackBar(responseDecode['Message']);
          updateLoader(false);
          update();
        }
        updateLoader(false);update();
      });
    } on CustomException {
      Utils.showErrorSnackBar(responseDecode['Message']);
      updateLoader(false);
      update();
    } catch (error) {
      Utils.showErrorSnackBar(responseDecode['Message']);
      updateLoader(false);
      update();
    }
  }
  /// clear form
  clearClaimForm(){
    selectedClaimDateToShow = "";selectedBillDateToShow = "";
    selectedClaimDateToSend = "";selectedBillDateToSend = "";
    selectedClaimType = 0 ; selectedFlag = 0; selectedBillable=0;
    natureOfClaim="";natureOfClaimId="";
    selectedClientName="";selectedClientId="";
    selectedYear="";selectedClaimYearId="";
    selectedService="";selectedServiceId="";
    selectedTask="";selectedTaskId="";
    claimSubmittedBy="";claimSubmittedById="";
    claimFileName="";clientServiceId="";

    claimParticular.clear();claimTravelFrom.clear();claimTravelTo.clear();
    claimKms.clear();claimChallanNo.clear();claimBillNo.clear();claimAmount.clear();

    update();
  }

  int selectedFlag = 0;
  List<String> claimStatusList = ["All","Pending","Approved","Rejected","Added to Bill"];
  String selectedEmployee = "";
  String selectedClaimStatus = "Pending";
  String selectedEmpId = "";
  List<ClaimDetails> claimEditList =[];
  String statusAction = "";
  String idForStatusUpdate = "";
  String claimFileToShow = "";

  updateSelectedFlag(int val,BuildContext context){ selectedFlag = val; callClaimList();update();}
  updateSelectedEmployee(String val){
    if(claimSubmittedByList.isNotEmpty){
      selectedEmployee = val; callClaimList();update();
    }
  }
  showSelectedEmp(String id){
    if(claimSubmittedByList.isNotEmpty){
      selectedEmpId = id;
      callClaimList();
      update();
    }
  }
  updateSelectedClaimStatus(String val){ selectedClaimStatus = val;callClaimList(); update();}

  /// client list
  void callClaimList() async {
    claimClientList.clear();
    updateLoader(true);
    try {
      ClaimClientListResponse? response = (await repository.getClaimList(
        selectedFlag == 0 ? "own" : "team",
        selectedClaimStatus == "All" ? "" : selectedClaimStatus,
        selectedFlag == 0 ? "" : selectedEmpId==""?"":selectedEmpId,));

      if (response.success!) {
        if (response.claimClientListDetails!.isEmpty) {
        }
        else{
          claimClientList.addAll(response.claimClientListDetails!);
        }
        updateLoader(false);
        update();
      } else {
        updateLoader(false);
        update();
      }
    } on CustomException {
      updateLoader(false);
      update();
    } catch (error) {
      updateLoader(false);
      update();
    }
  }

  /// claim list for export
  List<ClaimClientListDetails> getEmployeeData() {
    for (var element in claimListForExport) {
      ClaimClientListDetails(claimId: element.claimId,name: element.name,claimDate: element.claimDate,
          claimAmount: "Rs. ${element.claimAmount}", billDate: element.billDate,cliamBillable: element.cliamBillable,
          taskName: element.taskName, serviceName: element.serviceName, claimStatus: element.claimStatus,
          particulars: element.particulars);
    }
    return claimListForExport;
  }

  navigateToExportScreen(){
    updateLoader(true);
    callClaimListToExport();
    Get.toNamed(AppRoutes.exportScreen);
  }

  void callClaimListToExport() async {
    claimListForExport.clear();
    updateLoader(true);
    try {
      ClaimClientListResponse? response = (await repository.getClaimList(selectedFlag == 0 ? "own" : "team" ,"",""));

      if (response.success!) {
        if (response.claimClientListDetails!.isEmpty) {
        }
        else{
          claimListForExport.addAll(response.claimClientListDetails!);
          claimDataSource = ClaimDataSource(claimData: claimListForExport);
          update();
        }
        updateLoader(false);
        update();
      } else {
        updateLoader(false);
        update();
      }
    } on CustomException {
      updateLoader(false);
      update();
    } catch (error) {
      updateLoader(false);
      update();
    }
  }
  /// claim edit
  void callClaimEditList() async {
    claimEditList.clear();
    updateLoader(true);
    try {
      ClaimEditResponse? response = (await repository.getClaimEditList(selectedClaimId));

      if (response.success!) {
        if (response.claimDetails!.isEmpty) {
          updateLoader(false);
          update();
        }
        else{
          claimEditList.addAll(response.claimDetails!);

          claimFileToShow = response.url!+claimEditList[0].file!;
          selectedClaimDateToSend =  claimEditList[0].claimDateToSend!;
          selectedClaimDateToShow = claimEditList[0].claimDate!;

          selectedClaimType = claimEditList[0].typeOfClaim == "1"?1:0;
          claimParticular.text = claimEditList[0].particulars!;
          claimTravelFrom.text = claimEditList[0].claimFrom!;
          claimTravelTo.text = claimEditList[0].claimTo!;
          claimKms.text = claimEditList[0].kms!;
          claimChallanNo.text = claimEditList[0].challan??"";
          claimBillNo.text = claimEditList[0].billNo!;

          selectedBillDateToShow = claimEditList[0].billDate!;
          selectedBillDateToSend = claimEditList[0].billDateToSend!;

          claimFileName = claimEditList[0].file!;
          claimAmount.text = claimEditList[0].claimAmount!;
          selectedTask =claimEditList[0].typeOfClaim!;
          selectedBillable=claimEditList[0].cliamBillable=="Yes"?0:1;
          selectedServiceId = claimEditList[0].service!;
          selectedTaskId = claimEditList[0].task!;
          natureOfClaimId = claimEditList[0].typeOfClaim!;
          selectedClaimYearId = claimEditList[0].cliamFinancialYearId!;
          claimSubmittedById = claimEditList[0].addedBy!;
          clientServiceId = claimEditList[0].clientApplicableService!;
          selectedClientId = claimEditList[0].clientName!;
          selectedService = claimEditList[0].serviceName!;
          natureOfClaim = claimEditList[0].name!;
          claimSubmittedBy = claimEditList[0].firmEmployeeName!;
          claimFileName = claimEditList[0].file!;
          selectedClientName = claimEditList[0].firmClientName!;
          selectedYear = "${claimEditList[0].startYear!}-${claimEditList[0].endYear!}";

          updateLoader(false);
          update();
        }

      } else {
        updateLoader(false);
        update();
      }
    } on CustomException catch (e) {
      Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }
  }

  openPdf() async {
    //final uri = Uri.parse(claimFileToShow);
    // final uri = Uri.parse("https://www.africau.edu/images/default/sample.pdf");
    // print("uri");
    // print(uri);
    // if (await canLaunchUrl(uri)) {
    //   await launchUrl(uri);
    // } else {
    //   throw 'Could not launch $uri';
    // }
    // // OpenFile.open(claimFileToShow);
    // update();
    // ignore: deprecated_member_use
    String url = claimFileToShow;
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  onWillPopBack(){
    clearClaimForm();
    Get.toNamed(AppRoutes.claimList);
    update();
  }
  onBackPress(){
    selectedFlag=0;selectedClaimStatus="";selectedEmployee="";
    Get.offNamedUntil(AppRoutes.bottomNav, (route) => false);
    update();
  }
  /// claim update
  void callUpdateClaimForm() async {

    // print(selectedTask);
    // print(selectedClaimDateToSend);
    // print(selectedClaimType);
    // print(natureOfClaimId);
    // print(claimParticular.text);
    // print(selectedClientId);
    // print(selectedClaimYearId);
    // print(selectedServiceId);
    // print(selectedTaskId);
    // print(selectedBillDateToSend);
    // print(claimAmount.text);
    // print(claimSubmittedById);
    // print(selectedClaimFile);
    // print(selectedBillable);
    // print(claimTravelFrom.text);
    // print(claimTravelTo.text);
    // print(claimKms.text);
    // print(claimChallanNo.text);
    // print(clientServiceId);
    // print(claimBillNo.text);
    // print(selectedClaimId);
    try {
      Utils.dismissKeyboard();
      var response = (await repository.getUpdateClaimForm(
        taskName : selectedTask,
        claimDate: selectedClaimDateToSend==""?todayDateToShowToSend:selectedClaimDateToSend,
        claimType: selectedClaimType==0?"1":"0",
        natureOfClaim:  natureOfClaimId,
        particulars: claimParticular.text,
        clientName: selectedClientId,
        year:  selectedClaimYearId,
        service: selectedServiceId,
        task: selectedTaskId,
        date:  selectedBillDateToSend==""? todayDateToShowToSend : selectedBillDateToSend,
        amount: claimAmount.text.isEmpty ? "" : claimAmount.text,
        claimSubmittedBy: claimSubmittedById,
        claimImage: selectedClaimImage==null?claimFileName:selectedClaimImage.path,
        billable: selectedBillable==0?"Yes":"No",
        travelFrom: claimTravelFrom.text,
        travelTo: claimTravelTo.text,
        kms: claimKms.text,
        challanNo: claimChallanNo.text,
        clientServiceId:clientServiceId,
        billNo: claimBillNo.text,
        claimId:selectedClaimId,
      ));
      response.listen((value) {
        var responseDecode = json.decode(value);
        if(responseDecode['Success'] == true){
          clearClaimForm();
          callClaimList();
          Get.toNamed(AppRoutes.claimList);
          Utils.showSuccessSnackBar(responseDecode['Message']);
          updateLoader(false);
          update();
        }
        else if (responseDecode['Success'] == false){
          Utils.showErrorSnackBar(responseDecode['Message']);
          updateLoader(false);
          update();
        }
        // else if (responseDecode['status'] == false){
        //   Utils.showErrorSnackBar(responseDecode['message']);
        //   updateLoader(false);
        //   update();
        // }
        updateLoader(false);update();
      });
    } on CustomException catch(e){
      Utils.showErrorSnackBar(e.toString());
      updateLoader(false);
      update();
    } catch (error) {
      Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }
  }
  updateStatus(String action,String claimId,BuildContext context){
    updateLoader(true);
    idForStatusUpdate = claimId;
    statusAction = action; callUpdateStatus(context); update();
  }
  /// update status
  void callUpdateStatus(BuildContext context) async {
    try {
      ApiResponse? response = (await repository.getUpdateStatus(idForStatusUpdate,statusAction,
          statusAction=="Reject"? remark.text : ""));

      if (response.success!) {
        Navigator.pop(context);
        Utils.showSuccessSnackBar(response.message);
        remark.clear();
        updateLoader(false);
        update();
      } else {
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);
        update();
      }
    } on CustomException catch (e) {
      Utils.showErrorSnackBar(e.getMsg());
      updateLoader(false);
      update();
    } catch (error) {
      Utils.showErrorSnackBar(error.toString());
      updateLoader(false);
      update();
    }
  }

  callLogout(){
    Utils.showLoadingDialog();
    GetStorage().remove("userId");
    GetStorage().remove("userName");
    GetStorage().remove("name");
    GetStorage().remove("firmId");
    GetStorage().erase();
    Utils.showSuccessSnackBar("Logout Successfully!");
    Utils.dismissLoadingDialog();
    Get.offNamedUntil(AppRoutes.login, (route) => false);
    update();
  }
}