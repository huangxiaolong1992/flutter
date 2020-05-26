import 'package:flutter/material.dart';
import './pages/dynamic/app.dart';
import './pages/loading/loading.dart';
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
        '/app': (BuildContext content) => new App()
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