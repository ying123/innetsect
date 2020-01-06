import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/draw/drawee_data.dart';
import 'package:innetsect/data/draw/lottery_registration_page.dart';

import 'package:innetsect/model/draw/drawshop_model.dart';
import 'package:rxdart/rxdart.dart';

///登记信息
class RegistrationInformationProvide extends BaseProvide {
  bool _groupValuea = true;
  bool get groupValuea => _groupValuea;
  set groupValuea(bool obj) {
    _groupValuea = obj;
    notifyListeners();
  }

  int _registrationStatus = 0;
  int get registrationStatus => _registrationStatus;
  set registrationStatus(int registrationStatus) {
    _registrationStatus = registrationStatus;
    notifyListeners();
  }

  LotteryRegistrationPageModel _lotteryRegistrationPageModel = LotteryRegistrationPageModel();
  LotteryRegistrationPageModel get lotteryRegistrationPageModel=>_lotteryRegistrationPageModel;
  set lotteryRegistrationPageModel(LotteryRegistrationPageModel lotteryRegistrationPageModel){
    _lotteryRegistrationPageModel = lotteryRegistrationPageModel;
  }
// ///抽签信息数据
//   DrawsModel _drawsModel = DrawsModel();
//   DrawsModel get drawsModel=>_drawsModel;
//   set drawsModel(DrawsModel drawsModel){
//     _drawsModel = drawsModel;
//   }
// ///商店数据
//   ShopsModel _model = ShopsModel();
//   ShopsModel get model=>_model;
//   set model(ShopsModel model){
//     _model = model;
//   }

///LotteryRegistrationPageModel
   

///姓名
  String _userName;
  String get userName=>_userName;
  set userName(String userName){
    _userName = userName;
  }
///证件
  String _certificate;
  String get certificate=>_certificate;
  set certificate( String certificate){
    _certificate = certificate;
  }
///手机号码
  String _phoneNumber;
  String get phoneNumber=>_phoneNumber;
  set phoneNumber(String phoneNumber){
    _phoneNumber = phoneNumber;
  }
///设备名称
  String _platform;
  String get platform=>_platform;
  set platform(String platform){
    _platform = platform;
  }

DraweeModel _draweeModel = DraweeModel();
DraweeModel get draweeModel=>_draweeModel;
set draweeModel(DraweeModel draweeModel){
  _draweeModel = draweeModel;
}
///国家编码
String _countryCode = '86';
String get countryCode=>_countryCode;
set countryCode(String countryCode){
  _countryCode = countryCode;
  notifyListeners();
}

///登记
  DrawshopRepo _repo = DrawshopRepo();
  Observable drawshop(){
    
    var today =  DateTime.now();
    String todatStr = today.toString();
    List<String> todatSp = todatStr.split('.');

    
   
    Map body = {
      "drawID": lotteryRegistrationPageModel.drawID,
      "shopID": lotteryRegistrationPageModel.shopID,
     // "acctID": 1,
      "realName": userName,
      "telPrefix": "86",
      "mobile": phoneNumber,
      "icNo": certificate,
      "registerDate": todatSp[0],
      "platform": platform,
      "longitude": 121.494523,//经度
      "latitude": 31.318514,//纬度
    };
     print('todatSP ======> ${todatSp[0]}');
     print('drawID ======> ${lotteryRegistrationPageModel.drawID}');
     print('shopID ======> ${lotteryRegistrationPageModel.shopID}');
     print('icNo ======> $certificate');
    return _repo.drawshop(body, lotteryRegistrationPageModel.drawID).doOnData((item){

    }).doOnError((e,stack){

    }).doOnDone((){

    });

  }


}
