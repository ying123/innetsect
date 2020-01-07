import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:innetsect/api/loading.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/draw/draw_data.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/draw/draw_provide.dart';
import 'package:innetsect/view/widget/loading_state_widget.dart';
import 'package:provide/provide.dart';
import 'package:flutter_baidu_map/flutter_baidu_map.dart';

///抽签
class DrawPage extends PageProvideNode {
  final DrawProvide _provide = DrawProvide();
  final Map redirectParam;
  DrawPage({this.redirectParam}) {
    mProviders.provide(Provider<DrawProvide>.value(_provide));
    print('redirectParam========>${redirectParam['redirectParam']}');
   _provide.redirectParamId = int.parse(redirectParam['redirectParam']);
  }
  @override
  Widget buildContent(BuildContext context) {
    return DrawPageContentPage(_provide);
  }
}

class DrawPageContentPage extends StatefulWidget {
  final DrawProvide provide;
  DrawPageContentPage(this.provide);
  @override
  _DrawPageContentPageState createState() => _DrawPageContentPageState();
}

class _DrawPageContentPageState extends State<DrawPageContentPage> {
  DrawProvide provide;
  LoadState _loadState = LoadState.State_Loading;
  @override
  void initState() {
    super.initState();
    provide ??= widget.provide;
     /// 百度定位
     FlutterBaiduMap.setAK("Q07ulrG0wmUGKcKwtN6ChlafT8eBuEkX");
      _baiduLocation().then((item){

      print("_baidu========${item.latitude}");
      print("_baidu========${item.longitude}");
    });
     _loadDrawInfo();
  }

   /// 百度定位
  Future _baiduLocation() async{
    BaiduLocation location = await FlutterBaiduMap.getCurrentLocation();
    print("location.locationDescribe======${location.locationDescribe}");
    print("location.latitude======${location.latitude}");
    print("location.longitude======${location.longitude}");
  //  provide.longitude = location.longitude;
  //  provide.latitude = location.latitude;

    return location;
  }
  _loadDrawInfo() {
    provide.draws().doOnListen(() {}).listen((items) {
      print('items.data====> ${items.data}');
      if (items.data != null) {
        provide.drawsModel = DrawsModel.fromJson(items.data);
        print('steps=====>${provide.drawsModel.steps.length}');
        print('shops=====>${provide.drawsModel.shops.length}');
        print('pics====>${provide.drawsModel.pics.length}');
        setState(() {
          _loadState = LoadState.State_Success;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
       
        title: Text('抽签'),
        centerTitle: true,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
            size: ScreenAdapter.size(60),
          ),
        ),
      ),
      body: LoadStateLayout(
        state: _loadState,
        loadingContent: '加载中...',
        successWidget: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            _setupBody(),
            //  Center(
            //   child: Container(
            //     width: ScreenAdapter.width(680),
            //     height: ScreenAdapter.height(1),
            //     color: Colors.black12,
            //   ),
            // ),
            _setupHead(),
            SizedBox(
              height: ScreenAdapter.height(20),
            ),
             Center(
              child: Container(
                width: ScreenAdapter.width(680),
                height: ScreenAdapter.height(1),
                color: Colors.black38,
              ),
            ),
            _setupEnd(),
            _setupActivityIsIntroduced()
          ],
        ),
      ),
      )
    );
  }

  Provide<DrawProvide> _setupHead() {
    return Provide<DrawProvide>(
      builder: (BuildContext context, Widget child, DrawProvide provide) {
        return Container(
          color: Colors.white,
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenAdapter.width(680),
                child: Center(
                  child: Text(provide.drawsModel.drawName,
                  textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenAdapter.size(37),
                          fontWeight: FontWeight.w800)),
                ),
              ),
              Expanded(
                child: Container(

                ),
              ),
              Container(
                width: ScreenAdapter.width(680),
                child: Center(
                  child: Text(
                    '${provide.drawsModel.startTime}至${provide.drawsModel.endTime}',style: TextStyle(
                      fontSize: ScreenAdapter.size(30),color: Color.fromRGBO(159, 177, 189, 1.0),
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(

                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Provide<DrawProvide> _setupBody() {
    return Provide<DrawProvide>(
      builder: (BuildContext context, Widget child, DrawProvide provide) {
        return Column(
          children: <Widget>[
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(360),
              color: Colors.white,
              child: Center(
                child: Container(
                  width: ScreenAdapter.width(695),
                  height: ScreenAdapter.height(360),
                  child: Image.network(
                    provide.drawsModel.drawPic,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: ScreenAdapter.height(50),
            ),
            // Center(
            //   child: Container(
            //     width: ScreenAdapter.width(695),
            //     height: ScreenAdapter.height(1),
            //     color: Colors.black12,
            //   ),
            // )
          ],
        );
      },
    );
  }

  Provide<DrawProvide> _setupEnd() {
    return Provide<DrawProvide>(
      builder: (BuildContext context, Widget child, DrawProvide provide) {
        return ListView.builder(
          itemCount: provide.drawsModel.shops.length,
          shrinkWrap: true,
          primary: false,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: ScreenAdapter.height(40)),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(135),
              child: InkWell(
                onTap: () {
                  print('北京被点击');
                  // Navigator.pushNamed(context, '/drawDetailsPage',arguments: {
                  //   'shopID':provide.drawsModel.shops[index].shopID
                  // });
                  if (AppConfig.userTools.getUserToken() == '') {
                    Navigator.pushNamed(context, '/loginPage');
                  }

                  Navigator.pushNamed(context, '/endOfTheDrawPage',arguments: {
                   'pics': provide.drawsModel.pics,
                   'shops':provide.drawsModel.shops[index],
                   'longitude':provide.longitude,
                   'latitude':provide.latitude
                  });
                },
                child: Center(
                  child: Container(
                    width: ScreenAdapter.width(695),
                    height: ScreenAdapter.height(95),
                    // margin: EdgeInsets.only(bottom: ScreenAdapter.height(40)),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54)),
                    child: Center(
                      child: Text(
                        provide.drawsModel.shops[index].shopName,
                        style: TextStyle(
                            fontSize: ScreenAdapter.size(30),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
  
  Provide<DrawProvide> _setupActivityIsIntroduced() {
    return Provide<DrawProvide>(
      builder: (BuildContext context, Widget child, DrawProvide provide) {
        return Column(
          children: <Widget>[
            //  Center(
            //   child: Container(
            //     width: ScreenAdapter.width(680),
            //     height: ScreenAdapter.height(1),
            //     color: Colors.black12,
            //   ),
            // ),
            SizedBox(
              height: ScreenAdapter.height(20),
            ),
//            Container(
//              width: ScreenAdapter.width(680),
//              child: Text(
//                '活动介绍',
//                style: TextStyle(fontSize: ScreenAdapter.size(35)),
//              ),
//            ),
            SizedBox(
              height: ScreenAdapter.height(48),
            ),
            
            // Container(
            //   width: ScreenAdapter.width(680),
            //   child: Html(
            //     data: provide.drawsModel.drawRule,
            //   ),
            // ),
          ],
        );
      },
    );
  }

}
