import 'package:flutter/material.dart';
import '../model/categoryGoodsList.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryGoodsListData> categoryGoodsList = [];
  // 点击大类时更换商品列表
  getGoodsList(List<CategoryGoodsListData> list) {
    categoryGoodsList = list;
    notifyListeners();
  }
}
