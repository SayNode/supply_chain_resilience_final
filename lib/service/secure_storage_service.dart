import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:supply_chain/model/secure_storage_content.dart';
import 'package:supply_chain/utils/constants.dart';

class SecureStorageService extends GetxService {
  final storage = const FlutterSecureStorage();
  SecureStorageContent storedContent = SecureStorageContent();

  Future<bool> isKeyInStorage(String key) async{
    bool isKeyInStorage = await storage.containsKey(key: key);
    return isKeyInStorage;
  }
  Future<bool> isUserInStorage() async{
    bool isAccessTokenInStorage = await storage.containsKey(key: ChainConstants.accessToken);
    return isAccessTokenInStorage;
  }

  Future<void> getStoredContent() async {
    Map<String, String> allValues = await storage.readAll();
    storedContent =  SecureStorageContent.fromJson(allValues);
  }

  Future<void> init() async {
    debugPrint('SecureStorageService - initializing ...');
    await getStoredContent();
    debugPrint('SecureStorageService - done.');
    return;
  }

  void storeAndOverwrite(SecureStorageContent storedContent) {
    storage.write(key: ChainConstants.accessToken, value: storedContent.accessToken);
    storage.write(key: ChainConstants.refreshToken, value: storedContent.accessToken);
    storage.write(key: ChainConstants.address, value: storedContent.address);
    storage.write(key: ChainConstants.publicKey, value: storedContent.publicKey);
    storage.write(key: ChainConstants.secretKey, value: storedContent.secretKey);
  }

  isAddressCreated() async{
    bool isSecretKeyInStorage = await storage.containsKey(key: ChainConstants.secretKey);
    bool isPublicKeyInStorage = await storage.containsKey(key: ChainConstants.publicKey);
    bool isAddressInStorage = await storage.containsKey(key: ChainConstants.address);
    bool variablesExist = isAddressInStorage && isSecretKeyInStorage && isPublicKeyInStorage;
    if (!variablesExist) {
      return false;
    }
    String address = storedContent.address;
    String publicKey = storedContent.publicKey;
    String secretKey = storedContent.secretKey;
    return address.isNotEmpty && publicKey.isNotEmpty && secretKey.isNotEmpty;
  }

}