import 'package:flutter/material.dart';
import 'package:innetsect/app_navigation_bar.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/mall_page.dart';

class EntrancePage extends StatefulWidget {
  @override
  _EntrancePageState createState() => new _EntrancePageState();
}

class _EntrancePageState extends State<EntrancePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: Colors.black,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new InkWell(
              onTap: (){
                // 展会
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context){
                    return AppNavigationBar();
                  }
                ),(Route<dynamic> route) => false);
              },
              child: new Container(
                width: double.infinity,
                height: ScreenAdapter.getScreenHeight()/2,
                child: Image.asset("assets/images/main/trade_enter.jpg",fit: BoxFit.fitWidth,),
              )
            ),
            new InkWell(
              onTap: (){
                // 商城
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context){
                      return MallPage();
                    }
                ),(Route<dynamic> route) => false);
              },
              child: new Container(
                width: double.infinity,
                height: ScreenAdapter.getScreenHeight()/2,
                child: Image.asset("assets/images/main/commodity_enter.jpg",fit: BoxFit.fitWidth,),
              )
            )
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}