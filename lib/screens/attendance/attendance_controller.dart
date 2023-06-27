import 'package:biznew/constant/repository/api_repository.dart';
import 'package:biznew/routes/app_pages.dart';
import 'package:biznew/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AttendanceController extends GetxController {
  final ApiRepository repository;

  // ignore: unnecessary_null_comparison
  AttendanceController({required this.repository}) : assert(repository != null);

  bool isLoading = true;

  ///common
  String userId = "";
  String userName = "";
  String name = "";

  @override
  void onInit() {
    super.onInit();
    userId = GetStorage().read("userId") ?? "";
    userName = GetStorage().read("userName") ?? "";
    name = GetStorage().read("name") ?? "";
    repository.getData();
    getCurrentPosition();
  }

  String? currentAddress;
  Position? currentPosition;

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Utils.showErrorSnackBar(
          "Location services are disabled. Please enable the services");
      update();
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Utils.showErrorSnackBar("Location permissions are denied");
        update();
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Utils.showErrorSnackBar(
          "Location permissions are permanently denied, we cannot request permissions.");
      update();
      return false;
    }
    update();
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      print(
          "lat : ${currentPosition!.latitude}, long : ${currentPosition!.longitude},");
      update();
      getAddressFromLatLng(currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
    update();
  }

  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress = '${place.street}, ${place.subLocality}, '
          '${place.subAdministrativeArea}, ${place.postalCode}';

      print("place");
      print(place);
      print("place.name");
      print(place.name);
      print("place.administrativeArea");
      print(place.administrativeArea);
      print("place.country");
      print(place.country);
      print("place.isoCountryCode");
      print(place.isoCountryCode);
      print("place.locality");
      print(place.locality);
      print("place.postalCode");
      print(place.postalCode);
      print("place.street");
      print(place.street);
      print("place.subAdministrativeArea");
      print(place.subAdministrativeArea);
      print("place.subLocality");
      print(place.subLocality);
      print("place.subThoroughfare");
      print(place.subThoroughfare);
      print("place.thoroughfare");
      print(place.thoroughfare);

      isLoading = false;

      update();
    }).catchError((e) {
      debugPrint(e);
      isLoading = false;
    });
    update();
  }

  callLogout() {
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
