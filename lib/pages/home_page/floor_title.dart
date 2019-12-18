import 'package:flutter/material.dart';

// 楼层标题
class FloorTitle extends StatelessWidget {
  final String pictureAddress;
  const FloorTitle({Key key, this.pictureAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(pictureAddress),
    );
  }
}
