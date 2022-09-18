import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:supply_chain/page/report/report.dart';
import 'package:supply_chain/state/issue_state_controller.dart';

class ChooseLocationController extends GetxController {
  String where = "Where did it happened?";
  RxString drag = "Try to get location...".obs;
  String place = "place";
  var postion = LatLng(0, 0).obs;
  var location = LatLng(0, 0).obs;

  GoogleMapController? mapController;
  RxSet<Marker> customMarkerList = Set<Marker>().obs;
  IssueStateController issueStateController = Get.put(IssueStateController());

  changePosition(CameraPosition position) {
    postion.value = LatLng(position.target.latitude, position.target.longitude);
  }

  Future<LatLng> getUserCurrentLocation() async {
    try {
      await Geolocator.requestPermission();
    } catch (e) {
      return LatLng(0, 0);
    }
    return LatLng((await Geolocator.getCurrentPosition()).latitude,
        (await Geolocator.getCurrentPosition()).longitude);
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  addToIssue() {


    issueStateController.issue.value.gpsCoordinates =
        "${postion.value.latitude.toStringAsFixed(6)} ${postion.value.longitude.toStringAsFixed(6)}";
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    location.value = LatLng((await getUserCurrentLocation()).latitude,
        (await getUserCurrentLocation()).longitude);
    print("Latitude: " + location.value.latitude.toString());
    mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(location.value.latitude, location.value.longitude),
        zoom: 16)));
    drag.value = "Swipe the map to change the location";
  }
}
