import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/address_management/new_address/new_address_page.dart';
import 'package:innetsect/view_model/my/address_management/address_management_provide.dart';
import 'package:provide/provide.dart';

class AddressManagementPage extends PageProvideNode {
  final AddressManagementProvide _provide = AddressManagementProvide();
  AddressManagementPage() {
    mProviders.provide(Provider<AddressManagementProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    return AddressManagementContentPage(_provide);
  }
}

class AddressManagementContentPage extends StatefulWidget {
  final AddressManagementProvide provide;
  AddressManagementContentPage(this.provide);
  @override
  _AddressManagementContentPageState createState() =>
      _AddressManagementContentPageState();
}

class _AddressManagementContentPageState
    extends State<AddressManagementContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          '地址管理',
          style: TextStyle(
           // fontSize: ScreenAdapter.size(48),
           // fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/xiangxia.png',
              fit: BoxFit.none,
              width: ScreenAdapter.width(38),
              height: ScreenAdapter.width(38),
            )),
      ),
      body: Container(
        color: Colors.white,
      ),
      bottomNavigationBar: _setupBottomBtn(),
    );
  }
  Provide<AddressManagementProvide>_setupBottomBtn(){
    return Provide<AddressManagementProvide>(
      builder: (BuildContext context, Widget child, AddressManagementProvide provide){
        return Container(
        width: ScreenAdapter.width(750),
        height: ScreenAdapter.height(150),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black12))
        ),
        child: Center(
          child: InkWell(
            onTap: (){
              print('新建地址被点击');
              Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return NewAddressPage();
                } 
              ));
            },
            child: Container(
              width: ScreenAdapter.width(705),
              height: ScreenAdapter.height(95),
              color: Colors.black,
              child: Center(
                child: Text(
                  '新建地址',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenAdapter.size(38)
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      },
    );
  }
}
