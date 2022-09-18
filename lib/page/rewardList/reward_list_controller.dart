import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supply_chain/model/secure_storage_content.dart';
import 'package:supply_chain/service/secure_storage_service.dart';
import 'package:supply_chain/state/issue_state_controller.dart';
import 'package:supply_chain/state/user_state_controller.dart';
import 'package:supply_chain/theme/colors.dart';
import 'package:supply_chain/utils/constants.dart';
import 'package:thor_devkit_dart/utils.dart';
import 'package:thor_request_dart/connect.dart';
import 'package:thor_request_dart/wallet.dart';

class RewardListController extends GetxController {
  RxInt selectedIndex = 0.obs;
  UserStateController userStateController = Get.put(UserStateController());
  IssueStateController issueStateController = Get.put(IssueStateController());
  bool isAwaitingForConfirmation = false;

  RxList<Color> buttonColorList = [
    ChainColor.grey2,
    ChainColor.grey2,
    ChainColor.grey2,
    ChainColor.grey2
  ].obs;

  RxList<Color> iconColorList = [
    ChainColor.black,
    ChainColor.black,
    ChainColor.black,
    ChainColor.black
  ].obs;
  List<String> imageIconList = [
    "assets/images/cash_icon.png",
    "assets/images/online_course_icon.png",
    "assets/images/token_icon.png",
    "assets/images/google_play_icon.png"
  ];

  List<String> imageIconLabelList = [
    "Cash \n 100",
    "Online courses \n 50",
    "Tokens \n 15",
    "Google Play \n 20"
  ];

  List<String> rewardAddresses = [
    "0x26ED60c7CBe2519ae39E13486D91772D7D07563f" ///Cash
    "0x75466C6e66eb0FF5e0380Ef0438aC04aAa7EbD42", /// Course
    "0x6620086742791009C5348d35aa5bD2018CAb5FF7", /// Token
    "0x361d23b15772A40e8cdC69c27fF40BC8867BAf36" /// Play Store
  ];

  List<int> minimumAmount = [
    100,
    50,
    15,
    20
  ];

  String backText = "back";
  String confirmText = "Confirm";
  String title = "How do you want to\nredeem?";

  selectButton(index) {
    selectedIndex.value = index;
    buttonColorList.value = [
      ChainColor.grey2,
      ChainColor.grey2,
      ChainColor.grey2,
      ChainColor.grey2
    ];
    iconColorList.value = [
      ChainColor.black,
      ChainColor.black,
      ChainColor.black,
      ChainColor.black
    ];
    buttonColorList.value[index] = ChainColor.secondary;
    iconColorList.value[index] = ChainColor.white;
  }

  bool isAmountSufficient(int index) {
    if (minimumAmount[index] <= userStateController.user.value.balance) {
      return true;
    }
    return false;
  }

  purchase() async {
    if(isAmountSufficient(selectedIndex.value)) {
      /// send transaction of the selected amount to the relative address
      var connector = Connect("https://testnet.veblocks.net");
      var _wallet = Wallet(hexToBytes("dce1443bd2ef0c2631adc1c67e5c93f13dc23a41c18b536effbbdcbcdb96fb65"));
      var response = await connector.transferToken(
          _wallet,
           issueStateController.issue.value.walletAddress,
           rewardAddresses[selectedIndex.value], // OCE smart contract
           BigInt.from(3 * (10^18))
      );
      debugPrint("purchased tokens" + response.toString());
    }
    return null;
  }
}
