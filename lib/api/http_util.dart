import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/api/loading.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/tools/user_tool.dart';

class HttpUtil {
  static HttpUtil instance;
  Dio dio;
  BaseOptions options;

  static HttpUtil getInstance(){
    print('getInstance');
    if (instance == null) {
      instance = new HttpUtil();
    }
    return instance;
  }  

  HttpUtil(){
    dio = new Dio()
      ..options = BaseOptions(
        baseUrl:AppConfig.baseUrl,
        connectTimeout: 10000,
        receiveTimeout: 10000, 
      
        )
        ..interceptors.add(HeaderInterceptor());

  }
}

class HeaderInterceptor extends Interceptor {

  @override
  Future onRequest(RequestOptions options) async {
    print(options.method);
    final String token = AppConfig.userTools.getUserToken();
//    final token ='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiJuZG0xMjM0NTYiLCJzY29wZSI6WyJyZWFkIiwid3JpdGUiXSwiYWNjdF90eXBlIjoyMSwibW9iaWxlIjoiMTU2MTgwOTY1MjAiLCJpZCI6MSwiZXhwIjoxNTcyNDM4MDgzLCJwb3J0cmFpdCI6Imh0dHBzOi8vaW5uZXJzZWN0OS5vc3MtY24tc2hhbmdoYWkuYWxpeXVuY3MuY29tL2FjY291bnRzLzIwMTkvMV9wb3J0cmFpdC5qcGciLCJhdXRob3JpdGllcyI6WyJST0xFX01FTUJFUiIsIlJPTEVfUEFSVE5FUiIsIlJPTEVfRVhISUJJVE9SX0lOVklURUQiXSwianRpIjoiM2RmZmE1N2EtYzMyNS00NTFiLWFhN2ItNjdlZjhmZGYwN2U1IiwiZW1haWwiOiIiLCJjbGllbnRfaWQiOiJpbm5lcnNlY3QiLCJzdGF0dXMiOjF9.oe9VYSxdJDlukIKoT2a5N4menHYVK4Vz7Cd1z17zCDE';
    print('token:->$token');
    if (token != null && token.length>0) {
      print('12312');
      options.headers.putIfAbsent('Authorization', ()=> 'Bearer' + ' '+token);
    }

    ///deviceID: f37bc0e55fb942808b5ada371cd3e89b
    //platform: IOS
    //manufacturer: huawei
    //osVersion: 6.7
    //osModel: plus
    //locale: chinese
    //appVersion: 2.3
    String jsons = UserTools().getDeviceInfo();
    if(jsons!=null){
      Map<String,dynamic> map = json.decode(jsons);
      options.headers.putIfAbsent("deviceID",() => map['deviceID']);
      options.headers.putIfAbsent("platform", () => map['platform']);
      options.headers.putIfAbsent("manufacturer", () => map['manufacturer']);
      options.headers.putIfAbsent("osVersion", () => map['osVersion']);
      options.headers.putIfAbsent("osModel", () => map['osModel']);
      options.headers.putIfAbsent("locale", () => map['locale']);
      options.headers.putIfAbsent("appVersion", () => map['appVersion']);
    }
//    if(options.extra["context"]!=null
//        &&options.path!="/api/eshop/app/splash"
//    &&options.path!="/api/accounts/me"){
//      Loading.ctx=options.extra["context"];
//      Loading.show("加载中");
//    }
    print(options.headers);
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    // TODO: implement onResponse
//    if(response.request.extra['context']!=null
//        &&response.request.path!="/api/eshop/app/splash"
//    ) {
//      Future.delayed(Duration(seconds: 1),(){
//        Loading.remove();
//      });
//    }
//    Loading.complie(uri: response.request.uri.toString());
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
//   print("onError->$err");
//   Future.delayed(Duration(seconds: 1),(){
//     Loading.remove();
//   });
    return super.onError(err);
  }

}