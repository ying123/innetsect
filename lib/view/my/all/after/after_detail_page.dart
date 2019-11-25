import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/order/after_order_model.dart';
import 'package:innetsect/utils/common_util.dart';
import 'package:innetsect/utils/screen_adapter.dart';
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
      body: _afterServiceProvide.afterOrderModel!=null? Center(
        child: Column(
          children: <Widget>[
            // 商品详情
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
            // 申请原因
            Container(
              width: double.infinity,
              height: ScreenAdapter.height(8),
              color: Color(0xFFFFFF),
            ),
            _applyCause(),
            // 备注
            Container(
              width: double.infinity,
              height: ScreenAdapter.height(8),
              color: Color(0xFFFFFF),
            ),
            _remarkWidget(),
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
            _afterServiceProvide.afterOrderModel.exAddressID==null?Container():Container(
              width: double.infinity,
              height: ScreenAdapter.height(8),
              color: Color(0xFFFFFF),
            ),
            _afterServiceProvide.afterOrderModel.exAddressID==null?Container():_addressWidget(),
            // 订单编号
            Container(
              width: double.infinity,
              height: ScreenAdapter.height(8),
              color: Color(0xFFFFFF),
            ),
            _afterOrderNo(),
            // 创建日期
            Container(
              width: double.infinity,
              height: ScreenAdapter.height(8),
              color: Color(0xFFFFFF),
            ),
            _afterDate()
          ],
        ),
      ):Center(),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _afterServiceProvide ??= widget._afterServiceProvide;

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _afterServiceProvide.resetApplyType();
  }

  /// 订单信息
  Provide<AfterServiceProvide> _orderDetail(){
    return Provide<AfterServiceProvide>(
      builder: (BuildContext context,Widget widget,AfterServiceProvide provide){
        String status = CommonUtil.afterStatusName(provide.afterOrderModel.status);
        if(provide.afterOrderModel.syncStatus>=3&&provide.afterOrderModel.status==40){
          status = "已发出换货";
        }else if(provide.afterOrderModel.syncStatus>=3&&provide.afterOrderModel.status==50){
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
                ),
              ),
              // 商品展示
              _commodityContent(provide.afterOrderModel),
            ],
          ),
        );
      },
    );
  }

  /// 商品展示
  Widget _commodityContent(AfterOrderModel model){
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
                    child: new Text(list[0],softWrap: true,style: TextStyle(fontSize: ScreenAdapter.size(26),fontWeight: FontWeight.w600),),
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
                      padding: EdgeInsets.only(right: 20),
                      child: Text(provide.afterOrderModel.quantity.toString(),style: TextStyle(
                        color: Colors.grey,
                        fontSize: ScreenAdapter.size(24)
                      ),),
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
                "售后类型",
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
                        padding: EdgeInsets.only(left: 10),
                        child: Text(provide.applyTypeList[keys]['title'],
                          style: TextStyle(fontSize: ScreenAdapter.size(24)),),
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        });
  }

  /// 申请原因,_applyCause
  Provide<AfterServiceProvide> _applyCause(){
    return Provide<AfterServiceProvide>(
        builder: (BuildContext context,Widget widget,AfterServiceProvide provide){
          String reasonName = provide.afterOrderModel.reasonName!=null?
            provide.afterOrderModel.reasonName:"";
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
                    child: new Text(reasonName,
                      style: TextStyle(color: Color.fromRGBO(95, 95, 95, 1.0),
                          fontSize: ScreenAdapter.size(24)),),
                  ),
                ),
              ],
            ),
          );
        });
  }

  /// 备注
  Provide<AfterServiceProvide> _remarkWidget(){
    return Provide<AfterServiceProvide>(
        builder: (BuildContext context,Widget widget,AfterServiceProvide provide){
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
                    child: new Text(provide.afterOrderModel.reason,softWrap: true,
                      maxLines: 10,
                      style: TextStyle(color: Color.fromRGBO(95, 95, 95, 1.0),
                          fontSize: ScreenAdapter.size(24)),),
                  ),
                ),
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

  /// 查看物流
  Widget _logisticsWidget(){
    return GestureDetector(
      onTap: (){
        // 跳转物流
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

  /// 地址栏
  Provide<AfterServiceProvide> _addressWidget(){
    return Provide<AfterServiceProvide>(
      builder: (BuildContext context,Widget widget, AfterServiceProvide provide){
        AfterOrderModel model = provide.afterOrderModel;
        return new Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.only(top: 10,bottom: 10),
          child: new Column(
            children: <Widget>[
              new Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: this.getAddress(model),
              ),
              getAddressDetailWidget(shipTo: model.exShipTo)
            ],
          ),
        );
      },
    );
  }

  Widget getAddress(AfterOrderModel model){
    return this.getAddressWidget(name: model.exReceipient,tel: model.exTel);
  }

  Widget getAddressDetailWidget({String shipTo}){
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 40,bottom: 10),
      child:  new Text(shipTo,
        style: TextStyle(color: Colors.black54,fontSize: ScreenAdapter.size(22)),),
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
                          child: new Text("$name  $tel ",maxLines: 1,style: TextStyle(fontSize: ScreenAdapter.size(24)),),)
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
  Widget _afterOrderNo(){
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
                  _afterServiceProvide.afterOrderModel.orderNo,
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
  Widget _afterDate(){
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
                  _afterServiceProvide.afterOrderModel.requestDate,
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