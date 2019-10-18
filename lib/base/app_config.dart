

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

  /// 添加颜色色值
  /// 主视觉颜色
  static final primaryColor = Color.fromRGBO(247, 235, 68, 1.0);
  /// 辅助线颜色
  static final assistLineColor = Color.fromRGBO(234, 234, 234, 1.0);
  /// 辅助颜色
  static final assistColor = Color.fromRGBO(220, 67, 26, 1.0);
  /// 主要文字
  static final fontBackColor = Color.fromRGBO(25, 25, 25, 1.0);
  /// 辅助描述或未选中文字
  static final assistFontColor = Color.fromRGBO(197, 197, 197, 1.0);
  /// 背景色
  static final backGroundColor = Color.fromRGBO(249, 249, 249, 1.0);

  static UserTools userTools;
  static init()async{
    userTools = await UserTools.getInstance();
  }
}