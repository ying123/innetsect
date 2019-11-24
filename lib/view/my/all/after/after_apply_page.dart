import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/order/rmareasons_model.dart';
import 'package:innetsect/data/order_detail_model.dart';
import 'package:innetsect/utils/common_util.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/address_management/address_management_page.dart';
import 'package:innetsect/view/my/all/after/rmareason_page.dart';
import 'package:innetsect/view/widget/commodity_modal_bottom.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/my_order/after_service_provide.dart';
import 'package:provide/provide.dart';

/// 申请售后页面
class AfterApplyPage extends PageProvideNode{
  final AfterServiceProvide _afterServiceProvide = AfterServiceProvide.instance;
  final CommodityDetailProvide _commodityDetailProvide = CommodityDetailProvide.instance;

  AfterApplyPage(){
    mProviders.provide(Provider<AfterServiceProvide>.value(_afterServiceProvide));
    mProviders.provide(Provider<CommodityDetailProvide>.value(_commodityDetailProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return AfterApplyContent(_afterServiceProvide,_commodityDetailProvide);
  }
}

class AfterApplyContent extends StatefulWidget {
  final AfterServiceProvide _afterServiceProvide;
  final CommodityDetailProvide _commodityDetailProvide;
  AfterApplyContent(this._afterServiceProvide,this._commodityDetailProvide);
  @override
  _AfterApplyContentState createState() => new _AfterApplyContentState();
}

class _AfterApplyContentState extends State<AfterApplyContent> {
  AfterServiceProvide _afterServiceProvide;
  CommodityDetailProvide _commodityDetailProvide;
  //原因描述
  String reason="";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context, widget: new Text("申请售后",
          style: TextStyle(fontSize: ScreenAdapter.size((30)),
          fontWeight: FontWeight.w900 )
      )),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: Provide<AfterServiceProvide>(
            builder: (BuildContext context,Widget widget,AfterServiceProvide provide){
              return Column(
                children: <Widget>[
                  // 订单信息
                  _orderDetail(),
                  // 申请数量
                  _applyCount(),
                  // 申请类型
                  Container(
                    width: double.infinity,
                    height: ScreenAdapter.height(8),
                    color: Color(0xFFFFFF),
                  ),
                  _applyType(),
                  // 选择规格，如果是换货
                  provide.applyTypeList[1]['isSelected']?Container(
                    width: double.infinity,
                    height: ScreenAdapter.height(8),
                    color: Color(0xFFFFFF),
                  ):Container(),
                  provide.applyTypeList[1]['isSelected']?_orderDetailWidget():Container(),
                  // 申请原因
                  Container(
                    width: double.infinity,
                    height: ScreenAdapter.height(8),
                    color: Color(0xFFFFFF),
                  ),
                  _applyCause(),
                  // 退款方式
                  provide.applyTypeList[1]['isSelected']?Container(
                    width: double.infinity,
                    height: ScreenAdapter.height(8),
                    color: Color(0xFFFFFF),
                  ):Container(),
                  provide.applyTypeList[1]['isSelected']?_payRefundWidget():Container(),
                  // 地址
                  provide.applyTypeList[1]['isSelected']?Container(
                    width: double.infinity,
                    height: ScreenAdapter.height(8),
                    color: Color(0xFFFFFF),
                  ):Container(),
                  provide.applyTypeList[1]['isSelected']?_addressWidget():Container(),
                ],
              );
            },
          ),
        ),
      ),
      bottomSheet: Provide<AfterServiceProvide>(
          builder: (BuildContext context,Widget widget,AfterServiceProvide provide){
            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 20,right: 20),
              child:  RaisedButton(
                color: Colors.black,
                textColor: Colors.white,
                onPressed: (){
                  /// 提交申请
                  //退换类型
                  if(!provide.applyTypeList[0]['isSelected']&&!provide.applyTypeList[1]['isSelected']){
                    CustomsWidget().showToast(title: "请选择申请类型");
                    return;
                  }
                  // 退换原因
                  bool flag = false;
                  _afterServiceProvide.rmareasonsModelList.forEach((item){
                    if(item.isSelected==true){
                      flag = true;
                      // 当退换原因为5、6时，原因描述和图片必须填写
                      if(item.reasonType==5||item.reasonType==6){
                        if(reason==""){
                          CustomsWidget().showToast(title: "请填写申请售后具体原因");
                          return;
                        }
                      }
                    }
                  });
                  if(!flag){
                    CustomsWidget().showToast(title: "请选择申请原因");
                    return;
                  }
                  // 当退换原因为5、6时，原因描述和图片必须填写

                  _submitAfterRequest();
                },
                child: new Text("提交申请"),
              ),
            );
          }
      )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _afterServiceProvide ??= widget._afterServiceProvide;
    _commodityDetailProvide ??= widget._commodityDetailProvide;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commodityDetailProvide.afterBtn = false;
    _afterServiceProvide.skusModel = null;
  }

  /// 订单信息
  Provide<AfterServiceProvide> _orderDetail(){
    return Provide<AfterServiceProvide>(
      builder: (BuildContext context,Widget widget,AfterServiceProvide provide){
        return new Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 5),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // 订单号
              new Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: new Text("订单号:  ${provide.orderDetailModel.orderNo}"),
              ),
              // 商品展示
              _commodityContent(provide.orderDetailModel),
            ],
          ),
        );
      },
    );
  }

  /// 商品展示
  Widget _commodityContent(OrderDetailModel model){
    List list = CommonUtil.skuNameSplit(model.skuName);
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 5),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // 商品图片
          new Container(
              width: ScreenAdapter.width(120),
              height: ScreenAdapter.height(120),
              alignment: Alignment.center,
              child: new Image.network(model.skuPic,fit: BoxFit.fill,
                width: ScreenAdapter.width(100),height: ScreenAdapter.height(100),)
          ),
          // 商品描述
          new Container(
              width: (ScreenAdapter.getScreenWidth()/1.7)-4,
              padding: EdgeInsets.only(left: 10,top: 5),
              child: list!=null? new Column(
                children: <Widget>[
                  new Container(
                    width: double.infinity,
                    child: new Text(list[0],softWrap: true,),
                  ),
                  new Container(
                      width: double.infinity,
                      child: new Text(list[1],style: TextStyle(color: Colors.grey),)
                  ),
                  new Container(
                      padding:EdgeInsets.only(top: 10),
                      alignment: Alignment.centerLeft,
                      child: new Text("可申请数量: ${model.quantity} 件")
                  )
                ],
              ): new Text(model.skuName,softWrap: true,)
          ),
          // 价格
          new Container(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new CustomsWidget().priceTitle(price: model.salesPrice.toString())
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 申请数量
  Provide<AfterServiceProvide> _applyCount(){
    return Provide<AfterServiceProvide>(
      builder: (BuildContext context,Widget widget,AfterServiceProvide provide){
        return Row(
          children: <Widget>[
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(80),
              padding:EdgeInsets.only(left: 20),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      "申请数量",
                      style: TextStyle(
                          color: Color.fromRGBO(95, 95, 95, 1.0),
                          fontSize: ScreenAdapter.size(28),
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 10),
                      child: _counterWidget(),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  /// 计数器
  Provide<AfterServiceProvide> _counterWidget(){
    return Provide<AfterServiceProvide>(
      builder: (BuildContext context,Widget widget,AfterServiceProvide provide){
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new GestureDetector(
              onTap: (){
                provide.reduce();
              },
              child: new Container(
              width: ScreenAdapter.width(60.0),
              height: ScreenAdapter.height(60.0),
              child: Icon(Icons.remove,color: AppConfig.assistFontColor,),
              ),
            ),
            new Container(
              height: ScreenAdapter.height(60.0),
              padding: EdgeInsets.only(left: 5,right: 5),
              margin: EdgeInsets.only(left: 5,right: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppConfig.backGroundColor,
                  borderRadius: BorderRadius.circular(2.0)
              ),
              child: new Text("${provide.count}",style: TextStyle(
                  fontSize: ScreenAdapter.size(24),
                  fontWeight: FontWeight.w900
              ),),
            ),
            new GestureDetector(
              onTap: (){
                provide.addCount();
              },
              child: new Container(
                width: ScreenAdapter.width(60.0),
                height: ScreenAdapter.height(60.0),
                margin: EdgeInsets.only(right: 10),
                child: Icon(Icons.add,color: AppConfig.assistFontColor,),
              ),
            )
          ],
        );
      },
    );
  }

  /// 申请类型
  Provide<AfterServiceProvide> _applyType(){
    /**
     *   退换策略,0：此商品不支持退换货,>0申请售后，1.退货，2.换货,3.可退换
     *   int rmaPolicy;
     */
    return Provide<AfterServiceProvide>(
      builder: (BuildContext context,Widget widget,AfterServiceProvide provide){
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(80),
          padding:EdgeInsets.only(left: 20),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "申请类型(必选项)",
                style: TextStyle(
                    color: Color.fromRGBO(95, 95, 95, 1.0),
                    fontSize: ScreenAdapter.size(28),
                    fontWeight: FontWeight.w500
                ),
              ),
              Expanded(
                child: _applyTypeAction(),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 退换货选择
  Provide<AfterServiceProvide> _applyTypeAction(){
    /**
     *   退换策略,0：此商品不支持退换货,>0申请售后，1.退货，2.换货,3.可退换
     *   int rmaPolicy;
     */
    return Provide<AfterServiceProvide>(
        builder: (BuildContext context,Widget widget,AfterServiceProvide provide){
        return Container(
          width: double.infinity,
          height: ScreenAdapter.height(80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: provide.applyTypeList.asMap().keys.map((keys){
              return Container(
                width: ScreenAdapter.width(100),
                margin: EdgeInsets.only(right: 20),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new InkWell(
                      onTap: (){
                        provide.onSelectedApplyType(keys);
                      },
                      child: Row(
                        children: <Widget>[
                          new Container(
                            child: provide.applyTypeList[keys]['isSelected']? new Icon(
                              Icons.check_circle,
                              size: 20.0,
                              color: AppConfig.fontBackColor,
                            ) : new Icon(Icons.panorama_fish_eye,
                              size: 20.0,
                            ),
                          ),
                          Container(
                            child: Text(provide.applyTypeList[keys]['title']),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
    });
  }

  /// 如果是换货，选择规格
  Provide<AfterServiceProvide> _orderDetailWidget(){
    return Provide<AfterServiceProvide>(
        builder: (BuildContext context,Widget widget,AfterServiceProvide provide){
          String skuName="";
          if(provide.skusModel!=null){
            List list = CommonUtil.skuNameSplit(provide.skusModel.skuName);
            skuName = list[1];
          }
          return Container(
            width: double.infinity,
            color: Colors.white,
            child: InkWell(
              onTap: (){
                // 商品详情请求
                _commodityDetailProvide.prodId = provide.orderDetailModel.prodID;
                _loadDetail();
                //选择规格请求
                CommodityModalBottom.showBottomModal(context:context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20,top: 10,bottom: 10),
                    child: Text(
                      provide.skusModel!=null?"已选":"请选择",
                      style: TextStyle(
                          color: Color.fromRGBO(95, 95, 95, 1.0),
                          fontSize: ScreenAdapter.size(28),
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  provide.skusModel!=null?
                      Expanded(
                        flex: 8,
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 10),
                          child: Text("$skuName",style: TextStyle(color:Color.fromRGBO(95, 95, 95, 1.0)),),
                        ),
                      ):Container(),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.chevron_right,color:Color.fromRGBO(95, 95, 95, 1.0),),
                    ),
                  ),
                ],
              ),
            ),
          );
    });
  }

  /// 申请原因,_applyCause
  Provide<AfterServiceProvide> _applyCause(){
    return Provide<AfterServiceProvide>(
        builder: (BuildContext context,Widget widget,AfterServiceProvide provide){
        return Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.only(bottom: 20),
          child: new Column(
            children: <Widget>[
              // 申请原因
              InkWell(
                onTap: () async{
                  // 申请原因请求
                  _rmareasonsRequest();
                  _bottomSheetActoin();
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: ScreenAdapter.width(750),
                      height: ScreenAdapter.height(80),
                      padding:EdgeInsets.only(left: 20),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Text(
                              "申请原因(必选项)",
                              style: TextStyle(
                                  color: Color.fromRGBO(95, 95, 95, 1.0),
                                  fontSize: ScreenAdapter.size(28),
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 10),
                              child: new Text(provide.selectModel().reasonName!=null?provide.selectModel().reasonName:"请选择申请原因",style: TextStyle(color: Color.fromRGBO(95, 95, 95, 1.0),),),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(Icons.chevron_right,color:Color.fromRGBO(95, 95, 95, 1.0),),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // 申请售后原因
              Container(
                padding: EdgeInsets.only(left: 20,right: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)
                ),
                child: TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "请描述申请售后的具体原因",
                    hintStyle: TextStyle(fontSize: ScreenAdapter.size(24)),
                    fillColor: AppConfig.assistLineColor,
                    filled: true,
                    contentPadding: EdgeInsets.only(left: 10,right: 10,top: 5,)
                  ),
                  onChanged: (val){
                    setState(() {
                      reason = val;
                    });
                  },
                ),
              )
            ],
          ),
        );
    });
  }

  /// 退款方式widget
  Widget _payRefundWidget(){
    return Row(
      children: <Widget>[
        Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(80),
          padding:EdgeInsets.only(left: 20,right: 20),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Center(
                child: Text(
                  "退款方式",
                  style: TextStyle(
                      color: Color.fromRGBO(95, 95, 95, 1.0),
                      fontSize: ScreenAdapter.size(28),
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
              Center(
                child: Text(
                  "原支付返回",
                  style: TextStyle(
                      color: Color.fromRGBO(95, 95, 95, 1.0),
                      fontSize: ScreenAdapter.size(28),
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  /// 申请售后弹出框
  void _bottomSheetActoin(){
    showModalBottomSheet(context: context, builder: (BuildContext context){
      return RmareasonPage();
    });
  }

  /// 地址栏
  Provide<AfterServiceProvide> _addressWidget(){
    return Provide<AfterServiceProvide>(
      builder: (BuildContext context,Widget widget, AfterServiceProvide provide){
        OrderDetailModel model = provide.orderDetailModel;
        return new GestureDetector(
          onTap: (){
            // 跳转地址管理
            Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context){
                  return AddressManagementPage();
                },
                settings: RouteSettings(arguments: {'pages': 'afterApply'})
            ));
          },
          child: new Container(
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        child: this.getAddress(model),
                      ),
                      model==null?new Container():
                      model.addressModel==null?model.shipTo!=null?
                      this.getAddressDetailWidget(addressDetail: model.shipTo)
                          : new Container()
                          : this.getAddressDetailWidget(
                          province: model.addressModel.province,
                          city: model.addressModel.city,
                          addressDetail: model.addressModel.addressDetail
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(Icons.chevron_right,color: Colors.grey,),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getAddress(OrderDetailModel model){
    Widget widget;
    if(model==null) return new Container();
    if(model.addressModel!=null){
      widget = this.getAddressWidget(name: model.addressModel.name,tel: model.addressModel.tel);
    }else if(model.tel!=null){
      widget = this.getAddressWidget(name: model.receipient,tel: model.tel);
    }
    return widget;
  }

  Widget getAddressDetailWidget({String province="",String city="",String addressDetail}){
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 40,bottom: 10),
      child:  new Text(province+city+addressDetail,
        style: TextStyle(color: Colors.grey),),
    );
  }

  Widget getAddressWidget({String name,String tel}){
    return new Column(
      children: <Widget>[
        new Container(
          width: double.infinity,
          child: new Row(
            children: <Widget>[
              new Expanded(
                  flex:2,
                  child: new Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: new Row(
                      children: <Widget>[
                        new Image.asset("assets/images/mall/location.png",fit: BoxFit.fill,width: ScreenAdapter.width(25),),
                        new Padding(padding: EdgeInsets.only(left: 5),
                          child: new Text("$name  $tel ",maxLines: 1,),)
                      ],
                    ),
                  )
              ),
            ],
          ),
        ),

      ],
    );
  }

  ///申请原因请求
  void _rmareasonsRequest(){
    _afterServiceProvide.rmareasonsListData().doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
          _afterServiceProvide.addRmaeasonList(RmareasonsModelList.fromJson(item.data).list);
      }
    }, onError: (e) {});
  }

  /// 商品详情请求
  _loadDetail(){
    /// 加载详情数据
    _commodityDetailProvide.detailData()
        .doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      _commodityDetailProvide.setCommodityModels(CommodityModels.fromJson(item.data));
      _commodityDetailProvide.setInitData();
      _commodityDetailProvide.isBuy = false;
      _commodityDetailProvide.afterBtn = true;
//      _provide
    }, onError: (e) {});
  }

  /// 提交申请
  _submitAfterRequest(){
    int index = _afterServiceProvide.applyTypeList.indexWhere((item)=>item['isSelected']==true);
    _afterServiceProvide.submitSalesRma(_afterServiceProvide.applyTypeList[index]['val'], reason)
        .doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        _afterServiceProvide.updateOrderListModal();
        Navigator.pop(context);
        CustomsWidget().showToast(title: "提交成功");
      }
    }, onError: (e) {});
  }


}