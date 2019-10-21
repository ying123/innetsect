import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/view_model/my/all/all_provide.dart';
import 'package:provide/provide.dart';

class AllPage extends PageProvideNode{
  final AllProvide _provide = AllProvide();
  AllPage(){
    mProviders.provide(Provider.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
   
    return AllContentPage();
  }
}

class AllContentPage extends StatefulWidget {
  @override
  _AllContentPageState createState() => _AllContentPageState();
}

class _AllContentPageState extends State<AllContentPage> {
  @override
  Widget build(BuildContext context) {
    print('quanbu');
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('全部'),
      ),
    );
  }
}