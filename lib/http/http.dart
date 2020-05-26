
import 'package:dio/dio.dart';
import 'dart:convert';
import '../utils/globla.dart';

Dio dio = new Dio(BaseOptions(
    connectTimeout: 5000,   // 连接服务器超时时间，单位是毫秒.
    receiveTimeout: 10000,   // 响应流上前后两次接受到数据的间隔，单位为毫秒, 这并不是接收数据的总时限.
  )
);

final String baseUrl = "http://192.168.50.118:8080";

Future postHttp(String url, data, token) async {
  var  options = Options(headers: {
    'Authorization': token
  });

  try {
    Response response = await dio.post(
      "$baseUrl$url", 
      data: data,
      options: options
    );

    final responseJson = json.decode(response.toString());
          Map<String, dynamic> newData = responseJson ;

    return newData;
  } catch (e) {
    G.toast('网络异常');
  }
}

Future getHttp(String url, String token) async {
  var  options = Options(headers: {
    'Authorization': token
  });

  try {
    Response response = await dio.get(
      "$baseUrl$url",
      options: options
    );
    
    final responseJson = json.decode(response.toString());
          Map<String, dynamic> newData = responseJson ;

    return newData['data'];
  } catch (e) {
    G.toast('网络异常');
  }
}