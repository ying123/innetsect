import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/my/complete/complete_provide.dart';
import 'package:provide/provide.dart';

class CompletePage extends PageProvideNode{
  final CompleteProvider _provider = CompleteProvider();
  CompletePage(){
    mProviders.provide(Provider.value(_provider));
  }
  @override
  Widget buildContent(BuildContext context) {
    
    return CompleteContentPage();
  }
}

class CompleteContentPage extends StatefulWidget {
  @override
  _CompleteContentPageState createState() => _CompleteContentPageState();
}

class _CompleteContentPageState extends State<CompleteContentPage> {
  @override
  Widget build(BuildContext context) {
     return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(435),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(
                      color: Color.fromRGBO(249, 249, 249, 1.0), width: 3))),
          child: _setupCell(),
        );
      },
    );
  }
    Provide<CompleteProvider>_setupCell(){
    return Provide<CompleteProvider>(
      builder: (BuildContext context, Widget child, CompleteProvider provide){
        return Column(
          children: <Widget>[
            Container(
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(110),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: ScreenAdapter.width(40),
                    ),
                    Container(
                      child: Text('订单号: 14654561561'),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Container(
                      child: Text(
                        '交易成功',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      width: ScreenAdapter.width(40),
                    ),
                  ],
                ),
              ),
              Container(
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(205),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Color.fromRGBO(234, 234, 234, 1.0),
                ))),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(ScreenAdapter.width(20), 0,
                          ScreenAdapter.width(20), 0),
                      width: ScreenAdapter.width(115),
                      height: ScreenAdapter.height(168),
                      child: Image.asset(
                        'assets/images/yifu2.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: ScreenAdapter.width(30),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: ScreenAdapter.width(398),
                      height: ScreenAdapter.height(168),
                      child: Text(
                        'PROFOUND 春季印花休闲连帽卫衣',
                        softWrap: true,
                        style: TextStyle(fontSize: ScreenAdapter.size(30)),
                      ),
                    ),
                    Container(
                        width: ScreenAdapter.width(130),
                        height: ScreenAdapter.height(168),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: ScreenAdapter.height(75),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(),
                                ),
                                Text(
                                  '￥',
                                  style: TextStyle(
                                      fontSize: ScreenAdapter.size(30),
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '380',
                                  style: TextStyle(
                                      fontSize: ScreenAdapter.size(38),
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(),
                                ),
                                Text(
                                  '共2件',
                                  style: TextStyle(color: Colors.black54),
                                )
                              ],
                            )
                          ],
                        ))
                  ],
                ),
              ),
              Container(
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(110),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: ScreenAdapter.width(460),
                    ),
                    Container(
                      width: ScreenAdapter.width(165),
                      height: ScreenAdapter.height(65),
                      decoration: BoxDecoration(
                      border: Border.all(color: Colors.black87)
                    ),
                      child: Center(
                        child: Text(
                          '订单进度',style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ScreenAdapter.width(20),
                    ),
                    Container(
                      width: ScreenAdapter.width(85),
                      height: ScreenAdapter.height(65),
                    //  color: Colors.black,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black87)
                    ),
                      child: Center(
                        child: Text(
                          '评价',style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ],
        );
      },
    );
  }
}