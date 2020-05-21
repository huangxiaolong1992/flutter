/*
* 我的
 */

import 'package:flutter/material.dart';
import '../../../components/pullToPushList.dart';

class Mine extends StatefulWidget{
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<Mine>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
      ),
      body: Column(
        children: <Widget>[
          AboutMe(),
          Expanded(
            child: PullToPushList()
          )
        ],
      ),
    );
  }


  Widget AboutMe(){
    return Container(
      height: 120.0,
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          Padding(  
            padding: const EdgeInsets.only(top: 20.0, bottom: 15.0),
            child:Text(
              "黄孝龙",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0
              ),
            )
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text("1",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    Text("动态",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                  ],
                ),
              ),
              
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text("1",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    Text("粉丝",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                  ],
                ),
              ),
              
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text("1",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    Text("关注",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}