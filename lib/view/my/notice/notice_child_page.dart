import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/my/notice/notice_provide.dart';
import 'package:provide/provide.dart';

class NoticeChildPage extends PageProvideNode{
  
  final NoticeProvide _provide = NoticeProvide.instance;
  
  NoticeChildPage(){
    mProviders.provide(Provider<NoticeProvide>.value(_provide));
  }
  
  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return NoticeChildContent(_provide);
  }
}

class NoticeChildContent extends StatefulWidget {

  final NoticeProvide _provide;

  NoticeChildContent(this._provide);
  @override
  _NoticeChildContentState createState() => new _NoticeChildContentState();
}

class _NoticeChildContentState extends State<NoticeChildContent> {
  NoticeProvide _provide;
  @override
  Widget build(BuildContext context) {
    Map<dynamic,dynamic> map = ModalRoute.of(context).settings.arguments;

    return new Scaffold(
      appBar: CustomsWidget().customNav(
          context: context,
          widget: new Text(map['topic'],style: TextStyle(fontSize: ScreenAdapter.size((30)),
          fontWeight: FontWeight.w900 ),
        )),
      body: Provide<NoticeProvide>(
        builder: (BuildContext context,Widget widget, NoticeProvide provide){
          var index = provide.list.indexWhere((wh)=>wh['topic']==map['topic']).toInt();
          List list = provide.list[index]['item'];
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, int idx){
              return ExpansionTile(
                title: new Text(list[idx]['question'],style: TextStyle(color: Colors.black),),
                backgroundColor: AppConfig.backGroundColor,
                children: <Widget>[
                  ListTile(
                    subtitle: new Text(list[idx]['answer'],style: TextStyle(color: Colors.grey),),
                  )
                ],
              );
            },
          );
        },
      )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _provide ??= widget._provide;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}