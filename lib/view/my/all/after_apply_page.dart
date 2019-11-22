import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/utils/common_util.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/my_order/after_service_provide.dart';
import 'package:provide/provide.dart';

/// 申请售后页面
class AfterApplyPage extends PageProvideNode{
  final AfterServiceProvide _afterServiceProvide = AfterServiceProvide.instance;

  AfterApplyPage(){
    mProviders.provide(Provider<AfterServiceProvide>.value(_afterServiceProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return AfterApplyContent(_afterServiceProvide);
  }
}

class AfterApplyContent extends StatefulWidget {
  final AfterServiceProvide _afterServiceProvide;
  AfterApplyContent(this._afterServiceProvide);
  @override
  _AfterApplyContentState createState() => new _AfterApplyContentState();
}

class _AfterApplyContentState extends State<AfterApplyContent> {
  AfterServiceProvide _afterServiceProvide;
  List<Map<String,dynamic>> applyTypeList = [{"val":1,"title":"退货","isSelected": false},
    {"val":2,"title":"换货","isSelected": false}];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context, widget: new Text("申请售后",
          style: TextStyle(fontSize: ScreenAdapter.size((30)),
          fontWeight: FontWeight.w900 )
      )),
      body: Center(
        child: Column(
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
            // 申请原因
            Container(
              width: double.infinity,
              height: ScreenAdapter.height(8),
              color: Color(0xFFFFFF),
            ),
            _applyCause()
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 20,right: 20),
        child:  RaisedButton(
          color: Colors.black,
          textColor: Colors.white,
          onPressed: (){
            // 提交申请
          },
          child: new Text("提交申请"),
        ),
      ),
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
                child: new Text("订单号:  ${provide.commodityModels.orderNo}"),
              ),
              // 商品展示
              _commodityContent(provide.commodityModels),
            ],
          ),
        );
      },
    );
  }

  /// 商品展示
  Widget _commodityContent(CommodityModels model){
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
              height: ScreenAdapter.height(140),
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
            new InkWell(
              onTap: (){
                provide.reduce();
              },
              child: new Container(
              width: ScreenAdapter.width(40.0),
              height: ScreenAdapter.height(60.0),
              child: Icon(Icons.remove,color: AppConfig.assistFontColor,),
              ),
            ),
            new Container(
              height: ScreenAdapter.height(60.0),
              padding: EdgeInsets.only(left: 5,right: 5),
              margin: EdgeInsets.only(left: 10,right: 5),
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
            new InkWell(
              onTap: (){
                provide.addCount();
              },
              child: new Container(
                width: ScreenAdapter.width(40.0),
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
            children: applyTypeList.asMap().keys.map((keys){
              return Container(
                width: ScreenAdapter.width(100),
                margin: EdgeInsets.only(right: 20),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new InkWell(
                      onTap: (){
                        applyTypeList.forEach((val)=> val['isSelected']=false);
                        setState(() {
                          applyTypeList[keys]['isSelected'] = !applyTypeList[keys]['isSelected'];
                        });
                      },
                      child: new Container(
                        child: applyTypeList[keys]['isSelected']? new Icon(
                          Icons.check_circle,
                          size: 20.0,
                          color: AppConfig.fontBackColor,
                        ) : new Icon(Icons.panorama_fish_eye,
                          size: 20.0,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(applyTypeList[keys]['title']),
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
        return Container(
          width: double.infinity,
          height: ScreenAdapter.height(240),
          color: Colors.white,
          child: new Column(
            children: <Widget>[
              // 申请原因
              Row(
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
                            child: new Text("请选择申请原因",style: TextStyle(color: Color.fromRGBO(95, 95, 95, 1.0),),),
                          ),
                        ),
                        Center(
                          child: Icon(Icons.chevron_right,color:Color.fromRGBO(95, 95, 95, 1.0),),
                        )
                      ],
                    ),
                  )
                ],
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
                ),
              )
            ],
          ),
        );
    });
  }
}