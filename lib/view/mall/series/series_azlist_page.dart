import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/view_model/mall/series/series_provide.dart';
import 'package:provide/provide.dart';

/// 品牌
class SeriesAzListPage extends PageProvideNode{

  final SeriesProvide _seriesProvide = SeriesProvide.instance;

  SeriesAzListPage(){
    mProviders.provide(Provider<SeriesProvide>.value(_seriesProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return SeriesAzListContent(_seriesProvide);
  }
}

class SeriesAzListContent extends StatefulWidget {
  final SeriesProvide _seriesProvide;
  SeriesAzListContent(this._seriesProvide);
  @override
  _SeriesAzListContentState createState() => _SeriesAzListContentState();
}

class _SeriesAzListContentState extends State<SeriesAzListContent> {
  SeriesProvide _seriesProvide;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesProvide ??= widget._seriesProvide;
  }
}
