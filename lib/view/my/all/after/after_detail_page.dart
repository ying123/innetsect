import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/data/order/after_order_model.dart';
import 'package:innetsect/utils/common_util.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/all/after/after_logistics_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/my_order/after_service_provide.dart';
import 'package:provide/provide.dart';

class AfterDetailPage extends PageProvideNode{
  final AfterServiceProvide _afterServiceProvide = AfterServiceProvide.instance;

  AfterDetailPage(){
    mProviders.provide(Provider<AfterServiceProvide>.value(_afterServiceProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return AfterDetailContent(_afterServiceProvide);
  }
}

class AfterDetailContent extends StatefulWidget {
  final AfterServiceProvide _afterServiceProvide;
  AfterDetailContent(this._afterServiceProvide);

  @override
  _AfterDetailContentState createState() => new _AfterDetailContentState();
}

class _AfterDetailContentState extends State<AfterDetailContent> {
  AfterServiceProvide _afterServiceProvide;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
        widget: new Text("售后详情",style: TextStyle(fontSize: ScreenAdapter.size((30)),
            fontWeight: FontWeight.w900)),
      ),
      body: Provide<AfterServiceProvide>(
        builder: (BuildContext context,Widget widget,AfterServiceProvide provide){
          if(provide.afterOrderModel!=null){
            return ListView(
              children: <Widget>[
                // 商品详情
                _orderDetail(provide),
                // 驳回原因
                _orderReject(provide),
                // 申请数量
                Container(
                  width: double.infinity,
                  height: ScreenAdapter.height(8),
                  color: Color(0xFFFFFF),
                ),
                _applyCount(provide),
                // 申请类型
                Container(
                  width: double.infinity,
                  height: ScreenAdapter.height(8),
                  color: Color(0xFFFFFF),
                ),
                _applyType(provide),
                // 换货
                provide.afterOrderModel.rmaType==2?Container(
                  width: double.infinity,
                  height: ScreenAdapter.height(8),
                  color: Color(0xFFFFFF),
                ):Container(width: 0.0,height: 0.0,),
                provide.afterOrderModel.rmaType==2?_applySkuModel(provide):Container(width: 0.0,height: 0.0,),
                // 申请原因
                Container(
                  width: double.infinity,
                  height: ScreenAdapter.height(8),
                  color: Color(0xFFFFFF),
                ),
                _applyCause(provide),
                // 备注
                Container(
                  width: double.infinity,
                  height: ScreenAdapter.height(8),
                  color: Color(0xFFFFFF),
                ),
                _remarkWidget(provide),
                // 退款方式
                Container(
                  width: double.infinity,
                  height: ScreenAdapter.height(8),
                  color: Color(0xFFFFFF),
                ),
                _payRefundWidget(),
                // 查看物流
                Container(
                  width: double.infinity,
                  height: ScreenAdapter.height(8),
                  color: Color(0xFFFFFF),
                ),
                _logisticsWidget(),
                // 地址
                provide.afterOrderModel.exAddressID==null?Container(width: 0,height: 0,):Container(
                  width: double.infinity,
                  height: ScreenAdapter.height(8),
                  color: Color(0xFFFFFF),
                ),
                _addressWidget(provide),
                // 订单编号
                Container(
                  width: double.infinity,
                  height: ScreenAdapter.height(8),
                  color: Color(0xFFFFFF),
                ),
                _afterOrderNo(provide),
                // 创建日期
                Container(
                  width: double.infinity,
                  height: ScreenAdapter.height(8),
                  color: Color(0xFFFFFF),
                ),
                _afterDate(provide)
              ],
            );
          }else{
            return Container(width: 0.0,height: 0.0,);
          }
        },
      )
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _afterServiceProvide ??= widget._afterServiceProvide;
    if(_afterServiceProvide.afterOrderModel!=null){
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _afterServiceProvide.resetApplyType();
  }

  /// 订单信息
  Widget _orderDetail(AfterServiceProvide provide){
    String status = CommonUtil.afterStatusName(
        provide.afterOrderModel.status);
    if (provide.afterOrderModel.syncStatus >= 3 &&
        provide.afterOrderModel.status == 40) {
      status = "已发出换货";
    } else if (provide.afterOrderModel.syncStatus >= 3 &&
        provide.afterOrderModel.status == 50) {
      status = "换货已完成";
    }
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("售后单号:  ${provide.afterOrderModel.rmaNo}",
                    style: TextStyle(fontSize: ScreenAdapter.size(24)),),
                  new Text(status,
                      style: TextStyle(fontSize: ScreenAdapter.size(24),color: AppConfig.blueBtnColor))
                ],
              )
          ),
          // 商品展示
          _commodityContent(),
        ],
      ),
    );
  }

  /// 驳回原因
  Widget _orderReject(AfterServiceProvide provide){
    if(provide.afterOrderModel.status==34){
      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 20,right: 10,top: 10,bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Text(
                "驳回原因",
                style: TextStyle(
                    color: Color.fromRGBO(95, 95, 95, 1.0),
                    fontSize: ScreenAdapter.size(28),
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                  child:Text(provide.afterOrderModel.remark!=null?provide.afterOrderModel.remark:"",
                    maxLines: 10,
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: ScreenAdapter.size(24)
                    ),)
              ),
            ),
          ],
        ),
      );
    }else{
      return Container(height: 0.0,width: 0.0,);
    }
  }

  /// 商品展示
  Provide<AfterServiceProvide> _commodityContent(){
    return Provide<AfterServiceProvide>(
        builder: (BuildContext context,Widget widget,AfterServiceProvide provide) {
          List list = CommonUtil.skuNameSplit(provide.afterOrderModel.skuName);
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
                      child: Provide<AfterServiceProvide>(
                          builder: (BuildContext context,Widget widget,AfterServiceProvide provide) {
                            return new Image.network(provide.afterOrderModel.skuPic+ConstConfig.LIST_IMAGE_SIZE,fit: BoxFit.fill,
                              width: ScreenAdapter.width(100),height: ScreenAdapter.height(100),);
                          }
                      )
                  ),
                  // 商品描述
                  new Container(
                      width: (ScreenAdapter.getScreenWidth()/1.7)-4,
                      padding: EdgeInsets.only(left: 10,top: 5),
                      child:  list!=null? new Column(
                                children: <Widget>[
                                  new Container(
                                    width: double.infinity,
                                    child: new Text(list[0],softWrap: true,style: TextStyle(fontSize: ScreenAdapter.size(26),fontWeight: FontWeight.w600),),
                                  ),
                                  new Container(
                                      width: double.infinity,
                                      child: new Text(list[1],style: TextStyle(color: Colors.grey),)
                                  ),
                                  new Container(
                                      padding:EdgeInsets.only(top: 10),
                                      alignment: Alignment.centerLeft,
                                      child: new Text("可申请数量: ${provide.afterOrderModel.quantity} 件")
                                  )
                                ],
                              ): new Text(provide.afterOrderModel.skuName,softWrap: true,)
                  ),
                  // 价格
                  new Container(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new CustomsWidget().priceTitle(price: provide.afterOrderModel.salesPrice.toString())
                      ],
                    ),
                  )
                ],
              ));
        }
    );
  }

  /// 申请数量
  Widget _applyCount(AfterServiceProvide provide){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 20,top: 10,bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
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
                padding: EdgeInsets.only(right: 20),
                child: Text(provide.afterOrderModel.quantity.toString(),style: TextStyle(
                    color: Colors.grey,
                    fontSize: ScreenAdapter.size(24)
                ),)
            ),
          ),
        ],
      ),
    );
  }

  /// 申请类型
  Widget _applyType(AfterServiceProvide provide){
    /**
     *   退换策略,0：此商品不支持退换货,>0申请售后，1.退货，2.换货,3.可退换
     *   int rmaPolicy;
     */
    return Container(
      width: ScreenAdapter.width(750),
      height: ScreenAdapter.height(80),
      padding:EdgeInsets.only(left: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "售后类型",
            style: TextStyle(
                color: Color.fromRGBO(95, 95, 95, 1.0),
                fontSize: ScreenAdapter.size(28),
                fontWeight: FontWeight.w500
            ),
          ),
          Expanded(
            child: _applyTypeAction(provide),
          ),
        ],
      ),
    );
  }

  /// 退换货选择
  Widget _applyTypeAction(AfterServiceProvide provide){
    /**
     *   退换策略,0：此商品不支持退换货,>0申请售后，1.退货，2.换货,3.可退换
     *   int rmaPolicy;
     */
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: _afterServiceProvide.applyTypeList.asMap().keys.map((keys){
        return Container(
          width: ScreenAdapter.width(120),
          margin: EdgeInsets.only(right: 20),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: provide.applyTypeList[keys]['isSelected']? new Icon(
                    Icons.check_circle,
                    size: 20.0,
                    color: AppConfig.fontBackColor,
                  ) : new Icon(Icons.panorama_fish_eye,
                    size: 20.0,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(_afterServiceProvide.applyTypeList[keys]['title'],
                    style: TextStyle(fontSize: ScreenAdapter.size(24)),),
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  /// 换货类型
  Widget _applySkuModel(AfterServiceProvide provide){
    Widget widget = Container(width: 0.0,height: 0.0,);
    String skuName="";
    if(provide.afterOrderModel.skuName!=null){
      List list = CommonUtil.skuNameSplit(provide.afterOrderModel.skuName);
      skuName = list[1];
      widget = Expanded(
        flex: 8,
        child: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 10),
          child: Text(skuName,style: TextStyle(color:Color.fromRGBO(95, 95, 95, 1.0)),),
        ),
      );
    }
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 20,top: 10,bottom: 10),
              child: Text( "已选",
                style: TextStyle(
                    color: Color.fromRGBO(95, 95, 95, 1.0),
                    fontSize: ScreenAdapter.size(28),
                    fontWeight: FontWeight.w500
                ),
              )
          ),
          widget
        ],
      ),
    );
  }

  /// 申请原因,_applyCause
  Widget _applyCause(AfterServiceProvide provide){
    String reasonName = "";
    if(provide.afterOrderModel.reasonName != null){
      reasonName=provide.afterOrderModel.reasonName;
    }
    return Container(
      width: double.infinity,
      color: Colors.white,
      height: ScreenAdapter.height(80),
      padding: EdgeInsets.only(left: 20,right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(
              "申请原因",
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
              child:new Text(reasonName,
                style: TextStyle(color: Color.fromRGBO(95, 95, 95, 1.0),
                    fontSize: ScreenAdapter.size(24)),)
            ),
          ),
        ],
      ),
    );
  }

  /// 备注
  Widget _remarkWidget(AfterServiceProvide provide){
      return Container(
        width: double.infinity,
        color: Colors.white,
        height: ScreenAdapter.height(80),
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                "备注",
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
                child: new Text(provide.afterOrderModel.reason!=null
                    ?provide.afterOrderModel.reason:'',softWrap: true,
                  maxLines: 10,
                  style: TextStyle(color: Color.fromRGBO(95, 95, 95, 1.0),
                      fontSize: ScreenAdapter.size(24)),)
              ),
            ),
          ],
        ),
      );
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

  /// 查看物流
  Widget _logisticsWidget(){
    return InkWell(
      onTap: () {
        // 跳转物流
        // 退货物流请求
        if(_afterServiceProvide.afterOrderModel.waybillNo!=null){
          _getShipperDetail();

        }else{
          CustomsWidget().showToast(title: "暂无物流信息");
        }
      },
      child: Row(
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
                    "查看物流",
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
      ),
    );
  }

  /// 退货物流请求
  _getShipperDetail(){
    Navigator.push(context, MaterialPageRoute(
        builder: (context){
          return AfterLogisticsPage();
        }
    ));
  }

  /// 地址栏
  Widget _addressWidget(AfterServiceProvide provide){
    Widget widget = Container(width: 0,height: 0,);
    if(provide.afterOrderModel.exAddressID!=null){
      widget = new Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.only(top: 10,bottom: 10),
        child: new Column(
          children: <Widget>[
            new Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: this.getAddress(provide),
            ),
            getAddressDetailWidget(provide)
          ],
        ),
      );
    }
    return widget;
  }

  Widget getAddress(AfterServiceProvide provide){
    return this.getAddressWidget(provide);
  }

  Widget getAddressDetailWidget(AfterServiceProvide provide){
    AfterOrderModel model = provide.afterOrderModel;
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 40,bottom: 10),
      child:  new Text(model.exShipTo==null?"":model.exShipTo,
        style: TextStyle(color: Colors.black54,fontSize: ScreenAdapter.size(22)),),
    );
  }

  Widget getAddressWidget(AfterServiceProvide provide){
    Widget widget = Container(width: 0,height: 0,);
    AfterOrderModel model = provide.afterOrderModel;
    if(model.exReceipient!=null&&model.exTel!=null){
      widget = new Padding(padding: EdgeInsets.only(left: 5),
        child: new Text("${model.exReceipient}  ${model.exTel} ",maxLines: 1,style: TextStyle(fontSize: ScreenAdapter.size(24)),),);
    }
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
                        widget
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

  /// 订单编号widget
  Widget _afterOrderNo(AfterServiceProvide provide){
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
                  "订单编号",
                  style: TextStyle(
                      color: Color.fromRGBO(95, 95, 95, 1.0),
                      fontSize: ScreenAdapter.size(28),
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
              Center(
                child: Text(
                  provide.afterOrderModel.orderNo,
                  style: TextStyle(
                      color: Color.fromRGBO(95, 95, 95, 1.0),
                      fontSize: ScreenAdapter.size(24),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  /// 创建日期widget
  Widget _afterDate(AfterServiceProvide provide){
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
                  "创建日期",
                  style: TextStyle(
                      color: Color.fromRGBO(95, 95, 95, 1.0),
                      fontSize: ScreenAdapter.size(28),
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
              Center(
                child: Text(
                  provide.afterOrderModel.requestDate,
                  style: TextStyle(
                    color: Color.fromRGBO(95, 95, 95, 1.0),
                    fontSize: ScreenAdapter.size(24),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}