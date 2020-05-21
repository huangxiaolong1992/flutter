import 'package:flutter/material.dart';
import 'dart:convert';

class UserInfoProvide with ChangeNotifier{
  var userData;
  
  userInfo(obj){
    final responseJson = json.decode(obj.toString());
    Map<String, dynamic> newData = responseJson ;
    userData = newData;
    
    notifyListeners();
  }
}