import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/order_detail_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/mall/commodity/order_detail_provide.dart';
import 'package:innetsect/view_model/mall/logistics/logistics_provide.dart';
import 'package:provide/provide.dart';

class LogisticsPage extends PageProvideNode{
  final LogisticsProvide _provide = LogisticsProvide.instance;
  final OrderDetailProvide _detailProvide = OrderDetailProvide.instance;

  LogisticsPage(){
    mProviders.provide(Provider<LogisticsProvide>.value(_provide));
    mProviders.provide(Provider<OrderDetailProvide>.value(_detailProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return LogisticsContent(_provide,_detailProvide);
  }
}

class LogisticsContent extends StatefulWidget {
  final LogisticsProvide _provide;
  final OrderDetailProvide _detailProvide;
  LogisticsContent(this._provide,this._detailProvide);
  @override
  _LogisticsContentState createState() => new _LogisticsContentState();
}

class _LogisticsContentState extends State<LogisticsContent> {
  LogisticsProvide _provide;
  OrderDetailProvide _detailProvide;
  List list = new List();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
          widget: new Text("物流信息",style: TextStyle(fontSize: ScreenAdapter.size((30)),
            fontWeight: FontWeight.w900 ),),
        onTap: (){
          Navigator.popAndPushNamed(context, _provide.backPage);
        }
      ),
      body: new Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          new Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: new Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 20,bottom: 10),
                child: CustomsWidget().subTitle(title: "订单编号:  ${_detailProvide.orderDetailModel.orderNo}",
                    color: AppConfig.blueBtnColor),
              )
          ),
          new Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: new Container(
                width: double.infinity,
                height: ScreenAdapter.getScreenHeight()-40,
                child: list==null?
                    new Padding(padding: EdgeInsets.all(20),
                      child: new Text("暂无数据"),
                    )
                    :ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index){
                        return new Row(
                          children: <Widget>[
                            Expanded(
                              child: new Row(
                                children: <Widget>[
                                  Expanded( 
                                    flex:1,
                                    child: new Container(
                                      color: Colors.yellow,
                                      child: Text('1'),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: new Container(
                                      padding: EdgeInsets.only(left: 10,right: 20),
                                      margin: EdgeInsets.only(top: 20),
                                      child: new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Text(list[index]['context']),
                                          new Padding(padding: EdgeInsets.only(top: 20),
                                            child: new Text(list[index]['ftime'],style: TextStyle(color: Colors.grey),),),
                                          new Divider(endIndent: 10,color: AppConfig.assistLineColor,)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      }),
              )
          )
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _provide ??= widget._provide;
    _detailProvide ??= widget._detailProvide;
    _loadData();
  }

  /// 订单物流
  _loadData(){
    OrderDetailModel model = _detailProvide.orderDetailModel;
    _provide.getLogisticsList(orderID: model.orderID,shipperCode: model.shipperCode,
    waybillNo: model.waybillNo,phone:model.tel).doOnListen(() {
      print('doOnListen');
    }).doOnCancel(() {}).listen((items) {
      ///加载数据
      print('listen data->$items');
      if(items!=null&&items.data!=null){
        setState(() {
          list = items.data['data'];
        });
      }
    }, onError: (e) {});
  }
}