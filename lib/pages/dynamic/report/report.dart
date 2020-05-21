import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Report extends StatefulWidget{
  
  @override
  _ReportState createState() => _ReportState();
}


class _ReportState extends State<Report>{
  List _imgPath = [];
  bool _switchSelected = false; //维护单选开关状态

  @override
  Widget build(BuildContext context){
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
                    print('2');
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
            ),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: _switchSelected,
                  activeColor: Colors.blue, //选中时的颜色
                  onChanged:(value){
                    setState(() {
                      _switchSelected = value;
                    });
                  } ,
                ),
                Text(
                  '仅自己可见',
                  style: TextStyle(
                    color: Colors.black45
                  ),
                )
              ],
            )
          )
             
        ]
      )   
    );
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
