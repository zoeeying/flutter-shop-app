import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './config/httpHeaders.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String showText = '还没有请求数据';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('请求远程数据'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: _jike,
                child: Text('请求数据'),
              ),
              Text(showText),
            ],
          ),
        ),
      ),
    );
  }

  void _jike(){
    print('开始调用数据');
    getHttp().then((val){
      showText = val['data'].toString();
    });
  }

  Future getHttp() async {
    try {
      Response response;
      Dio dio = new Dio();
      // 设置请求头
      dio.options.headers = httpHeaders;
      response =
          await dio.get('https://time.geekbang.org/serv/v2/explore/list');
      print(response);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
