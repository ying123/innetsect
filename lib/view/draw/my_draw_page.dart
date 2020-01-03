//我的抽签

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/draw/my_draw_data.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/draw/my_draw_provide.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:innetsect/view/widget/loading_state_widget.dart';
import 'package:provide/provide.dart';
import 'package:flutter/material.dart';

class MyDrawPage extends PageProvideNode {
  final MyDrawProvide _provide = MyDrawProvide();
  MyDrawPage() {
    mProviders.provide(Provider<MyDrawProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    return MyDrawContentPage(_provide);
  }
}

class MyDrawContentPage extends StatefulWidget {
  final MyDrawProvide provide;
  MyDrawContentPage(this.provide);
  @override
  _MyDrawContentPageState createState() => _MyDrawContentPageState();
}

class _MyDrawContentPageState extends State<MyDrawContentPage> {
  MyDrawProvide provide;
  LoadState _loadState = LoadState.State_Loading;
  //控制器
  EasyRefreshController _controller;
  //分页
  int pageNo = 1;
  @override
  void initState() {
    super.initState();
    provide ??= widget.provide;
    _loadMyDrawData(pageNo: pageNo);
  }

  _loadMyDrawData({int pageNo}) {
    provide
        .myDrawData(pageNo, 8)
        .doOnListen(() {})
        .doOnError((e, stack) {})
        .doOnDone(() {})
        .listen((items) {
      print('===============>${items.data}');
      if (items.data != null) {
        provide.addDataModel(MyDrawDataModelList.fromJson(items.data).list);
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
          title: Text('我的抽签'),
          elevation: 0.0,
          centerTitle: true,
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
        body: new LoadStateLayout(
          state: _loadState,
          loadingContent: '加载中...',
          successWidget: ListWidgetPage(
            controller: _controller,
            onRefresh: () async {
              print('onRefresh');
              setState(() {
                _loadState = LoadState.State_Loading;
              });
              pageNo = 1;
              provide.clearMyDrawDataModel();
              _loadMyDrawData(pageNo: pageNo);
            },
            onLoad: () async {
              print('onLoad');
              // setState(() {
              //   _loadState = LoadState.State_Loading;
              // });
              pageNo++;
              _loadMyDrawData(pageNo: pageNo);
            },
            child: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  _setUpMyDrawDataList(),
                ]),
              )
            ],
          ),
        ));
  }

  Provide<MyDrawProvide> _setUpMyDrawDataList() {
    return Provide<MyDrawProvide>(
      builder: (BuildContext context, Widget child, MyDrawProvide provide) {
        return ListView.builder(
          itemCount: provide.dataModel.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: <Widget>[
                Container(
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(305),
                  child: InkWell(
                    onTap: (){
                      print(index);
                      Navigator.pushNamed(context, '/myDrawInfoPage',arguments: {
                        'myDrawDataModel':provide.dataModel[index]
                      });
                    },
                    child: Center(
                      child: Container(
                        width: ScreenAdapter.width(690),
                        height: ScreenAdapter.height(305),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black12))),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: ScreenAdapter.width(210),
                              height: ScreenAdapter.width(210),
                              child: Image.network(
                                provide.dataModel[index].drawPic,
                                fit: BoxFit.cover,
                                width: ScreenAdapter.width(210),
                                height: ScreenAdapter.height(210),
                              ),
                            ),
                            SizedBox(
                              width: ScreenAdapter.width(40),
                            ),
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  height: ScreenAdapter.height(40),
                                ),
                                Container(
                                  width: ScreenAdapter.width(418),
                                  height: ScreenAdapter.height(98),
                                  child: Text(
                                    provide.dataModel[index].drawName,
                                    style: TextStyle(
                                        fontSize: ScreenAdapter.size(35),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenAdapter.height(30),
                                ),
                                Container(
                                  width: ScreenAdapter.width(418),
                                  child: Text(
                                    '登记时间:',
                                    style: TextStyle(
                                        fontSize: ScreenAdapter.size(30),
                                        color: Color.fromRGBO(153, 151, 158, 1.0),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenAdapter.height(10),
                                ),
                                Container(
                                  width: ScreenAdapter.width(418),
                                  child: Text(
                                    provide.dataModel[index].registerDate,
                                    style: TextStyle(
                                        fontSize: ScreenAdapter.size(30),
                                        color: Color.fromRGBO(153, 151, 158, 1.0),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: ScreenAdapter.width(560),
                  top: ScreenAdapter.height(90),
                  child: Container(
                    width: ScreenAdapter.width(160),
                    height: ScreenAdapter.width(160),
                    child: provide.dataModel[index].status == 1
                        ? Image.asset(//以中签
                            'assets/images/mall/中签大.png')
                        : provide.dataModel[index].status == 0
                            ? Container() //已登记
                            : provide.dataModel[index].status == 2
                                ? Container() //已使用
                                : provide.dataModel[index].status == -1
                                    ? Container() //未中签
                                    : Container(), //其他
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
