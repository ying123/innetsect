import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:innetsect/view/login/login_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
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
  await HttpUtil().dio.get(url, queryParameters: params,
      options:Options(extra: {"context": context})).then((response){
     if (response.data is Map) {
  //  print('response是map类型');
    print('responsr->${response.data}');
    //将json数据转换成BaseResponse实例
    res = BaseResponse.fromJson(response.data);
  } else if (response.data is List) {
    print('_get response.data：->${response.data}');
    res = BaseResponse.fromlist(response.data);
  }
  }).catchError((error){
    print('error------${error.response.data['path']}');
    if(error.response.data['path']=='/api/eshop/shoppingcart/my'){
//      Future.delayed(Duration.zero,(){
//        Navigator.push(context, MaterialPageRoute(
//          builder: (context){
//            return LoginPage();
//          },
//        ));
//      });
    }
    if(error.response.data['path']=="/accounts/me"
      || error.response.statusCode==401
      ||error.response.data['message']=="jwt.token.expired"
    ){
      print(context.widget);
      Future.delayed(Duration.zero,(){
        Navigator.push(context, MaterialPageRoute(
          builder: (context){
            return LoginPage();
          },
          settings: RouteSettings(arguments: {"pages":context.widget}),
        ));
      });
    }else{
      if(error.response.data['message']!=null){
        Fluttertoast.showToast(
            msg: error.response.data['message'].toString(),
            gravity: ToastGravity.CENTER
        );
      }
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
  try{
    await HttpUtil()
        .dio
        .post(url, data: body, queryParameters: queryParameters,
        options:Options(extra: {"context": context})).then((res){
      if(res.data is Map){
        response = BaseResponse.fromJson(res.data);
      }else if(res.data is List){
        response = BaseResponse.fromlist(res.data);
      }
      print('response _post:->$response');
    }).catchError((error){

      if(error.response.data['message']=='密钥不正确'&&error.response.data['status']==400){
        CustomsWidget().showToast(title: error.response.data['message']);
        return ;
      }else {
        CustomsWidget().showToast(title: error.response.data['message']);
      }
      if(error.response.data['path']=="/salesorders/shoppingorder/create"){
        if(UserTools().getUserToken()==null){
          Future.delayed(Duration.zero,(){
            Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context){
                  return LoginPage();
                },settings: RouteSettings(arguments: {'pages': 'orderDetail'})
            ));
          });
        }
      }
      if(error.response.data['message']=="jwt.token.expired"){
        Future.delayed(Duration.zero,(){
          Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context){
                return LoginPage();
              }
          ));
        });
      }
    });
  }on DioError catch(e){
    print(e);
  }

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
Future patch(String url,
    {dynamic body, Map<String, dynamic> qureyParameters,BuildContext context}) {
  print('patch url:->$url body:->$body qureyParameters:->$qureyParameters');
  return _patch(url, body, queryParameters: qureyParameters,context: context);
}

Future _patch(String url, dynamic body,
    {Map<String, dynamic> queryParameters,BuildContext context}) async{
  Response response;
  try{
    await HttpUtil()
        .dio
        .patch(url, data: body, queryParameters: queryParameters,
        options:Options(extra: {"context": context})).then((item){
      response = item;
    }).catchError((error){
      if(error.response.data['message']!=null){
        CustomsWidget().showToast(title: error.response.data['message']);
      }
    });
  } on DioError catch(e){
    print(e);
  }

  return response;
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
      .put(url, data: body, queryParameters: queryParameters,
      options:Options(extra: {"context": context})).then((res){
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
  await dio.get(url, queryParameters: params,options:Options(extra: {"context": context})).then((response){
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

Future getHtml(String url, {Map<String, dynamic> params,BuildContext context}) {
  return _getHtml(url, params: params,context: context);
}

Future _getHtml(String url, {Map<String, dynamic> params,BuildContext context}) async {
  Response response;
  Dio dio = HttpUtil().dio;
  BaseOptions options = BaseOptions(
      baseUrl:AppConfig.baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 10000,
      headers: {
        'Content-Type':'text/html'
      }
  );
  dio.options = options;
  dio.interceptors.add(HeaderInterceptor());
  await dio.get(url, queryParameters: params,options:Options(extra: {"context": context})).then((res){
    response = res;
  }).catchError((error){
  });
  return response;
}

////delete请求
Future delete(String url,
    {dynamic body, Map<String, dynamic> qureyParameters,BuildContext context}) {
  return _delete(url, body, queryParameters: qureyParameters,context: context);
}

Future _delete(String url, dynamic body,
    {Map<String, dynamic> queryParameters,BuildContext context}) async {
  Response response;
  await HttpUtil()
      .dio
      .delete(url, data: body, queryParameters: queryParameters,
      options:Options(extra: {"context": context})).then((res){
    response = res;
    print('response _post:->$response');
  }).catchError((error) {
    if(error.response.data['path'].toString().indexOf("/reservations")>-1){
      CustomsWidget().showToast(title: error.response.data['message']);
    }
  });
  return response;
}