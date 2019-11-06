import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/commodity_types_model.dart';
import 'package:innetsect/enum/commodity_cart_types.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';

class CounterWidget extends StatefulWidget {
  final CommodityAndCartProvide provide ;
  // 数组下标
  final int idx;
  // 购物车商品列表
  final CommodityModels model;
  CounterWidget({this.provide,this.idx,this.model});

  @override
  _CounterWidgetState createState() => new _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  CommodityAndCartProvide provide;
  CommodityModels model;
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
    this.model = widget.model;
    if(this.provide.mode!="multiple"){
      setState(() {
        count = widget.provide.count;
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
        this.provide.reduce(idx: widget.idx,model: widget.model);
        if(this.provide.mode!="multiple"){
          setState(() {
            count = this.provide.count;
          });
        }else{
          // 如果商品减少到0，提示删除

          List<CommodityTypesModel> list = this.provide.commodityTypesModelLists;
          String types = model.shopID==37?CommodityCartTypes.commodity.toString(): CommodityCartTypes.exhibition.toString();
          list.forEach((item){
            if(item.types == types
              && item.commodityModelList[widget.idx].quantity==0){
              CustomsWidget().customShowDialog(context: context,
                  content: "是否删除该商品",
                  onPressed: (){
                    this.provide.onDelCountToZero(idx: widget.idx,model: widget.model,mode: "multiple");
                  }
              );
            }
          });
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
    int count = this.count;
    if(this.provide.mode=="multiple"){
      size=40.0;
      fontSize=28.0;
      circular=4.0;
      count=widget.model.quantity;
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
      child: new Text(count.toString(),style: TextStyle(
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
        this.provide.increment(idx: widget.idx,model: widget.model);
        if(this.provide.mode!="multiple"){
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