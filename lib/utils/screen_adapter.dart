import 'package:flutter_screenutil/flutter_screenutil.dart';

///屏幕适配
class ScreenAdapter {
  static init(context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
  }

  /// 根据设计稿的设备高度适配
  static height(double value) {
    return ScreenUtil.getInstance().setHeight(value);
  }

  ///根据设计稿的设备宽度适配
  static width(double value) {
    return ScreenUtil.getInstance().setWidth(value);
  }

  ///当前设备高度 dp
  static getScreenHeight() {
    return ScreenUtil.screenHeightDp;
  }

  ///当前设备宽度 dpscreen_adapter
  static getScreenWidth() {
    return ScreenUtil.screenWidthDp;
  }

  ///当前设备高度 px
  static getScreenPxHeight() {
    return ScreenUtil.screenHeight;
  }

  ///当前设备宽度 px
  static getScreenPxWidth() {
    return ScreenUtil.screenWidth;
  }
///字体大小适配方法
  ///@param fontSize 传入设计稿上字体的px ,
  ///@param allowFontScaling 控制字体是否要根据系统的“字体大小”辅助选项来进行缩放。默认值为false。
  ///@param allowFontScaling Specifies whether fonts should scale to respect Text Size accessibility settings. The default is false.
  static size(double value){
   return ScreenUtil.getInstance().setSp(value);  
  }
}
