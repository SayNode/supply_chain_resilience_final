import 'package:get/get.dart';

import '../model/user.dart';

class UserStateController extends GetxController {
  Rx<User> user = User().obs;
}