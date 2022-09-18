import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:supply_chain/page/rewardList/reward_list.dart';
import 'package:supply_chain/page/widgets/app_bar/chain_app_bar_title.dart';
import 'package:supply_chain/theme/colors.dart';
import 'package:supply_chain/theme/typography.dart';

import '../../state/user_state_controller.dart';
import 'controller/token_controller.dart';

class Token extends GetView<TokenController> {
  const Token({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var mainPadding = screenSize.height * 0.05;
    var tokenController = Get.put(TokenController());
    UserStateController userStateController = Get.put(UserStateController());

    return Scaffold(
      appBar: AppBar(
        title: ChainAppBarTitle(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: screenSize.height * 0.16,
              left: mainPadding,
              right: mainPadding),
          child: Container(
            height: screenSize.height * 0.67,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Text(
                tokenController.congratulations,
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                decoration: BoxDecoration(
                  color: ChainColor.secondary,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Obx(() => Text(userStateController.user.value.balance.toString() + " " + tokenController.tokens, style: ChainTypography.tokenAmount, )),
              ),
              SizedBox(height: screenSize.height * 0.25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () => Get.back(),
                      child: Container(
                        width: screenSize.width * 0.3,
                        height: screenSize.height * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 3, color: ChainColor.grey2),
                            color: ChainColor.white),
                        child: Center(
                          child: Text(tokenController.backText,
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 20, color: ChainColor.black, fontWeight: FontWeight.bold))),
                        ),
                      )),
                  TextButton(
                      onPressed: () => Get.to(() => RewardList()),
                      child: Container(
                        width: screenSize.width * 0.3,
                        height: screenSize.height * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ChainColor.primary),
                        child: Center(
                          child: Text(
                            tokenController.confirmText,
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 20, color: ChainColor.white)),
                          ),
                        ),
                      ))
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
