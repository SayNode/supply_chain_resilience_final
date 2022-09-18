import 'dart:collection';
import 'dart:math';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supply_chain/page/widgets/app_bar/chain_app_bar_title.dart';
import 'package:supply_chain/theme/colors.dart';
import '../../state/user_state_controller.dart';
import '../report/report.dart';
import 'controller/choose_location_controller.dart';
import 'package:geolocator/geolocator.dart';

class ChooseLocation extends GetView<ChooseLocationController> {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var mainPadding = screenSize.height * 0.05;
    ChooseLocationController chooseLocationController =
        Get.put(ChooseLocationController());
    UserStateController userStateController = Get.put(UserStateController());
    return Scaffold(
      appBar: AppBar(
        title: ChainAppBarTitle(),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.16,
                vertical: screenSize.width * 0.08),
            child: Column(
              children: [
                Text(
                  chooseLocationController.where,
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                Obx(() => Text(chooseLocationController.drag.value,
                    style: Theme.of(context).textTheme.headline3)),
              ],
            ),
          ),
          SizedBox(
              width: double.infinity,
              height: screenSize.height * 0.7,
              child: Stack(
                children: [
                  Obx(() => GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              chooseLocationController.location.value.latitude,
                              chooseLocationController
                                  .location.value.longitude),
                          zoom: 10),
                      onMapCreated: chooseLocationController.onMapCreated,
                      onCameraMove: chooseLocationController.changePosition)),
                  Center(
                    child: Image.asset("assets/images/custom_marker.png",
                        width: 40),
                  )
                ],
              ))
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Container(
                color: ChainColor.primary,
                width: screenSize.width * 0.4,
                height: screenSize.height * 0.03,
                child: Center(child: Text("Continue"))),
            onPressed: (() {
              chooseLocationController.addToIssue();
              Get.to(() => Report());
            }),
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
