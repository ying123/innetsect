import 'dart:io';

import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:innetsect/app.dart';

import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/res/const_defines.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:innetsect/utils/common_util.dart';
import 'package:innetsect/view/router/router.dart';
import 'package:innetsect/res/strings.dart';

import 'package:rammus/rammus.dart' as rammus;


GlobalKey<NavigatorState> gNavKey = GlobalKey();
//List<CameraDescription> gCameras;

void main() async {
  ///[ensureInitialized]确保初始化不出现异常
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.init(); //初始化App配置文件
  //CommonUtil.hideStatusbarEasy();
  //获取camama列表
  // 获取camama列表
  // try {
  //   gCameras = await availableCameras();
  // } on CameraException catch (e) {
  //   //logError(e.code, e.description);
  // }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

/// WidgetsBindingObserver 监控当前app是否在前台
class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // 语言包
  Locale locale = null;
  String _deviceId = "Unknown device";

  static final CHANNEL_FLUTTER_to_ANDROID = "channel_flutter2android";
  var m_channel_flutter2android = MethodChannel(CHANNEL_FLUTTER_to_ANDROID);

  static const platform =
      const MethodChannel("myflutterhelo.flutter.io/android");
  static const EventChannel eventChannel =
      const EventChannel('com.myflutterhelo.test/netChanged');

  var netChangeStr = "点我获取当前网络状态";

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      if (AppLifecycleState.resumed == state) {
      } else {}
    });
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
        SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        );
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    //配置简单多语言资源
    // setLocalizedSimpleValues(localizedSimpleValues);
    setLocalizedValues(localizedValues);
    //初始化配置文件
    initLocale();

    // 配置阿里推送
//    initPlatformState();
    rammus.setupNotificationManager(name: "innerset",id: "innetsect push");
//    rammus.initCloudChannelResult.listen((data){
//      print("----------->init successful ${data.isSuccessful} ${data.errorCode} ${data.errorMessage}");
//    });

    rammus.onNotification.listen((data){
      print("----------->notification here ${data.summary}");
      print("----------->device here $_deviceId");

    });
    rammus.onNotificationOpened.listen((data){
      print("-----------> ${data.summary} 被点了");

    });

    rammus.onNotificationClickedWithNoAction.listen((data){
      print("${data.summary} no action");

    });

  }

//  Future<void> initPlatformState() async {
//    String deviceId;
//    try {
//      deviceId = await rammus.deviceId;
//    } on PlatformException {
//      deviceId = 'Failed to get device id.';
//    }
//    if (!mounted) return;
//    setState(() {
//      _deviceId = deviceId;
//      //接下来你要做的事情
//      //1.将device id通过接口post给后台，然后进行指定设备的推送
//      //2.推送的时候，在Android8.0以上的设备都要设置通知通道
//    });
//  }

  void initLocale() async {
    if (!mounted) {
      return;
    }

    // set_locale('en', 'US');
//加载语言包
    loadLocale();
  }

  // 加载或者设置语言， 配置写在sharepreferrence里
  void loadLocale() {
    setState(() {
      // 从配置文件读取配置
      String country =
          AppConfig.userTools.getIniCountry(ConstDefines.ini_country);
      print('country$country');
      String language =
          AppConfig.userTools.getIniLanguage(ConstDefines.ini_language);
      print('language$language');
      locale = Locale('ini_country', 'ini_language');
      // if (country.isNotEmpty && language.isNotEmpty) {
      //   m_locale = Locale('ini_country', 'ini_language');
      // }
      // else {
      //   m_locale = null;
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        CustomLocalizations.delegate //设置本地化代理
      ],
      supportedLocales: CustomLocalizations.supportedLocales, //设置支持本地化语言集合
      locale: locale,

      title: CommonUtil.appTitle,
      theme: ThemeData(
        primaryColor: AppConfig.themedata.primaryColor,
        accentColor: AppConfig.themedata.accentColor,
      ),
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
      localeResolutionCallback:(deviceLocale, supportedLocales) {
        UserTools().setLocal(deviceLocale.toString());
//        return locale;
      },
      home: App(),

      //navigatorKey: gNavKey,
    );
  }
}
