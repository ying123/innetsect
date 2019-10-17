import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/view_model/activity/activity_provide.dart';
import 'package:provide/provide.dart';

///活动页面
class ActivityPage extends PageProvideNode{
  final ActivityProvide _provide = ActivityProvide();
  ActivityPage(){
    mProviders.provide(Provider<ActivityProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
   
    return ActivityContextPage();
  }
}


class ActivityContextPage extends StatefulWidget {
  @override
  _ActivityContextPageState createState() => _ActivityContextPageState();
}

class _ActivityContextPageState extends State<ActivityContextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('活动页面'),
      ),
    );
  }
}