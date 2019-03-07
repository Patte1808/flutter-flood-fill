import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final Color color;

  GridItem(this.color);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 800),
      color: this.color,
      height: 25.0,
      width: 25.0,
    );
  }
}