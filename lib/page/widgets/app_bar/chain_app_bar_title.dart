import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../state/user_state_controller.dart';
import '../../../theme/typography.dart';

class ChainAppBarTitle extends StatelessWidget {
  const ChainAppBarTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserStateController userStateController = Get.put(UserStateController());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => Text(userStateController.user.value.email, style: ChainTypography.appBar,)),
        Row(
          children: [
            Image.asset("assets/images/coin.png"),
            SizedBox(width: 10,),
            Obx(() => Text(userStateController.user.value.balance.toString(), style: ChainTypography.appBar,))
          ],
        )
      ],
    );
  }
}