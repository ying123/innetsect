import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';

class AllocatingRecordPage extends StatefulWidget {
  final String mobile;
  AllocatingRecordPage({this.mobile});
  @override
  _AllocatingRecordPageState createState() => new _AllocatingRecordPageState();
}

class _AllocatingRecordPageState extends State<AllocatingRecordPage> {
  EasyRefreshController _easyRefreshController;
  List _list = List();
  List _subList = List();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
          widget: new Text("调货记录",style: TextStyle(fontSize: ScreenAdapter.size((30)),
              fontWeight: FontWeight.w900)),leading: true
      ),
      body: ListWidgetPage(
        onLoad: () async{
          _loadList();
        },
        onRefresh: () async{
          _loadList();
        },
        controller: _easyRefreshController,
        child: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              _list.length>0?
                  _list.map((item){
                    return InkWell(
                      onTap: () async{
                        // 底部弹出
                        showModalBottomSheet(context: context, builder: (_){
                          return Container(
                            width: double.infinity,
                            child: Scaffold(
                              appBar: CustomsWidget().customNav(context: context,
                                  widget: new Text("调货记录",style: TextStyle(fontSize: ScreenAdapter.size((30)),
                                      fontWeight: FontWeight.w900)),leading: true
                              ),
                              body: ListView.builder(
                                  itemCount: _subList.length,
                                  itemExtent: ScreenAdapter.height(220),
                                  itemBuilder: (ctx,index){
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(bottom: BorderSide(color: Colors.white30))
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child:_subList[index]['ImgUrl']==null?
                                                Image.asset("assets/images/default/default_img.png",
                                                fit: BoxFit.fitWidth,): CachedNetworkImage(
                                              imageUrl: _subList[index]['ImgUrl'],
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(_subList[index]['NameEN']),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 10,bottom: 10),
                                                  child: Text("数量: ${_subList[index]['Qty']} 颜色: ${_subList[index]['Color']}"
                                                      "   尺码: ${_subList[index]['Size']}",style: TextStyle(
                                                      color: Colors.grey,fontSize: ScreenAdapter.size(24)
                                                  ),),
                                                ),
                                                Text(_subList[index]['UPC'])
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ) ;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("订单编号: ${item['DOCNO']}"),
                                Padding(
                                  padding: EdgeInsets.only(top: 10,bottom: 10),
                                  child: Text("编号： ${item['DeliveryCode']==null?'':item['DeliveryCode']}")
                                ),
                                Text("创建日期：${item['CreateTime']}",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: ScreenAdapter.size(24)
                                  ),)
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(_getStatus(item['Status']),
                                  style: TextStyle(
                                      color: AppConfig.blueBtnColor,fontSize: ScreenAdapter.size(24)
                                  ),),
                                Container(
                                  padding: EdgeInsets.only(top: 10,bottom: 10),
                                  child: Icon(Icons.chevron_right),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList()
                  :CustomsWidget().noDataWidget()
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
    _easyRefreshController = EasyRefreshController();
    _loadList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  _loadList() async{
    await Dio().get("http://exwms.exfox.com.cn/service/api/Transfer/getTransferByPhone?oWHKey=1"
        "&oUserKey=d6a0da66b82040429e2b2c9f2bec2779&oUrl=jobclient.htm"
        "&ReceivePhone=${widget.mobile}").then((item){
          if(item.data['data']!=null){
            setState(() {
              _list = item.data['data']['table0'];
              _subList = item.data['data']['table1'];
            });
          }
    });
  }

  String _getStatus(int status){
    //0/1/2==待处理/拣货中/已出库。-1是作废
    String str;
    switch(status){
      case 0:
        str="待处理";
      break;
      case 1:
        str="拣货中";
      break;
      case 2:
        str="已出库";
      break;
      case -1:
        str="作废";
      break;
    }
    return str;
  }
}