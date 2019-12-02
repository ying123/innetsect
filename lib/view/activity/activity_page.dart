import 'package:flutter/material.dart';
import 'package:innetsect/app_navigation_bar_provide.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/main/activity_model.dart';
import 'package:innetsect/utils/common_util.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
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
  final AppNavigationBarProvide _appNavProvide = AppNavigationBarProvide.instance;
  ActivityPage() {
    mProviders.provide(Provider<ActivityProvide>.value(_provide));
    mProviders.provide(Provider<AppNavigationBarProvide>.value(_appNavProvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return ActivityContextPage(_provide,_appNavProvide);
  }
}

class ActivityContextPage extends StatefulWidget {
  final ActivityProvide provide;
  final AppNavigationBarProvide _appNavProvide;
  ActivityContextPage(this.provide,this._appNavProvide);
  @override
  _ActivityContextPageState createState() => _ActivityContextPageState();
}

class _ActivityContextPageState extends State<ActivityContextPage> {
  ScrollController _scrollController;
  AppNavigationBarProvide _appNavProvide;

  @override
  void initState() {
    _scrollController = ScrollController();
    _appNavProvide ??= widget._appNavProvide;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
     
    return Scaffold(
        appBar:  CustomsWidget().customNav(context: context,
          widget: new Text("活动",style: TextStyle(fontSize: ScreenAdapter.size((30)),
              fontWeight: FontWeight.w900)),leading: false
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(280),
              alignment: Alignment.center,
              child: Wrap(
                spacing: 20,
                runSpacing: 10,
                children: _appNavProvide.activityList.asMap().keys.map((key){
                  ActivityModel item = _appNavProvide.activityList[key];
                  DateTime dates = DateTime.parse(item.sessionDate);
                  String weekday = CommonUtil.formatWeekday(dates.weekday);
                  String month = CommonUtil.formatMonth(dates.month);
                  String day = dates.day<10?"0${dates.day}":dates.day.toString();
                  Color colors = Colors.black;
                  Color textColors = Colors.white;
                  if(widget.provide.currentIndex!=key){
                    colors = Colors.black45;
                    textColors = Colors.white60;
                  }
                  return InkWell(
                    onTap: () {
                      setState(() {
                        widget.provide.currentIndex = key;
                      });
                    },
                    child: Container(
                      width: ScreenAdapter.getScreenWidth()/4,
                      height: ScreenAdapter.height(240),
                      decoration: BoxDecoration(
                        border: Border.all(color: colors),
                      ),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: ScreenAdapter.getScreenWidth()/3,
                              color: colors,
                              alignment: Alignment.center,
                              child: Text(weekday,style: TextStyle(
                                color: textColors,
                                fontSize: ScreenAdapter.size(32)
                              ),),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(month, style: TextStyle(
                                color: colors,
                                fontSize: ScreenAdapter.size(52),
                                fontWeight: FontWeight.w800
                              ),),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(day,style: TextStyle(
                                fontSize: ScreenAdapter.size(62),
                                color: colors,
                                fontWeight: FontWeight.w800
                              ),),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
//            Expanded(
//              child: ListView.builder(
//                physics: BouncingScrollPhysics(),
//                // shrinkWrap: true,
//                itemCount: widget.provide.activityListdata.length,
//                itemBuilder: (BuildContext context, int index) {
//                  return Stack(
//                    children: <Widget>[
//                      Center(
//                        child: Container(
//                          width: ScreenAdapter.width(690),
//                          height: ScreenAdapter.height(490),
//                       //   color: Colors.yellow,
//                        ),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.only(left: ScreenAdapter.width(40)),
//                        child: Container(
//                          width: ScreenAdapter.width(2),
//                          height: ScreenAdapter.height(52),
//                          color: Color.fromRGBO(200, 200, 200, 1.0),
//                        ),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.only(left: ScreenAdapter.width(60)),
//                        child: Container(
//                          width: ScreenAdapter.width(640),
//                          height: ScreenAdapter.height(2),
//                          color: Color.fromRGBO(200, 200, 200, 1.0),
//                        ),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.only(
//                            left: ScreenAdapter.width(34),
//                            top: ScreenAdapter.height(68)),
//                        child: Container(
//                          //alignment: Alignment.centerLeft,
//                          width: ScreenAdapter.width(15),
//                          height: ScreenAdapter.width(15),
//                          decoration: BoxDecoration(
//                              color: Colors.black87,
//                              borderRadius: BorderRadius.all(
//                                  Radius.circular(ScreenAdapter.width(10)))),
//                        ),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.only(
//                            left: ScreenAdapter.width(40),
//                            top: ScreenAdapter.height(109)),
//                        child: Container(
//                          //alignment: Alignment.centerLeft,
//                          width: ScreenAdapter.width(2),
//                          height: ScreenAdapter.width(375),
//                          decoration: BoxDecoration(
//                            color: Color.fromRGBO(200, 200, 200, 1.0),
//                            //borderRadius: BorderRadius.all(Radius.circular(ScreenAdapter.width(10)))
//                          ),
//                        ),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.only(
//                            left: ScreenAdapter.width(60),
//                            top: ScreenAdapter.height(490)),
//                        child: Container(
//                          width: ScreenAdapter.width(640),
//                          height: ScreenAdapter.height(2),
//                          color: Color.fromRGBO(215, 215, 215, 1.0),
//                        ),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.only(
//                            left: ScreenAdapter.width(78),
//                            top: ScreenAdapter.height(55)),
//                        child: Container(
//                          width: ScreenAdapter.width(130),
//                          height: ScreenAdapter.height(48),
//                       //   color: Color.fromRGBO(215, 215, 215, 1.0),
//                          child: Center(
//                            child: Text(
//                              widget.provide.activityListdata[index]['time'],
//                              style:
//                                  TextStyle(fontSize: ScreenAdapter.size(44), fontWeight: FontWeight.w500),
//                            ),
//                          ),
//                        ),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.only(
//                            left: ScreenAdapter.width(270),
//                            top: ScreenAdapter.height(25)),
//                        child: Container(
//                          width: ScreenAdapter.width(423),
//                          height: ScreenAdapter.height(240),
//                          //color: Color.fromRGBO(215, 215, 215, 1.0),
//                          child: Image.asset(widget.provide.activityListdata[index]['image'], fit: BoxFit.cover,),
//                        ),
//                      ),
//
//                        Padding(
//                        padding: EdgeInsets.only(
//                            left: ScreenAdapter.width(75),
//                            top: ScreenAdapter.height(120)),
//                        child: Container(
//                          width: ScreenAdapter.width(130),
//                          height: ScreenAdapter.height(48),
//                       //   color: Color.fromRGBO(215, 215, 215, 1.0),
//                          child: Center(
//                            child: Text(
//                              widget.provide.activityListdata[index]['endtime'],
//                              style:
//                                  TextStyle(fontSize: ScreenAdapter.size(25), color: Color.fromRGBO(200, 200, 200, 1.0),),
//                            ),
//                          ),
//                        ),
//                      ),
//                        Padding(
//                        padding: EdgeInsets.only(
//                            left: ScreenAdapter.width(90),
//                            top: ScreenAdapter.height(190)),
//                        child: Container(
//                          width: ScreenAdapter.width(130),
//                          height: ScreenAdapter.height(48),
//                       //   color: Color.fromRGBO(215, 215, 215, 1.0),
//                          child: Center(
//                            child: Text(
//                              widget.provide.activityListdata[index]['serialNumber'],
//                              style:
//                                  TextStyle(fontSize: ScreenAdapter.size(35),),
//                            ),
//                          ),
//                        ),
//                      ),
//                        Padding(
//                        padding: EdgeInsets.only(
//                            left: ScreenAdapter.width(75),
//                            top: ScreenAdapter.height(278)),
//                        child: Container(
//                          width: ScreenAdapter.width(140),
//                          height: ScreenAdapter.height(70),
//                       //   color: Color.fromRGBO(215, 215, 215, 1.0),
//                          child: Center(
//                            child: Text(
//                              '未开始',
//                              style:
//                                  TextStyle(fontSize: ScreenAdapter.size(45),),
//                            ),
//                          ),
//                        ),
//                      ),
//                        Padding(
//                        padding: EdgeInsets.only(
//                            left: ScreenAdapter.width(225),
//                            top: ScreenAdapter.height(279)),
//                        child: Container(
//                          width: ScreenAdapter.width(300),
//                          height: ScreenAdapter.height(70),
//                       //   color: Color.fromRGBO(215, 215, 215, 1.0),
//                          child: Center(
//                            child: Text(
//                              widget.provide.activityListdata[index]['title'],
//                              style:
//                                  TextStyle(fontSize: ScreenAdapter.size(33),),
//                            ),
//                          ),
//                        ),
//                      ),
//                        Padding(
//                        padding: EdgeInsets.only(
//                            left: ScreenAdapter.width(245),
//                            top: ScreenAdapter.height(320)),
//                        child: Container(
//                          width: ScreenAdapter.width(500),
//                          height: ScreenAdapter.height(70),
//                       //   color: Color.fromRGBO(215, 215, 215, 1.0),
//                          child: Center(
//                            child: Text(
//                              widget.provide.activityListdata[index]['subTitle'],
//                              style:
//                                  TextStyle(fontSize: ScreenAdapter.size(22),color: Color.fromRGBO(200, 200, 200, 1.0),),
//                            ),
//                          ),
//                        ),
//                      ),
//                        Padding(
//                        padding: EdgeInsets.only(
//                            left: ScreenAdapter.width(566),
//                            top: ScreenAdapter.height(390)),
//                        child: Container(
//                          width: ScreenAdapter.width(125),
//                          height: ScreenAdapter.height(60),
//                          color: Colors.yellow,
//                       //   color: Color.fromRGBO(215, 215, 215, 1.0),
//                          child: Center(
//                            child: Text(
//                              '预约'
//                            ),
//                          ),
//                        ),
//                      ),
//                        Padding(
//                        padding: EdgeInsets.only(
//                            left: ScreenAdapter.width(400),
//                            top: ScreenAdapter.height(392)),
//                        child: Container(
//                          width: ScreenAdapter.width(145),
//                          height: ScreenAdapter.height(60),
//                         // color: Colors.yellow,
//                       //   color: Color.fromRGBO(215, 215, 215, 1.0),
//                          child: Center(
//                            child: Text(
//                              '0人已预约',
//                              style: TextStyle(
//                                 color: Color.fromRGBO(200, 200, 200, 1.0),fontSize: ScreenAdapter.size(30)
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ],
//                  );
//                },
//              ),
//            )
          ],
        ));
  }
}
