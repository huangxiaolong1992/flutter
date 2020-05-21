 
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class G{
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  //toast
  static void toast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }

  static NavigatorState getCurrentState() => navigatorKey.currentState;

  /// 跳转页面使用 G.pushNamed
  static void pushNamed(String routeName, {Object arguments}){
    getCurrentState().pushNamed(routeName, arguments: arguments);
  }
}
 