import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:supply_chain/model/secure_storage_content.dart';
import 'package:supply_chain/service/secure_storage_service.dart';
import 'package:supply_chain/state/user_state_controller.dart';
import '../model/user.dart';
import '../page/choose_location/choose_location.dart';
import '../page/home/home.dart';
import '../utils/constants.dart';

import 'package:thor_devkit_dart/crypto/address.dart';
import 'package:thor_devkit_dart/crypto/secp256k1.dart';
import 'package:thor_devkit_dart/utils.dart';




/// needs the secure storage service to be initialized
class AuthService extends GetxService {

  String authenticationToken = "";
  SecureStorageService secureStorageService = Get.find<SecureStorageService>();
  UserStateController userStateController = Get.put(UserStateController());


  Future<AuthService> init() async {
    debugPrint('AuthService - initializing ...');
    // search for a token in the secure storage
    await secureStorageService.getStoredContent();

    bool isUserInStorage = await secureStorageService.isUserInStorage();
    bool isAddressCreated = await secureStorageService.isAddressCreated();
    if(!isAddressCreated) {
      //generate a new private key
      BigInt priv = generatePrivateKey();
      Uint8List pub = derivePublicKey(priv, false); // byte[65].
      Uint8List addr = Address.publicKeyToAddressBytes(pub);
      String address = "0x" + bytesToHex(addr);
      await secureStorageService.getStoredContent();
      SecureStorageContent secureStorageContent = secureStorageService.storedContent;
      secureStorageContent.secretKey = intToHex(priv);
      secureStorageContent.publicKey = bytesToHex(pub);
      secureStorageContent.address = address;
      secureStorageService.storeAndOverwrite(secureStorageContent);
      debugPrint("AuthService - created wallet: " + address);
    } else {
      debugPrint("AuthService - stored wallet: " + secureStorageService.storedContent.address);
    }
    if(isUserInStorage) {
      // check token validity
      bool isTokenValid = await this.isTokenValid(secureStorageService.storedContent.accessToken);
      if (isTokenValid){
        /// TODO uncomment when login page is ok
        // set the auth token for this session
        authenticationToken = secureStorageService.storedContent.accessToken;
        debugPrint("AuthService - user token: " + authenticationToken);
        userStateController.user.value = await getUser();
        if (userStateController.user.value.id != -1) {
          Get.to(() => Home());
        }
      }
    }
    debugPrint('AuthService - done.');
    return this;
  }

  Future<String> login(String email, String password) async{
    debugPrint("AuthService - starting login");
    var url = Uri.http(ChainConstants.domain, 'auth/login/');
    var body = {
      "email": email,
      "password": password
    };
    final response = await http.post(url, body: body);
    debugPrint("AuthService - got response");

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> userMap = jsonDecode(response.body);
        userStateController.user.value = User.fromJson(userMap["user"]);
        /// save the token
        authenticationToken = userMap[ChainConstants.accessToken];
        debugPrint("AuthService - authenticationToken: $authenticationToken");
        debugPrint("AuthService - user logged in: ${userStateController.user.value.email}");
        /// Store tokens in secure storage
        await secureStorageService.getStoredContent();
        SecureStorageContent storedContent = secureStorageService.storedContent;
        storedContent.accessToken = authenticationToken;
        storedContent.refreshToken = userStateController.user.value.email;
        secureStorageService.storeAndOverwrite(storedContent);
        return "";
      } catch (error) {
        debugPrint("AuthService - error while parsing the user: ${error}");
      }
    } else {
      debugPrint("AuthService - error while loggin in: ${response.body}");
      return response.body;
    }
    return "login error";
  }

  Future<bool> isTokenValid(String accessToken) async{
    var url = Uri.http(ChainConstants.domain, 'auth/token/verify/');
    var body = {
      "token": accessToken,
    };
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      debugPrint("AuthService - error while checking token validity in: ${response.body}");
    }
    return false;
  }

  Future<User> getUser() async{
    final queryParameters = {
      'token': authenticationToken
    };
    var url = Uri.http(ChainConstants.domain, 'auth/user/', queryParameters);
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: "Bearer " + authenticationToken});
    Map<String, dynamic> userMap = jsonDecode(response.body);
    User user = User.fromJson(userMap);
    return user;
  }

  // Future<UserStatistic> getUserStatistics() async{
  //   debugPrint("AuthService - starting login");
  //   var url = Uri.http(WizzerConstants.domain, 'api/users/status/w-progress/');
  //   final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: "Bearer " + authenticationToken});
  //   if (response.statusCode == 200) {
  //     try {
  //       Map<String, dynamic> userStatisticMap = jsonDecode(response.body)[0];
  //       debugPrint("AuthService - the User Statistics: ${userStatisticMap}");
  //       UserStatistic userStatistics = UserStatistic.fromJson(userStatisticMap);
  //       return userStatistics;
  //     } catch (error) {
  //       debugPrint("AuthService - error while parsing the User Statistics: ${error}");
  //     }
  //   } else {
  //     debugPrint("AuthService - error while searching for User Statistics in: ${response.body}");
  //     return UserStatistic();
  //   }
  //   return UserStatistic();
  // }


}