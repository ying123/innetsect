import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/exhibition/ex_activity_qrcode_model.dart';
import 'package:innetsect/main_provide.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/activity/activity_detail_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:innetsect/view/widget/pre_view_page.dart';
import 'package:innetsect/view_model/activity/activity_provide.dart';
import 'package:provide/provide.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ActivityMarkPage extends PageProvideNode{
  final ActivityProvide _activityProvide = ActivityProvide.instance;
  final MainProvide _mainProvide = MainProvide.instance;

  ActivityMarkPage(){
    mProviders.provide(Provider<ActivityProvide>.value(_activityProvide));
    mProviders.provide(Provider<MainProvide>.value(_mainProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return ActivityMarkContent(_activityProvide,_mainProvide);
  }
  
}

class ActivityMarkContent extends StatefulWidget {
  final ActivityProvide _activityProvide;
  final MainProvide _mainProvide;
  ActivityMarkContent(this._activityProvide,this._mainProvide);
  @override
  _ActivityMarkContentState createState() => new _ActivityMarkContentState();
}

class _ActivityMarkContentState extends State<ActivityMarkContent> {
  EasyRefreshController _easyRefreshController;
  List<ExActivityQrCodeModel> _list = List();
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
          widget: new Text("我的预约",style: TextStyle(fontSize: ScreenAdapter.size((30)),
              fontWeight: FontWeight.w900 ),)
      ),
      body: ListWidgetPage(
        controller: _easyRefreshController,
        onRefresh: () async{
          _page = 0;
          _list.clear();
          _loadList();
        },
        onLoad: () async{
          _page = _page+1;
          _loadList();
        },
        child: <Widget>[
          // 数据内容
          SliverList(
            delegate: SliverChildListDelegate(
              _list.map((item){
                return InkWell(
                  onTap: () async{
                    await Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return ActivityDetailPage(activityID: item.activityID,);
                        }
                    )).then((data){
                      if(data){
                        _loadList();
                      }
                    });
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
                          children: <Widget>[
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context){
                                    return PreViewPage();
                                  }
                                ));
                              },
                              child: Container(
                                width: ScreenAdapter.width(180),
                                height: ScreenAdapter.height(180),
                                margin: EdgeInsets.only(left: 40),
                                child: QrImage(
                                  foregroundColor: item.status==2?Colors.black26:Color(0xFF000000),
                                  data: item.reservationCode,
                                  size: 1000,
                                ),
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
                                    Text(item.activityName,maxLines: 2,softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: item.status==2?Colors.black26:Color(0xFF000000)
                                    ),),
                                    Padding(
                                        padding: EdgeInsets.only(top:20),
                                        child: Text(item.remark.substring(0,item.remark.length-2),softWrap: false,maxLines: 1,
                                          overflow: TextOverflow.ellipsis,style: TextStyle(
                                            fontSize: ScreenAdapter.size(24),
                                            color: item.status==2?Colors.black26:Color(0xFF000000)
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
                      item.status==2?
                          Positioned(
                            top: 0,
                            right: 10,
                            child: Image.asset("assets/images/user/un_use.png",
                            width: ScreenAdapter.width(140),
                            fit: BoxFit.fitWidth,),
                          )
                          :Container(width: 0,height: 0,)
                    ],
                  ),
                );
              }).toList()
            ),
          )],
      )
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
    widget._activityProvide.getDataList(widget._mainProvide.splashModel.exhibitionID,
    _page).doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        if(_page==1){
          _list.clear();
        }
        this.setState((){
          _list.addAll(ExActivityQrCodeModelList.fromJson(item.data).list);
        });
      }
    }, onError: (e) {});
  }
}