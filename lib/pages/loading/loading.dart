import 'package:flutter/material.dart';
import 'dart:async';

class Loading extends StatefulWidget{
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading>{
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 2000), () {
      Navigator.of(context).pushReplacementNamed(
        '/app'
      );
    });
  }


  @override
  Widget build(BuildContext context){
    return ConstrainedBox(
      child: Image.asset(
        'images/loading.jpg',
        fit: BoxFit.cover
      ),
      constraints: new BoxConstraints.expand(),
    );
  }
}