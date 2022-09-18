
import 'package:get/get.dart';
import 'package:supply_chain/service/category_service.dart';
import 'package:supply_chain/state/issue_state_controller.dart';

import '../choose_order/choose_order.dart';



class EventController extends GetxController {
  String happenedText = "What happend?";
  CategoryService categoryService = Get.put(CategoryService());
  IssueStateController issueStateController = Get.put(IssueStateController());

  String eventHappened = "";

  setEvent(int eventId, String eventText) {
    eventHappened = eventText;
    issueStateController.issue.value.category = eventId; /// update the issue
    Get.to(() => ChooseOrder());
  }
}