import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///Hex color
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

///Common AppBar
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
///Flutter Toast
class ToastAlert {
  void toastfun(String ss) {
    Fluttertoast.showToast(
        msg: ss,
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
        backgroundColor: Colors.black,
        gravity: ToastGravity.BOTTOM);
  }
}