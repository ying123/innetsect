import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/notice_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/notice/notice_child_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/my/notice/notice_provide.dart';
import 'package:provide/provide.dart';

/// 购买须知
class NoticePage extends PageProvideNode{
  final NoticeProvide _provide = NoticeProvide.instance;
  NoticePage(){
    mProviders.provide(Provider<NoticeProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return NoticeContent(_provide);
  }
}

class NoticeContent extends StatefulWidget {
  final NoticeProvide _provide;
  NoticeContent(this._provide);
  @override
  _NoticeContentState createState() => new _NoticeContentState();
}

class _NoticeContentState extends State<NoticeContent> {
  NoticeProvide _provide;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
          widget: new Text("购买须知",style: TextStyle(fontSize: ScreenAdapter.size((30)),
              fontWeight: FontWeight.w900 ),
          )),
      body:  Provide<NoticeProvide>(
        builder: (BuildContext context,Widget widget,NoticeProvide provide){
          if(provide.list.length>0){
            return new Container(
              child: Column(
                children: provide.list.map((item){
                  return new Column(
                    children: <Widget>[
                      CustomsWidget().listSlider(title: item['topic'],titleFont: FontWeight.w700,
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context){
                                  return NoticeChildPage();
                                },
                                settings: RouteSettings(arguments: {'topic':item['topic']})
                            ));
                          }
                      ),
                      Divider(height: 3,color: Colors.grey,indent: 20,endIndent: 20,)
                    ],
                  );
                }).toList(),
              ),
            );
          }else{
            return new Container();
          }
        },
      )
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _provide??=widget._provide;

    _loadData();
  }

  _loadData() async{
    _provide.listData().doOnListen(() {
      print('doOnListen');
    }).doOnCancel(() {}).listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item.data!=null){
        _provide.resetData(NoticeModelList.fromJson(item.data).list);
      }
    }, onError: (e) {});
  }
}