import 'package:flutter/material.dart';
import 'dart:convert';

class UserInfoProvide with ChangeNotifier{
  var userData;
  
  userInfo(obj){
    userData = obj;   
    notifyListeners();
  }
}