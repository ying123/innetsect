import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import '../data/base.dart';
import 'http_util.dart';

Observable<BaseResponse> get(String url, {Map<String, dynamic> params}) {
  print('get url:->$url params:->$params');
  return Observable.fromFuture(_get(url, params: params))
      .delay(Duration(milliseconds: 500))
      .asBroadcastStream();
}

Future<BaseResponse> _get(String url, {Map<String, dynamic> params}) async {
  var res;
  await HttpUtil().dio.get(url, queryParameters: params).then((response){
     if (response.data is Map) {
    print('response是map类型');
    //将json数据转换成BaseResponse实例
    res = BaseResponse.fromJson(response.data);
  } else if (response.data is List) {
    print('_get response.data：->${response.data}');
    res = BaseResponse.fromlist(response.data);
  }
  }).catchError((error){
    Fluttertoast.showToast(
      msg: error.toString(),
      gravity: ToastGravity.CENTER
    );
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
    {dynamic body, Map<String, dynamic> qureyParameters}) {
  print('post url:->$url body:->$body qureyParameters:->$qureyParameters');
  return Observable.fromFuture(
          _post(url, body, queryParameters: qureyParameters))
      .asBroadcastStream();
}

Future<BaseResponse> _post(String url, dynamic body,
    {Map<String, dynamic> queryParameters}) async {
  var response = await HttpUtil()
      .dio
      .post(url, data: body, queryParameters: queryParameters);
  print('response _post:->$response');
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
