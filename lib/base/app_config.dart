

import 'package:flutter/material.dart';
import 'package:innetsect/tools/user_tool.dart';
///App的所有基础配置
class AppConfig{


  ///基础链接
  static const baseUrl = 'http://gate.innersect.net';

  //todo App的所有基础配置

  //样式
  static final themedata = ThemeData(
    primaryColor: Colors.white,
    accentColor: Colors.white,
  );
///字体主颜色
  static final fontPrimaryColor = Color.fromRGBO(18, 18, 18, 1.0);

  static UserTools userTools;
  static init()async{
    userTools = await UserTools.getInstance();
  }
}