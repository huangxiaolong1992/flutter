
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../http/http.dart';
import 'dart:convert';
import "../login/login.dart";


class Register extends StatefulWidget{
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>{
  //用户名控制器
  TextEditingController _unameController = TextEditingController();

  //密码控制器
  TextEditingController _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('注册'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child:Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                '欢迎注册',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black54
                ),
              ),
            ),

            TextField(
              autofocus: true,
              controller: _unameController,
              decoration: InputDecoration(
                labelText: "用户名",
                hintText: "您的登录账号",
                prefixIcon: Icon(Icons.person)
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  prefixIcon: Icon(Icons.lock)
              ),
              obscureText: true,
            ),

            Container(
              margin: const EdgeInsets.all(30.0),
              child: SizedBox(
                width: double.infinity,
                height: 40.0,
                child: RaisedButton(
                  color: Colors.blue,
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  child: Text("注册",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0
                    ),
                  ),
                  onPressed: () {
                    _registerFun();
                  },
                )
              )
            ),
          ],
        ),
      )
    );
  }
  
  /*
   * 注册
  */
  void _registerFun() {
    String _userName = _unameController.text;
    String _password = _passwordController.text;
  
    if(_userName.length == 0 || _password.length == 0){
      Fluttertoast.showToast(
        msg: "账号和密码不能为空",
        gravity: ToastGravity.CENTER         
      );
    }else{
      FocusScope.of(context).unfocus();

      var data = {
        'username': _userName, 
        'password': _password
      };

      postHttp("/api/users/register",data)
        .then((response){
          final responseJson = json.decode(response.toString());
          Map<String, dynamic> newData = responseJson ;

          if(newData['code'] == 304){
            Fluttertoast.showToast(
              msg: "账号已被注册",
              gravity: ToastGravity.CENTER         
            );
          }else if(newData['code'] == 200){
            Fluttertoast.showToast(
              msg: "注册成功",
              gravity: ToastGravity.CENTER         
            );

            Navigator.push(context,
              MaterialPageRoute(builder: (context) => Login(
                userName: _userName,
                password: _password    
              ))
            );
          }
      });
    }
  }
}