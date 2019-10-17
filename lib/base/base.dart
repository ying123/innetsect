
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:rxdart/rxdart.dart';
///基本数据状态供应类[ChangeNotifier]通过混入changeNotifer管理听众
class BaseProvide with ChangeNotifier{
  ///复合订阅
  CompositeSubscription compositeSubscription = CompositeSubscription();

  /// add[StreamSubscription] to[CompositeSubscription]
  /// 在[dispose]的时候能进行取消
  addSubscription(StreamSubscription subscription){
    compositeSubscription.add(subscription);
  }

  @override
  void dispose() {
    super.dispose();
    compositeSubscription.dispose();
  }
}

///所有page的基类[PageProvideNode]
///隐藏了[ProviderNode] 的调用
abstract class PageProvideNode extends StatelessWidget {
///给子元素[child]提供数据相当于[Provider]容器
  final Providers mProviders = Providers();
  
  Widget buildContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return ProviderNode(
      providers: mProviders,
      child: buildContent(context),
    );
  }
}


abstract class BaseState<T extends StatefulWidget>extends State<T>{
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}