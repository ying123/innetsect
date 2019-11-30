import 'package:flutter/material.dart';
import 'package:innetsect/app_navigation_bar.dart';
import 'package:innetsect/app_navigation_bar_provide.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/address_management/address_management_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/binding_sign_in/binding_sign_in_proivde.dart';
import 'package:provide/provide.dart';
import 'package:flutter_picker/flutter_picker.dart';

class SortilegePage extends PageProvideNode{
  final BingdingSignInProvide _bingdingSignInProvide = BingdingSignInProvide.instance;
  final AppNavigationBarProvide _appNavProvide = AppNavigationBarProvide.instance;
  final String pages;

  SortilegePage({this.pages}){
    mProviders.provide(Provider<BingdingSignInProvide>.value(_bingdingSignInProvide));
    mProviders.provide(Provider<AppNavigationBarProvide>.value(_appNavProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return SortilegeContent(_bingdingSignInProvide,_appNavProvide,pages: pages,);
  }
}

class SortilegeContent extends StatefulWidget {
  final BingdingSignInProvide _bingdingSignInProvide;
  final AppNavigationBarProvide _appNavProvide;
  final String pages;
  SortilegeContent(this._bingdingSignInProvide,this._appNavProvide,{this.pages});

  @override
  _SortilegeContentState createState() => new _SortilegeContentState();
}

class _SortilegeContentState extends State<SortilegeContent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  BingdingSignInProvide _bingdingSignInProvide;
  AppNavigationBarProvide _appNavProvide;
  String _name;
  /// 性别
  List _sexList = [
    {"text":"男","value":1},
    {"text":"女","value":2}
  ];
  String _sexName;
  int _sex;
  /// 身份证
  List _identityList=[
    {"text":"身份证","value":0},
    {"text":"护照","value":1},
    {"text":"驾驶证","value":2},
    {"text":"户口本","value":3},
    {"text":"港澳台证件","value":4},
  ];
  String _identityName="身份证";
  int _identityType=0;
  ///证件号
  String _identityNo;
  /// 鞋码
  List _shoeList=[
    "35","35.5","36","37","37.5","38","39",
    "40.5","41","42","42.5","43","44","44.5","45","46"
  ];
  String _shoeName;
  /// 身高
  String _stature;
  /// 体重
  String _weight;

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return new Scaffold(
      key: _scaffoldKey,
      appBar: CustomsWidget().customNav(context: context,

          widget: new Text("抽签登记信息",style: TextStyle(fontSize: ScreenAdapter.size((30)),
            fontWeight: FontWeight.w900 ),
        ), actions: <Widget>[
            widget.pages=="mySetting"?Container():Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: (){
                  CustomsWidget().customShowDialog(context: context,
                      title: "温馨提示",content: "跳过'抽签登记信息'填写,将视为放弃抽签机会,"
                          "确定放弃离开?",
                      cancelTitle: "放弃离开",submitTitle: "继续填写",
                    onCancel: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context){
                          _appNavProvide.currentIndex = 2;
                          return AppNavigationBar();
                        }
                      ), (Route router)=>false);
                    }
                  );
                },
                child: Text("跳过",style: TextStyle(color: Colors.black,
                    fontSize: ScreenAdapter.size(28)),),
              ),
            )
          ]),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("姓名"),
              TextField(
                controller: TextEditingController.fromValue(
                    TextEditingValue(
                        text: _name==null?'':_name,
                        selection: TextSelection.fromPosition(TextPosition(
                            affinity: TextAffinity.downstream,
                            offset: _name.toString().length
                        ))
                    )),
                decoration: InputDecoration(
                    hintText: "请填写真实姓名"
                ),
                onChanged: (val){
                  setState(() {
                    _name = val;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Text("性别"),
              _sexWidget(),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Text("证件类型"),
              _identityWidget(),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Text("证件号"),
              TextField(
                controller: TextEditingController.fromValue(
                    TextEditingValue(
                        text: _identityNo==null?'':_identityNo,
                        selection: TextSelection.fromPosition(TextPosition(
                            affinity: TextAffinity.downstream,
                            offset: _identityNo.toString().length
                        ))
                    )),
                decoration: InputDecoration(
                    hintText: "请填写有效证件号"
                ),
                onChanged: (val){
                  setState(() {
                    _identityNo = val;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Text("鞋码"),
              _shoeWidget(),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Text("身高CM(可选)"),
              _statureWidget(),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Text("体重KG(可选)"),
              _weightWidget(),
            ],
          ),
        )
      ),
      bottomSheet: Container(
        width: ScreenAdapter.width(750),
        padding: EdgeInsets.only(left: 20,right: 20),
        child: RaisedButton(
          textColor: Colors.white,
          color: Colors.black,
          child: Text("提交",style: TextStyle(fontSize: ScreenAdapter.size(28),
              fontWeight: FontWeight.w600),),
          onPressed: (){
            // 提交
            if(_name==null){
              CustomsWidget().showToast(title: "请填写姓名");
            }else if(_sexName==null){
              CustomsWidget().showToast(title: "请选择性别");
            }else if(_identityNo==null){
              CustomsWidget().showToast(title: "请填写证件号");
            }else if(_shoeName==null){
              CustomsWidget().showToast(title: "请选择鞋码");
            }else{
              if(widget.pages=="mySetting"){
                _saveData();
              }else{
                CustomsWidget().customShowDialog(context: context,
                    title: "温馨提示",
                    content: "展会商品抢购在即,请及时填写设置'默认地址'",
                    cancelTitle: "放弃",
                    submitTitle: "去填写",
                    onCancel: (){
                      // 放弃
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (context){
                            _appNavProvide.currentIndex = 2;
                            return AppNavigationBar();
                          }
                      ), (Route router)=>false);
                    },onPressed: (){
                      _saveData();
                    });
              }
            }
          },
        ),
      ),
    );
  }

  _saveData(){
    // 提交信息
    var json = {
      "gender": _sex.toString(),
      "icType": _identityType.toString(),
      "height": _stature.toString(),
      "realName": _name,
      "weight": _weight.toString(),
      "icNo": _identityNo.toString(),
      "feetSize": _shoeName
    };
    _bingdingSignInProvide.submitInfo(json)
        .doOnListen(() {})
        .doOnError((e, stack) {})
        .listen((items) {
      print('brandMallitems=============>${items.data}');
      if (items.data != null) {
        if(widget.pages=="mySetting"){
          CustomsWidget().showToast(title: "提交成功");
          Navigator.pop(context);
        }else{
          //去填写跳转地址管理
          Navigator.push(context, MaterialPageRoute(
              builder: (context){
                return AddressManagementPage(pages:ConstConfig.EXHIBITION_SIGNED_IN);
              }
          ));
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bingdingSignInProvide ??= widget._bingdingSignInProvide;
    _appNavProvide ??= widget._appNavProvide;

    if(widget.pages=="mySetting"){
      _bingdingSignInProvide.getSignInfo()
          .doOnListen(() {})
          .doOnError((e, stack) {})
          .listen((items) {
        print('brandMallitems=============>${items.data}');
        if (items!=null&&items.data != null) {
          _sexList.forEach((item){
            if(item['value']==items.data['gender']){
              _sexName = item['text'];
            }
          });
          _identityList.forEach((item){
            if(item['value']==items.data['icType']){
              _identityType = item['value'] ;
              _identityName = item['text'];
            }
          });
          setState(() {
            _name = items.data['realName'];
            _sex = items.data['gender'];
            _identityNo = items.data['icNo'];
            _stature = items.data['height'].toString();
            _weight = items.data['weight'].toString();
            _shoeName = items.data['feetSize'].toString();
          });
        }
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  /// 性别
  Widget _sexWidget(){
    return InkWell(
      onTap: (){
        Picker(
            adapter: PickerDataAdapter(
                data: _sexList.map((item){
                  return PickerItem(text: Text(item['text']),value: item['value']);
                }).toList()
            ),
            cancelText: "取消",
            cancelTextStyle: TextStyle(color: Colors.blue),
            confirmText: "确定",
            confirmTextStyle: TextStyle(color: Colors.blue),
            changeToFirst: true,
            textAlign: TextAlign.left,
            textStyle: TextStyle(color: Colors.blue,fontSize: ScreenAdapter.size(24)),
            selectedTextStyle: TextStyle(color: Colors.red),
            columnPadding: EdgeInsets.all(20.0),
            itemExtent:40,
            onConfirm: (Picker picker, List value) {
              setState(() {
                _sex = picker.getSelectedValues()[0];
                _sexName = _sexList[value[0]]['text'];
              });
            }
        ).showModal(context);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(_sexName!=null?_sexName:"请选择性别"),
            Icon(Icons.chevron_right,color: Colors.grey,)
          ],
        ),
      ),
    );
  }

  /// 身份证
  Widget _identityWidget(){
    return InkWell(
      onTap: (){
        Picker(
            adapter: PickerDataAdapter(
                data: _identityList.map((item){
                  return PickerItem(text: Text(item['text']),value: item['value']);
                }).toList()
            ),
            cancelText: "取消",
            cancelTextStyle: TextStyle(color: Colors.blue),
            confirmText: "确定",
            confirmTextStyle: TextStyle(color: Colors.blue),
            changeToFirst: true,
            textAlign: TextAlign.left,
            textStyle: TextStyle(color: Colors.blue,fontSize: ScreenAdapter.size(24)),
            selectedTextStyle: TextStyle(color: Colors.red),
            columnPadding: EdgeInsets.all(20.0),
            itemExtent:40,
            onConfirm: (Picker picker, List value) {
              setState(() {
                _identityType = picker.getSelectedValues()[0];
                _identityName = _identityList[value[0]]['text'];
              });
            }
        ).showModal(context);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(_identityName!=null?_identityName:"身份证"),
            Icon(Icons.chevron_right,color: Colors.grey,)
          ],
        ),
      ),
    );
  }

  /// 鞋码
  Widget _shoeWidget(){
    return InkWell(
      onTap: (){
        Picker(
            adapter: PickerDataAdapter(
                data: _shoeList.map((item){
                  return PickerItem(text: Text(item),value: item);
                }).toList()
            ),
            cancelText: "取消",
            cancelTextStyle: TextStyle(color: Colors.blue),
            confirmText: "确定",
            confirmTextStyle: TextStyle(color: Colors.blue),
            changeToFirst: true,
            textAlign: TextAlign.left,
            textStyle: TextStyle(color: Colors.blue,fontSize: ScreenAdapter.size(24)),
            selectedTextStyle: TextStyle(color: Colors.red),
            columnPadding: EdgeInsets.all(20.0),
            itemExtent:40,
            onConfirm: (Picker picker, List value) {
              setState(() {
                _shoeName = _shoeList[value[0]];
              });
            }
        ).showModal(context);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(_shoeName!=null?_shoeName:"请选择鞋码"),
            Icon(Icons.chevron_right,color: Colors.grey,)
          ],
        ),
      ),
    );
  }

  /// 身高
  Widget _statureWidget(){
    return InkWell(
      onTap: (){
        List _statureList = List();
        for(int i=50;i<=230;i++){
          _statureList.add(i);
        }
        Picker(
            adapter: PickerDataAdapter(
                data: _statureList.map((item){
                  return PickerItem(text: Text(item.toString()),value: item);
                }).toList()
            ),
            cancelText: "取消",
            cancelTextStyle: TextStyle(color: Colors.blue),
            confirmText: "确定",
            confirmTextStyle: TextStyle(color: Colors.blue),
            changeToFirst: true,
            textAlign: TextAlign.left,
            textStyle: TextStyle(color: Colors.blue,fontSize: ScreenAdapter.size(24)),
            selectedTextStyle: TextStyle(color: Colors.red),
            columnPadding: EdgeInsets.all(20.0),
            itemExtent:40,
            onConfirm: (Picker picker, List value) {
              setState(() {
                _stature = _statureList[value[0]].toString();
              });
            }
        ).showModal(context);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(_stature!=null?_stature:"请选择身高"),
            Icon(Icons.chevron_right,color: Colors.grey,)
          ],
        ),
      ),
    );
  }

  /// 体重
  Widget _weightWidget(){
    return InkWell(
      onTap: (){
        List _weightList = List();
        for(int i=20;i<=220;i++){
          _weightList.add(i);
        }
        List _childList = List();
        for(int i=0;i<=9;i++){
          _childList.add(i);
        }
        Picker(
            adapter: PickerDataAdapter(
                data: _weightList.map((item){
                  return PickerItem(text: Text(item.toString()),value: item,
                  children: _childList.map((val){
                    return PickerItem(text: Text('.${val.toString()}'),value: val);
                  }).toList());
                }).toList()
            ),
            cancelText: "取消",
            cancelTextStyle: TextStyle(color: Colors.blue),
            confirmText: "确定",
            confirmTextStyle: TextStyle(color: Colors.blue),
            changeToFirst: true,
            textAlign: TextAlign.left,
            textStyle: TextStyle(color: Colors.blue,fontSize: ScreenAdapter.size(24)),
            selectedTextStyle: TextStyle(color: Colors.red),
            columnPadding: EdgeInsets.all(20.0),
            itemExtent:40,
            onConfirm: (Picker picker, List value) {
              print(picker.getSelectedValues());
              setState(() {
                _weight = picker.getSelectedValues()[0].toString()
                    +'.'+picker.getSelectedValues()[1].toString();
              });
            }
        ).showModal(context);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(_weight!=null?_weight:"请选择身高"),
            Icon(Icons.chevron_right,color: Colors.grey,)
          ],
        ),
      ),
    );
  }
}