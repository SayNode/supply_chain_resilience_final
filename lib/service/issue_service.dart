import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:supply_chain/model/secure_storage_content.dart';
import 'package:supply_chain/service/auth_service.dart';
import 'package:supply_chain/service/secure_storage_service.dart';
import 'package:supply_chain/state/issue_state_controller.dart';
import 'package:supply_chain/state/user_state_controller.dart';
import '../model/order.dart';
import '../model/user.dart';
import '../page/choose_location/choose_location.dart';
import '../page/home/home.dart';
import '../utils/constants.dart';


/// needs the secure storage service to be initialized
class IssueService extends GetxService {

  SecureStorageService secureStorageService = Get.find<SecureStorageService>();
  AuthService authService = Get.put(AuthService());
  UserStateController userStateController = Get.put(UserStateController());
  IssueStateController issueStateController = Get.put(IssueStateController());

  Future<IssueService> init() async {
    debugPrint('IssueService - initializing ...');
    await secureStorageService.getStoredContent();
    issueStateController.issue.value.walletAddress = secureStorageService.storedContent.address;
    issueStateController.issue.value.user = userStateController.user.value.id;
    debugPrint('IssueService - wallet_address is now: ' + issueStateController.issue.value.walletAddress);
    debugPrint('IssueService - done.');
    return this;
  }

  Future<bool> requestTokens() async {
    var url = Uri.http(ChainConstants.smart_contract_domain, 'form/${issueStateController.issue.value.walletAddress}/50000000000000000000');
    final response = await http.get(url);
    debugPrint("requesting tokens " + response.body);
    if(response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> submitIssue() async{
    debugPrint("Submitting issue");
    var url = Uri.http(ChainConstants.domain, 'api/issue/new/');

    var body = jsonEncode({
        "order_id": issueStateController.issue.value.order.split(';')[0],
      "message": issueStateController.issue.value.message,
      "suggestions": issueStateController.issue.value.suggestions,
      "delay_estimation": issueStateController.issue.value.delayEstimation.toString(),
      "status": 0,
      "gps_coordinates": issueStateController.issue.value.gpsCoordinates.toString(),
      "user": issueStateController.issue.value.user,
      "category": issueStateController.issue.value.category,
      "product": 3
    });

    debugPrint("whatever " + issueStateController.issue.value.gpsCoordinates.toString());

    final response = await http.post(url, body: body, headers: {HttpHeaders.authorizationHeader: "Bearer " + secureStorageService.storedContent.accessToken, HttpHeaders.contentTypeHeader: 'application/json'});
    debugPrint("response code: " + response.statusCode.toString());
    debugPrint("response code: " + response.body.toString());
    if(response.statusCode == 201) {
      await requestTokens();
      return true;
    }
    return false;
  }

}