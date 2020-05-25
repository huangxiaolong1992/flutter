import 'package:dy/pages/dynamic/app.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../http/http.dart';
import 'package:dio/dio.dart';
import 'package:provide/provide.dart';
import '../../../provide/userInfo.dart';
import '../../../utils/globla.dart';

class Report extends StatefulWidget{
  
  @override
  _ReportState createState() => _ReportState();
}


class _ReportState extends State<Report>{
  List _imgPath = [];
  bool _switchSelected = false; //维护单选开关状态
  List _getHttpImgPath = [];

  //发表内容控制器
  TextEditingController _reporController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Provide<UserInfoProvide>(
      builder: (context, child , userInfoProvide) {
        return Scaffold(
          appBar: AppBar(
            title: Text('发表动态'),
            actions: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 18.0, right: 15.0),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      child: Text('发表'),
                      onTap: () {
                        _postReport(userInfoProvide);
                      },
                    )
                  ],
                )
              ),
            ]
          ),
          floatingActionButton: FloatingActionButton(
            onPressed:() async {
              await _showModalBottomSheet(context);
            },
            tooltip: '选择图片',
            child: Icon(Icons.add_a_photo),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _TextField(),

              Container(
                padding: const EdgeInsets.all(5.0),
                child: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: _generateImages()
                )
              ),

              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black12
                    )
                  )
                )
              )             
            ]
          )
        ); 
      } 
    );
  }
  

  //发表请求接口
  void _postReport(userInfoProvide){
    String reporContent = _reporController.text;

    if(reporContent.length == ''){
    
      G.toast('发表内容不能为空');
      return;
    }
    
    //上传图片
    if(_imgPath.length > 0){
      _uploadImg();
    }
    
    //判断图片是否已经上传完成
    void pathIsHttp(){
      if(_imgPath.length == _getHttpImgPath.length){
        createInterfce(reporContent, userInfoProvide);
      }else{
        Future.delayed(Duration(milliseconds: 500), () {
          pathIsHttp();
        });
      }
    }  

    pathIsHttp();
  }

  

  void createInterfce(reporContent,userInfoProvide){
     
    Object data = {
      "username": userInfoProvide.userData['data']['username'],
      "dynamicContent": reporContent,
      "dynamicPic": _getHttpImgPath
    };
    
    postHttp("/api/dynamic/createDynamic", data, userInfoProvide.userData['data']['token'] )
      .then((response){

        if(response['code'] == 200){
          G.toast('发表成功');
        }

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => App()),
          (route)=>route==null
        );
        
      });
  }
  
   //上传图片
  void _uploadImg(){

    for(int i = 0 ; i < _imgPath.length; i++){
      String path = _imgPath[i].path;
      var name = path.substring(path.lastIndexOf("/") + 1, path.length);
 
      FormData formData = new FormData.from({
        "file": UploadFileInfo(_imgPath[i], name),
      });
  
      postHttp("/api/upload",formData, null)
        .then((response){
          _getHttpImgPath.add(response['data']['url']);
        });
    }
  }

  /*底部弹窗 选择相册或者拍照*/

  Future<int> _showModalBottomSheet(context) {
    
    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 150.0,
          child: Column(    
            children: <Widget>[
              GestureDetector(
                child: Container(
                  height: 50.0,
                  alignment: Alignment.center,
                  child: Text('从相册选取'),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12
                      )
                    )
                  ),
                ),
                onTap: () {
                  _openGallery(0);
                },
              ),
              GestureDetector(
                child: Container(
                  height: 50.0,
                  alignment: Alignment.center,
                  child: Text('拍照'),
                  decoration: BoxDecoration(
                    border: Border(              
                      bottom: BorderSide(
                        width: 8.0,
                        color: Colors.black12
                      )
                    )
                  ),
                ),
                onTap: () {
                  _openGallery(1);
                },
              ),
              GestureDetector(
                child: Container(
                  height: 50.0,
                  alignment: Alignment.center,
                  child: Text('取消'),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          )
        );
      },
    );
  }


  /*0:相册  1:拍照*/
  void _openGallery(int num) async {
    Navigator.pop(context);
    var source = num == 0 ? ImageSource.gallery : ImageSource.camera;
    var image = await ImagePicker.pickImage(source: source);
    
    if(image != null){
       setState(() {
        _imgPath.add(image);
      });
    }
  }


  /*文本框控件*/
  Widget _TextField(){
    return TextField(
      autofocus: true,
      maxLines: 8,
      controller: _reporController,
      decoration: InputDecoration(
        hintText: '随便说点什么',
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(20.0),
      ),
    );
  }

  // 图片面板
  _generateImages() {
    return _imgPath.map((file){
      return Stack(
        children: <Widget>[
          ClipRRect(
            //圆角效果
            borderRadius: BorderRadius.circular(4),
            child: Image.file(file,width: 80,height: 80,fit:BoxFit.fill),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: GestureDetector(
              onTap: (){
                setState(() {
                  _imgPath.remove(file);
                });
              },
              child: ClipOval(
                //圆角删除按钮
                child: Container(
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(color: Colors.black54),
                  child: Icon(Icons.close,size: 14,color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
}
