import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:supply_chain/page/choose_location/choose_location.dart';
import 'package:supply_chain/page/report/report.dart';
import 'package:supply_chain/theme/colors.dart';

import '../widgets/app_bar/chain_app_bar_title.dart';
import 'choose_order_controller.dart';

class ChooseOrder extends GetView<ChooseOrderController> {
  const ChooseOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var mainPadding = screenSize.height * 0.05;
    var chooseOrderController = Get.put(ChooseOrderController());

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
              chooseOrderController.title,
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.03),
                child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      var orderList = chooseOrderController
                          .orderService.orderList
                          .map((orderMap) =>
                              (orderMap.allAttributes as String).toLowerCase())
                          .toList();
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return orderList.where((String option) {
                        return option
                            .contains(textEditingValue.text.toLowerCase());
                      }).toList();
                    },
                    optionsViewBuilder: (context, onSelected, options) => Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              width: screenSize.width * 0.772,
                              decoration:
                                  BoxDecoration(color: Colors.transparent),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: options.length,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () =>
                                      onSelected(options.toList()[index]),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                            options
                                                .toList()[index]
                                                .split(';')
                                                .toList()[0],
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      Divider()
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    onSelected: (option) {
                      if (!chooseOrderController.orderListChoosen.value
                          .contains(option)) {
                        chooseOrderController.addOrderListChoosen(option);
                      }
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    fieldViewBuilder: (context, textEditingController,
                            focusNode, onFieldSubmitted) =>
                        TextField(
                            decoration: InputDecoration(
                                hintText:
                                    chooseOrderController.searchOrdersText,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ChainColor.darkPurple, width: 2),
                                    borderRadius: BorderRadius.circular(5)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ChainColor.darkPurple, width: 2),
                                    borderRadius: BorderRadius.circular(5))),
                            controller: textEditingController,
                            focusNode: focusNode,
                            onSubmitted: (value) => chooseOrderController
                                .addOrderListChoosen(value)))),
            Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.045),
                child: Obx(() => Column(
                        children: List.generate(
                            chooseOrderController.orderListChoosen.value.length,
                            (index) {
                      var orderList =
                          chooseOrderController.orderListChoosen.value;

                      return Padding(
                        padding:
                            EdgeInsets.only(bottom: screenSize.height * 0.02),
                        child: Container(
                            height: screenSize.height * 0.055,
                            width: screenSize.width * 0.8,
                            decoration: BoxDecoration(
                                color: ChainColor.secondary,
                                borderRadius: BorderRadius.circular(30)),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(orderList[index].split(';').toList()[0],
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .apply(color: ChainColor.white)),
                                Positioned(
                                    right: 8,
                                    child: IconButton(
                                        onPressed: () => chooseOrderController
                                            .orderListChoosen
                                            .remove(orderList[index]),
                                        icon: Icon(Icons.close_rounded,
                                            color: ChainColor.white)))
                              ],
                            )),
                      );
                    })))),
            Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.02),
              child: TextField(
                decoration: InputDecoration(
                    hintText: chooseOrderController.searchProductText,
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ChainColor.darkPurple, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ChainColor.darkPurple, width: 2),
                        borderRadius: BorderRadius.circular(5))),
                onSubmitted: (value) =>
                    chooseOrderController.productListChoosen.value.add(value),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.045),
                child: Obx(() => Column(
                        children: List.generate(
                            chooseOrderController
                                .productListChoosen.value.length, (index) {
                      var productList =
                          chooseOrderController.productListChoosen.value;

                      return Padding(
                        padding:
                            EdgeInsets.only(bottom: screenSize.height * 0.02),
                        child: Container(
                            height: screenSize.height * 0.055,
                            width: screenSize.width * 0.8,
                            decoration: BoxDecoration(
                                color: ChainColor.secondary,
                                borderRadius: BorderRadius.circular(30)),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(productList[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .apply(color: ChainColor.white)),
                                Positioned(
                                    right: 8,
                                    child: IconButton(
                                        onPressed: () => chooseOrderController
                                            .productListChoosen
                                            .remove(productList[index]),
                                        icon: Icon(Icons.close_rounded,
                                            color: ChainColor.white)))
                              ],
                            )),
                      );
                    }))))
          ]),
        )),
        floatingActionButton: Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            width: screenSize.width * 0.2,
            height: screenSize.width * 0.2,
            child: FloatingActionButton(
              backgroundColor: ChainColor.primary,
              onPressed: () => Get.to(() => ChooseLocation()),
              child: CircleAvatar(
                backgroundColor: ChainColor.primary,
                radius: screenSize.width * 0.08,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: ChainColor.white,
                  size: 40,
                ),
              ),
            ),
          ),
        ));
  }
}
