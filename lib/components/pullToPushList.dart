import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../pages/dynamic/mine/mine.dart';
import 'package:provide/provide.dart';
import '../provide/userInfo.dart';
import '../pages/dynamic/login/login.dart';
import '../http/http.dart';

class PullToPushList extends StatefulWidget {
  @override
  _PullToPushListState createState() => _PullToPushListState();
}


class _PullToPushListState extends State<PullToPushList> {
  var lists;
  var  userName , token;

  
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void _onRefresh() async{
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
  

  //获取动态
  
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

  _getListDate(context, String username, String token) {
    getHttp(
      "/api/dynamic/getDynamicList?usrname=$username",
      token
    )
      .then((response){
        setState(() {
          lists = response;
          
          print(lists);
        });
      }
    );
  }

  void deactivate() {
    super.deactivate();

    this._getListDate(context, userName, token);
  }

  Widget _renderData(String username, String token){
    this.userName = username;
    this.token = token;
    print(1);
    print(this.lists);
    return  SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
        itemBuilder:  (BuildContext context, int position) {
          return Column(
            children: <Widget>[  
              Text('${this.lists}'),    
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
                  onTap: (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Mine())
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                        
                          Image.asset(
                            'images/loading.jpg',
                            width: 36.0,
                            height: 36.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              children: <Widget>[
                                Text('${lists}'),
                                Text(
                                '两天前',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black38
                                  ),
                                )
                              ],
                            )
                          )
                        ], 
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                        child: Text('买房后悔吗',
                          textAlign: TextAlign.left, 
                        ),
                      ),
                      Container(
                        child: Text(
                          '买房后悔吗买房后悔吗买房后悔吗买房后悔吗买房后悔吗买房后悔吗后悔吗买房后悔吗买房后悔吗买房后悔吗',
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 12.0 ,
                            color: Colors.black38
                          )
                        ),
                      ),
                    ],
                  ),
                )
              )
            ],
          );
        } ,
        itemExtent: 180.0,
        itemCount: 10,
      ),
    );
  }
}

// Widget _itemBuilder(BuildContext context,response) {

//     return Column(
//       children: <Widget>[
       
//         Container(
//           padding: const EdgeInsets.only(left: 30.0, top: 10.0, bottom: 10.0),
//           decoration: BoxDecoration(
//             border: Border(
//               bottom: BorderSide(
//                 color: Color.fromRGBO(241, 241, 241, 1),
//                 width: 5.0,
//                 style: BorderStyle.solid
//               )
//             )
//           ),
//           child: GestureDetector(
//             onTap: (){
//               Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => Mine())
//               );
//             },
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     Image.asset(
//                       'images/loading.jpg',
//                       width: 36.0,
//                       height: 36.0,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10.0),
//                       child: Column(
//                         children: <Widget>[
//                           Text('1'),
//                           Text(
//                           '两天前',
//                             style: TextStyle(
//                               fontSize: 12.0,
//                               color: Colors.black38
//                             ),
//                           )
//                         ],
//                       )
//                     )
//                   ], 
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(top: 10.0, bottom: 5.0),
//                   child: Text('买房后悔吗',
//                     textAlign: TextAlign.left, 
//                   ),
//                 ),
//                 Container(
//                   child: Text(
//                     '买房后悔吗买房后悔吗买房后悔吗买房后悔吗买房后悔吗买房后悔吗后悔吗买房后悔吗买房后悔吗买房后悔吗',
//                     textAlign: TextAlign.left,
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 2,
//                     style: TextStyle(
//                       fontSize: 12.0 ,
//                       color: Colors.black38
//                     )
//                   ),
//                 ),
                
//                 // Container(
//                 //   child: Row(
//                 //     children: <Widget>[
//                 //       IconButton(
//                 //         icon: Icon(Icons.comment, color: Colors.grey, size: 16.0),
//                 //         onPressed: null
//                 //       ),
//                 //       IconButton(
//                 //         icon: Icon(Icons.collections, color: Colors.grey, size: 16.0),
//                 //         onPressed: null
//                 //       ),
//                 //       IconButton(
//                 //         icon: Icon(Icons.thumb_up, color: Colors.grey, size: 16.0),
//                 //         onPressed: null,
//                 //       )
//                 //     ],
//                 //   ),
//                 // )
//               ],
//             ),
//           )
//         )
//       ],
//     );
//   }


 