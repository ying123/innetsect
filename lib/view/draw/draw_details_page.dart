import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/draw/draw_data.dart';
import 'package:innetsect/data/draw/lottery_registration_page.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/draw/draw_details_provide.dart';
import 'package:innetsect/view/widget/loading_state_widget.dart';
import 'package:provide/provide.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

///抽签详情
class DrawDetailsPage extends PageProvideNode {
  final Map shopID;
  final DrawDetailsProvide _provide = DrawDetailsProvide();
  DrawDetailsPage({this.shopID}) {
    mProviders.provide(Provider<DrawDetailsProvide>.value(_provide));
    _provide.shopID = shopID['shopID'];
  }
  @override
  Widget buildContent(BuildContext context) {
    return DrawDetailsContentPage(_provide);
  }
}

class DrawDetailsContentPage extends StatefulWidget {
  final DrawDetailsProvide provide;
  DrawDetailsContentPage(this.provide);
  @override
  _DrawDetailsContentPageState createState() => _DrawDetailsContentPageState();
}

class _DrawDetailsContentPageState extends State<DrawDetailsContentPage> {
  DrawDetailsProvide provide;
  LoadState _loadState = LoadState.State_Loading;
  @override
  void initState() {
    super.initState();
    provide ??= widget.provide;
    _loadDrawInfo();
    _loadLotteryRegistrationPage();
    
  }
  _loadLotteryRegistrationPage(){
    provide.lotteryRegistrationPage().doOnListen((){

    }).doOnError((e,stack){

    }).listen((items){
      print('_loadLotteryRegistrationPageItems.data${items.data}');
      if (items!=null) {
        provide.lotteryRegistrationPageModel = LotteryRegistrationPageModel.fromJson(items.data);
      }
    });
  }

  _loadDrawInfo(){
    provide.draws().doOnListen((){

    }).doOnError((e,stack){

    }).listen((items){
      if (items != null) {
        provide.drawsModel = DrawsModel.fromJson(items.data);
        
        setState(() {
          _loadState = LoadState.State_Success;
        });
      }
    },onError: (e){
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        successWidget: Column(
        children: <Widget>[
          _setupHead(),
          _setupBody(),
          _setupEnd(),
        ],
      ),
      )
    );
  }

  Provide<DrawDetailsProvide> _setupHead() {
    return Provide<DrawDetailsProvide>(
      builder:
          (BuildContext context, Widget child, DrawDetailsProvide provide) {
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(360),
          color: Colors.white,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                provide.drawsModel.pics[index].picUrl,
                fit: BoxFit.fill,
              );
            },
            itemCount: provide.drawsModel.pics.length,
            viewportFraction: 0.8,
            scale: 0.9,
          ),
        );
      },
    );
  }

  Provide<DrawDetailsProvide> _setupBody() {
    return Provide<DrawDetailsProvide>(
      builder:
          (BuildContext context, Widget child, DrawDetailsProvide provide) {
            for (var item in provide.drawsModel.shops) {
              if (item.shopID == provide.shopID) {
                  provide.model = item;
                  print('item====>${item.shopID}');
                  print('provide====>${provide.shopID}');
              }
            }
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(560),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: ScreenAdapter.height(50),
              ),
              Center(
                child: Text(
                  provide.drawsModel.drawName,
                  style: TextStyle(
                      fontSize: ScreenAdapter.size(40),
                      fontWeight: FontWeight.w600),
                ),
              ),
              // Center(
              //   child: Text(
              //     '抽签资格',
              //     style: TextStyle(
              //         fontSize: ScreenAdapter.size(40),
              //         fontWeight: FontWeight.w600),
              //   ),
              // ),
              SizedBox(
                height: ScreenAdapter.height(30),
              ),
              Center(
                child: Text(
                  '${provide.model.shopName}    |   ￥${provide.drawsModel.drawProdPrice}',
                  style: TextStyle(
                      color: Color.fromRGBO(167, 166, 171, 1.0),
                      fontSize: ScreenAdapter.size(30),
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: ScreenAdapter.height(30),
              ),
              Center(
                child: Text(
                  '${provide.drawsModel.endTime}  截止登记',
                  style: TextStyle(
                      fontSize: ScreenAdapter.size(30),
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: ScreenAdapter.height(70),
              ),
              Center(
                child: Container(
                  width: ScreenAdapter.width(680),
                  height: ScreenAdapter.height(1),
                  color: Colors.black12,
                ),
              ),
              Container(
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(170),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: ScreenAdapter.width(50),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: ScreenAdapter.width(18),
                              height: ScreenAdapter.width(18),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(202, 202, 202, 1.0),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenAdapter.width(10)))),
                              child: Center(
                                child: Container(
                                  width: ScreenAdapter.width(8),
                                  height: ScreenAdapter.width(8),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(152, 152, 160, 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenAdapter.width(10)))),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: ScreenAdapter.width(10),
                            ),
                            Text(
                              'STEP 1',
                              style: TextStyle(
                                  color: Color.fromRGBO(150, 150, 150, 1.0)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenAdapter.height(10),
                        ),
                        Text(
                          '登记信息',
                          style: TextStyle(
                              color: Color.fromRGBO(150, 150, 150, 1.0),
                              fontSize: ScreenAdapter.size(30)),
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: ScreenAdapter.width(18),
                              height: ScreenAdapter.width(18),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(202, 202, 202, 1.0),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenAdapter.width(10)))),
                              child: Center(
                                child: Container(
                                  width: ScreenAdapter.width(8),
                                  height: ScreenAdapter.width(8),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(152, 152, 160, 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenAdapter.width(10)))),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: ScreenAdapter.width(10),
                            ),
                            Text(
                              'STEP 1',
                              style: TextStyle(
                                  color: Color.fromRGBO(150, 150, 150, 1.0)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenAdapter.height(10),
                        ),
                        Text(
                          '等待结果',
                          style: TextStyle(
                              color: Color.fromRGBO(150, 150, 150, 1.0),
                              fontSize: ScreenAdapter.size(30)),
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: ScreenAdapter.width(18),
                              height: ScreenAdapter.width(18),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(202, 202, 202, 1.0),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenAdapter.width(10)))),
                              child: Center(
                                child: Container(
                                  width: ScreenAdapter.width(8),
                                  height: ScreenAdapter.width(8),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(152, 152, 160, 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenAdapter.width(10)))),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: ScreenAdapter.width(10),
                            ),
                            Text(
                              'STEP 1',
                              style: TextStyle(
                                  color: Color.fromRGBO(150, 150, 150, 1.0)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenAdapter.height(10),
                        ),
                        Text(
                          '线下够买',
                          style: TextStyle(
                              color: Color.fromRGBO(150, 150, 150, 1.0),
                              fontSize: ScreenAdapter.size(30)),
                        )
                      ],
                    ),
                    SizedBox(
                      width: ScreenAdapter.height(70),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: ScreenAdapter.width(680),
                  height: ScreenAdapter.height(1),
                  color: Colors.black12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Provide<DrawDetailsProvide> _setupEnd() {
    return Provide<DrawDetailsProvide>(
      builder:
          (BuildContext context, Widget child, DrawDetailsProvide provide) {
        return Column(
          children: <Widget>[
            Center(
              child: Container(
                alignment: Alignment.centerLeft,
                width: ScreenAdapter.width(680),
                height: ScreenAdapter.height(130),
                child: Text(
                  '中奖名单',
                  style: TextStyle(fontSize: ScreenAdapter.size(30)),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                if (provide.model.drawStatus == 0) {//登记
                  Navigator.pushNamed(context, '/registrationInformationPage',
                  arguments: {'model':provide.model,
                              'drawsModel':provide.drawsModel });
                }else if (provide.model.drawStatus == 1) {
                  Navigator.pushNamed(context, '/drawRegisteredPage');
                }else if (provide.model.drawStatus == 2) {
                  Navigator.pushNamed(context, '/endOfTheDrawPage');
                }
                
              },
              child: Container(
                width: ScreenAdapter.width(680),
                height: ScreenAdapter.height(90),
                color: Colors.black,
                child: Center(
                  child: Text(
                    provide.registrationStatus == 0
                        ? '查看登记'
                        : provide.registrationStatus == 1 ? '登记' : "结束",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenAdapter.size(30),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
