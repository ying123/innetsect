

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CommonUtil{

  static String appTitle = 'innersect3';

  static const int cmd_user_setting = 100;


///匹配密码格式正确返回true
  static isPassword(String password) {
    return new RegExp(r'^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$').hasMatch(password);
  }
  ///匹配email格式正确返回true
  static isEmail(String email) {
    return new RegExp(r'^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$').hasMatch(email);
  }
///隐藏状态栏简单
  static hideStatusbarEasy(){
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  /// 验证手机号码
  static bool isPhoneLegal(String str) {
    return new RegExp('^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$').hasMatch(str);
  }


///通过动画曲线创建界面  
static Route createRoute(Tween<Offset> tween, Widget child) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position:
              animation.drive(tween.chain(CurveTween(curve: Curves.ease))),
          child: child,
        );
      });
}

static Route customCreateRoute(Widget page){
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        }
    );
}

  /// 商品skuname截取显示
  static List skuNameSplit(String skuName){
    List list = List();
    if(skuName.indexOf(":")>0){
      list = skuName.split(":");
    }
    return list;
  }

  /// 售后状态
  /// *[状态：10 申请中 30已审核通过 34审核不通过 35已退货 40已收到退货 50已完成 60 已协商取消 61验货不通过 -1用户取消]
  static String afterStatusName(int status){
    String name;
    switch(status){
      case 10:
        name = "申请中";
        break;
      case 30:
        name = "审核通过";
        break;
      case 34:
        name ="审核不通过";
        break;
      case 35:
        name = "已退货";
        break;
      case 40:
        name = "已收到退货";
        break;
      case 50:
        name="退货已完成";
        break;
      case 60:
        name="已协商取消";
        break;
      case 61:
        name="验货不通过";
        break;
      case -1:
        name="退货已取消";
        break;
    }
    return name;
  }

  /// 星期转换
  static String formatWeekday(int weekday){
    switch(weekday){
      case 1:
        return "星期一";
        break;
      case 2:
        return "星期二";
        break;
      case 3:
        return "星期三";
        break;
      case 4:
        return "星期四";
        break;
      case 5:
        return "星期五";
        break;
      case 6:
        return "星期六";
        break;
      case 7:
        return "星期日";
        break;
    }
  }

  /// 月份转换
  static String formatMonth(int month){
    switch(month){
      case 1:
        return "JAN";
        break;
      case 2:
        return "FEB";
        break;
      case 3:
        return "MAR";
        break;
      case 4:
        return "APR";
        break;
      case 5:
        return "MAY";
        break;
      case 6:
        return "JUN";
        break;
      case 7:
        return "JUL";
        break;
      case 8:
        return "AUG";
        break;
      case 9:
        return "SEP";
        break;
      case 10:
        return "OCT";
        break;
      case 11:
        return "NOV";
        break;
      case 12:
        return "DEC";
        break;
    }
  }

  /// 获取时分
  static String formatTimes(String times){
    String str = times.split(" ")[1];
    return str.substring(0,str.length-3);
  }

  /// 活动状态
  static String activityStatus(int status){
    //0 未开始 1进行中 2已结束 4已取消
    String str="";
    switch(status){
      case 0:
        str= "未开始";
        break;
      case 1:
        str= "进行中";
        break;
      case 2:
        str= "已结束";
        break;
      case 4:
        str= "已取消";
        break;
    }
    return str;
  }

}