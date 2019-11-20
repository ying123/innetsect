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
    return Provide<SeriesProvide>(
      builder: (BuildContext context, Widget widget,SeriesProvide provide){
        return LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraint.maxHeight),
                      child: _seriesProvide.category!=null? Container(
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
                            _seriesProvide.category.brands.length>0?
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
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _seriesProvide ??= widget._seriesProvide;
  }

  Provide<SeriesProvide> _cententWidget(String subTitle){
    return Provide<SeriesProvide>(
      builder: (BuildContext context,Widget widget,SeriesProvide provide){
        List<dynamic> list = subTitle=="subCategory"?provide.category.subCatalogs:provide.category.brands;
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
      },
    );
  }

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
