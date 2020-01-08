import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import './pages/index_page.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';

// 顶层依赖
void main() {
  var counter = Counter();
  var childCategory = ChildCategory();
  var categoryGoodsList = CategoryGoodsListProvide();
  var providers = Providers();
  // 注册依赖，两个点表示再返回providers，<Counter>是泛型
  // 多个状态可以在后面再..provide
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsList));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '小畅叙+',
        debugShowCheckedModeBanner: false, // 去除右上角的debug图标
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}
