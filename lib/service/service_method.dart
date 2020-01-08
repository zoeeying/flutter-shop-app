import 'package:dio/dio.dart';
import 'dart:async';
import '../config/service_url.dart';

Future request(url, {data}) async {
  try {
    //print('开始获取数据...............');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = Headers.formUrlEncodedContentType;
    if (data == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: data);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:======>$e');
  }
}
