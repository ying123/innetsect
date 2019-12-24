import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/provinces_model.dart';
import 'package:innetsect/data/series/approved_country_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/address_management/city/provinces_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/my/address_management/address_management_provide.dart';
import 'package:innetsect/view_model/my/address_management/new_address/new_address_provide.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:provide/provide.dart';

class CountryPage extends PageProvideNode{

  final NewAddressProvide _provide = NewAddressProvide.instance;
  final AddressManagementProvide _addressManagementProvide = AddressManagementProvide.instance;

  CountryPage(){
    mProviders.provide(Provider<NewAddressProvide>.value(_provide));
    mProviders.provide(Provider<AddressManagementProvide>.value(_addressManagementProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return CountryContentPage(_provide,_addressManagementProvide);
  }
}

class CountryContentPage extends StatefulWidget {
  final NewAddressProvide _provide;
  final AddressManagementProvide _addressManagementProvide;
  CountryContentPage(this._provide,this._addressManagementProvide);

  @override
  _CountryContentPageState createState() => _CountryContentPageState();
}

class _CountryContentPageState extends State<CountryContentPage> {
  NewAddressProvide _provide;
  AddressManagementProvide _addressManagementProvide;
  int _itemHeight = 60;
  int _suspensionHeight = 40;
  String _suspensionTag = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
          widget: new Text("请选择国家/地区",style: TextStyle(fontSize: ScreenAdapter.size((30)),
              fontWeight: FontWeight.w900
          ),
          )
      ),
      body: AzListView(
        data: _provide.countryPageList,
        isUseRealIndex: true,
        itemBuilder: (context, model) => _buildListItem(model),
        suspensionWidget: _buildSusWidget(_suspensionTag),
        onSusTagChanged: _onSusTagChanged,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _provide ??= widget._provide;
    _addressManagementProvide ??= widget._addressManagementProvide;
    _initLoadData();
  }

  /// 初始化数据
  void _initLoadData() {
    if(_provide.countryPageList!=null&&_provide.countryPageList.length>0){
      _handleList(_provide.countryPageList);
//            print('_suspensionTag===----->$_countryList[0].getSuspensionTag()');
      setState(() {
        _suspensionTag = _provide.countryPageList[0].getSuspensionTag();
      });
    }
  }

  /// 排序
  void _handleList(List<ApprovedCountryModel> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      print('==========>list[$i] = ${list[i].name}');
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    //根据 #,A-Z 排序
    _sortListBySuspensionTag(_provide.countryPageList);
  }

  /// 重置排序
  void _sortListBySuspensionTag(List<ISuspensionBean> list) {
    if (list == null || list.isEmpty) return;
    list.sort((a, b) {
      return a.getSuspensionTag().compareTo(b.getSuspensionTag());
    });
  }

  ///数据展示
  Widget _buildListItem(ApprovedCountryModel model) {
    String susTag = model.getSuspensionTag();
    return Column(
      children: <Widget>[
        Offstage(
          offstage: model.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        InkWell(
          onTap: (){
            // 设置参数
            _provide.setCountryModle(model);
            if(model.countryCode=='HK'||model.countryCode=='TW'
            ||model.countryCode=='MO'||model.countryCode=='CN'){
              // 选中国家
              _provide.getProvices(model.countryCode)
                  .doOnListen(() {}).doOnCancel(() {})
                  .listen((items) {
                if(items.data!=null&&items.data.length>0){
                  // 跳转到省份界面
                  _provide.addProvincesList(ProvincesModelList.fromJson(items.data).list);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (BuildContext context){
                        return ProvincesPage();
                      }
                  ));
                }else{
                  Navigator.pop(context);
                }
                print('listen data->$items');
              }, onError: (e) {});
            }else{
              _provide.setForeignAddressModel();
//              _addressManagementProvide.setForeignAddressModel();
              Navigator.pop(context);
            }
          },
          child: Container(
            height: _itemHeight.toDouble(),
            padding: EdgeInsets.only(right: 40,left: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: AppConfig.assistLineColor))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(model.name),
                Text("+ ${model.telPrefix}")
              ],
            ),
          ),
        )
      ],
    );
  }

  /// 标签展示
  Widget _buildSusWidget(String susTag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      height: _suspensionHeight.toDouble(),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Text('$susTag',
              softWrap: false,
              style: TextStyle(
                fontSize: 14.0,
                color: Color(0xff999999),
              ))
        ],
      ),
    );
  }

  /// 顶部标签更新
  void _onSusTagChanged(String tag) {
    setState(() {
      _suspensionTag = tag;
    });
  }
}
