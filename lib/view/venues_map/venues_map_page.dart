import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/venues_map/venues_map_provide.dart';
import 'package:provide/provide.dart';

class VenuesMapPage extends PageProvideNode {
  final VenuesMapProvide _provide = VenuesMapProvide();
  VenuesMapPage() {
    mProviders.provide(Provider.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return VenuesMapContentPage(_provide);
  }
}

class VenuesMapContentPage extends StatefulWidget {
  final VenuesMapProvide _provide;
  VenuesMapContentPage(this._provide);
  @override
  _VenuesMapContentPageState createState() => _VenuesMapContentPageState();
}

class _VenuesMapContentPageState extends State<VenuesMapContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          '场馆地图',
          style: TextStyle(
            color: AppConfig.fontPrimaryColor,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Image.asset(
            'assets/images/xiangxia.png',
            width: ScreenAdapter.width(38),
            height: ScreenAdapter.width(38),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(415),
              child: Image.asset(
                'assets/images/y场馆地图.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: ScreenAdapter.width(30)),
              color: Colors.white,
              alignment: Alignment.centerLeft,
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(80),
              child: Text(
                '展馆品牌分布情况',
                style: TextStyle(
                    color: AppConfig.fontPrimaryColor,
                    fontSize: ScreenAdapter.size(30),
                    fontWeight: FontWeight.w800),
              ),
            ),
            Container(
              height: ScreenAdapter.height(700),
              //color: Colors.yellow,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 10,
                itemExtent: 100,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(left: ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.height(100),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(
                        color: Colors.black12
                      ))
                    ),
                    child: Row(
                      
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: ScreenAdapter.height(20),
                            ),
                            Container(
                            width: ScreenAdapter.width(50),
                            height: ScreenAdapter.width(50),
                            color: Colors.black,
                            child: Center(child: Text('E4',style: TextStyle(color: Colors.white),)),
                          ),
                          ],
                        ),
                        SizedBox(
                              width: ScreenAdapter.height(20),
                            ),
                        Text('sdfhjsdhfkjlsdfhgksjdfhgjdsfhgdkslfjh')
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
