import 'package:flutter/material.dart';
import 'dart:convert';
import '../service/service_method.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';

import './home_page/swiper_diy.dart'; // 轮播图
import './home_page/top_navigator.dart'; // 导航
import './home_page/ad_banner.dart'; // banner图片
import './home_page/leader_phone.dart'; // 拨打店长电话模块
import './home_page/recommend.dart'; // 商品推荐模块
import './home_page/floor_title.dart'; // 楼层标题
import './home_page/floor_content.dart'; // 楼层商品
import './home_page/hot_goods.dart'; // 火爆专区商品

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String homePageContent = '正在获取数据';

  int page = 1; // 火爆专区页码
  List<Map> hotGoodsList = []; // 火爆专区商品

  @override
  Widget build(BuildContext context) {
    var positionInfo = {'lon': '115.02932', 'lat': '35.76189'};
    return Scaffold(
      appBar: AppBar(title: Text('小畅叙的APP')),
      // FutureBuilder可以解决异步请求数据然后渲染组件，而且不需要setState
      body: FutureBuilder(
        future: request('homePageContent', data: positionInfo),
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

            return EasyRefresh(
              header: MaterialHeader(),
              footer: MaterialFooter(),
              child: ListView(
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
                  HotGoods(hotGoodsList: hotGoodsList),
                ],
              ),
              onLoad: () async {
                print('开始加载更多......');
                var requestData = {'page': page};
                await request('homePageBelowConten', data: requestData)
                    .then((val) {
                  var data = json.decode(val.toString());
                  List<Map> newGoodsList = (data['data'] as List).cast();
                  setState(() {
                    hotGoodsList.addAll(newGoodsList);
                    page++;
                  });
                });
              },
            );
          } else {
            return Center(child: Text('加载中...'));
          }
        },
      ),
    );
  }
}
