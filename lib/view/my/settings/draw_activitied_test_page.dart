import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/settings/draw_activitied_test_provide.dart';
import 'package:provide/provide.dart';

///抽签活动测试
class DrwaActivitiedTestPage extends PageProvideNode {
  final DrwaActivitiedTestProvide _provide = DrwaActivitiedTestProvide();
  DrwaActivitiedTestPage() {
    mProviders.provide(Provider<DrwaActivitiedTestProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    return DrwaActivitiedTestContentPage(_provide);
  }
}

class DrwaActivitiedTestContentPage extends StatefulWidget {
  final DrwaActivitiedTestProvide _provide;
  DrwaActivitiedTestContentPage(this._provide);
  @override
  _DrwaActivitiedTestContentPageState createState() =>
      _DrwaActivitiedTestContentPageState();
}

class _DrwaActivitiedTestContentPageState
    extends State<DrwaActivitiedTestContentPage> {
  DrwaActivitiedTestProvide _provide;
  @override
  void initState() {
    super.initState();
    _provide ??= widget._provide;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('抽签活动测试'),
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

  Provide<DrwaActivitiedTestProvide> _setupRedirectParam() {
    return Provide<DrwaActivitiedTestProvide>(
      builder: (BuildContext context, Widget child,
          DrwaActivitiedTestProvide provide) {
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
                  Navigator.pushNamed(context, '/drawPage',arguments: {
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
