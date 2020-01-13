import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/base/base.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/settings/list_of_activities_provide.dart';
import 'package:provide/provide.dart';

class ListOfActivitiesPage extends PageProvideNode{
  final ListOfActivitiesProvide _provide = ListOfActivitiesProvide();
  ListOfActivitiesPage(){
    mProviders.provide(Provider<ListOfActivitiesProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return ListOfActivitiesContentPage(_provide);
  }
}

class ListOfActivitiesContentPage extends StatefulWidget {
  final ListOfActivitiesProvide _provide;
  ListOfActivitiesContentPage(this._provide);
  @override
  _ListOfActivitiesContentPageState createState() => _ListOfActivitiesContentPageState();
}

class _ListOfActivitiesContentPageState extends State<ListOfActivitiesContentPage> {
  ListOfActivitiesProvide _provide;
  @override
  void initState() { 
    super.initState();
    _provide??= widget._provide;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('活动列表'),
        centerTitle: true,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
            size: ScreenAdapter.size(60),
          ),
        ),
      ),
      body: _setupActivitiesList(),
    );
  }
  Provide<ListOfActivitiesProvide>_setupActivitiesList(){
    return Provide<ListOfActivitiesProvide>(
      builder: (BuildContext context, Widget child,ListOfActivitiesProvide provide ){
        return ListView.builder(
          itemCount: provide.activitiesTitl.length,
          itemBuilder: (BuildContext context, int index){
            return InkWell(
              onTap: (){
                if ('抽签活动'== provide.activitiesTitl[index]) {
                  print(provide.activitiesTitl[index]);
                  Navigator.pushNamed(context, '/drwaActivitiedTestPage');
                }else if('热区'== provide.activitiesTitl[index]){
                    print('热区被点击');
                    Navigator.pushNamed(context, '/hotTestPage');
                }
                else{
                  Fluttertoast.showToast(
                    msg: '暂未开启',
                    gravity: ToastGravity.CENTER
                  );
                }
              },
              child: Container(
                //alignment: Alignment.centerRight,
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(120),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black54))
                ),
                child: Center(child: Text(provide.activitiesTitl[index],style: TextStyle(fontSize: ScreenAdapter.size(30)),)),
              ),
            );
          },
        );
      },
    );
  }
}