import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/draw/drawee_data.dart';

///登入成功
class RegistrationSuccessfulProvide extends BaseProvide {



///线上线下 抽签类型
  int _drawAwardType;
  int get drawAwardType => _drawAwardType;
  set drawAwardType(int drawAwardType){
    _drawAwardType = drawAwardType;
  }

  
  DraweeModel _draweeModel = DraweeModel();
  DraweeModel get draweeModel => _draweeModel;
  set draweeModel(DraweeModel draweeModel) {
    _draweeModel = draweeModel;
  }

  double _longitude = 1231.1;
  double get longitude => _longitude;
  set longitude(double longitude) {
    _longitude = longitude;
  }

  double _latitude = 131.11;
  double get latitude => _latitude;
  set latitude(double latitude) {
    _latitude = latitude;
  }
}
