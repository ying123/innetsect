import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';

class CounterWidget extends StatefulWidget {
  final CommodityAndCartProvide provide;
  // 商品模型中的数量
  final int count;
  // 数组下标
  final int idx;
  CounterWidget({@required this.provide,this.idx,this.count});

  @override
  _CounterWidgetState createState() => new _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  CommodityAndCartProvide provide;
  int count;

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: this.provide.mode=="multiple"?MainAxisAlignment.end:MainAxisAlignment.center,
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
    this.provide = widget.provide;
    if(this.provide.mode=="multiple"){
      setState(() {
        count = widget.count;
      });
    }else{
      setState(() {
        count = this.provide.count;
      });
    }
  }

  /// 减少按钮
  Widget _reduceWidget(){
    double size = 80.0;
    if(this.provide.mode=="multiple"){
      size=60.0;
    }
    return new InkWell(
      onTap: (){
        this.provide.reduce(idx: widget.idx);
        if(this.provide.mode=="multiple"){
          if(widget.count>=0){
            setState(() {
              count = widget.count;
            });
          }
        }else{
          if(this.provide.count>=0){
            setState(() {
              count = this.provide.count;
            });
          }
        }
      },
      child: new Container(
        width: ScreenAdapter.width(size),
        height: ScreenAdapter.height(size),
        child: Icon(Icons.remove,color: AppConfig.assistFontColor,),
      ),
    );
  }

  /// 显示数字框
  Widget _showNumWidget(){
    double size = 80.0;
    double fontSize = 38.0;
    double circular =8.0;
    if(this.provide.mode=="multiple"){
      size=40.0;
      fontSize=28.0;
      circular=4.0;
    }
    return new Container(
      height: ScreenAdapter.height(size),
      padding: EdgeInsets.only(left: 5,right: 5),
      margin: EdgeInsets.only(left: 10,right: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppConfig.backGroundColor,
        borderRadius: BorderRadius.circular(circular)
      ),
      child: new Text(this.count.toString(),style: TextStyle(
        fontSize: ScreenAdapter.size(fontSize),
        fontWeight: FontWeight.w900
      ),),
    );
  }

  /// 增加按钮
  Widget _incrementWidget(){
    double size = 80.0;
    if(this.provide.mode=="multiple"){
      size=60.0;
    }
    return new InkWell(
      onTap: (){
        this.provide.increment(idx: widget.idx);
        if(this.provide.mode=="multiple"){
          setState(() {
            count = widget.count;
          });
        }else{
          setState(() {
            count = this.provide.count;
          });
        }
      },
      child: new Container(
        width: ScreenAdapter.width(size),
        height: ScreenAdapter.height(size),
        child: Icon(Icons.add,color: AppConfig.assistFontColor,),
      ),
    );
  }
}