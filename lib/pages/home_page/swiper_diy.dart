import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


// 首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList; // 用来接收参数
  // 无名无参的参数的父类
  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);
  // SwiperDiy({this.swiperDataList}); // 简写

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      child: Swiper(
        // 构造器
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            '${swiperDataList[index]['image']}',
            fit: BoxFit.fill, // 满容器填充
          );
        },
        itemCount: swiperDataList.length, // 图片张数
        pagination: SwiperPagination(), // 轮播图下面的小圆点导航器
        autoplay: true, // 自动播放
      ),
    );
  }
}