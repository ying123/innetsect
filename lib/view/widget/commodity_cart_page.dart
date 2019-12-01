import 'package:flutter/material.dart';
import 'package:innetsect/app_navigation_bar.dart';
import 'package:innetsect/app_navigation_bar_provide.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/commodity_types_model.dart';
import 'package:innetsect/data/order_detail_model.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:innetsect/utils/common_util.dart';
import 'package:innetsect/view/mall/mall_page.dart';
import 'package:innetsect/view/mall/order/order_detail_page.dart';
import 'package:innetsect/view/widget/counter_widget.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/mall/commodity/order_detail_provide.dart';
import 'package:innetsect/view_model/mall/mall_provide.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/utils/screen_adapter.dart';

/// 购物车
class CommodityCartPage extends PageProvideNode{
  final CommodityAndCartProvide _provide = CommodityAndCartProvide.instance;
  final CommodityDetailProvide _detailProvide = CommodityDetailProvide.instance;
  final OrderDetailProvide _orderDetailProvide = OrderDetailProvide.instance;
  final MallProvide _mallProvide = MallProvide.instance;
  final AppNavigationBarProvide _appNavigationBarProvide = AppNavigationBarProvide.instance;
  final String pages;

  CommodityCartPage({this.pages}){
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_provide));
    mProviders.provide(Provider<CommodityDetailProvide>.value(_detailProvide));
    mProviders.provide(Provider<OrderDetailProvide>.value(_orderDetailProvide));
    mProviders.provide(Provider<MallProvide>.value(_mallProvide));
    mProviders.provide(Provider<AppNavigationBarProvide>.value(_appNavigationBarProvide));
  }
  
  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return CommodityCartContent(_provide,_detailProvide,_orderDetailProvide,_mallProvide,_appNavigationBarProvide);
  }
}

class CommodityCartContent extends StatefulWidget {
  final CommodityAndCartProvide _provide;
  final CommodityDetailProvide _detailProvide;
  final OrderDetailProvide _orderDetailProvide;
  final AppNavigationBarProvide _appNavigationBarProvide;
  final MallProvide _mallProvide;
  final String pages;
  CommodityCartContent(this._provide,this._detailProvide,this._orderDetailProvide,this._mallProvide,
      this._appNavigationBarProvide,{this.pages});
  @override
  _CommodityCartContentState createState() => new _CommodityCartContentState();
}

class _CommodityCartContentState extends State<CommodityCartContent> {

  CommodityAndCartProvide provide;
  CommodityDetailProvide _detailProvide;
  OrderDetailProvide _orderDetailProvide;
  AppNavigationBarProvide _appNavigationBarProvide;
  MallProvide _mallProvide;

  // 全选
  bool isAllChecked = false;
  // 是否编辑
  bool isEdited = true;

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    // 获取上一页的传值
    Map<dynamic,dynamic> mapData = ModalRoute.of(context).settings.arguments;
    bool back = mapData['isBack']==null?false:mapData['isBack'];
    return new Scaffold(
      appBar: new AppBar(
        leading: back? new InkWell(
          onTap: (){
            // 返回
            Navigator.pop(context);
          },
          child: new Container(
              padding: EdgeInsets.all(20),
              child: new Image.asset("assets/images/mall/arrow_down.png",
                fit: BoxFit.fitWidth,
              )
          ),
        ):new Container(),
        title: new Text("购物车",style: TextStyle(
          fontSize: ScreenAdapter.size(28)
        ),),
        actions: <Widget>[
          // 右边按钮：编辑、完成
          new InkWell(
            onTap: (){
              setState(() {
                this.isEdited = !this.isEdited;
              });
            },
            child: new Container(
              width: ScreenAdapter.width(120),
              alignment: Alignment.center,
              child:  new Text(this.isEdited?"编辑":"完成",style: TextStyle(
                fontSize: ScreenAdapter.size(24)
              ),),
            ),
          )
        ],
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
      ),
      body: new Container(
        width: double.infinity,
        child: _cartContent(mapData['page']),
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    this.provide ??= widget._provide;
    this._detailProvide ??= widget._detailProvide;
    this._orderDetailProvide ??= widget._orderDetailProvide;
    this._mallProvide ??= widget._mallProvide;
    this._appNavigationBarProvide ??= widget._appNavigationBarProvide;
    // 设置多计数器模式
    this.provide.setMode(mode:"multiple");
    this.provide.sum = 0.00;
    // 初始化数据
    // 判断是否存在token
    print(UserTools().getUserToken());
    if(UserTools().getUserToken()!=null){
      _loadList();
    }
  }

  /// 购物车是否存在商品，构建视图
  Provide<CommodityAndCartProvide> _cartContent(String page){
    return Provide<CommodityAndCartProvide>(
      builder: (BuildContext context,Widget widget,CommodityAndCartProvide provide){
        List<CommodityTypesModel> list = provide.commodityTypesModelLists;
        if(list!=null && list.length>0&& (list[0].commodityModelList.length>0
            || (list.length>1&&list[1].commodityModelList.length>0))){
          return new Center(
            child: new Column(
              children: <Widget>[
                // 商品区域
                new Expanded(
                    flex: 8,
                    child: new Container(
                      width: double.infinity,
                      height: ScreenAdapter.getScreenHeight()-100,
                      child: new ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index){
                            return new Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 5,right: 5),
                              color: Colors.white,
                              child: list[index].commodityModelList.length>0? new Column(
                                children: <Widget>[
                                  new Container(
                                    width: double.infinity,
                                    height: ScreenAdapter.height(60),
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 10,right: 10),
                                    child: CustomsWidget().subTitle(
                                      title: list[index].getTypes(list[index].types),
                                      color: AppConfig.blueBtnColor
                                    ),
                                  ),
                                  _cartList(list[index].commodityModelList)
                                ],
                              ):new Container(),
                            );
                          }),
                    )
                ),
                // 底部操作栏区域
                new Expanded(
                    flex: 1,
                    child: new Container(
                      width: double.infinity,
                      height: ScreenAdapter.height(100),
                      alignment: Alignment.topCenter,
                      child: new Container(
                        width: double.infinity,
                        height: ScreenAdapter.height(100),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [BoxShadow(color: AppConfig.assistLineColor,
                                offset: Offset(0.0,-2.0)),
                              BoxShadow(color:AppConfig.assistLineColor,
                                offset: Offset(0.0,2.0)),]
                        ),
                        child: _bottomWidget(),
                      ),
                    )
                )
              ],
            ),
          );
        }else{
          // 没有商品视图
          return _cartNone(page);
        }
      },
    );
  }

  /// 购物车商品列表部件
  Provide<CommodityAndCartProvide> _cartList(List<CommodityModels> list){
    return Provide<CommodityAndCartProvide>(
      builder: (BuildContext context,Widget widget,CommodityAndCartProvide provide){
        return new Container(
          width: double.infinity,
          child: new Column(
            children: list.asMap().keys.map((key){
              List lists = CommonUtil.skuNameSplit(list[key].skuName);
              return new Container(
                width: double.infinity,
                height: ScreenAdapter.height(200),
                margin: EdgeInsets.only(top: 1,left: 10,right: 10),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppConfig.assistLineColor))
                ),
                child: new InkWell(
                  onTap: (){
                    print("详情跳转");
                  },
                  child: new Row(
                    children: <Widget>[
                      // 选择部件
                      new Expanded(
                          flex:1,
                          child: new Container(
                            child: CustomsWidget().customRoundedWidget(
                                isSelected: list[key].isChecked,
                                onSelectedCallback: (){
                                  provide.setSelected(key,list[key],list[key].isChecked);
                                  setState(() {
                                    this.isAllChecked = provide.isSelected;
                                  });
                                },
                                isDisable: list[key].isDisable
                            ),
                          )
                      ),
                      // 商品信息部件 及 计数器部件
                      new Expanded(
                          flex:10,
                          child: new Container(
                            child: new Row(
                              children: <Widget>[
                                // 商品信息 -- 图片
                                new Expanded(
                                    flex:1,
                                    child: new Container(
                                      padding:EdgeInsets.all(5),
                                      child: new Image.network(list[key].skuPic,width: ScreenAdapter.width(120),),
                                    )
                                ),
                                new Expanded(
                                    flex: 3,
                                    child: new Container(
                                      margin: EdgeInsets.only(top: 15,bottom: 5),
                                      child: new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          // 商品描述
                                          new Expanded(
                                              flex:2,
                                              child: lists!=null?
                                              new Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Text(lists[0],softWrap: true,),
                                                  ),
                                                  Expanded(
                                                    child: Text(lists[1],style: TextStyle(color: Colors.grey),)
                                                  )
                                                ],
                                              )
                                                  : new Container(
                                                padding: EdgeInsets.only(top: 10),
                                                child: new Text(list[key].skuName,softWrap: true,
                                                  style: TextStyle(fontSize: ScreenAdapter.size(28)),
                                                ),
                                              )),
                                          // 商品价格
                                          new Expanded(
                                              flex:1,
                                              child: CustomsWidget().priceTitle(price: list[key].salesPrice.toString())
                                          ),
                                          // 计数器
                                          new Expanded(
                                              flex: 1,
                                              child: new Container(
                                                alignment: Alignment.topCenter,
                                                child: CounterWidget(provide: provide,model: list[key],idx: key ),
                                              )
                                          )

                                        ],
                                      ),
                                    )
                                )
                              ],
                            ),
                          )
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  /// 底部操作栏
  Provide<CommodityAndCartProvide> _bottomWidget(){
    return Provide<CommodityAndCartProvide>(
      builder: (BuildContext context,Widget widget,CommodityAndCartProvide provide){
        return new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Container(
              width: ScreenAdapter.getScreenWidth()/4,
              padding: EdgeInsets.only(left: 20),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _customRoundedWidget(),
                  new Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: new Text("全选",style: TextStyle(fontWeight: FontWeight.w600),),
                  )
                ],
              ),
            ),
            new Container(
              width: ScreenAdapter.getScreenWidth()/1.4,
              padding: EdgeInsets.only(left: 20,right: 10),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  this.isEdited? new Text("总计: "): new Container(),
                  this.isEdited? new Text("¥ ${provide.sum.toString()}",style: TextStyle(fontWeight: FontWeight.w800),)
                      : new Container(),
                  this.isEdited?_bottomDyAction(text: "去结算",
                      callback: (){
                        // 去结算
                        // 选中商品
                        List<CommodityModels> list = [];
                        this.provide.commodityTypesModelLists.forEach((item){
                          item.commodityModelList.forEach((res){
                            if(res.isChecked==true){
                              list.add(res);
                            }
                          });
                        });
                        if(list.length==0){
                          CustomsWidget().showToast(title: "请选择商品");
                          return;
                        }
                        List json = new List();
                        list.forEach((commModel){
                          json.add({
                            "acctID": UserTools().getUserData()['id'],
                            "shopID":commModel.shopID,
                            "prodID":commModel.prodID,
                            "presale":commModel.presale,
                            "skuCode":commModel.skuCode,
                            "skuName":commModel.skuName,
                            "skuPic":commModel.skuPic,
                            "quantity":commModel.quantity,
                            "unit": commModel.unit,
                            "prodCode": commModel.prodCode,
                            "salesPrice":0.01,
                            "allowPointRate":commModel.allowPointRate
                          });
                        });

                        // 跳转订单详情
                        _detailProvide.createShopping(json,context)
                            .doOnListen(() {
                          print('doOnListen');
                        })
                            .doOnCancel(() {})
                            .listen((item) {
                          ///加载数据,订单详情
                          print('listen data->$item');
                          if(item.data!=null){
                            OrderDetailModel model = OrderDetailModel.fromJson(item.data);
                            this._orderDetailProvide.orderDetailModel = model;
                          }
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context){
                                return new OrderDetailPage();
                              })
                          );
                          //      _provide
                        }, onError: (e) {
                          print(e);
                        });
                      }
                  ) : _bottomDyAction(text: "删除所选",
                      callback: (){
                        // 删除所选
//                  this.provide.onDelSelect();
                        CustomsWidget().customShowDialog(context: context,
                          content: "是否删除所选商品",
                          onPressed: (){
                            List<CommodityModels> list = [];
                            this.provide.commodityTypesModelLists.forEach((item){
                              item.commodityModelList.forEach((res){
                                if(res.isChecked==true){
                                  list.add(res);
                                }
                              });
                            });
                            //请求删除
                            this.provide.removeCartsList(list).doOnListen(() {
                              print('doOnListen');
                            })
                                .doOnCancel(() {})
                                .listen((item) {
                              ///加载数据
                              print('listen data->$item');
                              if(item.data!=null){
                                this.provide.onDelSelect();
                                CustomsWidget().showToast(title: "删除成功");
                                Navigator.pop(context);
                              }
                            }, onError: (e) {});

                          });
                      }
                  )

                ],
              ),
            )
          ],
        );
      },
    );
  }

  /// 底部按钮变化：去结算、删除所选
  Widget _bottomDyAction({text,callback}){
    return new Container(
      padding: EdgeInsets.only(left: 5),
      child: new RaisedButton(
        textColor: Colors.white,
        color: this.isEdited?AppConfig.blueBtnColor:AppConfig.fontBackColor,
        onPressed: (){
          callback();
        },
        child: new Text("$text"),
      ),
    );
  }

  /// 自定义原型选择框，全选按钮
  Widget _customRoundedWidget(){
    return CustomsWidget().customRoundedWidget(
      isSelected: this.isAllChecked,
      onSelectedCallback: (){
        setState(() {
          this.isAllChecked = !this.isAllChecked;
        });
        // 所有选中的商品,选中或取消
        this.provide.setValSelected(this.isAllChecked);
      }
    );
  }

  /// 没有商品
  Provide<CommodityAndCartProvide> _cartNone(String page){
    return Provide<CommodityAndCartProvide>(
      builder: (BuildContext context, Widget widget,CommodityAndCartProvide provide){
        return  new Center(
          child: new Column(
            children: <Widget>[
              new Container(
                width: double.infinity,
                height: ScreenAdapter.getScreenHeight()/2.5,
                alignment: Alignment.bottomCenter,
                child: new Stack(
                  children: <Widget>[
                    new Image.asset("assets/images/mall/default_cart.png",width:
                    ScreenAdapter.width(240),),
                    new Positioned(
                        right: 0,
                        bottom: 0,
                        child: new Container(
                          width: ScreenAdapter.width(40),
                          height: ScreenAdapter.height(40),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              color: AppConfig.primaryColor
                          ),
                          child: new Text("0",style: TextStyle(fontWeight: FontWeight.w700),),
                        )
                    )
                  ],
                ),
              ),
              new Container(
                width: double.infinity,
                height: ScreenAdapter.height(80),
                alignment: Alignment.center,
                child: new Text("你的购物袋是空的"),
              ),
              new Container(
                width: double.infinity,
                height: ScreenAdapter.height(80),
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: new Container(
                  width: ScreenAdapter.getScreenWidth()/2.5,
                  child: new RaisedButton(
                    textColor: Colors.white,
                    color: AppConfig.fontBackColor,
                    onPressed: (){
                      ///TODO 判断是否展会进入
                      if(page=="mall"){
                        _mallProvide.currentIndex = 3;
                        _navigatorToPage(widget: MallPage(),navName: '/mallPage');
                      } else {
                        _appNavigationBarProvide.currentIndex = 2;
                        _navigatorToPage(widget: AppNavigationBar(),navName: '/appNavigationBarPage');
                      }
                    },
                    child: new Text("去逛逛"),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 跳转
  void _navigatorToPage({Widget widget,String navName}){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context){
          return widget;
        }
    ),ModalRoute.withName(navName),);
  }

  void _loadList(){
    provide.getMyCarts().doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        List<CommodityModels> list = CommodityList.fromJson(item.data).list;
        provide.commodityTypesModelLists.clear();
        list.forEach((res){
          provide.addCarts(res);
        });
      }
    }, onError: (e) {});
  }
}