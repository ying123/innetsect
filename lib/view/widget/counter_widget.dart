import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';

class CounterWidget extends StatefulWidget {
  final CommodityAndCartProvide _provide;
  CounterWidget(this._provide);

  @override
  _CounterWidgetState createState() => new _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  CommodityAndCartProvide provide;
  int count;

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _reduceWidget(),
        _showNumWidget(),
        _incrementWidget()
      ],
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.provide = widget._provide;
    setState(() {
      count = this.provide.count;
    });
  }

  /// 减少按钮
  Widget _reduceWidget(){
    return new InkWell(
      onTap: (){
        this.provide.reduce();
        setState(() {
          count = this.provide.count;
        });
      },
      child: new Container(
        width: ScreenAdapter.width(80),
        height: ScreenAdapter.height(80),
        child: Icon(Icons.remove,color: AppConfig.assistFontColor,),
      ),
    );
  }

  /// 显示数字框
  Widget _showNumWidget(){
    return new Container(
      height: ScreenAdapter.height(80),
      padding: EdgeInsets.only(left: 5,right: 5),
      margin: EdgeInsets.only(left: 10,right: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppConfig.backGroundColor,
        borderRadius: BorderRadius.circular(8)
      ),
      child: new Text(this.count.toString(),style: TextStyle(
        fontSize: ScreenAdapter.size(38),
        fontWeight: FontWeight.w900
      ),),
    );
  }

  /// 增加按钮
  Widget _incrementWidget(){
    return new InkWell(
      onTap: (){
        this.provide.increment();
        setState(() {
          count = this.provide.count;
        });
      },
      child: new Container(
        width: ScreenAdapter.width(80),
        height: ScreenAdapter.height(80),
        child: Icon(Icons.add,color: AppConfig.assistFontColor,),
      ),
    );
  }
}