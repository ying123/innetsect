import 'dart:convert';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:innetsect/app.dart';

import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/res/const_defines.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:innetsect/utils/common_util.dart';
import 'package:innetsect/view/mall/mall_page.dart';
import 'package:innetsect/view/router/router.dart';
import 'package:innetsect/res/strings.dart';
import 'package:innetsect/view/user_instructions_page.dart';
//import 'package:intent/intent.dart';

import 'package:rammus/rammus.dart' as rammus;
//import 'package:intent/intent.dart' as android_intent;
//import 'package:intent/action.dart' as android_action;


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

  static GlobalKey<NavigatorState> navigatorState = new GlobalKey();
  // app是否前后台
  bool _isApp = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    setState(() {
      if(AppLifecycleState.resumed == state){
        _isApp = false;
      }
      if (AppLifecycleState.paused == state){
        _isApp = true;
      }
    });

  }

  @override
  void initState() {
    super.initState();
    
    /// 百度定位
    // _baiduLocation().then((item){

    //   print("_baidu========${item.latitude}");
    //   print("_baidu========${item.longitude}");
    // });

    WidgetsBinding.instance.addObserver(this);

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
      print("----->>>>------>notification here ${data.summary}");
      print("data----->>>>------>notification here ${data.toString()}");
      print("----------->device here $_deviceId");

    });
    rammus.onNotificationOpened.listen((data){
      print(data);
      print('======================================>onNotificationOpened===>${data.extras}');
      print("-----------> ${data.summary} 被点了");
      //{"redirectType":"PRODUCT_DETAIL",
      // "redirectTo":"\/eshop\/{shop}\/products\/{id}",
      // "_ALIYUN_NOTIFICATION_PRIORITY_":"1",
      // "redirectParam":"37:18161",
      // "_ALIYUN_NOTIFICATION_ID_":"760988"}
//      if(_bannersList[index].redirectType==ConstConfig.URL){
//        /// 跳转URL
//        Navigator.push(context, MaterialPageRoute(
//            builder: (context){
//              return new WebView(url: _bannersList[index].redirectParam,);
//            }
//        ));
//      }

      if(_isApp){
//        final AndroidIntent intent = AndroidIntent(
//          action: 'action_main',
//          package: "com.example.innetsect",
//        );
//        intent.launch();
        // android_intent.Intent()
        //   ..setAction(android_action.Action.ACTION_MAIN)
        //     ..startActivity();
      }

      var json = jsonDecode(data.extras);

      if(json['redirectType']==ConstConfig.PRODUCT_DETAIL){
        /// 跳转商品详情
        List list = json['redirectParam'].split(":");
        _openApp(redirectType: ConstConfig.PRODUCT_DETAIL,
            types:int.parse(list[0]) ,
            prodID: int.parse(list[1]));
      }else if(json['redirectType']==ConstConfig.CONTENT_DETAIL){
        /// 跳转资讯详情
        _openApp(redirectType: ConstConfig.CONTENT_DETAIL,
            contentID: int.parse(json['redirectParam']));
      }else if(json['redirectType']==ConstConfig.PROMOTION){
        _openApp(redirectType: ConstConfig.PROMOTION,code:json['redirectParam']);

      }else if(json['redirectType'] == "DRAW_WINNER"){
         List list = json['redirectParam'].split(":");
       // _openApp(redirectType: ConstConfig.DRAW)
       
       Navigator.pushNamed(context,"/myDrawInfoPage", arguments: {
         'drawID':int.parse(list[0]),
         'shopID':int.parse(list[1]),
       });
      }
//      else if(_bannersList[index].redirectType==ConstConfig.PROMOTION){
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
     /// print("============================》${data.summary} no action");
     print('============================》onNotificationClickedWithNoAction');
     print("============================》${data.extras} no action");

    });

  }

  void _openApp({
    String redirectType,
    int types, int prodID,
    int contentID,String code
  }) {
    navigatorState.currentState.pushAndRemoveUntil(new MaterialPageRoute(
        builder: (ctx) => new MallPage(
          redirectType: redirectType,
          types: types ,
          prodID: prodID,
          contentID: contentID,
          code: code,
        )), (Route<dynamic> route) => false);
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
     //rammus.bindTag(target: rammus.CloudPushServiceTarget.DEVICE_TARGET,
    // tags: [deviceId],alias:deviceId);
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
      navigatorKey: navigatorState,
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
      initialRoute: '/', //  AppConfig.userTools.getAppNumber() !='1'?'/userInstructionsPage':'/',
      onGenerateRoute: onGenerateRoute,
      localeResolutionCallback:(deviceLocale, supportedLocales) {
        UserTools().setLocal(deviceLocale.toString());
//        return locale;
      },
      home:AppConfig.userTools.getAppNumber() !='666'? UserInstructionsPage():App()

      //navigatorKey: gNavKey,
    );
  }
}