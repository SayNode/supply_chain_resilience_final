import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supply_chain/page/event/event.dart';
import 'package:supply_chain/page/rewardList/reward_list.dart';
import 'package:supply_chain/page/token/token.dart';
import 'package:supply_chain/theme/colors.dart';
import '../widgets/app_bar/chain_app_bar_title.dart';
import 'controller/home_controller.dart';

class Home extends GetView<HomeController> {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double mainPadding = screenSize.width * 0.05;
    var homeController = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: ChainAppBarTitle(),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: screenSize.height * 0.08),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  left: mainPadding, right: mainPadding, bottom: mainPadding),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ChainColor.grey2,
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: ChainColor.grey1, width: 3)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenSize.height * 0.02,
                          ),
                          Text(homeController.reportText,
                              style: Theme.of(context).textTheme.headline2),
                          SizedBox(
                            height: screenSize.height * 0.02,
                          ),
                          Image.asset(homeController.reportImage),
                          SizedBox(
                            height: screenSize.height * 0.02,
                          ),
                          ElevatedButton(
                              onPressed: () => Get.to(() => Event()),
                              child: Text(homeController.elevatedButtonText1)),
                          SizedBox(
                            height: screenSize.height * 0.01,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.03,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ChainColor.grey2,
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: ChainColor.grey1, width: 3)),
                      child: Column(children: [
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        Text(homeController.rewardText,
                            style: Theme.of(context).textTheme.headline2),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        Image.asset(homeController.rewardImage),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        ElevatedButton(
                            onPressed: () => Get.to(() => Token()),
                            child: Text(homeController.elevatedButtonText2)),
                        SizedBox(
                          height: screenSize.height * 0.01,
                        ),
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


