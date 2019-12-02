import 'package:flutter/material.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/settings/protocol_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
          widget: new Text("关于INNERSECT",style: TextStyle(fontSize: ScreenAdapter.size((30)),
        fontWeight: FontWeight.w900)),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color:Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: new Column(
              children: <Widget>[
                // logo
                new Container(
                  width: ScreenAdapter.width(160),
                  height: ScreenAdapter.height(160),
                  margin: EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    image: DecorationImage(
                        image: AssetImage("assets/images/user/logo.png"),
                        fit: BoxFit.fitWidth
                    ),
                  ),
//              child: new Image.asset("assets/images/user/logo.png",fit: BoxFit.fill,),
                ),
                new Container(
                  margin: EdgeInsets.only(top: 20),
                  child: new Text("INNERSECT v3.0.0",style: TextStyle(color: Colors.grey,
                      fontSize: ScreenAdapter.size(32)),),
                ),
                CustomsWidget().listSlider(title: "隐私协议",onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return ProtocolPage(title: "innersect用户协议",);
                      }
                  ));
                }),
                new Divider(height: 5,indent: 10,endIndent: 10,color: Colors.grey,),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: new Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: new Text("©上海映市信息科技有限公司",style: TextStyle(color: Colors.grey),),
            ),
          )
        ],
      ),
    );
  }
}

//assets/images/user/logo.png