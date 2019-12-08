import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/exhibition/ticket_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:innetsect/view_model/show_tickets/ticket_provide.dart';
import 'package:provide/provide.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketsPage extends PageProvideNode{
  final TicketProvide _ticketProvide = TicketProvide();

  TicketsPage(){
    mProviders.provide(Provider<TicketProvide>.value(_ticketProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return TicketsContent(_ticketProvide);
  }
}

class TicketsContent extends StatefulWidget {
  final TicketProvide _ticketProvide;
  TicketsContent(this._ticketProvide);
  @override
  _TicketsContentState createState() => new _TicketsContentState();
}

class _TicketsContentState extends State<TicketsContent> {
  EasyRefreshController _easyRefreshController;
  List<TicketModel> _list = List();
  int _pages=1;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
        widget: new Text("我的门票",style: TextStyle(fontSize: ScreenAdapter.size((30)),
            fontWeight: FontWeight.w900)),
      ),
      body: ListWidgetPage(
        controller: _easyRefreshController,
        onRefresh: ()async{
          _pages = 1;
          _list.clear();
          _loadList();
        },
        onLoad: ()async{
          _pages ++;
          _loadList();
        },
        child: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                  _list!=null&&_list.isNotEmpty?_list.map((item){
                    return InkWell(
                      onTap: () async{
                        await showDialog(context: context,
                          builder: (ctx){
                            return Center(
                              child: SizedBox(
                                width: ScreenAdapter.width(400),
                                height: ScreenAdapter.height(400),
                                child: QrImage(
                                  data: item.ticketNo,
                                  size: 5000,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            );
                          }
                        );
                      },
                      child:  Stack(
                        children: <Widget>[
                          Container(
                            height: ScreenAdapter.height(220),
                            margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                            padding: EdgeInsets.only(top: 12),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: AssetImage("assets/images/default/activity_bg.png", )
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: ScreenAdapter.width(180),
                                  height: ScreenAdapter.height(180),
                                  margin: EdgeInsets.only(left: 40),
                                  child: QrImage(
                                    data: item.ticketNo,
                                    size: 5000,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: ScreenAdapter.height(180),
                                    padding: EdgeInsets.only(top: 6,left: 40,right: 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(item.ticketName,maxLines: 2,softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(0xFF000000)
                                          ),),
                                        Padding(
                                            padding: EdgeInsets.only(top:20),
                                            child: Text(item.validTimeDesc,softWrap: false,maxLines: 1,
                                              overflow: TextOverflow.ellipsis,style: TextStyle(
                                                  fontSize: ScreenAdapter.size(24),
                                                  color: Color(0xFF000000)
                                              ),
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList():CustomsWidget().noDataWidget()
            ))
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

  _loadList(){
    widget._ticketProvide.ticketsList(_pages).doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        setState(() {
          _list.addAll(TicketModelList.fromJson(item.data).list);
        });
      }
    }, onError: (e) {});
  }
}
