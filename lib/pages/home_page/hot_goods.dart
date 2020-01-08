import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HotGoods extends StatelessWidget {
  final List<Map> hotGoodsList; // 热销商品数据
  HotGoods({Key key, this.hotGoodsList}) : super(key: key);

  Widget _hotTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      alignment: Alignment.center, // 居中对齐
      color: Colors.transparent, // 透明颜色
      padding: EdgeInsets.all(5.0),
      child: Text('火爆专区'),
    );
  }

  Widget _wrapHotGoodsList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
          onTap: () {},
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(val['image'], width: ScreenUtil().setWidth(370)),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: ScreenUtil().setSp(26),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${val['mallPrice']}'),
                    Text(
                      '￥${val['price']}',
                      style: TextStyle(
                        color: Colors.black26,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _hotTitle(),
          _wrapHotGoodsList(),
        ],
      ),
    );
  }
}
