import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';

import './home_page/swiper_diy.dart'; // 轮播图
import './home_page/top_navigator.dart'; // 导航
import './home_page/ad_banner.dart'; // banner图片
import './home_page/leader_phone.dart'; // 拨打店长电话模块
import './home_page/recommend.dart'; // 商品推荐模块
import './home_page/floor_title.dart'; // 楼层标题
import './home_page/floor_content.dart'; // 楼层商品

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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
            String adPicture =
                data['data']['advertesPicture']['PICTURE_ADDRESS'];

            // 店长图片和店长电话
            String leaderImage = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];

            // 商品推荐列表
            List<Map> recommendList =
                (data['data']['recommend'] as List).cast(); // 强制转换List

            // 楼层商品
            String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
            String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
            String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
            List<Map> floor1 = (data['data']['floor1'] as List).cast();
            List<Map> floor2 = (data['data']['floor2'] as List).cast();
            List<Map> floor3 = (data['data']['floor3'] as List).cast();

            // 外边包一层SingleChildScrollView
            // 可以防止内容在一屏显示不下越界而出现黄条异常提示
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SwiperDiy(swiperDataList: swiper),
                  TopNavigator(navigatorList: navigatorList),
                  AdBanner(adPicture: adPicture),
                  LeaderPhone(
                    leaderImage: leaderImage,
                    leaderPhone: leaderPhone,
                  ),
                  Recommend(recommendList: recommendList),
                  FloorTitle(pictureAddress: floor1Title),
                  FloorContent(floorGoodsList: floor1),
                  FloorTitle(pictureAddress: floor2Title),
                  FloorContent(floorGoodsList: floor2),
                  FloorTitle(pictureAddress: floor3Title),
                  FloorContent(floorGoodsList: floor3),
                ],
              ),
            );
          } else {
            return Center(child: Text('加载中...'));
          }
        },
      ),
    );
  }
}
