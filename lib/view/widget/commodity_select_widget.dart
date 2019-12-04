import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/data/commodity_feature_model.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/commodity_skus_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:innetsect/base/base.dart';
import 'package:provide/provide.dart';

class CommoditySelectWidget extends PageProvideNode{
  final CommodityAndCartProvide _cartProvide=CommodityAndCartProvide.instance;
  final CommodityDetailProvide _detailProvide=CommodityDetailProvide.instance;

  CommoditySelectWidget(){
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_cartProvide));
    mProviders.provide(Provider<CommodityDetailProvide>.value(_detailProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return CommoditySelectContentWidget(_cartProvide,_detailProvide);
  }
}

/// 单选
class CommoditySelectContentWidget extends StatefulWidget {
  final CommodityAndCartProvide _cartProvide;
  final CommodityDetailProvide _detailProvide;
  CommoditySelectContentWidget(this._cartProvide,this._detailProvide);
  @override
  _CommoditySelectContentWidgetState createState() => new _CommoditySelectContentWidgetState();
}

class _CommoditySelectContentWidgetState extends State<CommoditySelectContentWidget> {
  CommodityAndCartProvide _cartProvide;
  CommodityDetailProvide _detailProvide;

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          _topContentWidget(),
          _bottomContentWidget()
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._cartProvide = widget._cartProvide;
    this._detailProvide = widget._detailProvide;
  }

  /// 上半部分
  Provide<CommodityDetailProvide> _topContentWidget(){
    return Provide<CommodityDetailProvide>(
      builder: (BuildContext context,Widget widget,CommodityDetailProvide provide){
        CommoditySkusModel skusModel = provide.skusModel;
        List<CommoditySkusModel> skuModelGroup = provide.skusList;
        return skusModel!=null?new Container(
          width: double.infinity,
          child: new Column(
            children: skuModelGroup.map((item){
              return new InkWell(
                onTap: (){
                  provide.setSelectColor(item,_cartProvide.count);
                  setState(() {});
                },
                child: new Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 10,right: 10),
                  height: ScreenAdapter.height(160),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: new Border(bottom: new BorderSide(
                          width: 1,
                          color: AppConfig.assistLineColor
                      )
                      )
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Container(
                        width: ScreenAdapter.width(120),
                        height: ScreenAdapter.height(120),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color:Colors.white,
                            border: new Border.all(width: 2,
                                color:skusModel.skuCode==item.skuCode?AppConfig.fontBackColor:Colors.white
                            )
                        ),
                        child: item.skuPic!=null?
                        CachedNetworkImage(imageUrl:"${item.skuPic}${ConstConfig.BANNER_TWO_SIZE}"
                          ,fit: BoxFit.fitWidth,)
                            :Image.asset("assets/images/default/default_squre_img.png",fit: BoxFit.fitWidth,),
                      ),
                      new Expanded(
                        flex:1,
                        child: item.features!=null?new Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(left: 10),
                          child: new Text(this.getName(item.features),softWrap: true,
                            style: TextStyle(
                                fontSize: ScreenAdapter.size(32)
                            ),
                          )
                        ):Container(),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ):new Container();
      },
    );
  }
  
  String getName(List<CommodityFeatureModel> res){
    String str ;
    res.forEach((item){
      if(item.featureGroup=="颜色"){
        str = item.featureValue;
      }
    });
    return str;
  }

  /// 下半部分，尺寸的选择
  Provide<CommodityDetailProvide> _bottomContentWidget(){
    return Provide<CommodityDetailProvide>(
        builder: (BuildContext context,Widget widget,CommodityDetailProvide provide){
          CommodityModels model = provide.commodityModels;
          CommoditySkusModel skusModel = provide.skusModel;
          List<CommodityFeatureModel> features = List();
          if(model!=null&&model.features!=null){
            features = model.features;
          }
          return new Container(
            width: double.infinity,
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: features.length>0? features.map((CommodityFeatureModel item){
                // 选中尺码
                return new InkWell(
                  onTap: (){
                    provide.setSelectSku(item,_cartProvide.count);
                    setState(() {});
                  },
                  child: item.featureGroup=="尺码" ?new Container(
                    width: ScreenAdapter.width(100),
                    height: ScreenAdapter.height(100),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 2,
                            color: skusModel.features.any((items)=>items.featureCode==item.featureCode)?AppConfig.fontBackColor:Colors.white
                        )
                    ),
                    alignment: Alignment.center,
                    child: new Text(item.featureValue,style: TextStyle(
                        fontSize: ScreenAdapter.size(32),
                        fontWeight: FontWeight.w900
                    ),),
                  ):new Text(""),
                );
              }).toList():[],
            ),
          );
        }
    );
  }
}