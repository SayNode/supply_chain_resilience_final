import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:supply_chain/page/reward_completion/reward_completion_controller.dart';
import 'package:supply_chain/theme/colors.dart';
import '../home/home.dart';

class RewardCompletion extends GetView<RewardCompletionController> {
  const RewardCompletion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var mainPadding = screenSize.height * 0.05;
    var rewardListController = Get.put(RewardCompletionController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: screenSize.height * 0.16,
              left: mainPadding,
              right: mainPadding),
          child: Column(children: [
            Text(
              rewardListController.title,
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            Container(
              child: Image.asset('assets/images/check.png'),
            ),
            SizedBox(height: screenSize.height * 0.10),
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
                        child: Text(rewardListController.backText,
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 20, color: ChainColor.black, fontWeight: FontWeight.bold))),
                      ),
                    )),
                TextButton(
                    onPressed: () => Get.to(() => Home()),
                    child: Container(
                      width: screenSize.width * 0.3,
                      height: screenSize.height * 0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: ChainColor.primary),
                      child: Center(
                        child: Text(
                          rewardListController.confirmText,
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
    );
  }
}
