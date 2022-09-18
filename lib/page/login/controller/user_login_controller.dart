import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:supply_chain/page/home/home.dart';
import '../../../service/auth_service.dart';

class UserLoginController extends GetxController {
  final passwordController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  RxBool isValid = false.obs;
  final authService = Get.find<AuthService>();
  RxString error = "".obs;


  @override
  onInit() {
    passwordController.value.text = "";
    emailController.value.text = "";
    super.onInit();
  }

  validate(value) {
    if(passwordController.value.text.isNotEmpty  && EmailValidator.validate(emailController.value.text)) {
      isValid.value = true;
    } else {
      isValid.value = false;
    }

  }


  Future<void> signInPressed() async {
    /// TODO show the loading
    String loginResult = await authService.login(emailController.value.text, passwordController.value.text);
    if (loginResult.isEmpty) {
      Get.to(Home());
    } else {
      /// TODO setup a failure for the login and the message to the user
      error.value = "error while logging in with these credentials";
    }
  }
}