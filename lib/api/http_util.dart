import 'package:dio/dio.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:device_info/device_info.dart';
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
    final token = AppConfig.userTools.getUserToken();
//    final token ='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiJuZG0xMjM0NTYiLCJzY29wZSI6WyJyZWFkIiwid3JpdGUiXSwiYWNjdF90eXBlIjoyMSwibW9iaWxlIjoiMTU2MTgwOTY1MjAiLCJpZCI6MSwiZXhwIjoxNTcyNDM4MDgzLCJwb3J0cmFpdCI6Imh0dHBzOi8vaW5uZXJzZWN0OS5vc3MtY24tc2hhbmdoYWkuYWxpeXVuY3MuY29tL2FjY291bnRzLzIwMTkvMV9wb3J0cmFpdC5qcGciLCJhdXRob3JpdGllcyI6WyJST0xFX01FTUJFUiIsIlJPTEVfUEFSVE5FUiIsIlJPTEVfRVhISUJJVE9SX0lOVklURUQiXSwianRpIjoiM2RmZmE1N2EtYzMyNS00NTFiLWFhN2ItNjdlZjhmZGYwN2U1IiwiZW1haWwiOiIiLCJjbGllbnRfaWQiOiJpbm5lcnNlY3QiLCJzdGF0dXMiOjF9.oe9VYSxdJDlukIKoT2a5N4menHYVK4Vz7Cd1z17zCDE';
    print('token:->$token');
    if (token != null && token.length>0) {
      print('12312');
      options.headers.putIfAbsent('Authorization', ()=> 'Bearer' + ' '+token);
    }
    if(options.path=="/api/accounts/me"){
      ///deviceID: f37bc0e55fb942808b5ada371cd3e89b
      //platform: IOS
      //manufacturer: huawei
      //osVersion: 6.7
      //osModel: plus
      //locale: chinese
      //appVersion: 2.3
      _getDeviceInfo().then((item){
        print(item);
        options.headers.putIfAbsent("deviceID",() => item.androidId);
        options.headers.putIfAbsent("platform", () => "android");
        options.headers.putIfAbsent("manufacturer", () => item.manufacturer);
        options.headers.putIfAbsent("osVersion", () => item.version);
        options.headers.putIfAbsent("osModel", () => item.model);
        options.headers.putIfAbsent("locale", () => UserTools().getLocal());
        options.headers.putIfAbsent("appVersion", () => "1.0.0");
      });
    }
    return super.onRequest(options);
  }

  @override
  Future onError(DioError err) {
   print("onError->$err");
    return super.onError(err);
  }

  Future<AndroidDeviceInfo> _getDeviceInfo() async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    return deviceInfo.androidInfo;
  }
}