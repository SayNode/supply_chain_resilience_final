import 'package:supply_chain/utils/constants.dart';

/// all content stored locally in secure storage will be in this model
/// this way we can get all the content and manage it through this class
/// TODO implement the saving and the reading
class SecureStorageContent {
  String accessToken = "";
  String refreshToken = "";
  String secretKey = "";
  String publicKey = "";
  String address = "";

  SecureStorageContent();

  SecureStorageContent.fromString({required this.accessToken, required this.refreshToken});

  SecureStorageContent.fromJson(Map<String, dynamic> json)
      : accessToken = json.containsKey(ChainConstants.accessToken) ? json[ChainConstants.accessToken] : "",
        secretKey = json.containsKey(ChainConstants.secretKey) ? json[ChainConstants.secretKey] : "",
        publicKey = json.containsKey(ChainConstants.publicKey) ? json[ChainConstants.publicKey] : "",
        address = json.containsKey(ChainConstants.address) ? json[ChainConstants.address] : "",
        refreshToken = json.containsKey(ChainConstants.refreshToken) ? json[ChainConstants.refreshToken] : "";

  Map<String, dynamic> toJson() => {
    ChainConstants.accessToken: accessToken,
    ChainConstants.refreshToken: refreshToken,
    ChainConstants.secretKey: secretKey,
    ChainConstants.publicKey: publicKey,
    ChainConstants.address: address,
  };

}