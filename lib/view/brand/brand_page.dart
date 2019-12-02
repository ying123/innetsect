import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/exhibition/brand_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/brand/brand_mall_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/brand/brand_provide.dart';
import 'package:provide/provide.dart';
import 'package:lpinyin/lpinyin.dart';

class BrandPage extends PageProvideNode {
  final BrandProvide _provide = BrandProvide();
  BrandPage() {
    mProviders.provide(Provider<BrandProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return BrandContentPage(_provide);
  }
}

class BrandContentPage extends StatefulWidget {
  final BrandProvide _provide;
  BrandContentPage(this._provide);
  @override
  _BrandContentPageState createState() => _BrandContentPageState();
}

class _BrandContentPageState extends State<BrandContentPage>
    with SingleTickerProviderStateMixin {
  BrandProvide _provide;

  //品牌
  List<BrandModel> _list = [];
  int _itemHeight = 60;
  //悬浮高度
  int _suspensionHeight = 40;
  //悬浮目标
  String _suspensionTag = "";

  @override
  void initState() {
    _provide??= widget._provide;
    super.initState();
    _initBrandData();
  }
  _initBrandData(){
    _provide.splashData().doOnListen((){

    }).doOnError((e, stack){

    }).listen((item){
      print('item)))))))))))${item.data}');
      if (item!= null) {
        _provide.brandModel(item.data['exhibitionID']).doOnListen((){

        }).doOnError((e, stack){

        }).listen((items){
          print('))))))))))))))======>${items.data}');

            ///加载数据
      print('listen data-------->${items.data}');
      if (items != null && items.data != null) {
        _list = BrandModelList.fromJson(items.data).list;
        for (var i = 0; i < _list.length; i++) {
          if (_list[i].brandName == null || _list[i].brandName == '#') {
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
    },onError: (e){

    });
  }

  /// 排序
  void _handleList(List<BrandModel> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      print('==========>list[$i] = ${list[i].brandName}');
      String pinyin = PinyinHelper.getPinyinE(list[i].brandName);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    list.sort((a, b) {
      String pinyinA = PinyinHelper.getPinyinE(a.brandName);
      String pinyinB = PinyinHelper.getPinyinE(b.brandName);
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
  Widget _buildListItem(BrandModel model) {
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
              leading: CircleAvatar(
                child: model.brandLogo==null?
                Image.asset('assets/images/logo.png',fit: BoxFit.cover,):
                Image.network(model.brandLogo),
              ),
              //Icon(Icons.compare),
              // CircleAvatar(
              //   child: Image.network(model.brandLogo),
              // ),
              title: Text(model.brandName),
              onTap: () {
                print("OnItemClick: ${model.brandName}");
                // 点击跳转筛选页
                // _searchProvide.searchValue = model.name;
                 _searchRequest(model.brandName);
             //  Navigator.pushNamed(context, '/brandMallPage');
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
    //_commodityListProvide.clearList();
    //_commodityListProvide.requestUrl = "/api/eshop/app/products/filterByBrand?brand=$name";
    //_searchProvide.onSearch(_commodityListProvide.requestUrl+'&pageNo=1&pageSize=8').doOnListen(() { }).doOnCancel(() {}).listen((items) {
      ///加载数据
     // print('listen data->$items');
      //if(items!=null&&items.data!=null){
       /// _commodityListProvide.addList(CommodityList.fromJson(items.data).list);
     // }

   // }, onError: (e) {});

    Navigator.push(context, MaterialPageRoute(
        builder: (context){
          return BrandMallPage(name);
        }
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomsWidget().customNav(context: context,
        widget: new Text("品牌",style: TextStyle(fontSize: ScreenAdapter.size((30)),
            fontWeight: FontWeight.w900)),leading: false
      ),
      body: AzListView(
        data: _list,
        isUseRealIndex: true,
        itemBuilder: (context, model)=>_buildListItem(model),
        suspensionWidget: _buildSusWidget(_suspensionTag),
        onSusTagChanged: _onSusTagChanged,
      ),
    );

  }
}
