import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:supply_chain/model/secure_storage_content.dart';
import 'package:supply_chain/service/secure_storage_service.dart';
import 'package:supply_chain/state/user_state_controller.dart';
import '../model/category.dart';
import '../model/user.dart';
import '../page/choose_location/choose_location.dart';
import '../page/home/home.dart';
import '../utils/constants.dart';


/// needs the secure storage service to be initialized
class CategoryService extends GetxService {

  SecureStorageService secureStorageService = Get.find<SecureStorageService>();
  List<Category> categoryList = [];

  Future<CategoryService> init() async {
    debugPrint('CategoryService - initializing ...');
    categoryList = await getCategoryList();
    debugPrint('CategoryService - done.');
    return this;
  }

  Future<List<Category>> getCategoryList() async{
    var url = Uri.http(ChainConstants.domain, 'api/category/');
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: "Bearer " + secureStorageService.storedContent.accessToken});
    List<dynamic> categoryListMap = jsonDecode(response.body);
    List<Category> categoryList = [];
    for (int i = 0; i < categoryListMap.length; i++) {
      categoryList.add(Category.fromJson(categoryListMap[i]));
    }
    return categoryList;
  }

}