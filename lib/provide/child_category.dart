import 'package:flutter/material.dart';
import '../model/category.dart'; // 里面的子类BxMallSubDto，作为泛型


class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  // 改变childCategoryList的方法
  getChildCategory(List<BxMallSubDto> list){
    BxMallSubDto all = BxMallSubDto();
    all.mallCategoryId = '00';
    all.mallSubId = '00';
    all.mallSubName = '全部';
    all.comments = 'null'; 
    childCategoryList = [all];
    // 需要在上面的List类型后面加上泛型<BxMallSubDto>，然后addAll里面才能直接放list
    childCategoryList.addAll(list); 
    // 监听改变
    notifyListeners();
  }
  
}
