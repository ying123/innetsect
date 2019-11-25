import 'package:innetsect/base/base.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/data/exhibition/halls_model.dart';
import 'package:innetsect/data/exhibition/venue_halls_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/venues_map/venues_halls_e6_provide.dart';
import 'package:provide/provide.dart';
class VenuesHallsE6Page extends PageProvideNode {
  final VenuesHallsE6Provide _provide = VenuesHallsE6Provide();
  List<HallsModel> venueHallsE6;
  VenuesHallsE6Page(this.venueHallsE6){
    mProviders.provide(Provider<VenuesHallsE6Provide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
 
    return VenuesHallsContentPage(_provide,venueHallsE6);
  }
}


class VenuesHallsContentPage extends StatefulWidget {
 final VenuesHallsE6Provide _provide;
 List<HallsModel> venueHallsE6;
  VenuesHallsContentPage(this._provide,this.venueHallsE6);
  @override
  _VenuesHallsContentPageState createState() => _VenuesHallsContentPageState();
}

class _VenuesHallsContentPageState extends State<VenuesHallsContentPage> {
  VenuesHallsE6Provide _provide;
  @override
  void initState() { 
    super.initState();
    _provide??= widget._provide;
    print('venueHallsE6=====>${widget.venueHallsE6}');
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(750),
      height: ScreenAdapter.height(600),
    );
  }
}