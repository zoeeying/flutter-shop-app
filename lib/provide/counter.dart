import 'package:flutter/material.dart';

// 建立一个类Counter，混入ChangeNotifier
// 意思就是不用管理听众
// 这个类似于创建一个State，但是为了跟State区分，我们叫创建Provide
class Counter with ChangeNotifier {
  int value = 0;
  increment() {
    value++;
    // 通知听众，value改变了，可以局部刷新Widget
    notifyListeners();
  }
}
