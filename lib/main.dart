import 'package:dy/pages/dynamic/login/login.dart';
import 'package:flutter/material.dart';
import './pages/dynamic/app.dart';
import './pages/loading/loading.dart';
import './pages/dynamic/report/report.dart';
import './pages/dynamic/mine/mine.dart';
import './pages/dynamic/register/register.dart';
import 'dart:ui';
import 'package:provide/provide.dart';
import './provide/userInfo.dart';

void main(){
  //main函数里面引用provide
  var userInfoProvide = UserInfoProvide();
  var providers = Providers();

  providers
    ..provide(Provider<UserInfoProvide>.value(userInfoProvide));

  runApp(
    ProviderNode(
      child: MyApp(),
      providers: providers
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '动态',
      debugShowCheckedModeBanner: false,
  
      routes: <String, WidgetBuilder> {
        '/app':      (BuildContext content) => new App(),
        '/report':   (BuildContext content) => new Report(),
        '/mine':     (BuildContext content) => new Mine(),
        '/login':    (BuildContext content) => new Login(),
        '/register': (BuildContext content) => new Register()
      },
      home: new Scaffold(
        appBar: PreferredSize(
          preferredSize:Size.fromHeight(MediaQueryData.fromWindow(window).padding.top),
          child:SafeArea(
            top: true,
            child: Offstage()
          )
        ),
        
        body: Loading()
      )
    );
  }
}