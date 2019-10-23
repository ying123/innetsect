

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
  /// 主视觉颜色,黄色
  static final primaryColor = Color.fromRGBO(247, 235, 68, 1.0);
  /// 辅助线颜色，灰色
  static final assistLineColor = Color.fromRGBO(234, 234, 234, 1.0);
  /// 辅助颜色，红色
  static final assistColor = Color.fromRGBO(220, 67, 26, 1.0);
  /// 主要文字，黑色
  static final fontBackColor = Color.fromRGBO(25, 25, 25, 1.0);
  /// 辅助描述或未选中文字，淡灰色
  static final assistFontColor = Color.fromRGBO(197, 197, 197, 1.0);
  /// 背景色，浅灰色
  static final backGroundColor = Color.fromRGBO(249, 249, 249, 1.0);

  static UserTools userTools;
  static init()async{
    userTools = await UserTools.getInstance();
  }
}

class Constants {
  static const IconFontFamily = "appIconFont";
  static const ConversationAvatarSize = 48.0;
  ///分割线宽度
  static const DividerWidth = 0.5;
  static const UnReadMsgNotifyDotSize = 20.0;
  static const ConversationMuteIcon = 18.0;
  ///头像大小
  static const ContactAvatarSize = 36.0;
  static const IndexBarWidth = 24.0;
  static const IndexLetterBoxSize = 114.0;
  static const IndexLetterBoxRadius = 4.0;
  static const FullWidthIconButtonIconSize = 24.0;
  static const ProfileHeaderIconSize = 60.0;

  static const ConversationAvatarDefaultIocn = Icon(
    IconData(
      0xe642,
      fontFamily: IconFontFamily,
    ),
    size: ConversationAvatarSize,
  );

  static const ContactAvatarDefaultIocn = Icon(
    IconData(
      0xe642,
      fontFamily: IconFontFamily,
    ),
    size: ContactAvatarSize,
  );

  static const ProfileAvatarDefaultIocn = Icon(
    IconData(
      0xe642,
      fontFamily: IconFontFamily,
    ),
    size: ProfileHeaderIconSize,
  );

}

class AppColors {
  static const BackgroundColor = 0xffebebeb;
  static const AppBarColor = 0xff303030;
  static const TabIconNormal = 0xff999999;
  static const TabIconActive = 0xff46c11b;
  static const AppBarPopupMenuColor = 0xffffffff;
  static const TitleColor = 0xff353535;
  static const ConversationItemBgColor = 0xffffffff;
  static const DescTextColor = 0xff9e9e9e;
  static const DividerColor = 0xffd9d9d9;
  static const NotifyDotBgColor = 0xffff3e3e;
  static const NotifyDotText = 0xffffffff;
  static const ConversationMuteIconColor = 0xffd8d8d8;
  static const DeviceInfoItemBgColor = 0xfff5f5f5;
  static const DeviceInfoItemTextColor = 0xff606062;
  static const DeviceInfoItemIconColor = 0xff606062;
  static const ContactGroupTitleBgColor = 0xffebebeb;
  static const ContactGroupTitleColor = 0xff888888;
  static const IndexLetterBoxBgColor = Colors.black45;

}

class AppStyles {
  static const TitleStyle = TextStyle (
    fontSize: 14.0,
    color: Color(AppColors.TitleColor),
  );

  static const DescStyle = TextStyle(
    fontSize: 12.0,
    color: Color(AppColors.DescTextColor),
  );
  static const UnreadMsgCountDotStyle = TextStyle(
    fontSize: 12.0,
    color: Color(AppColors.NotifyDotText),
  );

  static const DeviceInfoItemTextStyle = TextStyle(
    fontSize: 13.0,
    color: Color(AppColors.DeviceInfoItemTextColor),
  );
  static const GroupTitleItemTextStyle = TextStyle(
    color: Color(AppColors.ContactGroupTitleColor),
    fontSize: 14.0
  );

  static const IndexLetterBoxTextStyle = TextStyle(
    fontSize: 64.0,
    color: Colors.white, 
  );
}
