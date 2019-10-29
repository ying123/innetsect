import 'package:innetsect/base/const_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
///用户工具类
class UserTools{
  static UserTools _instance; 

  static Future<UserTools> get instance async{
    return await getInstance();
  }

  static Future<UserTools> getInstance()async{
    
    if (_instance == null) {
      _instance = new UserTools();
      print('应用配置用户工具类UserTools初始化完成....');
      await _instance._init();
    }
    return _instance;
  }

   static SharedPreferences _spf;

    Future _init()async{
    _spf = await SharedPreferences.getInstance();
    print('本地持久层SharedPreferences初始化完成');
  }

  //检查_spf是否为空
   static bool _beforCheck() {
    if (_spf == null) {
      return true;
    }
    return false;
  }


//存储用户数据
Future<bool> setUserData(Map<String, dynamic>user){
  if (_beforCheck()) {
    return null;    
  }
  var jsonStr =  json.encode(user);
  return _spf.setString(ConstConfig.CURRENT_USERDATA, jsonStr);
}

///获取用户数据
dynamic getUserData(){
  var mapStr = _spf.getString(ConstConfig.CURRENT_USERDATA);
  print('mapStr>>>>>>>$mapStr');
  if (mapStr != null) {
    var map = json.decode(mapStr);
    return map;
  }else{
    return null;
  }
}

///获取用户token
  String getUserToken(){
    var userData = this.getUserData();
    if (userData != null) {
     var user = userData as Map<String, dynamic>;
     return user['access_token'];
    }else{
      return '';
    }
  }

  
///从本地获取国家
  String getIniCountry(String iniCountry){
    String country = _spf.getString(iniCountry);
    return country;
  }
///从本地获取国家语言
  String getIniLanguage(String iniLanguage){
    String language = _spf.getString(iniLanguage);
    return language;
  }

///保存exhibitionID展会ID 到本地
  Future<bool> setExhibitionID(String exhibitionID)async{
    print('_spf<<<<<<<<<<<<<<<<<<$_spf <<<<<<$exhibitionID');
    if (_beforCheck()) {
      print('<<<<<<<<<<<<<<<<<<<<<<<<<<<<_beforCheck');
      return null;
    }
    return _spf.setString(ConstConfig.EXHIBITION_ID, exhibitionID);
  }

  
///获取exhibitionID展会ID
  Future<String> getExhibitionID()async{
    
    return _spf.getString(ConstConfig.EXHIBITION_ID);
  }



}