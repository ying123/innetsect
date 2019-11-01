import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/view/login/login_page.dart';
import 'package:rxdart/rxdart.dart';
import '../data/base.dart';
import 'http_util.dart';

Observable<BaseResponse> get(String url, {Map<String, dynamic> params,BuildContext context}) {
  print('get url:->$url params:->$params');
  return Observable.fromFuture(_get(url, params: params,context: context))
      .delay(Duration(milliseconds: 500))
      .asBroadcastStream();
}

Future<BaseResponse> _get(String url, {Map<String, dynamic> params,BuildContext context}) async {
  var res;
  await HttpUtil().dio.get(url, queryParameters: params).then((response){
     if (response.data is Map) {
    print('response是map类型');
    print('responsr->${response.data}');
    //将json数据转换成BaseResponse实例
    res = BaseResponse.fromJson(response.data);
  } else if (response.data is List) {
    print('_get response.data：->${response.data}');
    res = BaseResponse.fromlist(response.data);
  }
  }).catchError((error){
    if(error.response.data['path']=="/accounts/me"){

      Future.delayed(Duration.zero,(){
        Navigator.pushNamed(context, '/loginPage');
      });
    }else{
      Fluttertoast.showToast(
          msg: error.toString(),
          gravity: ToastGravity.CENTER
      );
    }
  });
 
 

  // print('_get response：->$response');
  // print('_get response.statusCode：->${response.statusCode}');
  //print('_get res.data->${res.data}');
  // if (res.success == false) {
  //   Fluttertoast.showToast(
  //     msg: res.message
  //   );
  // }
  return res;
}

///post请求
Observable<BaseResponse> post(String url,
    {dynamic body, Map<String, dynamic> qureyParameters,BuildContext context}) {
  print('post url:->$url body:->$body qureyParameters:->$qureyParameters');
  return Observable.fromFuture(
          _post(url, body, queryParameters: qureyParameters,context: context))
      .asBroadcastStream();
}

Future<BaseResponse> _post(String url, dynamic body,
    {Map<String, dynamic> queryParameters,BuildContext context}) async {
  var response;
  await HttpUtil()
      .dio
      .post(url, data: body, queryParameters: queryParameters).then((res){
    response = BaseResponse.fromJson(res.data);
    print('response _post:->$response');
  }).catchError((error){
    print(error);

    if(error.response.data['path']=="/salesorders/shoppingorder/create"){
      Future.delayed(Duration.zero,(){
        Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context){
            return LoginPage();
          },settings: RouteSettings(arguments: {'pages': 'orderDetail'})
        ));
      });
    }
  });
  //加json数据转换成BaseResponse实例
//  var res = BaseResponse.fromJson(response.data);
  //  if (res.success == false) {
  //    Fluttertoast.showToast(
  //      msg: res.message,
  //      gravity: ToastGravity.CENTER
  //    );
  //  }
  return response;
}

/// patch请求
Observable<BaseResponse> patch(String url,
    {dynamic body, Map<String, dynamic> qureyParameters}) {
  print('patch url:->$url body:->$body qureyParameters:->$qureyParameters');
  return Observable.fromFuture(
      _patch(url, body, queryParameters: qureyParameters))
      .asBroadcastStream();
}

Future<BaseResponse> _patch(String url, dynamic body,
    {Map<String, dynamic> queryParameters}) async {
  var response = await HttpUtil()
      .dio
      .patch(url, data: body, queryParameters: queryParameters);
  print('response _patch:->$response');
  //加json数据转换成BaseResponse实例
  var res = BaseResponse.fromJson(response.data);
  //  if (res.success == false) {
  //    Fluttertoast.showToast(
  //      msg: res.message,
  //      gravity: ToastGravity.CENTER
  //    );
  //  }
  return res;
}

///put请求
Observable<BaseResponse> put(String url,
    {dynamic body, Map<String, dynamic> qureyParameters,BuildContext context}) {
  print('post url:->$url body:->$body qureyParameters:->$qureyParameters');
  return Observable.fromFuture(
      _put(url, body, queryParameters: qureyParameters,context: context))
      .asBroadcastStream();
}

Future<BaseResponse> _put(String url, dynamic body,
    {Map<String, dynamic> queryParameters,BuildContext context}) async {
  var response;
  await HttpUtil()
      .dio
      .put(url, data: body, queryParameters: queryParameters).then((res){
    response = BaseResponse.fromJson(res.data);
    print('response _post:->$response');
  }).catchError((error){
    print(error);
  });
  return response;
}


Observable<BaseResponse> getCountries(String url, {Map<String, dynamic> params,BuildContext context}) {
  print('get url:->$url params:->$params');
  return Observable.fromFuture(_getCountries(url, params: params,context: context))
      .delay(Duration(milliseconds: 500))
      .asBroadcastStream();
}

Future<BaseResponse> _getCountries(String url, {Map<String, dynamic> params,BuildContext context}) async {
  var res;
  Dio dio = HttpUtil().dio;
  BaseOptions options = BaseOptions(
    baseUrl:AppConfig.baseUrl,
    connectTimeout: 10000,
    receiveTimeout: 10000,
    headers: {
      'Accept-Language':'zh-CN,zh;q=0.9,en;q=0.8'
    }
  );
  dio.options = options;
  dio.interceptors.add(HeaderInterceptor());
  await dio.get(url, queryParameters: params).then((response){
    if (response.data is Map) {
      print('response是map类型');
      print('responsr->${response.data}');
      //将json数据转换成BaseResponse实例
      res = BaseResponse.fromJson(response.data);
    } else if (response.data is List) {
      print('_get response.data：->${response.data}');
      res = BaseResponse.fromlist(response.data);
    }
  }).catchError((error){
  });
  return res;
}