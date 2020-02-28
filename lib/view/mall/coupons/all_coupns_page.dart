import 'dart:ui';

import 'package:innetsect/base/base.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/coupons/all_coupns_provide.dart';

import 'package:innetsect/view/mall/coupons/hj_expansion_tile_.dart';
import 'package:provide/provide.dart';
import 'package:extended_text/extended_text.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class AllCoupnsPage extends PageProvideNode {
  final AllCoupnsProvide _provide = AllCoupnsProvide();
  final int index;
  AllCoupnsPage(this.index) {
    mProviders.provide(Provider<AllCoupnsProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    return AllCoupnsContentPage(_provide, index);
  }
}

class AllCoupnsContentPage extends StatefulWidget {
  final AllCoupnsProvide _provide;
  final int index;
  AllCoupnsContentPage(this._provide, this.index);
  @override
  _AllCoupnsContentPageState createState() => _AllCoupnsContentPageState();
}

class _AllCoupnsContentPageState extends State<AllCoupnsContentPage> {
  AllCoupnsProvide _provide;
  int index;

  @override
  void initState() {
    _provide ??= widget._provide;
    index ??= widget.index;

    print('index=======>$index');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: setBody());
  }

  Provide<AllCoupnsProvide> setBody() {
    return Provide<AllCoupnsProvide>(
      builder: (BuildContext context, Widget child, AllCoupnsProvide provide) {
        return ListView.builder(
          physics: BouncingScrollPhysics(),
            itemCount: 5,
            itemBuilder: (BuildContext build, int index) {
              return HJExpansionTile(
                // leading: Container(
                //   width: ScreenAdapter.width(680),
                //   height: ScreenAdapter.height(200),
                //   color: Colors.yellow,
                // ),
                initiallyExpanded: false, //初始状态不展开
                title: Container(
                  width: double.infinity,
                  height: ScreenAdapter.height(250),
                  //color: Colors.yellow,
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      height: ScreenAdapter.height(200),
                      //color: Colors.blue,
                      child: Row(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                width: ScreenAdapter.width(206),
                                height: ScreenAdapter.height(166),
                                child: Image.asset(
                                  'assets/images/立减券.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Container(
                                width: ScreenAdapter.width(206),
                                height: ScreenAdapter.height(166),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    SizedBox(
                                      height: ScreenAdapter.height(20),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '￥',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ScreenAdapter.size(30)),
                                        ),
                                        Text(
                                          '130',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ScreenAdapter.size(50),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '满199元可用',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenAdapter.size(20)),
                                    ),
                                    SizedBox(
                                      height: ScreenAdapter.height(20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(20),
                          ),
                          Container(
                              width: ScreenAdapter.width(460),
                              height: ScreenAdapter.height(166),
                              //  color: Colors.yellow,
                              child: Stack(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          child: ExtendedText.rich(
                                              TextSpan(children: <InlineSpan>[
                                        WidgetSpan(
                                            child: Image.asset(
                                          'assets/images/lj.jpg',
                                          width: ScreenAdapter.width(100),
                                        )),
                                        TextSpan(text: ' '),
                                        TextSpan(
                                            text: "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈",
                                            style: TextStyle(
                                                fontSize:
                                                    ScreenAdapter.size(22))),
                                      ]))),
                                    ],
                                  ),
                                  Positioned(
                                      left: 0,
                                      top: ScreenAdapter.height(78),
                                      child: Container(
                                        width: ScreenAdapter.width(460),
                                        height: ScreenAdapter.height(55),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '2020.1.16-2020.02.17',
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenAdapter.size(20)),
                                            ),
                                            Expanded(child: Container()),
                                            //  SizedBox(
                                            //   width: ScreenAdapter.width(120),
                                            // ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: ScreenAdapter.width(130),
                                              height: ScreenAdapter.height(44),
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      68, 141, 227, 1.0),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              ScreenAdapter
                                                                  .width(25)))),
                                              child: Text(
                                                '立即使用',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        ScreenAdapter.size(20)),
                                              ),
                                            ),
                                            // SizedBox(
                                            //   width: ScreenAdapter.width(10),
                                            // ),
                                          ],
                                        ),
                                      )),
                                  Positioned(
                                      left: 0,
                                      top: ScreenAdapter.height(120),
                                      child: Container(
                                        width: ScreenAdapter.width(460),
                                        height: ScreenAdapter.height(55),
                                        // color: Colors.blue,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '详细信息',
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenAdapter.size(22)),
                                            ),
                                            Expanded(child: Container()),
                                            SizedBox(
                                              width: ScreenAdapter.width(120),
                                            ),
                                            Icon(
                                              provide.expansionChanged == true
                                                  ? Icons.expand_more
                                                  : Icons.chevron_right,
                                              size: ScreenAdapter.size(30),
                                            ),
                                            SizedBox(
                                              width: ScreenAdapter.width(50),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                // trailing: Container(
                //   width: ScreenAdapter.width(90),
                //   height:  ScreenAdapter.width(200),
                //   color: Colors.blue,
                //   child: Icon(Icons.chevron_right),
                // ),
                onExpansionChanged: (value) {
                  print('展开===============》$value');
                  provide.expansionChanged = value;
                },
                // subtitle: Container(
                //   width:ScreenAdapter.width(100),
                //   height:ScreenAdapter.width(80),
                //   color: Colors.blue,
                // ),
                backgroundColor:
                    Theme.of(context).accentColor.withOpacity(0.025),
                children: <Widget>[
                  ListTile(
                    title: Text('sdfsdfsd'),
                  ),
                  ListTile(
                    title: Text('sdfsdfsd'),
                  ),
                ],
              );
            });
      },
    );
  }
}
