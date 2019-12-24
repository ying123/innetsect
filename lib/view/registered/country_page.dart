import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/series/approved_country_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/my/address_management/new_address/new_address_provide.dart';
import 'package:innetsect/view_model/registered/registered_provide.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:provide/provide.dart';

class CountryPage extends PageProvideNode{

  final NewAddressProvide _provide = NewAddressProvide.instance;
  final RegisteredProvide _registeredProvide = RegisteredProvide.instance;

  CountryPage(){
    mProviders.provide(Provider<NewAddressProvide>.value(_provide));
    mProviders.provide(Provider<RegisteredProvide>.value(_registeredProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return CountryContentPage(_provide, _registeredProvide);
  }
}

class CountryContentPage extends StatefulWidget {
  final NewAddressProvide _provide;
  final RegisteredProvide _registeredProvide;
  CountryContentPage(this._provide,this._registeredProvide);

  @override
  _CountryContentPageState createState() => _CountryContentPageState();
}

class _CountryContentPageState extends State<CountryContentPage> {
  NewAddressProvide _provide;
  RegisteredProvide _registeredProvide;
  List<ApprovedCountryModel> _countryList=[];
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
        data: _countryList,
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
    _registeredProvide ??= widget._registeredProvide;
    _initLoadData();
  }

  /// 初始化数据
  void _initLoadData() {
    _provide.getCountriess().doOnListen(() {}).doOnCancel(() {}).listen(
            (items) {
          ///加载数据
          print('listen data->${items.data}');
          if (items != null && items.data != null) {
            if (!mounted) return;
            _countryList = ApprovedCountryModelList.fromJson(items.data).list;
            _handleList(_countryList);
//            print('_suspensionTag===----->$_countryList[0].getSuspensionTag()');
            setState(() {
              _suspensionTag = _countryList[0].getSuspensionTag();
            });
          }
        }, onError: (e) {});
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
    _sortListBySuspensionTag(_countryList);
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
            _registeredProvide.telPrefix=model.telPrefix;
            Navigator.pop(context);
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
