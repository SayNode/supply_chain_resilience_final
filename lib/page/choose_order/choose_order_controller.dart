import 'package:get/get.dart';
import 'package:supply_chain/state/issue_state_controller.dart';

import '../../service/order_service.dart';

class ChooseOrderController extends GetxController {
  String title = "Which goods are\naffected?";
  String searchOrdersText = "Search orders";
  String searchProductText = "Add products";
  OrderService orderService = Get.put(OrderService());
  IssueStateController issueStateController = Get.put(IssueStateController());

  RxList<String> orderListChoosen = <String>[].obs;
  RxList<String> productListChoosen = <String>[].obs;

  addOrderListChoosen(item) {
    orderListChoosen.value.add(item);
    issueStateController.issue.value.order = item;
  }
}
