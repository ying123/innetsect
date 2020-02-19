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
import 'package:flutter_baidu_map/flutter_baidu_map.dart';
import 'package:innetsect/view/user_instructions_page.dart';

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
  /// 强制竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  // FlutterBaiduMap.setAK("Q07ulrG0wmUGKcKwtN6ChlafT8eBuEkX");
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
    
    /// 百度定位
    // _baiduLocation().then((item){

    //   print("_baidu========${item.latitude}");
    //   print("_baidu========${item.longitude}");
    // });



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
    initPlatformState();
    rammus.setupNotificationManager(name: "innerset",id: "innetsect push");

    rammus.onNotification.listen((data){
      print("----------->notification here ${data.summary}");
      print("----------->device here $_deviceId");

    });
    rammus.onNotificationOpened.listen((data){
      print(data);
      print("-----------> ${data.summary} 被点了");
//      if(_bannersList[index].redirectType==ConstConfig.URL){
//        /// 跳转URL
//        Navigator.push(context, MaterialPageRoute(
//            builder: (context){
//              return new WebView(url: _bannersList[index].redirectParam,);
//            }
//        ));
//      }
      /// 跳转商品详情
//      if(_bannersList[index].redirectType==ConstConfig.PRODUCT_DETAIL){
//        List list = _bannersList[index].redirectParam.split(":");
//        _commodityDetail(types:int.parse(list[0]) ,prodID: int.parse(list[1]));
//      }else if(_bannersList[index].redirectType==ConstConfig.PROMOTION){
//        /// 跳转集合搜索列表
//        _searchRequest(_bannersList[index].redirectParam);
//      }else if(_bannersList[index].redirectType==ConstConfig.CONTENT_DETAIL){
//        /// 跳转资讯详情
//        _informationProvide.contentID =int.parse(_bannersList[index].redirectParam) ;
//        Navigator.push(context, MaterialPageRoute(
//            builder: (context){
//              return new InforWebPage();
//            }
//        ));
//      }else else if(_bannersList[index].redirectType == ConstConfig.ACTIVITY){
//        Navigator.push(context, MaterialPageRoute(
//            builder: (context){
//              return ActivityDetailPage(activityID: int.parse(_bannersList[index].redirectParam),);
//            }
//        ));
//      }

    });

    rammus.onNotificationClickedWithNoAction.listen((data){
      print("${data.summary} no action");

    });

  }

  /// 百度定位
  // Future _baiduLocation() async{
  //   BaiduLocation location = await FlutterBaiduMap.getCurrentLocation();
  //   print("location.locationDescribe======${location.locationDescribe}");
  //   print("location.latitude======${location.latitude}");
  //   print("location.longitude======${location.longitude}");
  //   return location;
  // }

  Future<void> initPlatformState() async {
    try {
     String deviceId =  await rammus.deviceId;
     print("deviceId=======>>>>$deviceId");
     //c9095149f890469194cd31338cf9d80b
     rammus.bindAccount(deviceId);
     rammus.bindTag(target: rammus.CloudPushServiceTarget.DEVICE_TARGET,
     tags: [deviceId],alias:deviceId);
    } on PlatformException {
    }

  }

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
        backgroundColor: AppConfig.assistLineColor,
      ),
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
      localeResolutionCallback:(deviceLocale, supportedLocales) {
        UserTools().setLocal(deviceLocale.toString());
//        return locale;
      },
      home:AppConfig.userTools.getAppNumber() !='1'? UserInstructionsPage():App(),

      //navigatorKey: gNavKey,
    );
  }
}
