import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:provide/provide.dart';

/// 单选
class CommoditySelectWidget extends StatefulWidget {
  final CommodityAndCartProvide _cartProvide;
  CommoditySelectWidget(this._cartProvide);

  @override
  _CommoditySelectWidgetState createState() => new _CommoditySelectWidgetState();
}

class _CommoditySelectWidgetState extends State<CommoditySelectWidget> {
  CommodityAndCartProvide _cartProvide;
  List list = [{'id':1,'image':'assets/images/mall/product2.png','color':'白色',
    'des':'描述描述描述描述描述描述描述述描述描述述描述描述','isSelected':true},
    {'id':2,'image':'assets/images/mall/product2.png','color':'红色',
      'des':'描述描述描述描述描述描述描述述描述描述述描述描述','isSelected':false}];

  List listSize = [{"id":1,"size":"M",'isSelected':true},
    {"id":2,"size":"L",'isSelected':false},
    {"id":3,"size":"L",'isSelected':false},
    {"id":4,"size":"L",'isSelected':false},
    {"id":5,"size":"L",'isSelected':false},
    {"id":6,"size":"X",'isSelected':false}];
  String size="大号";

  @override
  Widget build(BuildContext context) {
//    final obj = Provide.value<CommodityAndCartProvide>(context);
    print(this._cartProvide.count);
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
  }

  /// 上半部分
  Widget _topContentWidget(){
    return new Container(
      width: double.infinity,
      child: new Column(
        children: this.list.map((item){
          return new InkWell(
            onTap: (){
              setState(() {
                list.forEach((item)=> item['isSelected'] = false);
                item['isSelected'] = true;
              });
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
                        border: new Border.all(width: 2,color:
                        item['isSelected']?AppConfig.fontBackColor:Colors.white
                        )
                    ),
                    child: Image.asset(item['image'],fit: BoxFit.fill,),
                  ),
                  new Container(
                    width: ScreenAdapter.getScreenWidth()-100,
                    color: Colors.white,
                    child: new Text("${item['des']} ${this.size} ${item['color']}",softWrap: true,
                      style: TextStyle(
                          fontSize: ScreenAdapter.size(32)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// 下半部分，尺寸的选择
  Widget _bottomContentWidget(){
    return new Scrollbar(child: new SingleChildScrollView(
      scrollDirection:Axis.horizontal,
      child: new Center(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: listSize.map((item){
            return new InkWell(
              onTap: (){
                setState(() {
                  listSize.forEach((items)=>items['isSelected']=false);
                  item['isSelected'] = true;
                  size = item['size'];
                });
              },
              child: new Container(
                width: ScreenAdapter.width(100),
                height: ScreenAdapter.height(100),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 2,
                        color: item['isSelected']?AppConfig.fontBackColor:Colors.white
                    )
                ),
                alignment: Alignment.center,
                child: new Text(item['size'],style: TextStyle(
                    fontSize: ScreenAdapter.size(32),
                    fontWeight: FontWeight.w900
                ),),
              ),
            );
          }).toList(),
        ),
      ),
    ));
  }
}