import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

// 获取首页主体内容
Future getHomePageContent() async {
  try {
    Response response;
    Dio dio = new Dio();
    // 如果上面不引入dart:io，ContentType是不可以用的
    dio.options.contentType = Headers.formUrlEncodedContentType;
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    response = await dio.post(servicePath['homePageContext'], data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('首页主体内容获取失败！');
    }
  } catch (e) {
    return print('ERROR：===================$e');
  }
}
