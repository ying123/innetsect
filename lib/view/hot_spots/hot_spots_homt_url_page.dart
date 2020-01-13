import 'package:innetsect/base/base.dart';
import 'package:innetsect/view/hot_spots/hot_spots_homt_url_provide.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
class HotSpotsHomeUrlPage extends PageProvideNode{
  HotSpotsHomtUrlProvide _provide = HotSpotsHomtUrlProvide();
  HotSpotsHomeUrlPage(){
    mProviders.provide(Provider<HotSpotsHomtUrlProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return null;
  }
}