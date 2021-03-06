import 'package:dy/pages/dynamic/app.dart';
import 'package:dy/pages/dynamic/register/register.dart';
import 'package:flutter/material.dart';
import '../../../http/http.dart';
import 'dart:convert';
import 'package:provide/provide.dart';
import '../../../provide/userInfo.dart';
import '../../../utils/globla.dart';


class Login extends StatefulWidget{
  final String userName;
  final String password;

  Login({
    Key key,
    this.userName,
    this.password
  }) : super(key: key); 
  
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  //用户名控制器
  TextEditingController _unameController = TextEditingController();

    //密码控制器
  TextEditingController _passwordController = TextEditingController();
  
 @override
  Widget build(BuildContext context){
    // _unameController.text = widget.userName;
    // _passwordController.text = widget.password;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child:  Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  '欢迎登录',
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
                )
              ),
              TextField(
                controller:  _passwordController,
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  prefixIcon: Icon(Icons.lock)
                ),
                obscureText: true,
              ),

              
              GestureDetector(
                child: Container(
                  margin: const EdgeInsets.only(top: 10.0, left: 10.0),
                  alignment: Alignment.topLeft,
                  child: Text(
                    '注册',
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context)=>new Register())
                  );
                },             
              ),

              Container(
                margin: const EdgeInsets.all(30.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 40.0,
                  child: RaisedButton(
                    color: Colors.blue,
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    child: Text("登录",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0
                      ),
                    ),
                    onPressed: () {
                      _loginFun();
                    },
                  )
                )
              ),
            ],
          ),
        )
      )
    );
  }

   /*
   * 登录
  */
  void _loginFun() {
    String _userName = _unameController.text;
    String _password = _passwordController.text;
  
    if(_userName.length == 0 || _password.length == 0){
      G.toast('账号和密码不能为空');
    }else{
      FocusScope.of(context).unfocus();

      var data = {
        'username': _userName, 
        'password': _password
      };

      postHttp("/api/users/login",data, null)
        .then((response){
          if(response['code'] == 304){
            G.toast('账号已被注册');
          
          }else 
            if(response['code'] == 200){
              
              G.toast('登录成功');
              Provide.value<UserInfoProvide>(context).userInfo(response);

              Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context)=>new App()),
                (route)=>route==null
              );

          }else {
            if(response['code'] == 401 && response['msg'] == '密码错误'){
          
              G.toast('密码错误');
            }else{
          
              G.toast('用户不存在');
            }
          }
      });
    }
  }
}