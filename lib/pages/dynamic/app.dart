
import 'package:dy/pages/dynamic/mine/mine.dart';
import 'package:dy/pages/dynamic/report/report.dart';
import 'package:flutter/material.dart';
import '../../components/pullToPushList.dart';
import 'package:provide/provide.dart';
import '../../provide/userInfo.dart';

class App extends StatefulWidget {
 @override
  _App createState() => _App();
}

class _App extends State<App>{
   @override
  Widget build(BuildContext context) {
    return Provide<UserInfoProvide>(
      builder: (context, child , userInfoProvide) {
        return  MaterialApp(
          home: DefaultTabController(
            length: choices.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text("动态"),
                actions: <Widget>[

                  _loginIcon(userInfoProvide.userData, context),

                  _mineIcon(userInfoProvide.userData, context),

                  _report(userInfoProvide.userData, context)
                ],
                  
                bottom: TabBar(
                  isScrollable: true,
                  tabs: choices.map((Choice choice) {
                    return Tab(
                      text: choice.title
                    );
                  }).toList(),
                ),
              ),
              body: TabBarView(
                children: choices.map((Choice choice){
                  return Container(
                    alignment: Alignment.center,
                    child: PullToPushList(),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      }
    );
  }
}

//我的按钮显示与隐藏
Widget _mineIcon(data, context){
  if(data != null){
    return IconButton(
      icon: Icon(
        Icons.person,
        color: Colors.white,
        size: 26.0,
      ),
      onPressed: (){
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => Mine(

          ))
        );
      },
    );
  }else{
    return Text('');
  }
}
//发表按钮显示隐藏
Widget _report(data, context){
  if(data != null){
    return IconButton(
      icon: Icon(Icons.add_circle),
      tooltip: "Alarm",
      onPressed: () {
        
        // Navigator.of(context).pushNamed(
        //   '/report'
        // );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Report())
        );
      },
    );
  }else{
    return Text('');
  }
}

//登录按钮显示隐藏
Widget _loginIcon(data, context){
  if(data != null){
    return Text('');
  }else{
    return  
      (IconButton(
        icon: Icon(
          Icons.person,
          color: Colors.white,
          size: 26.0,
        ),
        onPressed: (){
          Navigator.of(context).pushNamed(
            '/login'
          );
        },
      )
    );
  }
}

class Choice {
  final String title;
  const Choice({this.title});
}

const List<Choice> choices = const <Choice>[
  const Choice(title: '全体'),
  // const Choice(title: '精华'),
  // const Choice(title: '收藏'),
  // const Choice(title: '我的')
];

class ChoiceCardWidget extends StatelessWidget {
  final Choice choice;
  ChoiceCardWidget({Key key,this.choice}) : super(key : key);

  @override
  Widget build(BuildContext context) {
  // TODO: implement build
   
    return Padding(
      padding: EdgeInsets.all(1.0),
      child: Card(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            
              Text(choice.title,style: TextStyle(fontSize: 50.0))
            ],
          ),
        ),
      ),
    );         
  }
}