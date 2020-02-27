import 'package:innetsect/base/base.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/coupons/all_coupns_provide.dart';

import 'package:innetsect/view/mall/coupons/hj_expansion_tile_.dart';
import 'package:provide/provide.dart';
import 'package:extended_text/extended_text.dart';



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
                            color: Colors.yellow,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: ScreenAdapter.width(100),
                                  height: ScreenAdapter.height(45),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color.fromRGBO(
                                              68, 141, 227, 1.0)) //蓝色
                                      ),
                                ),
                                Container(
                                  child: Container()
                                        ),
                              ],
                            ),
                          )
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
                  ListTile(
                    title: Text('sdfsdfsd'),
                  ),
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
