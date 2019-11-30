import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/binding_sign_in/sortilege_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view/widget/web_view_widget.dart';
class SignProtocolPage extends StatefulWidget {
  @override
  _SignProtocolPageState createState() => new _SignProtocolPageState();
}

class _SignProtocolPageState extends State<SignProtocolPage> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context, leading: false,
          widget: new Text("用户须知",style: TextStyle(fontSize: ScreenAdapter.size((30)),
              fontWeight: FontWeight.w900))
      ),
      body: WebViewWidget(url: "https://gate.innersect.net/agreement/index.html#/",),
      bottomSheet: Container(
        width: ScreenAdapter.width(750),
        height: ScreenAdapter.height(180),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
              child: Row(
                children: <Widget>[
                  CustomsWidget().customRoundedWidget(isSelected: _isSelected,
                      onSelectedCallback: (){
                        setState(() {
                          _isSelected = !_isSelected;
                        });
                      }),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: new Text("同意INNERSECT用户须知",style: TextStyle(
                      fontSize: ScreenAdapter.size(28),
                      color: AppConfig.blueBtnColor,
                    ),),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 20,right: 20),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.black,
                child: Text("抽签登记信息",style: TextStyle(fontSize: ScreenAdapter.size(28),
                    fontWeight: FontWeight.w600),),
                onPressed: (){
                  if(_isSelected){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return SortilegePage();
                        }
                      ));
                  }else{
                    CustomsWidget().showToast(title: "请认真阅读用户须知并同意");
                  }
                },
              ),
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