void main() {
  List growableList = List.from([1, 2, 3, 4, 5]);
  // 返回列表的字符串表示
  String string = growableList.toString();
  print((string as List).cast());
  // 返回列表的集合表示
  // print(growableList.toSet());
  // // 返回字符串的列表表示
  // print(growableList.toList());
  // // 用指定字符连接列表元素
  // print(growableList.join(','));
}
