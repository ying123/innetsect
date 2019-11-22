import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/series/category_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/search/search_screen_page.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_list_provide.dart';
import 'package:innetsect/view_model/mall/search/search_provide.dart';
import 'package:innetsect/view_model/mall/series/series_provide.dart';
import 'package:provide/provide.dart';

/// 品类下视图
class SeriesCategoryChildPage extends PageProvideNode{
  final SeriesProvide _seriesProvide = SeriesProvide.instance;
  final SearchProvide _searchProvide = SearchProvide.instance;
  final CommodityListProvide _commodityListProvide = CommodityListProvide.instance;
  final CategoryModel model;

  SeriesCategoryChildPage({this.model}){
    mProviders.provide(Provider<SeriesProvide>.value(_seriesProvide));
    mProviders.provide(Provider<SearchProvide>.value(_searchProvide));
    mProviders.provide(Provider<CommodityListProvide>.value(_commodityListProvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return SeriesCategoryChildContentPage(_seriesProvide,_searchProvide,_commodityListProvide,model: model);
  }
}
class SeriesCategoryChildContentPage extends StatefulWidget {
  final SeriesProvide _seriesProvide;
  final SearchProvide _searchProvide;
  final CommodityListProvide _commodityListProvide;
  final CategoryModel model;
  SeriesCategoryChildContentPage(this._seriesProvide,this._searchProvide,this._commodityListProvide,{this.model});
  @override
  _SeriesCategoryChildContentPageState createState() => _SeriesCategoryChildContentPageState();
}

class _SeriesCategoryChildContentPageState extends State<SeriesCategoryChildContentPage> {
  SeriesProvide _seriesProvide;
  SearchProvide _searchProvide;
  CommodityListProvide _commodityListProvide;
  // 左侧选择栏
  List<CategoryModel> _subList=[];
  // 右边内容
  CategoryModel _category;
  // 右边内容宽度
  double _width = ScreenAdapter.getScreenWidth()-(ScreenAdapter.getScreenWidth()/5);
  int _leftCatCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Row(
        children: <Widget>[
          new Container(
            width: ScreenAdapter.getScreenWidth()/5,
            color: AppConfig.assistLineColor,
            child: _leftNavList(),
          ),
          _rightList()
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesProvide ??= widget._seriesProvide;
    _searchProvide ??= widget._searchProvide;
    _commodityListProvide ??= widget._commodityListProvide;

    _subList = widget.model.subCatalogs;
    _subList.forEach((item)=>item.isSelected=false);
    _subList[0].isSelected = true;
    _loadRightData(_subList[0]);
  }

  /// 左侧数据加载
  void _loadRightData(CategoryModel model){
    _seriesProvide.getSubCateGory(model.catCode).doOnListen(() { }).doOnCancel(() {}).listen((items) {
      ///加载数据
      print('listen data->$items');
      if(items!=null&&items.data!=null){
        if(!mounted) return;
        List list = items.data['subCatalogs'];
        Map<String,dynamic> json= {
          'catCode': model.catCode,
          'catName': model.catName,
          'catPic': ''
        };
        list.insert(0, json);
        _category = CategoryModel.fromJosn(items.data);
//        dynamic json = {
//
//        }
//        _category.subCatalogs.insert(0, element)
        setState(() {
          _leftCatCode = model.catCode;
        });

      }

    }, onError: (e) {});
  }

  /// 左侧栏
  Widget _leftNavList(){
    return ListView.builder(
      itemCount: _subList.length,
      itemBuilder: (context,int index) {
        return InkWell(
          onTap: () {
            _subList.forEach((item) => item.isSelected = false);
            setState(() {
              _subList[index].isSelected = true;
            });
            // 选中品类左侧边栏后加载数据
            _loadRightData(_subList[index]);
          },
          child: Container(
            height: ScreenAdapter.height(70),
            alignment: Alignment.center,
            color: _subList[index].isSelected ? Colors.black : AppConfig
                .assistLineColor,
            child: Text(
              _subList[index].catName,
              style: TextStyle(fontSize: ScreenAdapter.size(28),
                  color: _subList[index].isSelected ? Colors.white : Colors
                      .black),
            ),
          ),
        );
      }
    );
  }

  /// 右边区域
  Widget _rightList(){
    return LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: _category!=null? Container(
                    width: _width,
                    child: Column(
                      children: <Widget>[
                        new Padding(padding: EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
                          child: _subTitleWidget("子类"),),
                        new Container(
                          width: double.infinity,
                          padding:EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          child: _cententWidget("subCategory"),
                        ),
                        _category.brands.length>0?
                        new IntrinsicHeight(
                          child: new Column(
                            children: <Widget>[
                              new Padding(padding: EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
                                child: _subTitleWidget("品牌"),),
                              new Container(
                                width: double.infinity,
                                padding:EdgeInsets.only(left: 20),
                                alignment: Alignment.centerLeft,
                                child: _cententWidget("brands"),
                              ),
                            ],
                          ),
                        )
                            :Container()
                      ],
                    ),
                  ):Container()
              )
          );
        }
    );
  }

  Widget _cententWidget(String subTitle){
    List<dynamic> list = subTitle=="subCategory"?_category.subCatalogs:_category.brands;
    return Wrap(
      spacing: 20.0, // 主轴(水平)方向间距
      runSpacing: 20.0, // 纵轴（垂直）方向间距
      alignment: WrapAlignment.start, //沿主轴方向居中
      children:  list.asMap().keys.map((keys){
        String pic = subTitle=="subCategory"?list[keys].catPic:list[keys].brandLogo;
        String name = subTitle=="subCategory"?list[keys].catName:list[keys].name;
        if(keys==0&&subTitle=="subCategory"){
          name = "所有";
        }
        return InkWell(
          onTap: (){
            _searchProvide.searchValue = subTitle=="subCategory"?list[keys].catName:list[keys].name;
            // 品类搜索
            if(subTitle=="subCategory"){
              _searchRequest(catCode:list[keys].catCode);
            }else{
              _searchRequest(catCode:_leftCatCode,brands:name);
            }
          },
          child: new Container(
            width: _width/4,
            height: ScreenAdapter.height(120),
            child: Column(
              children: <Widget>[
                new Container(
                  width: ScreenAdapter.width(80),
                  height: ScreenAdapter.height(80),
                  child: new ClipOval(
                    child:pic==""?Image.asset("assets/images/mall/hot_brand1.png"): Image.network(pic),
                  ),
                ),
                Container(
                  width: ScreenAdapter.width(120),
                  height: ScreenAdapter.height(40),
                  alignment: Alignment.center,
                  child: Text(name,style: TextStyle(color: Colors.black,fontSize: ScreenAdapter.size(20)),),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  /// 子标题
  Widget _subTitleWidget(String title){
    return Row(
      children: <Widget>[
        new Container(
          width:_width/3,
          height: ScreenAdapter.height(32),
          alignment: Alignment.centerRight,
          child: Divider(color: Colors.grey,),
        ),
        new Container(
          width:_width/3-40,
          height: ScreenAdapter.height(32),
          alignment: Alignment.center,
          child: new Text(title,style: TextStyle(color: Colors.black,fontSize: ScreenAdapter.size(24)),),
        ),
        new Container(
          width:_width/3,
          height: ScreenAdapter.height(32),
          alignment: Alignment.centerLeft,
          child: Divider(color: Colors.grey,),
        )
      ],
    );
  }

  /// 搜索请求
  void _searchRequest({int catCode,String brands}){
    // 清除原数据
    _commodityListProvide.clearList();
    String brandParams = 'brand=';
    if(brands!=null){
      brandParams = 'brand=$brands';
    }
    _commodityListProvide.requestUrl = "/api/eshop/app/products/filterByCatCode?catCode=$catCode&$brandParams";
    _searchProvide.onSearch(_commodityListProvide.requestUrl+'&pageNo=1&pageSize=8').doOnListen(() { }).doOnCancel(() {}).listen((items) {
      ///加载数据
      print('listen data->$items');
      if(items!=null&&items.data!=null){
        if(!mounted) return;
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
