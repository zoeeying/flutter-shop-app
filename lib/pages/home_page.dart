import 'package:flutter/material.dart';
import 'service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '正在获取数据';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+')),
      // FutureBuilder可以解决异步请求数据然后渲染组件，而且不需要setState
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            // List里面是Map
            List<Map> swiper = (data['data']['slides'] as List).cast();
            return Column(
              children: <Widget>[SwiperDiy(swiperDataList: swiper)],
            );
          } else {
            return Center(child: Text('加载中...'));
          }
        },
      ),
    );
  }
}

// 首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList; // 用来接收参数
  // 无名无参的参数的父类
  // SwiperDiy({Key key, this.swiperDataList}) : super(key: key);
  SwiperDiy({this.swiperDataList});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

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
        pagination: SwiperPagination(), // 轮播图下面的导航器
        autoplay: true, // 自动播放
      ),
    );
  }
}
