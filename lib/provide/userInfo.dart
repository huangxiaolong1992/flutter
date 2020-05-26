import 'package:flutter/material.dart';

class UserInfoProvide with ChangeNotifier{
  var userData;
  
  userInfo(obj){
    userData = obj;   
    notifyListeners();
  }
}