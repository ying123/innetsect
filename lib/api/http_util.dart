

import 'package:dio/dio.dart';
import 'package:innetsect/base/app_config.dart';


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
    final token = AppConfig.userTools.getUserToken();
    print('token:->$token');
    if (token != null && token.length>0) {
      print('12312');
      options.headers.putIfAbsent('Authorization', ()=> 'Bearer' + ' '+token);
    }
    return super.onRequest(options);
  }

  @override
  Future onError(DioError err) {
   print("onError->$err");
    return super.onError(err);
  }
}