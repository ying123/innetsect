import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/draw/drawee_data.dart';
///登入成功
class RegistrationSuccessfulProvide extends BaseProvide{

  DraweeModel _draweeModel = DraweeModel();
  DraweeModel get draweeModel=>_draweeModel;
  set draweeModel(DraweeModel draweeModel){
    _draweeModel = draweeModel;
  }
  
}