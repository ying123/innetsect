import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/draw/temporary_order_provide.dart';
import 'package:innetsect/view_model/mall/commodity/order_detail_provide.dart';
import 'package:innetsect/view_model/my/address_management/address_management_provide.dart';
import 'package:provide/provide.dart';


///临时订单页面
class  TemporaryOrderPage  extends PageProvideNode{
  final TemporaryOrderProvider _provider = TemporaryOrderProvider();
  final AddressManagementProvide _managementProvide  = AddressManagementProvide.instance;
  final OrderDetailProvide _orderDetailProvide = OrderDetailProvide.instance;
  TemporaryOrderPage(){
    mProviders.provide(Provider<TemporaryOrderProvider>.value(_provider));
  }

  @override
  Widget buildContent(BuildContext context) {
      return TemporaryOrderContentPage(_provider,_managementProvide,_orderDetailProvide);
  }
}


class TemporaryOrderContentPage extends StatefulWidget {
  final TemporaryOrderProvider provider;
  final AddressManagementProvide managementProvide;
  final OrderDetailProvide orderDetailProvide;
  TemporaryOrderContentPage(this.provider, this.managementProvide, this.orderDetailProvide);
  
  @override
  _TemporaryOrderContentPageState createState() => _TemporaryOrderContentPageState();
}

class _TemporaryOrderContentPageState extends State<TemporaryOrderContentPage> {
  TemporaryOrderProvider provider;
  AddressManagementProvide managementProvide;
  OrderDetailProvide orderDetailProvide;
  @override
  void initState() {
    provider??= widget.provider;
    managementProvide??= widget.managementProvide;
    orderDetailProvide??= widget.orderDetailProvide;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('订单详情'),
        centerTitle: true,
        elevation: 0.0,
        leading:    InkWell(
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
          setSelectAddress(),
        ],
      ),
    );

   
  }
///选择地址
  Provide<TemporaryOrderProvider> setSelectAddress(){
    return Provide<TemporaryOrderProvider>(
      builder: (BuildContext context, Widget child, TemporaryOrderProvider provide ){
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(125),
          color: Color.fromRGBO(242, 242, 242, 1.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: ScreenAdapter.width(20),
              ),
              Container(
                child: Image.asset('assets/images/mall/express.png',width: ScreenAdapter.width(70),height: ScreenAdapter.height(70),),
              ),
               SizedBox(
                width: ScreenAdapter.width(20),
              ),
              Text('添加购物地址',style: TextStyle(fontSize: ScreenAdapter.size(35),color: Color.fromRGBO(181, 181, 181, 1.0)),),
              Expanded(
                child: Container(),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/addressManagementPage').then((value){
                      print('listAddressModel=============>>>========>${managementProvide.listAddressModel}');
                  });
                },
                child: Icon(Icons.chevron_right,size: ScreenAdapter.size(80),))
            ],
          ),
        );
      }
    );
  }
}