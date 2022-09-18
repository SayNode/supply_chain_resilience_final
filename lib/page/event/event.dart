import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:supply_chain/main.dart';
import 'package:supply_chain/page/event/widget/event_button.dart';

import '../widgets/app_bar/chain_app_bar_title.dart';
import 'event_controller.dart';

class Event extends GetView<EventController> {
  const Event({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var eventController = Get.put(EventController());
    double mainPadding = screenSize.width * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: ChainAppBarTitle(),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: screenSize.height * 0.08,
          left: mainPadding,
          right: mainPadding),
        child: Center(
          child: Column(
            children: [
              Text(eventController.happenedText,
                  style: Theme.of(context).textTheme.headline1),
              SizedBox(
                height: screenSize.height * 0.08,
              ),
              Container(
                height: screenSize.height * 0.6,
                child: ListView.builder(
                  itemCount: eventController.categoryService.categoryList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: screenSize.height * 0.03),
                      child: EventButton(
                          mainPadding: mainPadding,
                          eventController: eventController,
                          screenSize: screenSize,
                          eventText: eventController.categoryService.categoryList[index].categoryName.capitalizeFirst.toString(),
                          eventId: eventController.categoryService.categoryList[index].id,
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
