import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/data/series/category_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/mall/series/series_provide.dart';
import 'package:provide/provide.dart';

/// 左侧栏
class SeriesLeftNavPage extends PageProvideNode{
  final SeriesProvide _seriesProvide = SeriesProvide.instance;
  final CategoryModel model;

  SeriesLeftNavPage({this.model}){
    mProviders.provide(Provider<SeriesProvide>.value(_seriesProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return SeriesLeftNavContent(_seriesProvide,model: model,);
  }
}
class SeriesLeftNavContent extends StatefulWidget {
  final SeriesProvide _seriesProvide;
  final CategoryModel model;
  SeriesLeftNavContent(this._seriesProvide,{this.model});
  @override
  _SeriesLeftNavContentState createState() => _SeriesLeftNavContentState();
}

class _SeriesLeftNavContentState extends State<SeriesLeftNavContent> {
  SeriesProvide _seriesProvide;
  List<CategoryModel> _subList=[];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _subList.length,
        itemBuilder: (context,int index){
          return InkWell(
            onTap: (){
              _subList.forEach((item)=>item.isSelected=false);
              setState(() {
                _subList[index].isSelected = true;
              });

              // 选中品类左侧边栏
              _loadData(_subList[index].catCode);
            },
            child: Container(
              height: ScreenAdapter.height(70),
              alignment: Alignment.center,
              color: _subList[index].isSelected?Colors.black:AppConfig.assistLineColor,
              child: Text(
                _subList[index].catName,
                style: TextStyle(fontSize: ScreenAdapter.size(28),
                    color: _subList[index].isSelected?Colors.white:Colors.black),
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesProvide ??= widget._seriesProvide;
    _subList = widget.model.subCatalogs;
    _subList.forEach((item)=>item.isSelected=false);
    _subList[0].isSelected = true;
    _loadData(_subList[0].catCode);
  }

  void _loadData(int catCode){
    _seriesProvide.getSubCateGory(catCode).doOnListen(() { }).doOnCancel(() {}).listen((items) {
      ///加载数据
      print('listen data->$items');
      if(items!=null&&items.data!=null){
        _seriesProvide.onCheckCatCode(CategoryModel.fromJosn(items.data));
      }

    }, onError: (e) {});
  }
}
