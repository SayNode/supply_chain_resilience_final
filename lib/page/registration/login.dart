import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supply_chain/theme/colors.dart';
import 'package:supply_chain/theme/typography.dart';
import 'controller/user_login_controller.dart';
import 'widget/social_box.dart';

class Login extends GetView<UserLoginController> {
  Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double mainPadding = screenSize.width * 0.05;
    var userLoginController = Get.put(UserLoginController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset("assets/images/login_background.jpeg"),
              Column(
                children: [
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.08),
                    child: SizedBox(
                      width: screenSize.width * 0.91,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sign in to Use App",
                            style: TextStyle(),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                                () => TextFormField(
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                controller:
                                userLoginController.emailController.value,
                                onChanged: (value) =>
                                    userLoginController.validate(value),
                                validator: (value) {
                                  if (!EmailValidator.validate(value!)) {
                                    return "Enter a valid email address";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    suffixIcon:
                                    Icon(Icons.alternate_email_rounded), labelText: "email")),
                          ),
                          SizedBox(
                            height: screenSize.height * 0.02,
                          ),
                          Obx(
                                () => TextFormField(
                              autovalidateMode: AutovalidateMode.disabled,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              onChanged: (value) =>
                                  userLoginController.validate(value),
                              controller:
                              userLoginController.passwordController.value,
                              decoration:
                              InputDecoration(suffixIcon: Icon(Icons.lock), labelText: "password"),
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.02,),
                          Obx(
                                () => TextFormField(
                              autovalidateMode: AutovalidateMode.disabled,
                              obscureText: false,
                              enableSuggestions: false,
                              autocorrect: false,
                              onChanged: (value) =>
                                  userLoginController.validate(value),
                              controller:
                              userLoginController.roleController.value,
                              decoration:
                              InputDecoration(suffixIcon: Icon(Icons.manage_accounts), labelText: "your role"),
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.01,),
                          RichText(text: TextSpan(
                              children: [
                                TextSpan(text: "Forgot Password?", style: TextStyle(color: ChainColor.greyText1, fontFamily: 'Futura')),
                                TextSpan( text: " Click Here", style: TextStyle(color: ChainColor.blueLink1, fontFamily: 'Futura'))
                              ]),
                          ),
                          Obx(() {
                            if (userLoginController.error.value.isNotEmpty) {
                              return Container(
                                child: Column(
                                  children: [
                                    SizedBox(height: screenSize.height * 0.01,),
                                    Text(userLoginController.error.value, style: ChainTypography.error,)
                                  ],
                                ),
                              );
                            }
                            return SizedBox();
                          }),
                          SizedBox(height: screenSize.height * 0.01,),
                          Obx(() => ElevatedButton(
                              onPressed: userLoginController.isValid.value ? userLoginController.signInPressed : null,
                              style: ElevatedButton.styleFrom(textStyle: Theme.of(context).textTheme.headline5, padding: EdgeInsets.all(13)),
                              child: const SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    "Sign In",
                                    textAlign: TextAlign.center,
                                  ))),
                          ),
                          SizedBox(
                            height: screenSize.height * 0.03,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     SizedBox(
                          //         width: screenSize.width * 0.2,
                          //         child: Divider(
                          //           height: 20,
                          //           thickness: 2,
                          //         )),
                          //     Text(
                          //       "Or Sign In With",
                          //       style: TextStyle(),
                          //       textAlign: TextAlign.left,
                          //     ),
                          //     SizedBox(
                          //         width: screenSize.width * 0.2,
                          //         child: Divider(
                          //           height: 20,
                          //           thickness: 2,
                          //         ))
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: screenSize.height * 0.03,
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: screenSize.width * 0.05),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       SocialBox(
                          //           screenSize: screenSize,
                          //           imagePath: "assets/images/google_login.png"),
                          //       SocialBox(
                          //           screenSize: screenSize,
                          //           imagePath:
                          //           "assets/images/facebook_login.png"),
                          //       SocialBox(
                          //           screenSize: screenSize,
                          //           imagePath: "assets/images/apple_login.png"),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  testValid() {
    debugPrint("test of change");
  }
}
