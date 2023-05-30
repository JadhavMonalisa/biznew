import 'package:biznew/constant/provider/custom_exception.dart';
import 'package:biznew/constant/repository/api_repository.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/screens/petty_task/petty_task_model.dart';
import 'package:biznew/utils/custom_response.dart';
import 'package:biznew/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PettyTaskController extends GetxController {
  final ApiRepository repository;

  // ignore: unnecessary_null_comparison
  PettyTaskController({required this.repository}) : assert(repository != null);

  ///common
  String userId="";
  String userName="";
  String name="";
  bool loader = false;
  List<String> noDataList = ["No Data Found!"];
  bool validateBranchName = false;
  bool validateClientName = false;
  bool validateEmployeeName = false;
  List<Branchlist> branchNameList = [];
  List<Clientslist> clientNameList = [];
  List<EmplyeeList> employeeNameList = [];
  String selectedBranchName = "";
  String selectedClientName = "";
  String selectedEmployeeName = "";
  String selectedTriggerDate = "";
  String selectedTriggerDateToSend = "";
  bool validateTriggerDate = false;
  String selectedTargetDate = "";
  String selectedTargetDateToSend = "";
  bool validateTargetDate = false;
  DateTime selectedDate = DateTime.now();
  TextEditingController fees = TextEditingController();
  TextEditingController task = TextEditingController();
  TextEditingController estimatedHours = TextEditingController();
  TextEditingController estimatedMinutes = TextEditingController();
  bool validateFees = false;
  bool validateTask = false;
  bool validateEstimatedHr = false;
  bool validateEstimatedM = false;
  String selectedBranchId = "";
  String selectedClientId = "";
  String selectedEmpId = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userId = GetStorage().read("userId")??"";
    userName = GetStorage().read("userName")??"";
    name = GetStorage().read("name")??"";
    repository.getData();
    callBranchNameList();
  }

  updateLoader(bool val) { loader = val; update(); }

  clearAll(){
    selectedBranchId = ""; selectedClientId = ""; selectedEmpId = "";
    selectedBranchName = ""; selectedClientName = ""; selectedEmployeeName = "";
    selectedTriggerDate = "" ; selectedTargetDate = ""; selectedDate = DateTime.now(); task.clear();
    fees.clear(); estimatedHours.clear(); estimatedMinutes.clear();
    update();
  }

  navigateFromAddClient(){
    selectedConstitution = ""; clientCode.clear(); companyName.clear();
    selectedBranchName = ""; selectedClientGroupName = ""; parentCompanyName.clear();
    erstWhileName.clear(); clientCin.clear(); clientPan.clear(); clientTan.clear();
    clientGstin.clear(); selectedIndustryName = ""; selectedBusinessNature = "";
    selectedBirthDate = ""; tradeName.clear(); selectedIncorporationDate = "";
    addressLine1.clear(); addressLine2.clear(); area.clear(); city.clear();
    selectedState = ""; selectedDistrict = ""; pincode.clear(); landlineNo.clear();
    noOfPlants.clear(); whatsAppNo.clear(); clientEmail.clear(); update();
    Get.toNamed(AppRoutes.pettyTaskFrom);
    update();
  }

  onWillPopBack(){
    clearAll();
    Get.offNamedUntil(AppRoutes.bottomNav, (route) => false);
    update();
  }

  ///branch name
  updateSelectedBranchId(String val){
    if(branchNameList.isNotEmpty){
      selectedBranchId = val; callClientList(); callEmpList(); update();
    }
  }
  checkBranchNameValidation(String val){
    if(branchNameList.isNotEmpty){
      selectedBranchName = val;
      selectedClientId = ""; selectedClientName ="";
      selectedEmpId = ""; selectedEmployeeName = "";
      update();
      if(selectedBranchName==""){ validateBranchName = true; update(); }
      else{validateBranchName = false; update(); }
    }
  }

  ///client name
  updateSelectedClientId(String val,BuildContext context){
    if(clientNameList.isNotEmpty){
      selectedClientId = val;  update();
    }
  }
  checkClientNameValidation(String val, BuildContext context){
    if(clientNameList.isNotEmpty){
      selectedClientName = val; update();
      if(selectedClientName==""){ validateClientName = true; update(); }
      else{validateClientName = false; update(); }
    }
  }

  ///employee name
  updateSelectedEmpId(String val,BuildContext context){
    selectedEmpId = val; update();
  }
  checkEmployeeNameValidation(String val,BuildContext context){
    if(employeeNameList.isNotEmpty){
      selectedEmployeeName = val;update();
      if(selectedEmployeeName==""){ validateEmployeeName = true; update(); }
      else{validateEmployeeName = false; update(); }
    }
  }
  ///hours
  checkEstimatedHoursValidation(BuildContext context){
    if(estimatedHours.text.isEmpty){ validateEstimatedHr = true; update(); }
    else{validateEstimatedHr = false; update(); }
  }
  ///minutes
  checkEstimatedMinutesValidation(BuildContext context){
    if(estimatedMinutes.text.isEmpty){ validateEstimatedM = true; update(); }
    else{validateEstimatedM = false; update(); }
  }
  ///fees
  checkFeesValidation(BuildContext context){
    if(fees.text.isEmpty){ validateFees = true; update(); }
    else{validateFees = false; update(); }
  }
  ///task
  checkTaskValidation(BuildContext context){
    if(task.text.isEmpty){ validateTask = true; update(); }
    else{validateTask = false; update(); }
  }
  ///all validations
  checkValidation(BuildContext context){
    updateLoader(true);
    if(selectedBranchName=="" || selectedClientName=="" || selectedEmployeeName=="" ||
    selectedTriggerDate=="" || selectedTargetDate=="" || estimatedHours.text.isEmpty ||
        estimatedMinutes.text.isEmpty || task.text.isEmpty || fees.text.isEmpty ||
        estimatedHours.text.isEmpty || estimatedMinutes.text.isEmpty){

      selectedBranchName=="" ? validateBranchName = true: validateBranchName = false;
      selectedClientName=="" ? validateClientName = true: validateClientName = false;
      selectedEmployeeName=="" ? validateEmployeeName = true: validateEmployeeName = false;
      selectedTriggerDate=="" ? validateTriggerDate = true: validateTriggerDate = false;
      selectedTargetDate=="" ? validateTargetDate = true: validateTargetDate = false;
      estimatedHours.text.isEmpty ? validateEstimatedHr = true: validateEstimatedHr = false;
      estimatedMinutes.text.isEmpty ? validateEstimatedM = true: validateEstimatedM = false;
      task.text.isEmpty ? validateTask = true: validateTask = false;
      fees.text.isEmpty ? validateFees = true: validateFees = false;
      estimatedHours.text.isEmpty ? validateEstimatedHr = true: validateEstimatedHr = false;
      estimatedMinutes.text.isEmpty ? validateEstimatedM = true: validateEstimatedM = false;
      updateLoader(false);
      update();
    }

    else{
      callAddPettyTask(context);
    }
  }

  Future<void> selectDate(BuildContext context,String dateFor) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: dateFor=="triggerDate" ? DateTime.now() : DateTime(1700, 1),
        lastDate: DateTime(2100, 1));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }

    String formattedMonth = "";
    String formattedDay = "";

    if(dateFor=="triggerDate"){

      ///format month
      if(selectedDate.month.toString().length==1){
        formattedMonth = selectedDate.month.toString().padLeft(2, '0');
      }
      else{
        formattedMonth = selectedDate.month.toString();
      }

      ///format date
      if(selectedDate.day.toString().length==1){
        formattedDay = selectedDate.day.toString().padLeft(2, '0');
      }
      else{
        formattedDay = selectedDate.day.toString();
      }


      selectedTriggerDate = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      selectedTriggerDateToSend = "${selectedDate.year}-$formattedMonth-$formattedDay";
      selectedTargetDate = selectedTriggerDate;
      selectedTriggerDate=="" ? validateTriggerDate = true: validateTriggerDate = false;

      selectedTargetDateToSend = selectedTriggerDateToSend;
      update();
    }
    else if(dateFor=="birthDate"){
      selectedBirthDate = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      update();
    }
    else if(dateFor=="incorporationDate"){
      selectedIncorporationDate = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      update();
    }
    update();
  }
  /// branch name list
  void callBranchNameList() async {
    branchNameList.clear();
    try {
      BranchNameModel? response = (await repository.getBranchNameList());
      if (response.success!) {
        branchNameList.addAll(response.branchListDetails!);
        if(branchNameList.length==1){
          selectedBranchId = branchNameList[0].id!;
          selectedBranchName = branchNameList[0].name!;
          callClientList();callEmpList();
        }
        updateLoader(false);
        update();
      } else {
        updateLoader(false);update();
      }
      update();
    } on CustomException {
      updateLoader(false);
      update();
    } catch (error) {
      updateLoader(false);
      update();
    }
  }
  /// branch client list
  void callClientList() async {
    clientNameList.clear();
    try {
      BranchClientListModel? response = (await repository.getBranchClientList(selectedBranchId));
      if (response.success!) {
        clientNameList.addAll(response.clientListDetails!);

        if(clientNameList.length==1){
          selectedClientId = clientNameList[0].firmClientId!;
          selectedClientName = clientNameList[0].firmClientFirmName!;
        }
        updateLoader(false);
        update();
      } else {
        updateLoader(false);update();
      }
      update();
    } on CustomException {
      updateLoader(false);
      update();
    } catch (error) {
      updateLoader(false);
      update();
    }
  }
  /// branch employee list
  void callEmpList() async {
    employeeNameList.clear();
    try {
      BranchEmpModel? response = (await repository.getBranchEmpList(selectedBranchId));
      if (response.success!) {
        employeeNameList.addAll(response.empListDetails!);
        if(employeeNameList.length==1){
          selectedEmpId = employeeNameList[0].mastId!;
          selectedEmployeeName = employeeNameList[0].firmEmployeeName!;
        }
        updateLoader(false);
        update();
      } else {
        updateLoader(false);update();
      }
      update();
    } on CustomException {
      updateLoader(false);
      update();
    } catch (error) {
      updateLoader(false);
      update();
    }
  }
  /// add petty task
  void callAddPettyTask(BuildContext context) async {
    try {
      ApiResponse? response = (await repository.getAddPettyTask(selectedBranchId,selectedClientId,selectedEmpId,
        selectedTargetDateToSend,selectedTriggerDateToSend,task.text,fees.text,estimatedHours.text,estimatedMinutes.text));
      if (response.success!) {
        Utils.showSuccessSnackBar(response.message);
        clearAll();
        updateLoader(false);
        update();
      } else {
        Utils.showErrorSnackBar(response.message);
        updateLoader(false);update();
      }
      update();
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

  //--------------add client----------------------//

  ///add client
  List<String> constitutionList = [];
  String selectedConstitution = "";
  TextEditingController clientCode = TextEditingController();
  TextEditingController companyName = TextEditingController();
  List<String> groupList = [];
  String selectedClientGroupName = "";
  TextEditingController parentCompanyName = TextEditingController();
  TextEditingController erstWhileName = TextEditingController();
  TextEditingController clientCin = TextEditingController();
  TextEditingController clientPan = TextEditingController();
  TextEditingController clientTan = TextEditingController();
  TextEditingController clientGstin = TextEditingController();
  List<String> industryList = [];
  String selectedIndustryName = "";
  List<String> businessNatureList = [];
  String selectedBusinessNature = "";
  String selectedBirthDate = "";
  String selectedIncorporationDate = "";
  TextEditingController tradeName = TextEditingController();
  String dateOfIncorporation = "";
  TextEditingController addressLine1 = TextEditingController();
  TextEditingController addressLine2 = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController city = TextEditingController();
  List<String> stateList  = [];
  String selectedState = "";
  List<String> districtList  = [];
  String selectedDistrict = "";
  TextEditingController pincode = TextEditingController();
  TextEditingController landlineNo = TextEditingController();
  TextEditingController noOfPlants = TextEditingController();
  List<String> whatsAppNoCodeList = [];
  TextEditingController whatsAppNo = TextEditingController();
  TextEditingController clientEmail = TextEditingController();
  bool addClientValidateConstitution = false;
  bool addClientValidateClientCode = false;
  bool addClientValidateCompanyName = false;
  bool addClientValidateBranchName = false;
  bool validateClientGroup = false;
  bool validateParentCompany = false;
  bool validateErstwhileName = false;
  bool validateClientCin = false;
  bool validateClientPan = false;
  bool validateClientTan = false;
  bool validateClientGstin = false;
  bool validateIndustry = false;
  bool validateBusinessNature = false;
  bool validateBirthDate = false;
  bool validateTradeName = false;
  bool validateDateOfIncorporation = false;
  bool validateAddressLine1 = false;
  bool validateAddressLine2 = false;
  bool validateArea = false;
  bool validateCity = false;
  bool validateState = false;
  bool validateDistrict = false;
  bool validatePincode = false;
  bool validateLandlineNo = false;
  bool validateNoOfPlants = false;
  bool validateWhatsAppNo = false;
  bool validateClientEmail = false;

  ///constitution
  updateSelectedConstitution(String val){
    if(constitutionList.isNotEmpty){
      selectedConstitution = val; update();
    }
  }
  checkConstitutionValidation(String val){
    if(constitutionList.isNotEmpty){
      selectedConstitution = val;
      update();
      if(selectedConstitution==""){ addClientValidateConstitution = true; update(); }
      else{addClientValidateConstitution = false; update(); }
    }
  }
  ///client code
  checkClientCodeValidation(BuildContext context){
    if(clientCode.text==""){ addClientValidateClientCode = true; update(); }
    else{addClientValidateClientCode = false; update(); }
  }
  ///company name
  checkCompanyNameValidation(BuildContext context){
    if(companyName.text==""){ addClientValidateCompanyName = true; update(); }
    else{addClientValidateCompanyName = false; update(); }
  }
  ///client group
  updateSelectedClientGroup(String val){
    if(groupList.isNotEmpty){
      selectedClientGroupName = val; update();
    }
  }
  checkClientGroupValidation(String val){
    if(groupList.isNotEmpty){
      selectedClientGroupName = val;
      update();
      if(selectedClientGroupName==""){ validateClientGroup = true; update(); }
      else{validateClientGroup = false; update(); }
    }
  }
  ///parent company
  checkParentNameValidation(BuildContext context){
    if(parentCompanyName.text==""){ validateParentCompany = true; update(); }
    else{validateParentCompany = false; update(); }
  }
  ///erstwhile
  checkErstwhileValidation(BuildContext context){
    if(erstWhileName.text==""){ validateErstwhileName = true; update(); }
    else{validateErstwhileName = false; update(); }
  }
  ///client cin
  checkClientCinValidation(BuildContext context){
    if(clientCin.text==""){ validateClientCin = true; update(); }
    else{validateClientCin = false; update(); }
  }
  ///client pan
  checkClientPanValidation(BuildContext context){
    if(clientPan.text==""){ validateClientPan = true; update(); }
    else{validateClientPan = false; update(); }
  }
  ///client tan
  checkClientTanValidation(BuildContext context){
    if(clientTan.text==""){ validateClientTan = true; update(); }
    else{validateClientTan = false; update(); }
  }
  ///client gstin
  checkClientGstinValidation(BuildContext context){
    if(clientGstin.text==""){ validateClientGstin = true; update(); }
    else{validateClientGstin = false; update(); }
  }
  ///industry
  updateSelectedIndustryName(String val){
    if(industryList.isNotEmpty){
      selectedIndustryName = val; update();
    }
  }
  checkIndustryValidation(String val){
    if(industryList.isNotEmpty){
      selectedIndustryName = val;
      update();
      if(selectedIndustryName==""){ validateIndustry = true; update(); }
      else{validateIndustry = false; update(); }
    }
  }
  ///business nature
  updateSelectedBusinessNature(String val){
    if(businessNatureList.isNotEmpty){
      selectedBusinessNature = val; update();
    }
  }
  checkBusinessNatureValidation(String val){
    if(businessNatureList.isNotEmpty){
      selectedBusinessNature = val;
      update();
      if(selectedBusinessNature==""){ validateBusinessNature = true; update(); }
      else{validateBusinessNature = false; update(); }
    }
  }
  ///birth date
  checkBirthDateValidation(BuildContext context){
    if(selectedBirthDate==""){ validateBirthDate = true; update(); }
    else{validateBirthDate = false; update(); }
  }
  ///trade name
  checkTradeNameValidation(BuildContext context){
    if(tradeName.text==""){ validateTradeName = true; update(); }
    else{validateTradeName = false; update(); }
  }
  ///date of incorporation
  checkDateOfIncorporationValidation(BuildContext context){
    if(selectedIncorporationDate==""){ validateDateOfIncorporation = true; update(); }
    else{validateDateOfIncorporation = false; update(); }
  }
  ///address line 1
  checkAddressLine1Validation(BuildContext context){
    if(addressLine1.text==""){ validateAddressLine1 = true; update(); }
    else{validateAddressLine1 = false; update(); }
  }
  ///address line 2
  checkAddressLine2Validation(BuildContext context){
    if(addressLine2.text==""){ validateAddressLine2 = true; update(); }
    else{validateAddressLine2 = false; update(); }
  }
  ///area
  checkAreaValidation(BuildContext context){
    if(area.text==""){ validateArea = true; update(); }
    else{validateArea = false; update(); }
  }
  ///city
  checkCityValidation(BuildContext context){
    if(city.text==""){ validateCity = true; update(); }
    else{validateCity = false; update(); }
  }
  ///state
  updateSelectedState(String val){
    if(stateList.isNotEmpty){
      selectedState = val; update();
    }
  }
  checkStateValidation(String val){
    if(stateList.isNotEmpty){
      selectedState = val;
      update();
      if(selectedState==""){ validateState = true; update(); }
      else{validateState = false; update(); }
    }
  }
  ///district
  updateSelectedDistrict(String val){
    if(districtList.isNotEmpty){
      selectedDistrict = val; update();
    }
  }
  checkDistrictValidation(String val){
    if(districtList.isNotEmpty){
      selectedDistrict = val;
      update();
      if(selectedDistrict==""){ validateDistrict = true; update(); }
      else{validateDistrict = false; update(); }
    }
  }
  ///pincode
  checkPincodeValidation(BuildContext context){
    if(pincode.text==""){ validatePincode = true; update(); }
    else{validatePincode = false; update(); }
  }
  ///landline no
  checkLandlineNoValidation(BuildContext context){
    if(landlineNo.text==""){ validateLandlineNo = true; update(); }
    else{validateLandlineNo = false; update(); }
  }
  ///no of plants
  checkNoOfPlantsValidation(BuildContext context){
    if(noOfPlants.text==""){ validateNoOfPlants = true; update(); }
    else{validateNoOfPlants = false; update(); }
  }
  ///whatsapp no
  checkWhatsAppNoValidation(BuildContext context){
    if(whatsAppNo.text==""){ validateWhatsAppNo = true; update(); }
    else{validateWhatsAppNo = false; update(); }
  }
  ///client email
  checkClientEmailValidation(BuildContext context){
    if(clientEmail.text==""){ validateClientEmail = true; update(); }
    else{validateClientEmail = false; update(); }
  }
}