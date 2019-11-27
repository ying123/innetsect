import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/series/approved_model.dart';
import 'package:innetsect/view/mall/search/search_screen_page.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_list_provide.dart';
import 'package:innetsect/view_model/mall/search/search_provide.dart';
import 'package:innetsect/view_model/mall/series/series_provide.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:provide/provide.dart';

/// 品牌
class SeriesAzListPage extends PageProvideNode {
  final SeriesProvide _seriesProvide = SeriesProvide.instance;
  final SearchProvide _searchProvide = SearchProvide.instance;
  final CommodityListProvide _commodityListProvide = CommodityListProvide.instance;

  SeriesAzListPage() {
    mProviders.provide(Provider<SeriesProvide>.value(_seriesProvide));
    mProviders.provide(Provider<SearchProvide>.value(_searchProvide));
    mProviders.provide(Provider<CommodityListProvide>.value(_commodityListProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return SeriesAzListContent(_seriesProvide,_searchProvide,_commodityListProvide);
  }
}

class SeriesAzListContent extends StatefulWidget {
  final SeriesProvide _seriesProvide;
  final SearchProvide _searchProvide;
  final CommodityListProvide _commodityListProvide;
  SeriesAzListContent(this._seriesProvide,this._searchProvide,this._commodityListProvide);
  @override
  _SeriesAzListContentState createState() => _SeriesAzListContentState();
}

class _SeriesAzListContentState extends State<SeriesAzListContent> {
  SeriesProvide _seriesProvide;
  SearchProvide _searchProvide;
  CommodityListProvide _commodityListProvide;
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
    _searchProvide ??= widget._searchProvide;
    _commodityListProvide ??= widget._commodityListProvide;
    _initLoadData();
  }

  /// 初始化数据
  void _initLoadData() {
    _seriesProvide.seriesListData().doOnListen(() {}).doOnCancel(() {}).listen(
        (items) {
      ///加载数据
      print('listen data->${items.data}');
      if (items != null && items.data != null) {
        if (!mounted) return;
        _list = ApprovedModelList.fromJson(items.data).list;
        _handleList(_list);
        print('_suspensionTag===----->$_list[0].getSuspensionTag()');
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
    list.sort((a, b) {
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
                border: Border(
                    bottom: BorderSide(color: AppConfig.assistLineColor))),
            child: ListTile(
              leading: CircleAvatar(
                child: Image.network(model.brandLogo),
              ),
              title: Text(model.name),
              onTap: () {
                print("OnItemClick: $model");
                // 点击跳转筛选页
                _searchProvide.searchValue = model.name;
                _searchRequest(model.name);
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

  /// 搜索请求
  void _searchRequest(String name){
    // 清除原数据
    _commodityListProvide.clearList();
    _commodityListProvide.requestUrl = "/api/eshop/app/products/filterByBrand?brand=$name";
    _searchProvide.onSearch(_commodityListProvide.requestUrl+'&pageNo=1&pageSize=8').doOnListen(() { }).doOnCancel(() {}).listen((items) {
      ///加载数据
      print('listen data->$items');
      if(items!=null&&items.data!=null){
        _commodityListProvide.addList(CommodityList.fromJson(items.data).list);
      }

    }, onError: (e) {});

    Navigator.push(context, MaterialPageRoute(
        builder: (context){
          return SearchScreenPage();
        }
    ));
  }
}
