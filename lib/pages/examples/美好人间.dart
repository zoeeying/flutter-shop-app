import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 文本框的控制器中需要使用
  TextEditingController typeController = TextEditingController();
  String showText = '欢迎您来到美好人间高级会所';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('美好人间'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                TextField(
                  // 只有设置了控制器才能得到文本框的值，需要先声明一下
                  controller: typeController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    labelText: '美女类型',
                    helperText: '请输入你喜欢的类型',
                  ),
                  // 一定要置为false，不然可能会自动打开手机输入键盘
                  autofocus: false,
                ),
                RaisedButton(
                  onPressed: _choiceAction,
                  child: Text('选择完毕'),
                ),
                Text(
                  showText,
                  // 单独用Text，外边没有Container等组件的时候，需要给Text加上一些限制
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _choiceAction() {
    print('开始选择喜欢的类型');
    if (typeController.text.toString() == '') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text('美女类型不能为空！')),
      );
    } else {
      getHttp(typeController.text.toString()).then((val) {
        setState(() {
          showText = val['data']['name'].toString();
        });
      });
    }
  }

  Future getHttp(String typeText) async {
    try {
      Response response;
      var data = {'name': typeText};
      response = await Dio().get(
        'https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian',
        queryParameters: data,
      );
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
