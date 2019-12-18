import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 商品推荐类
class Recommend extends StatelessWidget {
  final List recommendList;
  Recommend({Key key, this.recommendList}) : super(key: key);

  // 标题方法
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft, // 上下居中，靠左对其
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 1.0),
        ),
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  // 单个商品方法
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white, // 因为整个应用背景设为了浅灰色，所以容器都需要设置白色背景
          border: Border(
            left: BorderSide(color: Colors.black12, width: 1.0),
          ),
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough, // 删除线
                color: Colors.grey,
                fontSize: ScreenUtil().setSp(26),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 横向列表方法
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(360),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList(),
        ],
      ),
    );
  }
}
