import 'dart:typed_data';

import 'package:thor_request_dart/wallet.dart';

// String? address = '0x00bab3d8de4ebbefb07d53b1ff8c0f2434bd616d'; // Key for testing
String? address = '';

//TODO: Change this once server api is implemented
String? username;
String? password;
bool loginStatus = false;

List<String>? mnemonicPhrase;
Uint8List? privateKey;
Wallet? wallet;
String? qrCode;

bool mnemonicNoted = false;
String token = '';

//auth0
bool isBusy = false;
bool isLoggedIn = false;
String? name;
String? picture;
String user = """{
    "userId": "W_Liechti",
    "displayName": "Werner Liechti",
    "walletAdress": "www.comits.be"
}""";
