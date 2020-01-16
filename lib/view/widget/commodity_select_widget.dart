import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/data/commodity_feature_model.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/commodity_skus_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
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
          _headerContentWidget(),
          _detailProvide.commodityModels.skus.length>1?_colorContentWidget():Text(''),
          _detailProvide.commodityModels.skus.length>1?_sizeContentWidget():Text('')
//          _topContentWidget(),
//          _bottomContentWidget()
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

  /// 顶部
  Provide<CommodityDetailProvide> _headerContentWidget(){
    return Provide<CommodityDetailProvide>(
      builder: (BuildContext context,Widget widget,CommodityDetailProvide provide){
        String price = provide.commodityModels.salesPrice.toString();
        String prodPic=provide.commodityModels.prodPic;
        String title = "请选择";
        String color = "颜色";
        String size = "尺码";

        int index = provide.colorSkuList.indexWhere((items)=>items.isSelected==true);
        int sizeIndex = provide.sizeSkuList.indexWhere((items)=>items.isSelected==true);
        if(index<0&&sizeIndex<0){
          price = provide.commodityModels.salesPriceRange.toString();
        }
        if(index>-1){
          price = provide.commodityModels.salesPrice.toString();
          prodPic = provide.colorSkuList[index].skuPic;
          color = "";
        }
        if(sizeIndex>-1){
          price = provide.commodityModels.salesPrice.toString();
          size = "";
        }
        if(index>-1&&sizeIndex>-1){
          title = "已选";
          size = "\"${provide.skusModel.features[0].featureValue}\"";
          color = "\"${provide.skusModel.features[1].featureValue}\"";
          price = provide.commodityModels.salesPrice.toString();
        }

        return Container(
          width: double.infinity,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  width: ScreenAdapter.width(120),
                  height: ScreenAdapter.height(120),
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(left: 20,right: 15,top: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 5.0)]
                  ),
                  child: Image.network(prodPic,fit: BoxFit.fitWidth,),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // 选中sku价格
                    CustomsWidget().priceTitle(price: price,fontSize: ScreenAdapter.size(42)),
                    // 选择颜色尺码
                    Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Text("$title $color $size",style: TextStyle(color: Colors.black,fontSize: ScreenAdapter.size(28)),)
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
  
  /// 颜色选择部分
  Provide<CommodityDetailProvide> _colorContentWidget(){
    return Provide<CommodityDetailProvide>(
        builder: (BuildContext context,Widget widget,CommodityDetailProvide provide) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 30,left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text("颜色",style: TextStyle(color: Colors.black, fontSize: ScreenAdapter.size(32),fontWeight: FontWeight.w600),),
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children:provide.colorSkuList.length>0? provide.colorSkuList.asMap().keys.map((keys){
                    Color borderColor = Colors.transparent;
                    double borderWidth =0;
                    Color textColor = Colors.black;
                    if( provide.colorSkuList[keys].isSelected){
                      borderWidth = 1;
                      borderColor = AppConfig.blueBtnColor;
                      textColor = AppConfig.blueBtnColor;
                    }else if(provide.colorSkuList[keys].qtyInHand<=0){
                      borderWidth = 0;
                      borderColor = Colors.transparent;
                      textColor = Colors.grey;
                    }
                    return InkWell(
                      onTap: () async{
                        // 选中颜色并改变选中颜色
                        if(provide.colorSkuList[keys].qtyInHand>0){
                          provide.onSelectColor(provide.colorSkuList[keys],_cartProvide.count);
                          /// 选取其他颜色时，如果超出范围，则设置该sku最大数量
                          if(provide.skusModel.qtyInHand<_cartProvide.count){
                            _cartProvide.count = provide.skusModel.qtyInHand;
                          }
                          /// 请求尺码
                          provide.colorAndSizeData(types: provide.commodityModels.shopID,
                              prodId: provide.colorSkuList[keys].prodID,
                              featureGroup: provide.colorSkuList[keys].featureGroup,
                              featureCode: provide.colorSkuList[keys].featureCode).doOnListen(() {
                            print('doOnListen');
                          })
                              .doOnCancel(() {})
                              .listen((item) {
                            if(item!=null&&item.data!=null){
                              /// 根据选中颜色重新设置尺寸
                              List<CommodityFeatureModel> list = CommodityFeatureList.fromJson(item.data).list;
                              // 更新尺码数据
                              provide.sizeSkuList.forEach((items){
                                list.forEach((sizeItem){
                                  if(items.featureValue == sizeItem.featureValue){
                                    items.featureGroup = sizeItem.featureGroup;
                                    items.featureCode = sizeItem.featureCode;
                                    items.featureValue = sizeItem.featureValue;
                                    items.qtyInHand = sizeItem.qtyInHand;
                                  }
                                });
                              });
                              // 选中颜色
//                              provide.colorSkuList.forEach((items)=>items.isSelected = false);
//                              provide.colorSkuList[keys].isSelected = !provide.colorSkuList[keys].isSelected;
                              setState(() {});
                            }
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10,top: 5,bottom: 5,right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black12,
                          border: Border.all(
                              width: borderWidth,
                              color: borderColor
                          )
                        ),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: <Widget>[
                            provide.colorSkuList[keys].skuPic==null?
                            Image.asset("assets/images/default/default_img.png",fit: BoxFit.fitHeight,
                              height: ScreenAdapter.size(80),):
                            Image.network(provide.colorSkuList[keys].skuPic,fit: BoxFit.fitHeight,
                              height: ScreenAdapter.size(80),),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(provide.colorSkuList[keys].featureValue,
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: ScreenAdapter.size(28)),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList():[],
                )
              ],
            ),
          );
    });
  }

  /// 尺码选择
  Provide<CommodityDetailProvide> _sizeContentWidget(){
    return Provide<CommodityDetailProvide>(
        builder: (BuildContext context,Widget widget,CommodityDetailProvide provide) {
       return Container(
         width: double.infinity,
         padding: EdgeInsets.only(top: 30,left: 20),
         child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Padding(
                 padding: EdgeInsets.only(bottom: 10),
                 child: Text("尺码",style: TextStyle(color: Colors.black, fontSize: ScreenAdapter.size(32),fontWeight: FontWeight.w600),),
               ),
               Wrap(
                 spacing: 10,
                 runSpacing: 10,
                 children: provide.sizeSkuList.length>0?  provide.sizeSkuList.asMap()
                     .keys.map((keys){
                     bool sizeSelect = provide.sizeSkuList[keys].isSelected;
                     Color color = Colors.black;
                     if(provide.sizeSkuList[keys].qtyInHand<=0){
                       color = Colors.grey;
                     }
                     if(sizeSelect){
                       color = AppConfig.blueBtnColor;
                     }
                    return InkWell(
                     onTap: (){
                       // 选中尺码并改变尺码颜色
                       ///api/eshop/37/products/15082/otherGroupFeatures?group=尺码&code=L
                       if(provide.sizeSkuList[keys].qtyInHand>0){
                          provide.onSizeChange(provide.sizeSkuList[keys],_cartProvide.count);
                          /// 选取其他尺寸时，如果超出范围，则设置该sku最大数量
                          if(provide.skusModel.qtyInHand<_cartProvide.count){
                            _cartProvide.count = provide.skusModel.qtyInHand;
                          }
                          /// 请求颜色
                          provide.colorAndSizeData(types: provide.commodityModels.shopID,
                              prodId: provide.sizeSkuList[keys].prodID,
                              featureGroup: provide.sizeSkuList[keys].featureGroup,
                              featureCode: provide.sizeSkuList[keys].featureCode).doOnListen(() {
                            print('doOnListen');
                          })
                              .doOnCancel(() {})
                              .listen((item) {
                            if(item!=null&&item.data!=null){
                              /// 根据选中颜色重新设置尺寸
                              List<CommodityFeatureModel> list = CommodityFeatureList.fromJson(item.data).list;
                              // 更新颜色数据
                              provide.colorSkuList.forEach((items){
                                list.forEach((colorItem){
                                  if(items.featureValue == colorItem.featureValue){
                                    items.featureGroup = colorItem.featureGroup;
                                    items.featureCode = colorItem.featureCode;
                                    items.featureValue = colorItem.featureValue;
                                    items.qtyInHand = colorItem.qtyInHand;
                                  }
                                });
                              });
                              // 选中尺码
//                              provide.sizeSkuList.forEach((items)=>items.isSelected = false);
//                              provide.sizeSkuList[keys].isSelected = !provide.sizeSkuList[keys].isSelected;
                              setState(() {});
                            }
                          });
                       }
                     },
                     child: Container(
                       width: ScreenAdapter.width(120),
                       height: ScreenAdapter.height(120),
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(5),
                           color: Colors.black12,
                         border: Border.all(width: sizeSelect?1:0,
                             color: sizeSelect?AppConfig.blueBtnColor:Colors.transparent)
                       ),
                       child: Text(provide.sizeSkuList[keys].featureValue,
                         style: TextStyle(color: color,
                             fontSize: ScreenAdapter.size(28),
                             fontWeight: FontWeight.bold),),
                     ),
                   );
                 }).toList():[],
               )
             ]),
       );
    });
  }

  /// 上半部分
//  Provide<CommodityDetailProvide> _topContentWidget(){
//    return Provide<CommodityDetailProvide>(
//      builder: (BuildContext context,Widget widget,CommodityDetailProvide provide){
//        CommoditySkusModel skusModel = provide.skusModel;
//        List<CommoditySkusModel> skuModelGroup = provide.skusList;
//        return skusModel!=null?new Container(
//          width: double.infinity,
//          child: new Column(
//            children: skuModelGroup.map((item){
//              return new InkWell(
//                onTap: (){
//                  provide.setSelectColor(item,_cartProvide.count);
//                  setState(() {});
//                },
//                child: new Container(
//                  width: double.infinity,
//                  margin: EdgeInsets.only(left: 10,right: 10),
//                  height: ScreenAdapter.height(160),
//                  decoration: BoxDecoration(
//                      color: Colors.white,
//                      border: new Border(bottom: new BorderSide(
//                          width: 1,
//                          color: AppConfig.assistLineColor
//                      )
//                      )
//                  ),
//                  child: new Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    children: <Widget>[
//                      new Container(
//                        width: ScreenAdapter.width(120),
//                        height: ScreenAdapter.height(120),
//                        padding: EdgeInsets.all(5),
//                        decoration: BoxDecoration(
//                            color:Colors.white,
//                            border: new Border.all(width: 2,
//                                color:skusModel.skuCode==item.skuCode?AppConfig.fontBackColor:Colors.white
//                            )
//                        ),
//                        child: item.skuPic!=null?
//                        CachedNetworkImage(imageUrl:"${item.skuPic}${ConstConfig.BANNER_TWO_SIZE}"
//                          ,fit: BoxFit.fitWidth,)
//                            :Image.asset("assets/images/default/default_squre_img.png",fit: BoxFit.fitWidth,),
//                      ),
//                      new Expanded(
//                        flex:1,
//                        child: item.features!=null?new Container(
//                          color: Colors.white,
//                          padding: EdgeInsets.only(left: 10),
//                          child: new Text(this.getName(item.features),softWrap: true,
//                            style: TextStyle(
//                                fontSize: ScreenAdapter.size(32)
//                            ),
//                          )
//                        ):Container(),
//                      ),
//                    ],
//                  ),
//                ),
//              );
//            }).toList(),
//          ),
//        ):new Container();
//      },
//    );
//  }
//
//  String getName(List<CommodityFeatureModel> res){
//    String str ;
//    res.forEach((item){
//      if(item.featureGroup=="颜色"){
//        str = item.featureValue;
//      }
//    });
//    return str;
//  }
//
//  /// 下半部分，尺寸的选择
//  Provide<CommodityDetailProvide> _bottomContentWidget(){
//    return Provide<CommodityDetailProvide>(
//        builder: (BuildContext context,Widget widget,CommodityDetailProvide provide){
//          CommodityModels model = provide.commodityModels;
//          CommoditySkusModel skusModel = provide.skusModel;
//          List<CommodityFeatureModel> features = List();
//          if(model!=null&&model.features!=null){
//            features = model.features;
//          }
//          return new Container(
//            width: double.infinity,
//            child: Wrap(
//              spacing: 5,
//              runSpacing: 5,
//              children: features.length>0? features.map((CommodityFeatureModel item){
//                // 选中尺码
//                return new InkWell(
//                  onTap: (){
//                    provide.setSelectSku(item,_cartProvide.count);
//                    setState(() {});
//                  },
//                  child: item.featureGroup=="尺码" ?new Container(
//                    width: ScreenAdapter.width(100),
//                    height: ScreenAdapter.height(100),
//                    margin: EdgeInsets.all(10),
//                    decoration: BoxDecoration(
//                        color: Colors.white,
//                        border: Border.all(width: 2,
//                            color: skusModel.features.any((items)=>items.featureCode==item.featureCode)?AppConfig.fontBackColor:Colors.white
//                        )
//                    ),
//                    alignment: Alignment.center,
//                    child: new Text(item.featureValue,style: TextStyle(
//                        fontSize: ScreenAdapter.size(32),
//                        fontWeight: FontWeight.w900
//                    ),),
//                  ):new Text(""),
//                );
//              }).toList():[],
//            ),
//          );
//        }
//    );
//  }
}