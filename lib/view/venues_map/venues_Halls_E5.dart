import 'package:azlistview/azlistview.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/data/exhibition/halls_model.dart';
import 'package:innetsect/data/exhibition/venue_halls_model.dart';
import 'package:innetsect/data/series/approved_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/venues_map/venues_Halls_e5_provide.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:provide/provide.dart';

class VenuesHallsE5Page extends PageProvideNode {
  VenuesHallsE5Provide _e5provide = VenuesHallsE5Provide();
  List<HallsModel> venueHallsE5;
  VenuesHallsE5Page(this.venueHallsE5) {
    mProviders.provide(Provider<VenuesHallsE5Provide>.value(_e5provide));
    print('E5-------------->${venueHallsE5}');
  }
  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return VenuesHallsE5ContentPage(_e5provide, venueHallsE5);
  }
}

class VenuesHallsE5ContentPage extends StatefulWidget {
  VenuesHallsE5Provide _e5provide;
  List<HallsModel> venueHallsE5;
  VenuesHallsE5ContentPage(this._e5provide, this.venueHallsE5);
  @override
  _VenuesHallsE5ContentPageState createState() =>
      _VenuesHallsE5ContentPageState();
}

class _VenuesHallsE5ContentPageState extends State<VenuesHallsE5ContentPage> {
  VenuesHallsE5Provide _e5provide;
  List<HallsModel> venueHallsE5;

  List<ApprovedModel> _list = [];
  String _suspensionTag = "";
  int _itemHeight = 60;
  int _suspensionHeight = 40;
  @override
  void initState() {
    super.initState();
    _e5provide ??= widget._e5provide;
    venueHallsE5 ??= widget.venueHallsE5;
    _initLoadData();
  }



  void _initLoadData(){
    _e5provide.hallsData(venueHallsE5[0].exhibitionID, venueHallsE5[0].exhibitionHall).doOnListen((){

    }).doOnCancel((){

    }).listen((items){
       ///加载数据
      print('listen data->$items');
      if (items != null && items.data != null) {
        if (!mounted) return;
        _list = ApprovedModelList.fromJson(items.data).list;
        _handleList(_list);
        print('_suspensionTag===----->${_list[0]}.getSuspensionTag()');
        setState(() {
          _suspensionTag = _list[0].getSuspensionTag();
        });
      }
    });
  }

    @override
  Widget build(BuildContext context) {
    print('_list===>${_list[0].tagIndex}');
    return AzListView(
      data: _list,
      isUseRealIndex: true,
      itemBuilder: (context, model) => _buildListItem(model),
      suspensionWidget: _buildSusWidget(_suspensionTag),
      onSusTagChanged: _onSusTagChanged,
    );
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

}
