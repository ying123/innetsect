import 'package:innetsect/base/base.dart';
import 'package:innetsect/model/exhibition/binding_qrcode_model.dart';
import 'package:rxdart/rxdart.dart';

class BingdingSignInProvide extends BaseProvide {

  double _size = 1000;
  double get size => _size;

  String _qrCode = '';
  String get qrCode =>_qrCode;
  set qrCode(String qrCode ){
    _qrCode = qrCode;
    notifyListeners();
  } 

  QrcodeRepo _repo =  QrcodeRepo();
  ///获取二维码数据
  Observable qrcodeData(){
    return _repo.qrcode().doOnData((item){

    }).doOnError((e, stack){

    }).doOnDone((){

    });
  }
  
  /// 验证二维码
  ///验证签到
  Observable validQrcode (int exhibitionID){
    return _repo.validQrcode(exhibitionID).doOnData((item){

    }).doOnError((e, stack){

    }).doOnDone((){

    });
  }

  /// 提交信息
  Observable submitInfo (dynamic json){
    return _repo.submitInfo(json).doOnData((item){

    }).doOnError((e, stack){

    }).doOnDone((){

    });
  }

  /// 获取信息
  Observable getSignInfo (){
    return _repo.getSignInfo().doOnData((item){

    }).doOnError((e, stack){

    }).doOnDone((){

    });
  }

  ///工厂模式
  factory BingdingSignInProvide() => _getInstance();
  static BingdingSignInProvide get instance => _getInstance();
  static BingdingSignInProvide _instance;
  static BingdingSignInProvide _getInstance() {
    if (_instance == null) {
      _instance = new BingdingSignInProvide._internal();
    }
    return _instance;
  }
  BingdingSignInProvide._internal() {
    print('BingdingSignInProvide init');
    // 初始化
  }
}