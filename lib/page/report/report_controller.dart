

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supply_chain/model/user.dart';
import 'package:supply_chain/page/choose_location/choose_location.dart';
import 'package:supply_chain/service/balance_service.dart';
import 'package:supply_chain/service/issue_service.dart';
import 'package:supply_chain/state/issue_state_controller.dart';
import 'package:supply_chain/state/user_state_controller.dart';

class ReportController extends GetxController {
  String title = "Tell us a bit more about the event";
  String delayEstimationText = "Delay estimation";
  RxDouble delayEstimated = 0.0.obs;
  String sliderStartText = "Hours";
  String sliderEndText = "Weeks";
  String furtherInformation = "Further information:";
  String alternativeText = "Which alternatives or solutions do you suggest?";
  String furtherInformationHintText = "Description of ...";
  String alternativeTextHintText = "I suggest ...";
  String buttonText = "Submit report";
  IssueStateController issueStateController = Get.put(IssueStateController());
  IssueService issueService = Get.put(IssueService());
  BalanceService balanceService = Get.put(BalanceService());
  final furtherInformationController = TextEditingController().obs;
  final suggestionController = TextEditingController().obs;
  int delayValue = 0;


  Map valueToDelay = {
    0: 0,
    10: 1,
    20: 3,
    30: 6,
    40: 12,
    50: 18,
    60: 1,
    70: 2,
    80: 3,
    90: 4,
    100: 5,
    110: 1,
    120: 3,
    130: 6,
    140: 12
  };

  String getDelayEstimatedLabel(double value) {
    delayValue = value.toInt();
    if (value < 60) {
      return "${valueToDelay[value]} hours";
    } else if (value < 110) {
      return "${valueToDelay[value]} days";
    } else {
      return "${valueToDelay[value]} weeks";
    }
  }

  confirm() async {
    issueStateController.issue.value.delayEstimation = delayValue.toString();
    issueStateController.issue.value.message = furtherInformationController.value.text;
    issueStateController.issue.value.suggestions = suggestionController.value.text;
    await issueService.submitIssue();
    await balanceService.updateUserBalance();
  }
}