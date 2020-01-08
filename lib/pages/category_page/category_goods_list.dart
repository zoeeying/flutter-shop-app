import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmp/provide/category_goods_list.dart';
import 'package:provide/provide.dart';

// 商品列表，可以上拉加载更多
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(builder: (context, child, data) {
      return Container(
        width: ScreenUtil().setWidth(570),
        height: ScreenUtil().setHeight(1000),
        child: ListView.builder(
          itemCount: data.categoryGoodsList.length,
          itemBuilder: (context, index) {
            return _goodsListItem(data.categoryGoodsList, index);
          },
        ), // 动态的构造方法的ListView
      );
    });
  }

  Widget _goodsImage(List goodsList, int index) {
    return Container(
      child: Image.network(goodsList[index].image),
      width: ScreenUtil().setWidth(200),
    );
  }

  Widget _goodsName(List goodsList, int index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        goodsList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsPrice(List goodsList, int index) {
    return Container(
      width: ScreenUtil().setWidth(370),
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        children: <Widget>[
          Text(
            '价格：￥${goodsList[index].presentPrice}',
            style: TextStyle(
              color: Colors.pink,
              fontSize: ScreenUtil().setSp(28),
            ),
          ),
          Text(
            '￥${goodsList[index].oriPrice}',
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }

  Widget _goodsListItem(List goodsList, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: Colors.black12,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(goodsList, index),
            Column(
              children: <Widget>[
                _goodsName(goodsList, index),
                _goodsPrice(goodsList, index),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
