import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/app.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/settings/protocol_page.dart';

///用户须知
class UserInstructionsPage extends StatefulWidget {
  @override
  _UserInstructionsPageState createState() => _UserInstructionsPageState();
}

class _UserInstructionsPageState extends State<UserInstructionsPage> {
  @override
  void initState() { 
    super.initState();
    AppConfig.userTools.setAppNumber('1');
  }
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: new ExactAssetImage('assets/images/main/open_app.jpg'),
            fit: BoxFit.cover,
          )),
        ),
        Positioned(
          top: ScreenAdapter.height(285),
          left: ScreenAdapter.width(60),
          child: Container(
              width: ScreenAdapter.width(630),
              height: ScreenAdapter.height(665),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenAdapter.width(10)))),
              child: Column(
                children: <Widget>[
                  Container(
                    width: ScreenAdapter.width(630),
                    height: ScreenAdapter.height(555),
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black12))),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: ScreenAdapter.height(48),
                        ),
                        Container(
                            width: ScreenAdapter.width(550),
                            height: ScreenAdapter.height(480),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Center(
                                      child: Text(
                                        '服务协议和隐私政策',
                                        style: TextStyle(
                                            fontSize: ScreenAdapter.size(30)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        '请你务必审慎阅读、充分理解"服务协议',
                                        style: TextStyle(
                                            fontSize: ScreenAdapter.size(28)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        '和"隐私政策"各条款,包括但不限于:为了',
                                        style: TextStyle(
                                            fontSize: ScreenAdapter.size(28)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        '向你提供即时通讯、内容分享等服务，',
                                        style: TextStyle(
                                            fontSize: ScreenAdapter.size(28)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        '我们需要手机你的设备信息、操作日志等，',
                                        style: TextStyle(
                                            fontSize: ScreenAdapter.size(28)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        '个人信息。你可以在设置中查看，变更删除',
                                        style: TextStyle(
                                            fontSize: ScreenAdapter.size(28)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        '个人信息并管理你的授权.',
                                        style: TextStyle(
                                            fontSize: ScreenAdapter.size(28)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        '你可阅读',
                                        style: TextStyle(
                                            fontSize: ScreenAdapter.size(28)),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          //ProtocolPage
                                          return ProtocolPage(
                                            title: "innersect用户须知",
                                            leading: true,
                                          );
                                        }));
                                      },
                                      child: Text(
                                        '《服务协议》',
                                        style: TextStyle(
                                            fontSize: ScreenAdapter.size(28),
                                            color: Colors.blue),
                                      ),
                                    ),
                                    Text(
                                      '和',
                                      style: TextStyle(
                                          fontSize: ScreenAdapter.size(28)),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          //ProtocolPage
                                          return ProtocolPage(
                                            title: "innersect用户须知",
                                            leading: true,
                                          );
                                        }));
                                      },
                                      child: Text(
                                        '《隐私政策》',
                                        style: TextStyle(
                                            fontSize: ScreenAdapter.size(28),
                                            color: Colors.blue),
                                      ),
                                    ),
                                    Text(
                                      '了解',
                                      style: TextStyle(
                                          fontSize: ScreenAdapter.size(28)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        '详细信息.如果你同意，请点击"同意"开始接',
                                        style: TextStyle(
                                            fontSize: ScreenAdapter.size(28)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        '受我们的服务',
                                        style: TextStyle(
                                            fontSize: ScreenAdapter.size(28)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                  Container(
                    height: ScreenAdapter.height(110),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            Fluttertoast.showToast(
                              msg: '请点击同意我们的服务',
                              gravity: ToastGravity.CENTER,
                            );
                          },
                          child: Text(
                            '暂不支持',
                            style: TextStyle(fontSize: ScreenAdapter.size(30)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              //ProtocolPage
                              return App();
                            }));
                          },
                          child: Text(
                            '同意',
                            style: TextStyle(
                                fontSize: ScreenAdapter.size(30),
                                color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
        )
      ],
    ));
  }
}
