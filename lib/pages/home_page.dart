import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';

import './widgets/home/swiper_diy.dart'; // 轮播图
import './widgets/home/top_navigator.dart'; // 导航
import './widgets/home/ad_banner.dart'; // banner图片
import './widgets/home/leader_phone.dart'; // 拨打店长电话模块

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
            // 轮播图数据
            List<Map> swiper = (data['data']['slides'] as List).cast();
            // 导航数据
            List<Map> navigatorList = (data['data']['category'] as List).cast();
            // banner图片地址
            String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];

            // 店长图片和店长电话
            String leaderImage = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];


            return Column(
              children: <Widget>[
                SwiperDiy(swiperDataList: swiper),
                TopNavigator(navigatorList: navigatorList),
                AdBanner(adPicture: adPicture),
                LeaderPhone(leaderImage: leaderImage, leaderPhone: leaderPhone),
              ],
            );
          } else {
            return Center(child: Text('加载中...'));
          }
        },
      ),
    );
  }
}
