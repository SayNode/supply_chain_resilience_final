import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:supply_chain/page/choose_location/choose_location.dart';
import 'package:supply_chain/page/report/report_controller.dart';
import 'package:supply_chain/page/token/token.dart';
import 'package:supply_chain/state/issue_state_controller.dart';
import 'package:supply_chain/utils/globals.dart';

import '../../service/issue_service.dart';
import '../../theme/colors.dart';
import '../widgets/app_bar/chain_app_bar_title.dart';

class Report extends GetView<ReportController> {
  const Report({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var mainPadding = screenSize.height * 0.05;
    var reportController = Get.put(ReportController());

    return Scaffold(
      appBar: AppBar(
        title: ChainAppBarTitle(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: screenSize.height * 0.08,
              left: mainPadding,
              right: mainPadding),
          child: Column(children: [
            Text(
              reportController.title,
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.08),
              child: Text(reportController.delayEstimationText,
                  style: Theme.of(context).textTheme.headline2),
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.01),
                child: Text(
                    reportController.getDelayEstimatedLabel(
                        reportController.delayEstimated.value),
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ),
            Obx(() => Slider(
                  activeColor: ChainColor.darkPurple,
                  inactiveColor: ChainColor.purple,
                  min: 0.0,
                  max: 140.0,
                  value: reportController.delayEstimated.value,
                  divisions: 14,
                  onChanged: (value) =>
                      reportController.delayEstimated.value = value,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(reportController.sliderStartText,
                    style: Theme.of(context).textTheme.bodyText1),
                Text(reportController.sliderEndText,
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.04),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(reportController.furtherInformation,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.01),
              child: Obx(
                  () => TextField(
                    maxLines: 8,
                    controller: reportController.furtherInformationController.value,
                    decoration: InputDecoration(
                        hintText: reportController.furtherInformationHintText,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ChainColor.darkPurple, width: 2),
                            borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ChainColor.darkPurple, width: 2),
                            borderRadius: BorderRadius.circular(5)))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.04),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(reportController.alternativeText,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.01),
              child: Obx(
                  () => TextField(
                    maxLines: 8,
                    controller: reportController.suggestionController.value,
                    decoration: InputDecoration(
                        hintText: reportController.alternativeTextHintText,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ChainColor.darkPurple, width: 2),
                            borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ChainColor.darkPurple, width: 2),
                            borderRadius: BorderRadius.circular(5)))),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.03),
              child: ElevatedButton(
                  onPressed: () async {
                    await reportController.confirm();
                    Get.to(() => Token());
                  } ,
                  child: Container(
                      height: screenSize.height * 0.06,
                      width: screenSize.width * 0.9,
                      child: Center(
                          child: Text(reportController.buttonText,
                              style: Theme.of(context).textTheme.button, textAlign: TextAlign.center,)))),
            )
          ]),
        ),
      ),
    );
  }
}
