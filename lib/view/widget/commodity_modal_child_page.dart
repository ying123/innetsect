import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/commodity_select_widget.dart';
import 'package:innetsect/view/widget/counter_widget.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:provide/provide.dart';

class CommodityModalChildPage extends StatefulWidget {
  final CommodityAndCartProvide _cartProvide;
  final double _height;
  CommodityModalChildPage(this._cartProvide,this._height);

  @override
  _CommodityModalChildPageState createState() => new _CommodityModalChildPageState();
}

class _CommodityModalChildPageState extends State<CommodityModalChildPage> {
  CommodityAndCartProvide _cartProvide;
  double _height;

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        // 返回按钮
        goBackIcon(),
        // 中间部分
        contentWidget(),
        // 计数器
        counterWidget(),
        // 加入购物车、立即购买
        bottomBtn()
      ],
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._cartProvide = widget._cartProvide;
    this._height = widget._height;
  }

  /// 返回按钮
  Widget goBackIcon(){
    return new Container(
      height: ScreenAdapter.height(60),
      color: Colors.white,
      width: double.infinity,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: new Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: new Icon(Icons.clear),
            )
          )
        ],
      ),
    );
  }
  
  /// 中间选择区域
  Widget contentWidget(){
    return new Container(
      width: double.infinity,
      height: this._height-150,
      color: Colors.white,
      child: new CommoditySelectWidget(this._cartProvide),
    );
  }

  /// 计数器
  Widget counterWidget(){
    return new Container(
      width: double.infinity,
      height: ScreenAdapter.height(100),
      alignment: Alignment.center,
      child: CounterWidget(this._cartProvide),
    );
  }

  /// 底部按钮
  Widget bottomBtn(){
    return new Container(
      width: double.infinity,
      height: this._height-476,
      color: Colors.white,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            width: ScreenAdapter.getScreenWidth()/2,
            padding: EdgeInsets.only(left: 10,right: 5),
            child: new RaisedButton(
              color: AppConfig.fontBackColor,
              textColor: Colors.white,
              onPressed: (){},
              child: new Text("加入购物车",style: TextStyle(
                  fontSize: ScreenAdapter.size(30)
                ),
              ),
            ),
          ),
          new Container(
            width: ScreenAdapter.getScreenWidth()/2,
            padding: EdgeInsets.only(left: 5,right: 10),
            child: new RaisedButton(
              color: AppConfig.primaryColor,
              textColor: AppConfig.fontBackColor,
              onPressed: (){},
              child: new Text("立即购买",style: TextStyle(
                  fontSize: ScreenAdapter.size(30)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}