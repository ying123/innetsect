import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/city_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/my/address_management/new_address/new_address_provide.dart';
import 'package:provide/provide.dart';
import 'package:city_pickers/city_pickers.dart';

class NewAddressPage extends PageProvideNode {
  final NewAddressProvide _provide = NewAddressProvide();
  NewAddressPage() {
    mProviders.provide(Provider<NewAddressProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return NewAddressContentPage(_provide);
  }
}

class NewAddressContentPage extends StatefulWidget {
  final NewAddressProvide provide;
  NewAddressContentPage(this.provide);
  @override
  _NewAddressContentPageState createState() => _NewAddressContentPageState();
}

class _NewAddressContentPageState extends State<NewAddressContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('新建收货地址'),
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
                        )
                      ],
                    )
            ),
            InkWell(
              onTap: () async{
                //弹出国家
                Result tempResult = await CityPickers.showCitiesSelector(context: context,citiesData: widget.provide.cityJson);
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
                      )
                    ],
                  )
              ),
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
                          child: Text('所在地区',style: TextStyle(fontSize: ScreenAdapter.size(30)),),
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
                          child: Text('详细地址',style: TextStyle(fontSize: ScreenAdapter.size(30)),),
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
                          child: Text('设置为默认',style: TextStyle(fontSize: ScreenAdapter.size(30)),),
                        )
                      ],
                    )
            ),
          ],
        );
      },
    );
  }

  Provide<NewAddressProvide> _setupBottomBtn() {
    return Provide<NewAddressProvide>(
      builder: (BuildContext context, Widget child, NewAddressProvide provide) {
        return Center(
          child: InkWell(
            onTap: () {
              print('保存被点击');
            },
            child: Container(
              width: ScreenAdapter.width(705),
              height: ScreenAdapter.height(95),
              color: Colors.black,
              child: Center(
                child: Text(
                  '保存',
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
    widget.provide.getCity().doOnListen(() {}).doOnCancel(() {}).listen((items) {
      print('listen data->$items');
      widget.provide.parseMap(CityModelList.fromJson(items.data).list);
    }, onError: (e) {});
  }
}
