import 'package:flutter/material.dart';
import 'dart:ui';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

PreferredSizeWidget appBarCommon({required context}){
  return AppBar(
      leading:IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
        ),
        onPressed: (){
          Navigator.pop(context);
        },
      ));
}