import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/account_cancellation_provide.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:provide/provide.dart';

///账户注销
class AccountCancellationPage extends PageProvideNode{
  final AccountCancellationProvide _provide = AccountCancellationProvide();
  AccountCancellationPage(){
    mProviders.provide(Provider<AccountCancellationProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
   
    return AccountCancellationContentPage(_provide);
  }
  
}

class AccountCancellationContentPage extends StatefulWidget {
  final AccountCancellationProvide provide;
  AccountCancellationContentPage(this.provide);
  @override
  _AccountCancellationContentPageState createState() => _AccountCancellationContentPageState();
}

class _AccountCancellationContentPageState extends State<AccountCancellationContentPage> {
  AccountCancellationProvide provide;
  @override
  void initState() { 
    super.initState();
    provide??= widget.provide;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text('账户注销'),
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
          SizedBox(
            height: ScreenAdapter.height(40),
          ),
          Center(child: _setUpAccountCancellation()),
        ],
      ),
    //  bottomNavigationBar: _setUpAccountCancellation(),
    );
  }

  Provide<AccountCancellationProvide>_setUpAccountCancellation(){
    return Provide<AccountCancellationProvide>(
      builder: (BuildContext contxt, Widget child,AccountCancellationProvide provide){
        return InkWell(
          onTap: (){
            print('注销账户被点击');
            CustomsWidget().customShowDialog(
              context: context,
              title: '注销账户',
              content: '是否注销账户？',
              onPressed: (){
                print('onPressed');
                provide.accountCancellation().then((result){
                  print('================>$result');
                  print('result.data================>${result.data}');
                  if (result.data == true) {
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                      msg: '注销成功',
                      gravity: ToastGravity.CENTER,
                    );
                  }
                  
                });
              }
            );
          },
          child: Container(
            width: ScreenAdapter.width(710),
            height: ScreenAdapter.height(100),
            color:  Color.fromRGBO(146, 169, 201, 1.0),
            child: Center(
              child: Text('注销账号',style: TextStyle(fontSize: ScreenAdapter.size(30)),),
            ),
          ),
        );
      },
    );
  }
}