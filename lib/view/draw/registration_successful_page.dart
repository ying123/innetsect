import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/draw/registration_successful_provide.dart';
import 'package:provide/provide.dart';

///登记成功
class RegistrationSuccessfulPage extends PageProvideNode {
  final RegistrationSuccessfulProvide _provide =
      RegistrationSuccessfulProvide();
  final Map draweeModel;
  RegistrationSuccessfulPage({this.draweeModel}) {
    mProviders.provide(Provider<RegistrationSuccessfulProvide>.value(_provide));
    _provide.draweeModel = draweeModel['draweeModel'];
    _provide.longitude = draweeModel['longitude'];
    _provide.latitude = draweeModel['latitude'];

    print('_provide.draweeModel.drawID=====>${_provide.draweeModel.drawID}');
    print('_provide.draweeModel.shopID=====>${_provide.draweeModel.shopID}');
    print('登记成功longitude:=====>${_provide.longitude}');
    print('登记成功latitude:=====>${_provide.latitude}');
  }
  @override
  Widget buildContent(BuildContext context) {
    return RegistrationSuccessfulContentPage(_provide);
  }
}

class RegistrationSuccessfulContentPage extends StatefulWidget {
  final RegistrationSuccessfulProvide provide;
  RegistrationSuccessfulContentPage(this.provide);
  @override
  _RegistrationSuccessfulContentPageState createState() =>
      _RegistrationSuccessfulContentPageState();
}

class _RegistrationSuccessfulContentPageState
    extends State<RegistrationSuccessfulContentPage> {
  RegistrationSuccessfulProvide provide;
  @override
  void initState() {
    super.initState();
    provide ??= widget.provide;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text('登记信息'),
          centerTitle: true,
          elevation: 0.0,
          leading: Container()
          //  InkWell(
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          //   child: Icon(
          //     Icons.chevron_left,
          //     size: ScreenAdapter.size(60),
          //   ),
          // ),
          ),
      body: Column(
        children: <Widget>[
          _setupBody(),
        ],
      ),
    );
  }

  Provide<RegistrationSuccessfulProvide> _setupBody() {
    return Provide<RegistrationSuccessfulProvide>(
      builder: (BuildContext context, Widget child,
          RegistrationSuccessfulProvide provide) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: ScreenAdapter.height(180),
            ),
            Center(
              child: Image.asset(
                'assets/images/registration_successful.jpg',
                width: ScreenAdapter.width(135),
                height: ScreenAdapter.width(135),
              ),
            ),
            SizedBox(
              height: ScreenAdapter.height(50),
            ),
            Center(
              child: Text(
                '恭喜你, 你已完成信息登记!',
                style: TextStyle(fontSize: ScreenAdapter.size(35)),
              ),
            ),
            SizedBox(
              height: ScreenAdapter.height(135),
            ),
            // Container(
            //   width: ScreenAdapter.width(690),
            //   height: ScreenAdapter.height(1),
            //   color: Colors.black12,
            // ),
            SizedBox(
              height: ScreenAdapter.height(110),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/mallPage', (route) => route == null);
                  },
                  child: Container(
                    width: ScreenAdapter.width(340),
                    height: ScreenAdapter.height(85),
                    decoration: BoxDecoration(color: Colors.black),
                    child: Center(
                      child: Text(
                        '返回',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenAdapter.size(30),
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/checkTheRegistrationPage',
                        arguments: {
                          'drawID': provide.draweeModel.drawID,
                          'shopID': provide.draweeModel.shopID,
                          'longitude': provide.longitude,
                          'latitude': provide.latitude
                        });
                  },
                  child: Container(
                    width: ScreenAdapter.width(340),
                    height: ScreenAdapter.height(85),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(149, 169, 201, 1.0),
                      // border: Border(right: BorderSide(color: Colors.black),
                      //   top: BorderSide(color: Colors.black),
                      //   bottom: BorderSide(color: Colors.black),
                      // )
                    ),
                    child: Center(
                      child: Text(
                        '查看登记',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenAdapter.size(30),
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
            SizedBox(
              height: ScreenAdapter.height(55),
            ),
          ],
        );
      },
    );
  }
}
