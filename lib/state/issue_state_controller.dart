import 'package:get/get.dart';

import '../model/issue.dart';
import '../model/user.dart';

class IssueStateController extends GetxController {
  Rx<Issue> issue = Issue().obs;
}