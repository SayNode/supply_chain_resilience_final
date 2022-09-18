import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get.dart';
import 'package:supply_chain/page/choose_location/choose_location.dart';
import 'package:supply_chain/page/login/login.dart';
import 'package:supply_chain/service/auth_service.dart';
import 'package:supply_chain/service/balance_service.dart';
import 'package:supply_chain/service/category_service.dart';
import 'package:supply_chain/service/issue_service.dart';
import 'package:supply_chain/service/order_service.dart';
import 'package:supply_chain/service/secure_storage_service.dart';
import 'package:supply_chain/theme/theme.dart';

import 'page/home/home.dart';

void main() {
  initServices();
  runApp(const Chain());
}

class Chain extends StatelessWidget {
  const Chain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chain',
      theme: ChainTheme().themeData,
      home: Login(),
    );
  }
}

void initServices() async {
  debugPrint('starting services ...');
  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.

  SecureStorageService secureStorageService = Get.put(SecureStorageService());
  AuthService authService = Get.put(AuthService());
  CategoryService categoryService = Get.put(CategoryService());
  OrderService orderService = Get.put(OrderService());
  BalanceService balanceService = Get.put(BalanceService());
  IssueService issueService = Get.put(IssueService());
  await secureStorageService.init();
  await authService.init();
  await categoryService.init();
  await orderService.init();
  await balanceService.init();
  await issueService.init();
  debugPrint('All services started...');
}
