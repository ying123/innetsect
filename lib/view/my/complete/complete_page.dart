import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/view_model/my/complete/complete_provide.dart';
import 'package:provide/provide.dart';

class CompletePage extends PageProvideNode{
  final CompleteProvider _provider = CompleteProvider();
  CompletePage(){
    mProviders.provide(Provider.value(_provider));
  }
  @override
  Widget buildContent(BuildContext context) {
    
    return CompleteContentPage();
  }
}

class CompleteContentPage extends StatefulWidget {
  @override
  _CompleteContentPageState createState() => _CompleteContentPageState();
}

class _CompleteContentPageState extends State<CompleteContentPage> {
  @override
  Widget build(BuildContext context) {
     return Container(
      color: Colors.white,
      child: Center(
        child: Text('已完成'),
      ),
    );
  }
}