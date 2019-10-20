
import 'package:innetsect/base/base.dart';

class PersonalCenterProvide extends BaseProvide{

///头像
  String _headPortrait ;
  get headPortrait{
    if (_headPortrait == null) {
      _headPortrait = 'assets/images/def_head_big.png';
    }
    return _headPortrait;
  }
  set headPortrait(String headPortrait){
    _headPortrait = headPortrait;
    notifyListeners();
  }


var _imagePath;
get imagePath{
  
  return _imagePath;
}
set imagePath(var imagePath){
  if (imagePath == null) {
    return;
  }
  _imagePath = imagePath;
  notifyListeners();
}

///昵称
  String _nickname;
  get nickname{
    if (_nickname == null) {
      _nickname = '你还未设置昵称';
    }
    return _nickname;
  }
  set nickname(String nickname){
    _nickname = nickname;
    notifyListeners();
  }
///性别
 String _gender;
  get gender{
    if (_gender == null) {
      _gender = '你还未设置性别';
    }
    return _gender;
  }
  set gender(String gender){
    _gender = gender;
    notifyListeners();
  }

///生日
 String _birthday;
  get birthday{
    if (_birthday == null) {
      _birthday = '你还未设置性别';
    }
    return _birthday;
  }
  set birthday(String birthday){
    _birthday = birthday;
    notifyListeners();
  }
}