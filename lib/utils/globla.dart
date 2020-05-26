import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class G{
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  //toast
  static void toast(String text) {
    Fluttertoast.showToast(
      msg: text,
      gravity: ToastGravity.CENTER
    );
  }

  //时间戳转成时间
  static  changeDate(String timeStamp){ 
    var time = new DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp));
    return time;
  } 
}
 