import 'package:azlistview/azlistview.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/data/exhibition/halls_e6_model.dart';
import 'package:innetsect/data/exhibition/halls_model.dart';
import 'package:innetsect/data/exhibition/venue_halls_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/venues_map/venues_halls_e6_provide.dart';
import 'package:provide/provide.dart';
import 'package:lpinyin/lpinyin.dart';
class VenuesHallsE6Page extends PageProvideNode {
  final VenuesHallsE6Provide _provide = VenuesHallsE6Provide();
  List<HallsModel> venueHallsE6;
  VenuesHallsE6Page(this.venueHallsE6){
    mProviders.provide(Provider<VenuesHallsE6Provide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
 
    return VenuesHallsContentPage(_provide,venueHallsE6);
  }
}


class VenuesHallsContentPage extends StatefulWidget {
 final VenuesHallsE6Provide _provide;
 List<HallsModel> venueHallsE6;
  VenuesHallsContentPage(this._provide,this.venueHallsE6);
  @override
  _VenuesHallsContentPageState createState() => _VenuesHallsContentPageState();
}

class _VenuesHallsContentPageState extends State<VenuesHallsContentPage> {
  VenuesHallsE6Provide _provide;
  List<HallsModel> venueHallsE6;

  //品牌
  List<HallsE6Model> _list = [];
  int _itemHeight = 60;
  //悬浮高度
  int _suspensionHeight = 40;
  //悬浮目标
  String _suspensionTag = "";
  @override
  void initState() { 
    super.initState();
    _provide??= widget._provide;
    venueHallsE6??= widget.venueHallsE6;
    _initLoadData();
    print('venueHallsE6=====>${widget.venueHallsE6}');
  }

  void _initLoadData(){
    _provide.hallsData(venueHallsE6[1].exhibitionID, venueHallsE6[1].exhibitionHall).doOnListen((){}).doOnCancel((){

    }).listen((items){
       ///加载数据
      print('listen data-------->${items.data}');
      if (items != null && items.data != null) {
        _list = HallsE6ModelList.fromJson(items.data).list;
        for (var i = 0; i < _list.length; i++) {
          if (_list[i].name == null || _list[i].name == '#') {
            _list.removeAt(i);
          }
        }
        print('_list =====>$_list');
        _handleList(_list);
        setState(() {
          _suspensionTag = _list[0].getSuspensionTag();
        });
      }
    });
  }

  /// 排序
  void _handleList(List<HallsE6Model> list) {
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
  Widget _buildListItem(HallsE6Model model) {
    print('model----------->model.name');
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
              leading: Container(
                width: ScreenAdapter.width(100),
                height: ScreenAdapter.height(50),
                color: Colors.black,
                child: Center(
                  child: Text(model.locCode, style: TextStyle(color: Colors.white),),
                ),
              ),
              //Icon(Icons.compare),
              // CircleAvatar(
              //   child: Image.network(model.brandLogo),
              // ),
              title: Text(model.name),
              onTap: () {
                print("OnItemClick: $model");
                // 点击跳转筛选页
                // _searchProvide.searchValue = model.name;
                // _searchRequest(model.name);
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
}