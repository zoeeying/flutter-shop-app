// 左侧大类导航
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'dart:convert';
import '../../service/service_method.dart';
import '../../model/category.dart';
import '../../model/categoryGoodsList.dart';
import '../../provide/child_category.dart';
import '../../provide/category_goods_list.dart';

class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  int listIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCategory();
    _getGoodsList();
  }

  // 获取大类
  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      // 需要设一下provide中的状态，不然白酒大类下面的小类默认不显示
      // 把provide中的状态设置为初始的第一个大类下面的小类
      // 这里跟React不太一样，setState设置过list后，可以直接用
      Provide.value<ChildCategory>(context)
          .getChildCategory(list[0].bxMallSubDto);
    });
  }

  // 获取不同大类下面的商品
  // 可选参数categoryId
  void _getGoodsList({String categoryId}) async {
    var postData = {
      // 传递给后台的参数可以做个判断，弄一个默认值，确保不会传递过去null
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': '', // 不能传null
      'page': 1,
    };
    await request('getMallGoods', data: postData).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      // 使用状态管理来管理goodsList
      Provide.value<CategoryGoodsListProvide>(context)
          .getGoodsList(goodsList.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setHeight(180),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: ListView.builder(
        itemCount: list.length,
        // 构造器
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
      ),
    );
  }

  Widget _leftInkWell(index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
        _getGoodsList(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20), // 设置某个方向的padding
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12),
          ),
        ),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
}
