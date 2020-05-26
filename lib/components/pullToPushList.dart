import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provide/provide.dart';
import '../provide/userInfo.dart';
import '../pages/dynamic/login/login.dart';
import '../http/http.dart';
import '../utils/globla.dart';

class PullToPushList extends StatefulWidget {
  @override
  _PullToPushListState createState() => _PullToPushListState();
}


class _PullToPushListState extends State<PullToPushList> {
  List lists = new List();
  var  userName , token;
  int pageNum = 1;
  
  ScrollController _scrollController = new ScrollController();

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void _onRefresh() async{

	setState(() {
    pageNum = 1;

	  _getListDate();

	});
    
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
   
    if(mounted)
    setState(() {
     
    });
     
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<UserInfoProvide>(
      builder: (context, child , userInfoProvide) {
        return Scaffold(
          body: userInfoProvide.userData  == null ? _toLogin() : _renderData(userInfoProvide.userData['data']['username'], userInfoProvide.userData['data']['token'])
        );
      }
    );
  }
  
  
  Widget _toLogin(){
    return Container(
      alignment: Alignment.center,
      child: RaisedButton(
        child: Text("登录"),
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => Login())
          );
        },
      )
    );
  }

  _getListDate()  {

    getHttp(
      "/api/dynamic/getDynamicList?usrname=$userName&index=$pageNum",
      token
    )
      .then((response){
        if(pageNum == 1){
          setState(() {  
            lists.clear();
            lists.addAll(response['result']);
          });
        }else{
          setState(() {  
            lists.addAll(response['result']);
          });
        } 
      }
    );
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    
    Future.delayed(Duration(milliseconds: 0), () async {
      if(userName != null){
        this._getListDate();
      }     
    });

    _scrollController.addListener(() {
      /// 滑动到底部，加载更多
      if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
        pageNum = pageNum + 1;
        _getListDate();
      }
    });
  }
  
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _renderData(String username, String token){
    this.userName = username;
    this.token = token;

    if(lists.length != 0){
      return  SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder:  (BuildContext context, int index) {
            return Column(
              children: <Widget>[  
              
                Container(
                  padding: const EdgeInsets.only(left: 30.0, top: 10.0, bottom: 10.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromRGBO(241, 241, 241, 1),
                        width: 5.0,
                        style: BorderStyle.solid
                      )
                    )
                  ),
                  child: GestureDetector(
                    
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            
                            _avatar('${lists[index]['username']}'),
                            
                            Container(
                              padding: const EdgeInsets.only(left: 10.0),
                        
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                    child: Text('${lists[index]['username']}')
                                  ),
                                  Container(
                                    child: Text(
                                      '${G.changeDate(lists[index]['time'])}',
                                      
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black38
                                      ),
                                    )
                                  )
                                ],
                              )
                            )
                          ], 
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                          child: Text(
                            '${lists[index]['dynamicContent']}',
                          ),
                        ),   
                        
                        Row(
                          children:  getPic(lists[index]['dynamicPic'])
                        )                                               
                      ],
                    ),
                  )
                )
              ],
            );
          } ,
          itemCount: lists.length,
        ),
      );
    }
  }
}




//组装发表的图片
getPic(List picArr){
  
  return picArr.map((v){
    return Image.network(
      v,
      width: 80,
      height: 80
    );
  }).toList();   
}

//头像为userName 的最后一个字符串
Widget _avatar(String username){
  return Container(
    height: 30.0,
    width: 30.0,
    alignment: Alignment.center,

    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(30.0),
    ),
  
    child: Text(
      username.substring(username.length - 1),
      style: TextStyle(
        color: Colors.white
      ),
    ),
  );
}
