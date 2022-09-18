import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:supply_chain/model/issue.dart';
import 'package:supply_chain/model/secure_storage_content.dart';
import 'package:supply_chain/service/auth_service.dart';
import 'package:supply_chain/service/secure_storage_service.dart';
import 'package:supply_chain/state/issue_state_controller.dart';
import 'package:supply_chain/state/user_state_controller.dart';
import 'package:thor_request_dart/connect.dart';
import '../model/order.dart';
import '../model/user.dart';
import '../page/choose_location/choose_location.dart';
import '../page/home/home.dart';
import '../utils/constants.dart';


/// needs the secure storage service to be initialized
class BalanceService extends GetxService {

  SecureStorageService secureStorageService = Get.find<SecureStorageService>();
  AuthService authService = Get.put(AuthService());
  UserStateController userStateController = Get.find<UserStateController>();
  int balance = 0;

  Future<BalanceService> init() async {
    await secureStorageService.getStoredContent();
    debugPrint('BalanceService - initializing ...'  + secureStorageService.storedContent.address);

    await updateUserBalance();
    debugPrint('BalanceService - done.');
    return this;
  }

  Future<void> updateUserBalance() async {
    balance = await getBalanceFromBlockchain();
    User user = User();
    user.id = userStateController.user.value.id;
    user.balance = balance;
    user.email = userStateController.user.value.email;
    user.avatar = userStateController.user.value.avatar;
    user.firstName = userStateController.user.value.firstName;
    user.lastName = userStateController.user.value.lastName;
    userStateController.user.value = user;
  }

  Future<int> getBalanceFromBlockchain() async {
    var connector = Connect("https://testnet.veblocks.net");
    BigInt balanceBI = await connector.balanceOfToken(secureStorageService.storedContent.address.toString(), ChainConstants.smart_contract_address);
    // BigInt balanceBI = await connector.balanceOfToken("0x215cabdcda0277eac21d4eb6236057a805181183", "0x66804d63Da582e6ff9904b6C189374E6300Bf9b5");
    int newBalance = (balanceBI / BigInt.parse("1000000000000000000")).toInt();
    debugPrint("balance amount DDDD " + newBalance.toString());
    return newBalance;
  }

  Future<int> getBalance() async{
    int balance = 0; /// api/users/balance
    var url = Uri.http(ChainConstants.domain, 'api/users/balance/');
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: "Bearer " + authService.authenticationToken});
    List<dynamic> dataMap = jsonDecode(response.body);
    debugPrint("balance is " + dataMap[0]["balance"].toString());
    balance = dataMap[0]["balance"];
    return balance;
  }

}