import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/mall/series/series_provide.dart';
import 'package:provide/provide.dart';

/// 品类右侧显示
class SeriesRightPage extends PageProvideNode{
  final SeriesProvide _seriesProvide = SeriesProvide.instance;
  SeriesRightPage(){
    mProviders.provide(Provider<SeriesProvide>.value(_seriesProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return SeriesRightContent(_seriesProvide);
  }
}

class SeriesRightContent extends StatefulWidget {
  final SeriesProvide _seriesProvide;
  SeriesRightContent(this._seriesProvide);

  @override
  _SeriesRightContentState createState() => _SeriesRightContentState();
}

class _SeriesRightContentState extends State<SeriesRightContent> {
  SeriesProvide _seriesProvide;
  double _width = ScreenAdapter.getScreenWidth()-(ScreenAdapter.getScreenWidth()/5);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          new Padding(padding: EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
          child: Row(
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
                child: new Text("子类",style: TextStyle(color: Colors.black,fontSize: ScreenAdapter.size(24)),),
              ),
              new Container(
                width:_width/3,
                height: ScreenAdapter.height(32),
                alignment: Alignment.centerLeft,
                child: Divider(color: Colors.grey,),
              )
            ],
          ),),
          new Container(
            width: double.infinity,
            alignment: Alignment.center,
            child:SingleChildScrollView(
              child: _cententWidget(),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _seriesProvide ??= widget._seriesProvide;
  }

  Provide<SeriesProvide> _cententWidget(){
    return Provide<SeriesProvide>(
      builder: (BuildContext context,Widget widget,SeriesProvide provide){
        return Wrap(
          spacing: 20.0, // 主轴(水平)方向间距
          runSpacing: 20.0, // 纵轴（垂直）方向间距
          alignment: WrapAlignment.start, //沿主轴方向居中
          children: provide.category.subCatalogs.map((item){
            return new Container(
              width: _width/4,
              height: ScreenAdapter.height(120),
              child: Column(
                children: <Widget>[
                  new Container(
                    width: ScreenAdapter.width(80),
                    height: ScreenAdapter.height(80),
                    child: new ClipOval(
                      child:item.catPic==""?Image.asset("assets/images/mall/hot_brand1.png"): Image.network(item.catPic),
                    ),
                  ),
                  Container(
                    width: ScreenAdapter.width(120),
                    height: ScreenAdapter.height(40),
                    alignment: Alignment.center,
                    child: Text(item.catName,style: TextStyle(color: Colors.black,fontSize: ScreenAdapter.size(20)),),
                  )
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
