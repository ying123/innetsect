import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/data/exhibition/vip_card_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:innetsect/view_model/my/vip_card_provide.dart';
import 'package:provide/provide.dart';

///贵宾卡
class VIPCardPage extends PageProvideNode {
  final VIPCardProvide _provide = VIPCardProvide();
  
  VIPCardPage() {
    mProviders.provide(Provider<VIPCardProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return VIPCardContent(_provide);
  }
  
}

class VIPCardContent extends StatefulWidget {

  final VIPCardProvide _provide;
  VIPCardContent(this._provide);
  @override
  _VIPCardContentState createState() => new _VIPCardContentState();
}

class _VIPCardContentState extends State<VIPCardContent> {

  List<VIPCardModle> _list;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
        widget: new Text("我的贵宾卡",style: TextStyle(fontSize: ScreenAdapter.size((30)),
            fontWeight: FontWeight.w900)),
      ),
      body: ListWidgetPage(
        onRefresh: () async{
          _loadData();
        },
        onLoad: () async{
          _loadData();
        },
        child: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              _list!=null&&_list.isNotEmpty?_list.map((item){
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    image: DecorationImage(
                      image: AssetImage("assets/images/user/vipcard/vip_card.png"),
                      fit: BoxFit.fitWidth
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                        child: Text(item.cardName,softWrap: false,maxLines: 1,style: TextStyle(
                          fontWeight: FontWeight.w800,fontSize: ScreenAdapter.size(42)
                        ),)
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("有效期至 ${item.expiryTime}",softWrap: false,maxLines: 1,style: TextStyle(
                                color: Colors.grey
                            ),),
                            Text("${item.discountRate.toString()} 折",softWrap: false, maxLines: 1,style: TextStyle(
                              color: AppConfig.blueBtnColor,fontSize: ScreenAdapter.size(72),fontWeight: FontWeight.w800
                            ),)
                          ],
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Text(item.remark==null?"":item.remark,style: TextStyle(
                          color: Colors.grey,fontSize: ScreenAdapter.size(28)
                        ),),
                      )
                    ],
                  ),
                );
              }).toList():CustomsWidget().noDataWidget()
            ),
          )
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  _loadData(){
    widget._provide.listData().doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        setState(() {
          _list = VIPCardModleList.fromJson(item.data).list;
        });
      }
    }, onError: (e) {});
  }
}