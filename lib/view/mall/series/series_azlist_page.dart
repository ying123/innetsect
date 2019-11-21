import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/series/approved_model.dart';
import 'package:innetsect/view_model/mall/series/series_provide.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:provide/provide.dart';

/// 品牌
class SeriesAzListPage extends PageProvideNode{

  final SeriesProvide _seriesProvide = SeriesProvide.instance;

  SeriesAzListPage(){
    mProviders.provide(Provider<SeriesProvide>.value(_seriesProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return SeriesAzListContent(_seriesProvide);
  }
}

class SeriesAzListContent extends StatefulWidget {
  final SeriesProvide _seriesProvide;
  SeriesAzListContent(this._seriesProvide);
  @override
  _SeriesAzListContentState createState() => _SeriesAzListContentState();
}

class _SeriesAzListContentState extends State<SeriesAzListContent> {
  SeriesProvide _seriesProvide;
  //品牌list
  List<ApprovedModel> _list = [];
  int _itemHeight = 60;
  int _suspensionHeight = 40;
  String _suspensionTag = "";

  @override
  Widget build(BuildContext context) {
    return AzListView(
      data: _list,
      isUseRealIndex: true,
      itemBuilder: (context, model) => _buildListItem(model),
      suspensionWidget: _buildSusWidget(_suspensionTag),
      onSusTagChanged: _onSusTagChanged,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesProvide ??= widget._seriesProvide;
    _initLoadData();
  }

  /// 初始化数据
  void _initLoadData(){
    _seriesProvide.seriesListData().doOnListen(() { }).doOnCancel(() {}).listen((items) {
      ///加载数据
      print('listen data->$items');
      if(items!=null&&items.data!=null){
        if(!mounted) return;
        _list = ApprovedModelList.fromJson(items.data).list;
        _handleList(_list);
        setState(() {
          _suspensionTag = _list[0].getSuspensionTag();
        });
      }

    }, onError: (e) {});
  }

  /// 排序
  void _handleList(List<ApprovedModel> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    list.sort((a,b){
      String pinyinA = PinyinHelper.getPinyinE(a.name);
      String pinyinB = PinyinHelper.getPinyinE(b.name);
      dynamic tagA = pinyinA.substring(1, 2).toLowerCase();
      dynamic tagB = pinyinB.substring(1, 2).toLowerCase();
      return tagA.compareTo(tagB);
    });
    //根据 #,A-Z 排序
    _sortListBySuspensionTag(_list);

  }

  /// 重置排序
  void _sortListBySuspensionTag(List<ISuspensionBean> list) {
    if (list == null || list.isEmpty) return;
    list.sort((a, b) {
        return a.getSuspensionTag().compareTo(b.getSuspensionTag());
    });
  }

  ///数据展示
  Widget _buildListItem(ApprovedModel model) {
    String susTag = model.getSuspensionTag();
    return Column(
      children: <Widget>[
        Offstage(
          offstage: model.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        SizedBox(
          height: _itemHeight.toDouble(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: AppConfig.assistLineColor))
            ),
            child:  ListTile(
              leading: CircleAvatar(
                child: Image.network(model.brandLogo),
              ),
              title: Text(model.name),
              onTap: () {
                print("OnItemClick: $model");
              },
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
          Text(
            '$susTag', softWrap: false,
            style: TextStyle(
              fontSize: 14.0,
              color: Color(0xff999999),
            )
          )
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
