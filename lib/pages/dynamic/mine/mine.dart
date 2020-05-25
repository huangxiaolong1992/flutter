/*
* 我的
 */

import 'package:flutter/material.dart';

import 'package:provide/provide.dart';
import '../../../provide/userInfo.dart';

class Mine extends StatefulWidget{
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<Mine>{

  @override
  Widget build(BuildContext context){
    return Provide<UserInfoProvide>(
      builder: (context, child , userInfoProvide) {
        return Scaffold(       
          appBar: AppBar(
            title: Text('关于我'),
          ),
          body: Container(
            height: 60.0,
            child:  ConstrainedBox(
              child: AboutMe(userInfoProvide),
              constraints: new BoxConstraints.expand(),   
            ),
          )
        );
      }
    );
  }


  Widget AboutMe(userInfoProvide){
    return Container(
      height: 100.0,
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(  
              padding: const EdgeInsets.only(top: 20.0, bottom: 15.0),
              child:Text(
                "${userInfoProvide.userData['data']['username']}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0
                ),
              )
            )
          )
        ],
      ),
    );
  }
}