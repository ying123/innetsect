import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/address_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/address_management/new_address/new_address_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:innetsect/view_model/mall/commodity/order_detail_provide.dart';
import 'package:innetsect/view_model/my/address_management/address_management_provide.dart';
import 'package:innetsect/view_model/my_order/after_service_provide.dart';
import 'package:provide/provide.dart';

class AddressManagementPage extends PageProvideNode {
  final AddressManagementProvide _provide = AddressManagementProvide();
  final OrderDetailProvide _orderDetailProvide = OrderDetailProvide.instance;
  final AfterServiceProvide _afterServiceProvide = AfterServiceProvide.instance;

  AddressManagementPage() {
    mProviders.provide(Provider<AddressManagementProvide>.value(_provide));
    mProviders.provide(Provider<OrderDetailProvide>.value(_orderDetailProvide));
    mProviders.provide(Provider<AfterServiceProvide>.value(_afterServiceProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    return AddressManagementContentPage(_provide,_orderDetailProvide,_afterServiceProvide);
  }
}

class AddressManagementContentPage extends StatefulWidget {
  final AddressManagementProvide _provide;
  final OrderDetailProvide _orderDetailProvide;
  final AfterServiceProvide _afterServiceProvide;
  AddressManagementContentPage(this._provide,this._orderDetailProvide,this._afterServiceProvide);

  @override
  _AddressManagementContentPageState createState() =>
      _AddressManagementContentPageState();
}

class _AddressManagementContentPageState
    extends State<AddressManagementContentPage> {
  OrderDetailProvide _orderDetailProvide;
  AddressManagementProvide _provide;
  AfterServiceProvide _afterServiceProvide;

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
      body: _content(),
      bottomNavigationBar: _setupBottomBtn(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _orderDetailProvide ??= widget._orderDetailProvide;
    _provide ??= widget._provide;
    _afterServiceProvide ??= widget._afterServiceProvide;
    // 地址管理请求
    _provide.clearList();
    _listData();
  }
  
  Provide<AddressManagementProvide> _content(){
    return Provide<AddressManagementProvide>(
      builder: (BuildContext context,Widget widget,AddressManagementProvide addressProvide){
        Map<dynamic,dynamic> mapData = ModalRoute.of(context).settings.arguments;
        return Container(
            color: Colors.white,
            width: double.infinity,
            child: new ListView.builder(
                itemCount: addressProvide.listAddressModel.length,
                itemBuilder: (BuildContext context, int index){
                  AddressModel item = addressProvide.listAddressModel[index];
                  return new InkWell(
                    onTap: (){
                      // 订单详情选中事件
                      if(mapData['pages']=="orderDetail"){
                        // 订单详情
                        _orderDetailProvide.editAddress(item);
                        Navigator.pop(context);
                      }else if(mapData['pages']=="afterApply"){
                        // 售后申请
                        _afterServiceProvide.editAddress(item);
                        Navigator.pop(context);
                      }
                    },
                    child: new Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 10,right: 10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1,color: AppConfig.assistLineColor))
                      ),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            child: new Text(item.name + item.tel),
                          ),
                          new Container(
                            padding:EdgeInsets.all(5),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Image.asset("assets/images/mall/location.png",fit: BoxFit.fill,width: ScreenAdapter.width(25),),
                                new Container(
                                  child: new Text(item.province+item.city+item.addressDetail),
                                )
                              ],
                            ),
                          ),
                          new Container(
                            child: new Row(
                              children: <Widget>[
                                new Expanded(
                                    flex:1,
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        new CustomsWidget().customRoundedWidget(isSelected: item.lastUsed,iconSize: 18, onSelectedCallback: (){
                                          // 设置默认地址
                                          addressProvide.onDefaultAddresses(item).then((items){
                                            if(items!=null){
                                              addressProvide.setIsDefault(item);
                                              CustomsWidget().showToast(title: "修改成功");
                                            }
                                          });
//                                          addressProvide.editDatas(item).doOnListen(() {}).doOnCancel(() {}).listen((items) {
//                                            print('listen data->$items');
//                                            addressProvide.setIsDefault(item);
//                                          }, onError: (e) {});
                                        }),
                                        new Padding(padding: EdgeInsets.only(left: 5),
                                          child: new Text("设为默认",style: TextStyle(color: Colors.orange),),)
                                      ],
                                    )
                                ),
                                new Expanded(
                                    flex:1,
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        new InkWell(
                                          onTap: (){
                                            //编辑
                                            addressProvide.addressModel = item;
                                            Navigator.push(context, MaterialPageRoute(
                                              builder: (BuildContext context){
                                                return NewAddressPage();
                                              }
                                            ));
                                          },
                                          child: new Icon(Icons.edit),
                                        ),
                                        new InkWell(
                                          onTap: (){
                                            //删除
                                            CustomsWidget().customShowDialog(context: context,
                                                title:"删除提示",content: "是否删除该收货地址?",
                                                onPressed: (){
                                                  addressProvide.delDatas(item).then((result){
                                                    if(result.data){
                                                      Fluttertoast.showToast(msg: "删除成功",
                                                          gravity: ToastGravity.CENTER);
                                                      _listData();
                                                    }else{
                                                      Fluttertoast.showToast(msg: "删除失败",
                                                          gravity: ToastGravity.CENTER);
                                                    }
                                                  });
                                                }
                                            );
                                          },
                                          child: new Icon(Icons.delete_forever),
                                        )
                                      ],
                                    )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                })
        );
      },
    );
  }

  Provide<AddressManagementProvide> _setupBottomBtn() {
    return Provide<AddressManagementProvide>(
      builder: (BuildContext context, Widget child,
          AddressManagementProvide provide) {
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(150),
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.black12))
          ),
          child: Center(
            child: InkWell(
              onTap: () {
                // 新建地址
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
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

  /// 列表数据
  void _listData() {
    _provide.listData().doOnListen(() {
      print('doOnListen');
    }).doOnCancel(() {}).listen((item) {
      ///加载数据
      print('listen data->$item');
      List<AddressModel> list = AddressModelList
          .fromJson(item.data)
          .list;
      _provide.addListAddress(list);
    }, onError: (e) {});
  }
}
