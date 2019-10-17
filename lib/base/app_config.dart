

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

  static UserTools userTools;
  static init()async{
    userTools = await UserTools.getInstance();
  }
}