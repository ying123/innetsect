import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/address_model.dart';
import 'package:innetsect/data/country_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/address_management/city/country_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/my/address_management/address_management_provide.dart';
import 'package:innetsect/view_model/my/address_management/new_address/new_address_provide.dart';
import 'package:provide/provide.dart';

class NewAddressPage extends PageProvideNode {
  final NewAddressProvide _provide = NewAddressProvide();
  final AddressManagementProvide _addressManagementProvide = AddressManagementProvide.instance;
  NewAddressPage() {
    mProviders.provide(Provider<NewAddressProvide>.value(_provide));
    mProviders.provide(Provider<AddressManagementProvide>.value(_addressManagementProvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return NewAddressContentPage(_provide,_addressManagementProvide);
  }
}

class NewAddressContentPage extends StatefulWidget {
  final NewAddressProvide provide;
  final AddressManagementProvide _addressManagementProvide;
  NewAddressContentPage(this.provide,this._addressManagementProvide);
  @override
  _NewAddressContentPageState createState() => _NewAddressContentPageState();
}

class _NewAddressContentPageState extends State<NewAddressContentPage> {

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget._addressManagementProvide.addressModel!=null?'修改收货地址':'新建收货地址'),
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
      body: ListView(
        physics: BouncingScrollPhysics(),
       // itemExtent: ScreenAdapter.height(720),
        children: <Widget>[
          _setupNewGoodsAddress(),
        ],
      ),
      bottomNavigationBar: Container(
        width: ScreenAdapter.width(750),
        height: ScreenAdapter.height(150),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black12))),
        child: _setupBottomBtn(),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 获取国家
    _getCountries();
    // 编辑时
    if(widget._addressManagementProvide.addressModel!=null){
      widget.provide.addressID = widget._addressManagementProvide.addressModel.addressID;
      setState(() {
        isSelected = widget._addressManagementProvide.addressModel.isDefault;
      });
    }
  }


  Provide<NewAddressProvide> _setupNewGoodsAddress() {
    return Provide<NewAddressProvide>(
      builder: (BuildContext context, Widget child, NewAddressProvide provide) {
        return Column(
          children: <Widget>[
            Container(
              width: ScreenAdapter.width(700),
              height: ScreenAdapter.height(100),
              // color: Colors.yellow,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),),
                      top: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),))
                      ),
                    child: Row(
                      children: <Widget>[
                        Center(
                          child: Text('收货人姓名',style: TextStyle(fontSize: ScreenAdapter.size(30)),),
                        ),
                        Container(
                          width: ScreenAdapter.width(500),
                          margin: EdgeInsets.only(left: 20),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: widget._addressManagementProvide.addressModel!=null?widget._addressManagementProvide.addressModel.name:"请输入收货人姓名"
                            ),
                            onChanged: (text){
                              provide.name = text;
                            },
                          ),
                        )
                      ],
                    )
            ),
            Container(
              width: ScreenAdapter.width(700),
              height: ScreenAdapter.height(100),
              // color: Colors.yellow,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),),
                      top: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),))
                      ),
                    child: Row(
                      children: <Widget>[
                        Center(
                          child: Text('手机号码',style: TextStyle(fontSize: ScreenAdapter.size(30)),),
                        ),
                        Container(
                          width: ScreenAdapter.width(500),
                          margin: EdgeInsets.only(left: 20),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: widget._addressManagementProvide.addressModel!=null?widget._addressManagementProvide.addressModel.tel:"请输入收货人手机号"
                            ),
                            onChanged: (text){
                              provide.tel=text;
                            },
                          ),
                        )
                      ],
                    )
            ),
            InkWell(
              onTap: () {
                //弹出国家
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context){
                    return CountryPage();
                  }
                ));
              },
              child: Container(
                  width: ScreenAdapter.width(700),
                  height: ScreenAdapter.height(100),
                  // color: Colors.yellow,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),),
                          top: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),))
                  ),
                  child: Row(
                    children: <Widget>[
                      Center(
                        child: Text('所在国家',style: TextStyle(fontSize: ScreenAdapter.size(30)),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: Text(provide.countryModel!=null?provide.countryModel.briefName:
//                        widget._addressManagementProvide.addressModel!=null?
//                        widget._addressManagementProvide.addressModel.:
                            ""),
                      )
                    ],
                  )
              ),
            ),
            Container(
              width: ScreenAdapter.width(700),
              height: ScreenAdapter.height(100),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),),
                      top: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),))
                      ),
                    child: Row(
                      children: <Widget>[
                        Center(
                          child: Text('所在地区',style: TextStyle(fontSize: ScreenAdapter.size(30)),),
                        ),
                        provide.provincesModel!=null&&provide.cityModel!=null&&provide.countyModel!=null?
                        Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: Text("${provide.provincesModel.regionName} ${provide.cityModel.regionName} ${provide.countyModel.regionName}"),
                        ):widget._addressManagementProvide.addressModel!=null?
                          Padding(
                            padding: EdgeInsets.only(left: 40),
                            child: Text("${widget._addressManagementProvide.addressModel.province} ${widget._addressManagementProvide.addressModel.city} "
                                "${widget._addressManagementProvide.addressModel.county}"),
                          )
                        :new Container()
                      ],
                    )
            ),
            Container(
              width: ScreenAdapter.width(700),
              height: ScreenAdapter.height(100),
              // color: Colors.yellow,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),),
                      top: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),))
                      ),
                    child: Row(
                      children: <Widget>[
                        Center(
                          child: Text('详细地址',style: TextStyle(fontSize: ScreenAdapter.size(30)),),
                        ),
                        Container(
                          width: ScreenAdapter.width(500),
                          margin: EdgeInsets.only(left: 20),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: widget._addressManagementProvide.addressModel!=null?widget._addressManagementProvide.addressModel.addressDetail:"请输入收货地址"
                            ),
                            onChanged: (text){
                              provide.addressDetail=text;
                            },
                          ),
                        )
                      ],
                    )
            ),
            Container(
              width: ScreenAdapter.width(700),
              height: ScreenAdapter.height(100),
              // color: Colors.yellow,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),),
                      top: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),))
                      ),
                    child: Row(
                      children: <Widget>[
                        CustomsWidget().customRoundedWidget(isSelected: isSelected,iconSize: 20, onSelectedCallback: (){
                          setState(() {
                            isSelected = !isSelected;
                          });
                          provide.isDefault=isSelected;
                        }),
                        Padding(
                          padding: EdgeInsets.only(left:10),
                          child: Text('设为默认',style: TextStyle(fontSize: ScreenAdapter.size(30)),),
                        )
                      ],
                    )
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    /// 清空选中国家城市
    widget.provide.clearSelect();
    widget._addressManagementProvide.addressModel = null;
  }

  Provide<NewAddressProvide> _setupBottomBtn() {
    return Provide<NewAddressProvide>(
      builder: (BuildContext context, Widget child, NewAddressProvide provide) {
        return Center(
          child: InkWell(
            onTap: () {
              /// 保存地址
              if(widget._addressManagementProvide.addressModel!=null){
                provide.createAndEditAddresses(context,isEdit: true)
                    .doOnListen(() {}).doOnCancel(() {})
                    .listen((items) {
                  print(items.data);
                  if(items.data!=null){
                    /// 列表数据
                    widget._addressManagementProvide.addAddresses(
                        AddressModel.fromJson(items.data));
                    Fluttertoast.showToast(msg: "修改成功",gravity: ToastGravity.CENTER);

                    Navigator.pop(context);
                  }
                }, onError: (e) {});
              }else{
                provide.createAndEditAddresses(context)
                    .doOnListen(() {}).doOnCancel(() {})
                    .listen((items) {
                  print(items.data);
                  if(items.data!=null){
                    /// 列表数据
                    widget._addressManagementProvide.addAddresses(
                        AddressModel.fromJson(items.data));
                    Fluttertoast.showToast(msg: "保存成功",gravity: ToastGravity.CENTER);
                    Navigator.pop(context);
                  }
                }, onError: (e) {});
              }
            },
            child: Container(
              width: ScreenAdapter.width(705),
              height: ScreenAdapter.height(95),
              color: Colors.black,
              child: Center(
                child: Text(
                  widget._addressManagementProvide.addressModel!=null?'修改':'保存',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenAdapter.size(38)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ///获取国家
  void _getCountries(){
    widget.provide.getCountriess().doOnListen(() {}).doOnCancel(() {}).listen((items) {
      print('listen data->$items');
      widget.provide.addCountryList(CountryModelList.fromJson(items.data).list);
    }, onError: (e) {});
  }
}
