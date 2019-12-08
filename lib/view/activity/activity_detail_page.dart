import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/exhibition/ex_activity_model.dart';
import 'package:innetsect/data/exhibition/ex_activity_qrcode_model.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/login/login_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/activity/activity_provide.dart';
import 'package:provide/provide.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ActivityDetailPage extends PageProvideNode{

  final ActivityProvide _provide = ActivityProvide.instance;
  final int activityID;

  ActivityDetailPage({this.activityID}){
    mProviders.provide(Provider<ActivityProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return ActivityDetailContent(_provide,activityID);
  }
}

class ActivityDetailContent extends StatefulWidget {
  final ActivityProvide _provide;
  final int activityID;
  ActivityDetailContent(this._provide,this.activityID);
  @override
  _ActivityDetailContentState createState() => new _ActivityDetailContentState();
}

class _ActivityDetailContentState extends State<ActivityDetailContent> {
  ExActivityModel _model = ExActivityModel();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: InkWell(
              onTap: (){
                Navigator.pop(context,true);
              },
              child: Icon(Icons.keyboard_arrow_down),
            ),
            pinned:true,
            expandedHeight: 240.0,
            flexibleSpace: FlexibleSpaceBar(
              background: _model.poster!=null&&(_model.poster).indexOf("http")>-1?
              CachedNetworkImage(
                imageUrl: "${_model.poster}",
                fit: BoxFit.fitWidth):
              Image.asset("assets/images/default/default_hori_img.png", fit: BoxFit.cover,),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: ScreenAdapter.getScreenHeight(),
            delegate: SliverChildListDelegate(
              _model.activityName!=null?[
                Container(
                  padding:EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(_model.activityName,
                        style: TextStyle(fontSize: ScreenAdapter.size(40))),
                      Padding(
                        padding: EdgeInsets.only(top: 10,bottom: 10),
                        child: Text("开始时间: ${_model.startTime}",
                          style: TextStyle(color: Colors.grey),),
                      ),
                      Text("场地: ${_model.locCode}",style: TextStyle(color: Colors.grey),),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: CustomsWidget().subTitle(title: "简介",
                            color: AppConfig.blueBtnColor,width: ScreenAdapter.width(16)),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Html(
                          data: _model.brief,
                        ),
                      )
                    ],
                  ),
                )
              ]:CustomsWidget().noDataWidget()
            ),
          )
        ],
      ),
      bottomSheet: Container(
        width: double.infinity,
        color: Colors.white,
        margin: EdgeInsets.only(left: 20,right: 20),
        child: _bottomWidget(),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  _initData(){
    widget._provide.getActivityDetail(widget.activityID).doOnListen(() {
      print('doOnListen');
    }).doOnCancel(() {}).listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        setState(() {
          _model = ExActivityModel.fromJson(item.data);
        });
      }
    }, onError: (e) {});
  }

  Widget _bottomWidget() {
    Widget widgets = Container(width: 0, height: 0,);
    if (_model.status!=null&&
        _model.status< 2 && _model.reservable) {
      if (_model.reserved&&_model.cancelable) {
        // 显示取消预约
        widgets =  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                onPressed: () {
                  // 取消预约
                  CustomsWidget().customShowDialog(context: context,
                    content: "是否确定取消该场活动预订？",
                    onPressed: () async{
                      await widget._provide.cancelActivity(
                          widget.activityID, _model.reservationID
                      ).then((item){
                          if(item!=null){
                            CustomsWidget().showToast(title: "取消成功");
                            _initData();
                          }
                          Navigator.pop(context);
                        });
                    }
                  );
                },
                textColor: Colors.white,
                color: Colors.black,
                child: Text("取消预约"),
              ),
            ),
            SizedBox(
              width: ScreenAdapter.width(20),
            ),
            Expanded(
              child: RaisedButton(
                onPressed: () async{
                  /// 请求二维码
                  widget._provide.getQrcode(widget.activityID, _model.reservationID).doOnListen(() {
                    print('doOnListen');
                  }).doOnCancel(() {}).listen((item) {
                    ///加载数据
                    print('listen data->$item');
                    if(item!=null&&item.data!=null){
                      ExActivityQrCodeModel qrModel = ExActivityQrCodeModel.fromJson(item.data);
                      if(qrModel.status==2){
                        showDialog(context: context,
                            builder: (context){
                              return AlertDialog(
                                contentPadding:EdgeInsets.only(
                                    left: ScreenAdapter.width(50),
                                    top: 10,
                                    bottom: 10,right: 10),
                                content: Container(
                                  width: ScreenAdapter.getScreenWidth()/2,
                                  height: ScreenAdapter.getScreenHeight()/4,
                                  alignment: Alignment.center,
                                  child: Image.asset("assets/images/default/past.png"),
                                ),
                              );
                            });
                      }else{
                        showDialog(context: context,
                            builder: (context){
                              return AlertDialog(
                                contentPadding:EdgeInsets.only(
                                    left: ScreenAdapter.width(200)/2,
                                    top: 10,
                                    bottom: 10,right: 10),
                                content: Container(
                                  width: ScreenAdapter.getScreenWidth()/2,
                                  height: ScreenAdapter.getScreenHeight()/4,
                                  alignment: Alignment.center,
                                  child: QrImage(
                                    data: qrModel.reservationCode,
                                    size: 1000,
                                    version: QrVersions.auto,
                                  ),
                                ),
                              );
                            });
                      }
                    }
                  }, onError: (e) {});
                },
                textColor: Colors.white,
                color: AppConfig.blueBtnColor,
                child: Text("查看二维码"),
              ),
            )
          ],
        );
      } else {
        // 显示预约按钮
        if (_model.inReservingTime) {
          widgets =
              RaisedButton(
                onPressed: () async{
                  // 请求预约
                  print(UserTools().getUserToken());
                  if(UserTools().getUserToken()==null
                  ||UserTools().getUserToken().isEmpty){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return LoginPage();
                      }
                    ));
                  }else{
                    _validMarkReq();
                  }
                },
                textColor: Colors.white,
                color: AppConfig.blueBtnColor,
                child: Text("预约"),
              );
        }
      }
    }
    return widgets;
  }

  _validMarkReq(){
    widget._provide.vaildMark(widget.activityID).doOnListen(() {
      print('doOnListen');
    }).doOnCancel(() {}).listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        CustomsWidget().showToast(title: "预约成功");
        _initData();
      }
    }, onError: (e) {});
  }
}