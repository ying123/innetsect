import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/order/logistice_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/my_order/after_service_provide.dart';
import 'package:provide/provide.dart';

/// 售后物流信息
class AfterLogisticsPage extends PageProvideNode{
  final AfterServiceProvide _afterServiceProvide = AfterServiceProvide.instance;
  AfterLogisticsPage(){
    mProviders.provide(Provider<AfterServiceProvide>.value(_afterServiceProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return AfterLogisticsContent(_afterServiceProvide);
  }
}

class AfterLogisticsContent extends StatefulWidget {
  final AfterServiceProvide _afterServiceProvide;
  AfterLogisticsContent(this._afterServiceProvide);
  @override
  _AfterLogisticsContentState createState() => new _AfterLogisticsContentState();
}

class _AfterLogisticsContentState extends State<AfterLogisticsContent> {
  AfterServiceProvide _afterServiceProvide;
  List<LogisticeModel> _list=new List();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
        widget: new Text("物流进度",style: TextStyle(fontSize: ScreenAdapter.size((30)),
            fontWeight: FontWeight.w900)),
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
                child: CustomsWidget().subTitle(title: "售后编号:  ${_afterServiceProvide.afterOrderModel.rmaNo}",
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
                child: _list.length>0?ListView.builder(
                    itemCount: _list.length,
                    itemBuilder: (BuildContext context, int index){
                      return new Row(
                        children: <Widget>[
                          Expanded(
                            child: new Row(
                              children: <Widget>[
//                                Expanded(
//                                  flex:1,
//                                  child: new Container(
//                                    color: Colors.yellow,
//                                    child: Text('1'),
//                                  ),
//                                ),
                                Expanded(
                                  flex: 9,
                                  child: new Container(
                                    padding: EdgeInsets.only(left: 10,right: 20),
                                    margin: EdgeInsets.only(top: 20),
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Text(_list[index].context),
                                        new Padding(padding: EdgeInsets.only(top: 20),
                                          child: new Text(_list[index].ftime,
                                            style: TextStyle(color: Colors.grey),),),
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
                    }): Column(
                  children: CustomsWidget().noDataWidget(),
                ),
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
    _afterServiceProvide ??= widget._afterServiceProvide;
    _loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _afterServiceProvide.clearLogisticeModelList();
  }

  _loadData(){
    _afterServiceProvide.getShipperDetail().doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        // 设置物流数据
        setState(() {
          _list = LogisticeModelList.fromJson(item.data['data']).list;
        });
      }
    }, onError: (e) {});
  }
}