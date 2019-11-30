import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/exhibition/venue_halls_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/venues_map/venues_Halls_E5.dart';
import 'package:innetsect/view/venues_map/venues_halls_e6_page.dart';
import 'package:innetsect/view_model/venues_map/venues_map_provide.dart';
import 'package:provide/provide.dart';

class VenuesMapPage extends PageProvideNode {
  final VenuesMapProvide _provide = VenuesMapProvide();

  ///'halls':provide.hallsModelList,
  ///'showId':provide.shopID,
  /// 'locOverview':provide.locOverview
  Map hallsData;
  VenuesMapPage({this.hallsData}) {
    mProviders.provide(Provider.value(_provide));
    _provide.addMenu(hallsData['halls']);
  }
  @override
  Widget buildContent(BuildContext context) {
    return VenuesMapContentPage(_provide, hallsData);
  }
}

class VenuesMapContentPage extends StatefulWidget {
  final VenuesMapProvide _provide;
  Map hallsData;
  VenuesMapContentPage(this._provide, this.hallsData);
  @override
  _VenuesMapContentPageState createState() => _VenuesMapContentPageState();
}

class _VenuesMapContentPageState extends State<VenuesMapContentPage>
    with TickerProviderStateMixin {
  TabController _tabController;
  String _image;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: widget._provide.menu.length, vsync: this);
    if(_tabController.index.toDouble() == _tabController.animation.value) {
      if (_tabController.index == 0) {
        _image = widget._provide.menu[0].overviewPic;
      }
      if(_tabController.index==1){
        _image = widget._provide.menu[1].overviewPic;
      }
    }
    widget._provide.hallsData(widget._provide.menu[0].exhibitionID, widget._provide.menu[0].exhibitionHall)
        .doOnListen((){}).doOnError((e,stack){

        }).listen((item){
          print('item0======>${item.data}');
          if (item.data!= null) {
            setState(() {
                widget._provide.addHallsModelE5List(VenueHallsModelList.fromJson(item.data).list);
            });
          }
        });
        widget._provide.hallsData(widget._provide.menu[1].exhibitionID, widget._provide.menu[1].exhibitionHall)
        .doOnListen((){}).doOnError((e,stack){

        }).listen((item){
          print('item1 ====>${item.data}');
           if (item.data!= null) {
            setState(() {
              widget._provide.addHallsModelE6List(VenueHallsModelList.fromJson(item.data).list);
            });
          }
        });
        
  }
    
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(425),
                  child: Image.network(
                    _image,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: ScreenAdapter.width(30),
                  top: ScreenAdapter.height(80),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/images/xiangxia.png',
                      width: ScreenAdapter.width(38),
                      height: ScreenAdapter.width(38),
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(80),
              child: Center(
                child: Container(
                    width: ScreenAdapter.width(300),
                    height: ScreenAdapter.height(80),
                    child: _tabBar()),
              ),
            ),
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(820),
            //  color: Colors.yellow,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                   VenuesHallsE5Page(widget._provide.menu),
                   VenuesHallsE6Page(widget._provide.menu),
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _tabBar() {
    return new Container(
      //width: ScreenAdapter.getScreenWidth()/7,
      child: new TabBar(
          controller: _tabController,
          isScrollable: false,
          indicatorColor: AppConfig.blueBtnColor,
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle: new TextStyle(fontSize: 14.0),
          labelColor: Colors.black,
          labelStyle:
              new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          indicatorSize: TabBarIndicatorSize.label,
          tabs: widget._provide.menu.map((item) {
            return new Tab(
              text: item.exhibitionHall,
            );
          }).toList()),
    );
  }

  // Provide<VenuesMapProvide> _setupVenuesMapList() {
  //   return Provide<VenuesMapProvide>(builder:
  //       (BuildContext context, Widget child, VenuesMapProvide provide) {
  //     return Container(
  //       height: ScreenAdapter.height(700),
  //       color: Colors.white,
  //       child: ListView.builder(
  //         physics: BouncingScrollPhysics(),
  //         itemCount: provide.venuesListmodel.length,
  //         itemExtent: 100,
  //         itemBuilder: (BuildContext context, int index) {
  //           return Container(
  //             margin: EdgeInsets.only(
  //                 left: ScreenAdapter.width(30),
  //                 right: ScreenAdapter.width(30)),
  //             width: ScreenAdapter.width(750),
  //             height: ScreenAdapter.height(100),
  //             decoration: BoxDecoration(
  //                 border: Border(bottom: BorderSide(color: Colors.black12))),
  //             child: Row(
  //               children: <Widget>[
  //                 Column(
  //                   children: <Widget>[
  //                     SizedBox(
  //                       height: ScreenAdapter.height(20),
  //                     ),
  //                     Container(
  //                       width: ScreenAdapter.width(50),
  //                       height: ScreenAdapter.width(50),
  //                       color: Colors.black,
  //                       child: Center(
  //                           child: Text(
  //                         provide.venuesListmodel[index]['mapTitle'],
  //                         style: TextStyle(color: Colors.white),
  //                       )),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   width: ScreenAdapter.height(20),
  //                 ),
  //                 Text(provide.venuesListmodel[index]['context']),
  //               ],
  //             ),
  //           );
  //         },
  //       ),
  //     );
  //   });
  // }
}
