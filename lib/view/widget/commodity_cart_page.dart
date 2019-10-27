import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/commodity_model.dart';
import 'package:innetsect/view/widget/counter_widget.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/utils/screen_adapter.dart';

/// 购物车
class CommodityCartPage extends PageProvideNode{
  final CommodityAndCartProvide _provide = CommodityAndCartProvide();

  CommodityCartPage(){
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_provide));
  }
  
  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return CommodityCartContent(_provide);
  }
}

class CommodityCartContent extends StatefulWidget {
  final CommodityAndCartProvide _provide;
  CommodityCartContent(this._provide);
  @override
  _CommodityCartContentState createState() => new _CommodityCartContentState();
}

class _CommodityCartContentState extends State<CommodityCartContent> {

  CommodityAndCartProvide provide;
  // 全选
  bool isAllChecked = false;
  // 是否编辑
  bool isEdited = true;

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    // 获取上一页的传值
    Map<dynamic,dynamic> mapData = ModalRoute.of(context).settings.arguments==null?
    { 'isBack':false } : ModalRoute.of(context).settings.arguments;
    return new Scaffold(
      appBar: new AppBar(
        leading: mapData['isBack']? new GestureDetector(
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
        child: _cartContent(),
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    this.provide = widget._provide;
    // 设置多计数器模式
    this.provide.setMode(mode:"multiple");
    for(int i=0;i<3;i++){
      CommodityModel model = new CommodityModel();
      model.size = "M";
      model.describe= "描述描述描述描述描述描述描述描述描述描述描述";
      model.count = 2;
      model.id = i+1;
      model.price = 100.00;
      model.colors = "白色";
      model.images = "assets/images/mall/product2.png";
      model.isSelected = false;
      this.provide.addCommodityModelList(model);
    }
  }

  /// 购物车是否存在商品，构建视图
  Provide<CommodityAndCartProvide> _cartContent(){
    return Provide<CommodityAndCartProvide>(
      builder: (BuildContext context,Widget widget,CommodityAndCartProvide provide){
        if(provide.commodityModelList!=null
            && provide.commodityModelList.length>0){
          return new Center(
            child: new Column(
              children: <Widget>[
                // 商品区域
                new Expanded(
                    flex: 8,
                    child: new Container(
                      width: double.infinity,
                      height: ScreenAdapter.getScreenHeight()-100,
                      child: new SingleChildScrollView(
                        child: _cartList(),
                      ),
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
          return _cartNone();
        }
      },
    );
  }

  /// 购物车商品列表部件
  Provide<CommodityAndCartProvide> _cartList(){
    return Provide<CommodityAndCartProvide>(
      builder: (BuildContext context,Widget widget,CommodityAndCartProvide provide){
        List<CommodityModel> list = provide.commodityModelList;
        return new Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 10),
          child: new Column(
            children: list.asMap().keys.map((key){
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
                                isSelected: list[key].isSelected,
                                onSelectedCallback: (){
                                  provide.setSelected(key,list[key].isSelected);
                                  setState(() {
                                    this.isAllChecked = provide.isSelected;
                                  });
                                }
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
                                      child: new Image.asset(list[key].images,width: ScreenAdapter.width(120),),
                                    )
                                ),
                                new Expanded(
                                    flex: 3,
                                    child: new Container(
                                      margin: EdgeInsets.all(5),
                                      child: new Column(
                                        children: <Widget>[
                                          // 商品描述
                                          new Expanded(
                                            flex:2,
                                            child: new Container(
                                              padding: EdgeInsets.only(top: 10),
                                              child: new Text(list[key].describe,softWrap: true,
                                                style: TextStyle(fontSize: ScreenAdapter.size(28)),
                                              ),
                                          )),
                                          // 商品价格
                                          new Expanded(
                                            flex:1,
                                            child: CustomsWidget().priceTitle(price: list[key].price.toString())
                                          ),
                                          // 计数器
                                          new Expanded(
                                            flex: 1,
                                            child: new Container(
                                              alignment: Alignment.centerRight,
                                              child: CounterWidget(provide: provide,idx: key ),
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
  Widget _bottomWidget(){
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
              this.isEdited? new Text("¥ 0.00",style: TextStyle(fontWeight: FontWeight.w800),)
                  : new Container(),
              this.isEdited?_bottomDyAction(text: "去结算",
                callback: (){
                  //去结算
                }
              ) : _bottomDyAction(text: "删除所选",
                callback: (){
                  // 删除所选
                  this.provide.onDelSelect();
                }
              )

            ],
          ),
        )
      ],
    );
  }

  /// 底部按钮变化：去结算、删除所选
  Widget _bottomDyAction({text,callback}){
    return new Container(
      padding: EdgeInsets.only(left: 5),
      child: new RaisedButton(
        textColor: this.isEdited?AppConfig.fontBackColor:Colors.white,
        color: this.isEdited?AppConfig.primaryColor:AppConfig.fontBackColor,
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
  Widget _cartNone(){
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
                  Navigator.pushNamedAndRemoveUntil(context, "/mallPage",(route) => route == null);
                },
                child: new Text("去逛逛"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}