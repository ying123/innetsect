import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/data/series/category_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/mall/series/series_provide.dart';
import 'package:provide/provide.dart';

/// 品类下视图
class SeriesCategoryChildPage extends PageProvideNode{
  final SeriesProvide _seriesProvide = SeriesProvide.instance;
  final CategoryModel model;

  SeriesCategoryChildPage({this.model}){
    mProviders.provide(Provider<SeriesProvide>.value(_seriesProvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return SeriesCategoryChildContentPage(_seriesProvide,model: model);
  }
}
class SeriesCategoryChildContentPage extends StatefulWidget {
  final SeriesProvide _seriesProvide;
  final CategoryModel model;
  SeriesCategoryChildContentPage(this._seriesProvide,{this.model});
  @override
  _SeriesCategoryChildContentPageState createState() => _SeriesCategoryChildContentPageState();
}

class _SeriesCategoryChildContentPageState extends State<SeriesCategoryChildContentPage> {
  SeriesProvide _seriesProvide;
  // 左侧选择栏
  List<CategoryModel> _subList=[];
  // 右边内容
  CategoryModel _category;
  // 右边内容宽度
  double _width = ScreenAdapter.getScreenWidth()-(ScreenAdapter.getScreenWidth()/5);

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

    _subList = widget.model.subCatalogs;
    _subList.forEach((item)=>item.isSelected=false);
    _subList[0].isSelected = true;
    _loadRightData(_subList[0].catCode);
  }

  /// 左侧数据加载
  void _loadRightData(int catCode){
    _seriesProvide.getSubCateGory(catCode).doOnListen(() { }).doOnCancel(() {}).listen((items) {
      ///加载数据
      print('listen data->$items');
      if(items!=null&&items.data!=null){
        if(!mounted) return;
        setState(() {
          _category = CategoryModel.fromJosn(items.data);
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
            _loadRightData(_subList[index].catCode);
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
      children:  list.map((item){
        String pic = subTitle=="subCategory"?item.catPic:item.brandLogo;
        String name = subTitle=="subCategory"?item.catName:item.name;
        return new Container(
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

}
