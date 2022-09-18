import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:supply_chain/model/secure_storage_content.dart';
import 'package:supply_chain/service/secure_storage_service.dart';
import 'package:supply_chain/state/user_state_controller.dart';
import '../model/order.dart';
import '../model/user.dart';
import '../page/choose_location/choose_location.dart';
import '../page/home/home.dart';
import '../utils/constants.dart';


/// needs the secure storage service to be initialized
class OrderService extends GetxService {

  SecureStorageService secureStorageService = Get.find<SecureStorageService>();
  List<Order> orderList = [];

  Future<OrderService> init() async {
    debugPrint('OrderService - initializing ...');

    orderList = await getOrderList();
    debugPrint('OrderService - done.');
    return this;
  }

  Future<List<Order>> getOrderList() async{
    final input = await rootBundle.loadString('assets/data/migros_data.csv');
    List<List<dynamic>> data = await CsvToListConverter().convert(input);

    List<Order> orderList = [];
    for (int i = 1; i < data.length; i++) {
      orderList.add(Order.fromString(data[i][0]));
    }
    return orderList;
  }

}