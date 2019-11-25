import 'package:innetsect/base/base.dart';
import 'package:innetsect/model/exhibition/binding_qrcode_model.dart';
import 'package:rxdart/rxdart.dart';

class BingdingSignInProvide extends BaseProvide {



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
}