import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/activity/activity_provide.dart';
import 'package:provide/provide.dart';

class Item {
  String week;
  String month;
  String day;
  bool selected;
  Item(this.week, this.month, this.day, this.selected);
}

///活动页面
class ActivityPage extends PageProvideNode {
  final ActivityProvide _provide = ActivityProvide();
  ActivityPage() {
    mProviders.provide(Provider<ActivityProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return ActivityContextPage(_provide);
  }
}

class ActivityContextPage extends StatefulWidget {
  final ActivityProvide provide;
  ActivityContextPage(this.provide);
  @override
  _ActivityContextPageState createState() => _ActivityContextPageState();
}

class _ActivityContextPageState extends State<ActivityContextPage> {
  ScrollController _scrollController;
  List<Item> _items;

  @override
  void initState() {
    _scrollController = ScrollController();
    _items = new List<Item>();
    _items.add(Item('星期二', '3月', '23', false));
    _items.add(Item('星期三', '4月', '24', false));
    _items.add(Item('星期一', '4月', '24', false));
    _items.add(Item('星期四', '4月', '24', false));
    _items.add(Item('星期五', '4月', '24', false));
    _items.add(Item('星期六', '4月', '24', false));
    _items.add(Item('星期日', '4月', '24', false));
    // Future.delayed(Duration(milliseconds: 2000),(){
    //   AppConfig.userTools.getExhibitionID().then((value){
    //   print('value>>>>>>>>$value');
    // });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
     
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '活动',
           
          ),
          centerTitle: true,
          leading: Container(),
          elevation: 0.0,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(365),
              child: Column(
                children: <Widget>[
                  Container(
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.height(365),
                    color: Colors.white,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      itemCount: _items.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (widget.provide.currentIndex == index) {
                          widget.provide.isBgColors = Colors.red;
                        } else {
                          widget.provide.isBgColors =
                              Color.fromRGBO(217, 215, 225, 1.0);
                        }
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.provide.currentIndex = index;
                              widget.provide.isBgColors = Colors.red;
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: ScreenAdapter.width(30),
                                  top: ScreenAdapter.height(15),
                                  bottom: ScreenAdapter.height(15)),
                              height: ScreenAdapter.width(340),
                              width: ScreenAdapter.height(310),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenAdapter.width(35))),
                                  //  border: Border.all(color: Colors.black26)
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(231, 231, 236, 1.0),
                                        // offset: Offset(5.0, 5.0),
                                        blurRadius: 2.0,
                                        spreadRadius: 2.0),
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: ScreenAdapter.width(310),
                                    height: ScreenAdapter.height(115),
                                    decoration: BoxDecoration(
                                        color: widget.provide
                                            .isBgColors, //_items[index].selected == true ? Colors.red : Color.fromRGBO(217, 215, 225, 1.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenAdapter.width(35)))),
                                    child: Center(
                                      child: Text(
                                        _items[index].week,
                                        style: TextStyle(
                                            fontSize: ScreenAdapter.size(38),
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: ScreenAdapter.width(20),
                                        top: ScreenAdapter.height(20)),
                                    width: ScreenAdapter.width(310),
                                    height: ScreenAdapter.height(75),
                                    child: Text(
                                      _items[index].month,
                                      style: TextStyle(
                                          fontSize: ScreenAdapter.size(40),
                                          color: Color.fromRGBO(
                                              175, 175, 175, 1.0),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Container(
                                    width: ScreenAdapter.width(310),
                                    height: ScreenAdapter.height(100),
                                    child: Center(
                                      child: Text(
                                        _items[index].day,
                                        style: TextStyle(
                                            fontSize: ScreenAdapter.size(90),
                                            color:
                                                Color.fromRGBO(33, 33, 33, 1.0),
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenAdapter.height(25),
                                  ),
                                  Container(
                                    width: ScreenAdapter.width(100),
                                    height: ScreenAdapter.height(10),
                                    color: Color.fromRGBO(175, 175, 175, 1.0),
                                  )
                                ],
                              )),
                        );
                      },
                      // shrinkWrap: true,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                // shrinkWrap: true,
                itemCount: widget.provide.activityListdata.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: ScreenAdapter.width(690),
                          height: ScreenAdapter.height(490),
                       //   color: Colors.yellow,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: ScreenAdapter.width(40)),
                        child: Container(
                          width: ScreenAdapter.width(2),
                          height: ScreenAdapter.height(52),
                          color: Color.fromRGBO(200, 200, 200, 1.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: ScreenAdapter.width(60)),
                        child: Container(
                          width: ScreenAdapter.width(640),
                          height: ScreenAdapter.height(2),
                          color: Color.fromRGBO(200, 200, 200, 1.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenAdapter.width(34),
                            top: ScreenAdapter.height(68)),
                        child: Container(
                          //alignment: Alignment.centerLeft,
                          width: ScreenAdapter.width(15),
                          height: ScreenAdapter.width(15),
                          decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenAdapter.width(10)))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenAdapter.width(40),
                            top: ScreenAdapter.height(109)),
                        child: Container(
                          //alignment: Alignment.centerLeft,
                          width: ScreenAdapter.width(2),
                          height: ScreenAdapter.width(375),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(200, 200, 200, 1.0),
                            //borderRadius: BorderRadius.all(Radius.circular(ScreenAdapter.width(10)))
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenAdapter.width(60),
                            top: ScreenAdapter.height(490)),
                        child: Container(
                          width: ScreenAdapter.width(640),
                          height: ScreenAdapter.height(2),
                          color: Color.fromRGBO(215, 215, 215, 1.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenAdapter.width(78),
                            top: ScreenAdapter.height(55)),
                        child: Container(
                          width: ScreenAdapter.width(130),
                          height: ScreenAdapter.height(48),
                       //   color: Color.fromRGBO(215, 215, 215, 1.0),
                          child: Center(
                            child: Text(
                              widget.provide.activityListdata[index]['time'],
                              style:
                                  TextStyle(fontSize: ScreenAdapter.size(44), fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenAdapter.width(270),
                            top: ScreenAdapter.height(25)),
                        child: Container(
                          width: ScreenAdapter.width(423),
                          height: ScreenAdapter.height(240),
                          //color: Color.fromRGBO(215, 215, 215, 1.0),
                          child: Image.asset(widget.provide.activityListdata[index]['image'], fit: BoxFit.cover,),
                        ),
                      ),

                        Padding(
                        padding: EdgeInsets.only(
                            left: ScreenAdapter.width(75),
                            top: ScreenAdapter.height(120)),
                        child: Container(
                          width: ScreenAdapter.width(130),
                          height: ScreenAdapter.height(48),
                       //   color: Color.fromRGBO(215, 215, 215, 1.0),
                          child: Center(
                            child: Text(
                              widget.provide.activityListdata[index]['endtime'],
                              style:
                                  TextStyle(fontSize: ScreenAdapter.size(25), color: Color.fromRGBO(200, 200, 200, 1.0),),
                            ),
                          ),
                        ),
                      ),
                        Padding(
                        padding: EdgeInsets.only(
                            left: ScreenAdapter.width(90),
                            top: ScreenAdapter.height(190)),
                        child: Container(
                          width: ScreenAdapter.width(130),
                          height: ScreenAdapter.height(48),
                       //   color: Color.fromRGBO(215, 215, 215, 1.0),
                          child: Center(
                            child: Text(
                              widget.provide.activityListdata[index]['serialNumber'],
                              style:
                                  TextStyle(fontSize: ScreenAdapter.size(35),),
                            ),
                          ),
                        ),
                      ),
                        Padding(
                        padding: EdgeInsets.only(
                            left: ScreenAdapter.width(75),
                            top: ScreenAdapter.height(278)),
                        child: Container(
                          width: ScreenAdapter.width(140),
                          height: ScreenAdapter.height(70),
                       //   color: Color.fromRGBO(215, 215, 215, 1.0),
                          child: Center(
                            child: Text(
                              '未开始',
                              style:
                                  TextStyle(fontSize: ScreenAdapter.size(45),),
                            ),
                          ),
                        ),
                      ),
                        Padding(
                        padding: EdgeInsets.only(
                            left: ScreenAdapter.width(225),
                            top: ScreenAdapter.height(279)),
                        child: Container(
                          width: ScreenAdapter.width(300),
                          height: ScreenAdapter.height(70),
                       //   color: Color.fromRGBO(215, 215, 215, 1.0),
                          child: Center(
                            child: Text(
                              widget.provide.activityListdata[index]['title'],
                              style:
                                  TextStyle(fontSize: ScreenAdapter.size(33),),
                            ),
                          ),
                        ),
                      ),
                        Padding(
                        padding: EdgeInsets.only(
                            left: ScreenAdapter.width(245),
                            top: ScreenAdapter.height(320)),
                        child: Container(
                          width: ScreenAdapter.width(500),
                          height: ScreenAdapter.height(70),
                       //   color: Color.fromRGBO(215, 215, 215, 1.0),
                          child: Center(
                            child: Text(
                              widget.provide.activityListdata[index]['subTitle'],
                              style:
                                  TextStyle(fontSize: ScreenAdapter.size(22),color: Color.fromRGBO(200, 200, 200, 1.0),),
                            ),
                          ),
                        ),
                      ),
                        Padding(
                        padding: EdgeInsets.only(
                            left: ScreenAdapter.width(566),
                            top: ScreenAdapter.height(390)),
                        child: Container(
                          width: ScreenAdapter.width(125),
                          height: ScreenAdapter.height(60),
                          color: Colors.yellow,
                       //   color: Color.fromRGBO(215, 215, 215, 1.0),
                          child: Center(
                            child: Text(
                              '预约'
                            ),
                          ),
                        ),
                      ),
                        Padding(
                        padding: EdgeInsets.only(
                            left: ScreenAdapter.width(400),
                            top: ScreenAdapter.height(392)),
                        child: Container(
                          width: ScreenAdapter.width(145),
                          height: ScreenAdapter.height(60),
                         // color: Colors.yellow,
                       //   color: Color.fromRGBO(215, 215, 215, 1.0),
                          child: Center(
                            child: Text(
                              '0人已预约',
                              style: TextStyle(
                                 color: Color.fromRGBO(200, 200, 200, 1.0),fontSize: ScreenAdapter.size(30)
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ));
  }
}
