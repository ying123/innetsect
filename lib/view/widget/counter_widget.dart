import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/commodity_types_model.dart';
import 'package:innetsect/enum/commodity_cart_types.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';

class CounterWidget extends StatefulWidget {
  final CommodityAndCartProvide provide ;
  final CommodityDetailProvide detailProvide;
  // 数组下标
  final int idx;
  // 购物车商品列表
  final CommodityModels model;
  CounterWidget({this.provide,this.idx,this.model,this.detailProvide});

  @override
  _CounterWidgetState createState() => new _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  CommodityDetailProvide _detailProvide;
  CommodityAndCartProvide provide;
  CommodityModels model;
  int count=1;
  bool isBadges = false;

  @override
  Widget build(BuildContext context) {
      return Column(
        children: <Widget>[
          model!=null&&model.panicBuyQtyPerAcct!=null?Text("每人限购${model.panicBuyQtyPerAcct}件",style: TextStyle(
            color: AppConfig.blueBtnColor,fontSize: ScreenAdapter.size(24)
          ),):Container(width: 0,height: 0,),
          Row(
            mainAxisAlignment: this.provide.mode=="multiple"?MainAxisAlignment.end:MainAxisAlignment.center,
            children: <Widget>[
              _reduceWidget(),
              _showNumWidget(),
              _incrementWidget()
            ],
          )
        ],
      );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.provide = widget.provide;
    this._detailProvide ??= widget.detailProvide;
    this.model = widget.model;

    if(this.model==null){
      this.model = CommodityModels();
    }
    if(this.provide.mode!="multiple"){
      setState(() {
        count = widget.provide.count;
      });
    }
    if(this.provide.mode=="multiple"){
      setState(() {
        count=widget.model.quantity;
      });
    }
    this.model.quantity = widget.provide.count;
    if(_detailProvide.commodityModels.badges!=null&&_detailProvide.commodityModels.badges.length>0){
      _detailProvide.commodityModels.badges.forEach((items){
        if(items.name=="售罄"){
          setState(() {
            isBadges = true;
          });
        }
      });
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
//    widget.provide.setInitCount();
  }

  /// 减少按钮
  Widget _reduceWidget(){
    double size = 80.0;
    if(this.provide.mode=="multiple"){
      size=60.0;
    }

    return new InkWell(
      onTap: (){
        if(!isBadges) {
          if (model.panicBuyQtyPerAcct == null ||
              (model.panicBuyQtyPerAcct != null &&
                  model.panicBuyQtyPerAcct > 1)) {
            // 判断规则选项
            if(this._detailProvide.skusModel==null
                ||(this._detailProvide.skusModel.features[0].featureValue==null
                    &&this._detailProvide.skusModel.features[1].featureValue==null)){
              CustomsWidget().showToast(title: "请选择颜色和尺码");
            }else if (this._detailProvide.skusModel.features[1].featureValue == null) {
              CustomsWidget().showToast(title: "请选择颜色");
            } else if (this._detailProvide.skusModel.features[0].featureValue == null) {
              CustomsWidget().showToast(title: "请选择尺码");
            } else {
              this.provide.reduce(idx: widget.idx, model: widget.model);
              if (this.provide.mode != "multiple") {
                setState(() {
                  count = this.provide.count;
                });
              } else {
                // 如果商品减少到0，提示删除

                List<CommodityTypesModel> list = this.provide
                    .commodityTypesModelLists;
                String types = model.shopID == 37 ? CommodityCartTypes.commodity
                    .toString() : CommodityCartTypes.exhibition.toString();
                list.forEach((item) {
                  if (item.types == types
                      && item.commodityModelList[widget.idx].quantity == 0) {
                    CustomsWidget().customShowDialog(context: context,
                        content: "是否删除该商品",
                        onCancel: () {
                          this.provide.setQuantity(item
                              .commodityModelList[widget.idx], widget.idx);
                          Navigator.pop(context);
                        },
                        onPressed: () {
                          this.provide.removeCarts(
                              item.commodityModelList[widget.idx])
                              .doOnListen(() {}).doOnCancel(() {})
                              .listen((res) {
                            if (res.data != null) {
                              this.provide.onDelCountToZero(idx: widget.idx,
                                  model: widget.model,
                                  mode: "multiple");
                              CustomsWidget().showToast(title: "删除成功");
                              Navigator.pop(context);
                            }
                          }, onError: (e) {});
                        }
                    );
                  }
                });
              }
            }
          }
        }
      },
      child: new Container(
        width: ScreenAdapter.width(size),
        alignment: Alignment.center,
        child: Icon(Icons.remove,color: isBadges?Colors.black12: AppConfig.assistFontColor,),
      ),
    );
  }

  /// 显示数字框
  Widget _showNumWidget(){
    double fontSize = 38.0;
    double circular =8.0;
    if(this.provide.mode=="multiple"){
      fontSize=28.0;
      circular=4.0;
    }

    return new Container(
      padding: EdgeInsets.only(bottom: 5,left: 5,right: 5,top: 2),
      margin: EdgeInsets.only(left: 10,right: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppConfig.backGroundColor,
        borderRadius: BorderRadius.circular(circular)
      ),
      child: new Text(this.provide.mode=="multiple"?widget.model.quantity.toString():
      widget.provide.count.toString(),style: TextStyle(
        fontSize: ScreenAdapter.size(fontSize),
        fontWeight: FontWeight.w900,
        color:isBadges?Colors.black12: model!=null&&model.panicBuyQtyPerAcct!=null&&model.panicBuyQtyPerAcct<2
            ?Colors.grey:Colors.black
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
        if(model.panicBuyQtyPerAcct==null||
            (model.panicBuyQtyPerAcct!=null&&model.panicBuyQtyPerAcct>1)){
          // 判断规则选项
          if(this._detailProvide.skusModel==null
              ||(this._detailProvide.skusModel.features[0].featureValue==null
                  &&this._detailProvide.skusModel.features[1].featureValue==null)){
            CustomsWidget().showToast(title: "请选择颜色和尺码");
          }else if(this._detailProvide.skusModel.features[1].featureValue==null){
            CustomsWidget().showToast(title: "请选择颜色");
          }else if(this._detailProvide.skusModel.features[0].featureValue==null){
            CustomsWidget().showToast(title: "请选择尺码");
          }else{
            // 判断数量不能超过库存数量
            if(this.provide.count>=_detailProvide.skusModel.qtyInHand){
              CustomsWidget().showToast(title: "数量超出范围");
            }else{
              this.provide.increment(idx: widget.idx,model: widget.model);
              if(this.provide.mode!="multiple"){
                this.model.quantity=this.provide.count;
                setState(() {
                  count = this.provide.count;
                });
              }
            }
          }
        }
      },
      child: new Container(
        width: ScreenAdapter.width(size),
        alignment: Alignment.center,
        child: Icon(Icons.add,color: isBadges?Colors.black12:AppConfig.assistFontColor,),
      ),
    );
  }
}