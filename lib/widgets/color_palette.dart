import 'package:flutter/material.dart';

class ColorPalette extends StatelessWidget {

  final List<Color> _colors;
  final Function _onColorItemPressed;

  ColorPalette(this._colors, this._onColorItemPressed);

  _buildColorItems() {
    return List.generate(this._colors.length, (index) => GestureDetector(
      onTap: () => this._onColorItemPressed(this._colors[index]),
      child: Container(
        color: this._colors[index],
        width: 40.0,
        height: 40.0,
      ),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildColorItems(),
    );
  }
}

