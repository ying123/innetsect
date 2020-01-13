import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/hot_spots/hot_test_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter/material.dart';

class HotTestPage extends PageProvideNode {
  HotTestProvide _provide = HotTestProvide();
  HotTestPage(){
    mProviders.provide(Provider<HotTestProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return HotTestContentPage(_provide);
  }
}

class HotTestContentPage extends StatefulWidget {
  HotTestProvide _provide;
  HotTestContentPage(this._provide);
  @override
  _HotTestContentPageState createState() => _HotTestContentPageState();
}

class _HotTestContentPageState extends State<HotTestContentPage> {
  HotTestProvide _provide;
  @override
  void initState() { 
    super.initState();
    _provide??=widget._provide;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('热区测试'),
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
      body: Column(
        children: <Widget>[
          _setupRedirectParam(),
        ],
      ),
    );
  }
  Provide<HotTestProvide> _setupRedirectParam() {
    return Provide<HotTestProvide>(
      builder: (BuildContext context, Widget child,
          HotTestProvide provide) {
        return Column(
         // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: ScreenAdapter.height(40),
            ),
            Container(
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(100),
                margin: EdgeInsets.only(left: ScreenAdapter.width(40)),
                child: Text(
                  '请输入活动ID:',
                  style: TextStyle(fontSize: ScreenAdapter.size(30)),
                )),

            Container(
              margin: EdgeInsets.only(left: ScreenAdapter.width(40)),
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(100),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.black54),bottom:BorderSide(color: Colors.black54) )
              ),
              child: TextField(
                maxLines: 1,
                enabled: true,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        top: ScreenAdapter.height(0),
                        bottom: ScreenAdapter.height(3)),
                    hintText: '请输入活动ID',
                    hintStyle: TextStyle(
                        color: Colors.grey, fontSize: ScreenAdapter.size(30)),
                    // focusedBorder: InputBorder.none,
                    // contentPadding: EdgeInsets.all(0)
                    border: InputBorder.none),
                onChanged: (str) {
                  provide.activitiedId = str;
                },
                onTap: () {},
              ),
            ),
            SizedBox(
              height: ScreenAdapter.height(60),
            ),
            InkWell(
              onTap: (){
                if (provide.activitiedId == '') {
                  Fluttertoast.showToast(
                    msg: '请输入ID',
                    gravity: ToastGravity.CENTER,
                  );
                }else{
                  Navigator.pushNamed(context, '/hotSpotsHomePage',arguments: {
                    'redirectParam':provide.activitiedId
                  });
                }
              },
              child: Center(
                child: Container(
                  width: ScreenAdapter.width(710),
                  height: ScreenAdapter.height(80),
                  color: Colors.black87,
                  child: Center(
                    child: Text('确定',style: TextStyle(fontSize: ScreenAdapter.size(30),color: Colors.white),),
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