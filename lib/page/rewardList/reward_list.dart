import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supply_chain/page/rewardList/reward_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:supply_chain/page/reward_completion/reward_completion.dart';
import 'package:supply_chain/theme/colors.dart';

class RewardList extends GetView<RewardListController> {
  const RewardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var mainPadding = screenSize.height * 0.05;
    var rewardListController = Get.put(RewardListController());

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
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              shrinkWrap: true,
              children: List.generate(
                  4,
                  (index) => TextButton(
                        onPressed: () =>
                            rewardListController.selectButton(index),
                        child: Obx(
                          () => Container(
                            decoration: BoxDecoration(
                                color: rewardListController.buttonColorList.value[index],
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      rewardListController.imageIconList[index],
                                      color: rewardListController.iconColorList[index], scale: 1.25),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      rewardListController.imageIconLabelList[index],
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: ChainColor.black)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
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
                    onPressed: () async{
                      debugPrint("purchase");
                      await rewardListController.purchase();
                      Get.to(() => RewardCompletion());
                    },
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
