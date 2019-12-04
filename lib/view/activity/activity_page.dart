import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:innetsect/app_navigation_bar_provide.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/data/exhibition/ex_activity_model.dart';
import 'package:innetsect/data/main/activity_model.dart';
import 'package:innetsect/main_provide.dart';
import 'package:innetsect/utils/common_util.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/activity/activity_detail_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/activity/activity_provide.dart';
import 'package:provide/provide.dart';

///活动页面
class ActivityPage extends PageProvideNode {
  final ActivityProvide _provide = ActivityProvide.instance;
  final AppNavigationBarProvide _appNavProvide = AppNavigationBarProvide.instance;
  final MainProvide _mainProvide = MainProvide.instance;
  ActivityPage() {
    mProviders.provide(Provider<ActivityProvide>.value(_provide));
    mProviders.provide(Provider<AppNavigationBarProvide>.value(_appNavProvide));
    mProviders.provide(Provider<MainProvide>.value(_mainProvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return ActivityContextPage(_provide,_appNavProvide,_mainProvide);
  }
}

class ActivityContextPage extends StatefulWidget {
  final ActivityProvide provide;
  final AppNavigationBarProvide _appNavProvide;
  final MainProvide _mainProvide;
  ActivityContextPage(this.provide,this._appNavProvide,this._mainProvide);
  @override
  _ActivityContextPageState createState() => _ActivityContextPageState();
}

class _ActivityContextPageState extends State<ActivityContextPage> {
  ScrollController _scrollController;
  AppNavigationBarProvide _appNavProvide;
  ActivityProvide _provide;
  List<ExActivityModel> _exAcivityList=List();

  @override
  void initState() {
    _scrollController = ScrollController()..addListener((){
        if (_scrollController.position.pixels >
            _scrollController.position.maxScrollExtent-20) {
          _loadData(_provide.days);
        }
    });
    _appNavProvide ??= widget._appNavProvide;
    _provide ??= widget.provide;
    DateTime currentTime = DateTime.now();
    String year = currentTime.year.toString();
    String month = currentTime.month.toString().padLeft(2,'0');
    String day = currentTime.day.toString().padLeft(2,'0');
    String days = "$year-$month-$day";
    _provide.days = days;
    int index = _appNavProvide.activityList.indexWhere((item){
      DateTime sessionDate = DateTime.parse(item.sessionDate);
      DateTime times = DateTime(currentTime.year,currentTime.month,currentTime.day);
      return sessionDate.isAtSameMomentAs(times);
    });
    if(index>-1) {
      setState(() {
        _provide.currentIndex = index;
      });
    }else{
      setState(() {
        _provide.currentIndex = 0;
      });
    }

    // 初始化请求数据
    _loadData(days);


    super.initState();
  }

  _loadData(String time){
    _provide.getActivityList(widget._mainProvide.splashModel.exhibitionID, time).doOnListen(() {
      print('doOnListen');
    }).doOnCancel(() {}).listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        setState(() {
          _exAcivityList = ExActivityModelList.fromJson(item.data).list;
        });
      }
    }, onError: (e) {});
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
                  if(_provide.currentIndex!=key){
                    colors = Colors.black45;
                    textColors = Colors.white60;
                  }
                  return InkWell(
                    onTap: () async{
                      setState(() {
                        _provide.currentIndex = key;
                        _provide.days = _appNavProvide.activityList[key].sessionDate;
                      });
                      _loadData(_provide.days);
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
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async{
                  _loadData(_provide.days);
                },
                child: ListView.builder(
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  // shrinkWrap: true,
                  itemCount: _exAcivityList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () async{
                        await Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              return ActivityDetailPage(activityID: _exAcivityList[index].activityID,);
                            }
                        )).then((data){
                          if(data){
                            _loadData(_provide.days);
                          }
                        });
                      },
                      child: Stack(
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
                              alignment: Alignment.centerLeft,
                              child: Text(
                                CommonUtil.formatTimes(_exAcivityList[index].startTime),
                                style:
                                TextStyle(fontSize: ScreenAdapter.size(44), fontWeight: FontWeight.w500),
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
                              child: _exAcivityList[index].poster==null||
                                  _exAcivityList[index].poster.indexOf("http")<0?
                              Image.asset("assets/images/default/default_hori_img.png", fit: BoxFit.cover,):
                              CachedNetworkImage(imageUrl: "${_exAcivityList[index].poster}${ConstConfig.BANNER_MINI_SIZE}",fit: BoxFit.fitWidth,),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: ScreenAdapter.width(80),
                                top: ScreenAdapter.height(120)),
                            child: Container(
                              width: ScreenAdapter.width(130),
                              height: ScreenAdapter.height(48),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${CommonUtil.formatTimes(_exAcivityList[index].endTime)}结束",
                                style:
                                TextStyle(fontSize: ScreenAdapter.size(25), color: Color.fromRGBO(200, 200, 200, 1.0),),
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
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _exAcivityList[index].locCode,
                                style:
                                TextStyle(fontSize: ScreenAdapter.size(35),),
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
                                  CommonUtil.activityStatus(_exAcivityList[index].status),
                                  style:
                                  TextStyle(fontSize: ScreenAdapter.size(36),
                                      color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: ScreenAdapter.width(225),
                                top: ScreenAdapter.height(300)),
                            child: Container(
                              width: ScreenAdapter.getScreenWidth()/1.5,
                              child: Text(
                                _exAcivityList[index].activityName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style:
                                TextStyle(fontSize: ScreenAdapter.size(28),),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: ScreenAdapter.width(235),
                                top: ScreenAdapter.height(320)),
                            child: Container(
                              width: ScreenAdapter.width(500),
                              height: ScreenAdapter.height(70),
                              alignment: Alignment.centerLeft,
                              child: Html(
                                data: _exAcivityList[index].brief,
                                useRichText: false,
                                customRender: (node,children){
                                  List<Widget> widget = children;
                                  if(widget.length>0){
                                    Text text = widget[0];
                                    String str = text.data;
                                    return Text(str,softWrap: false,
                                      maxLines: 1,overflow: TextOverflow.ellipsis,
                                    );
                                  }else{
                                    String text = node.text;
                                    return Text(text,softWrap: false,
                                      maxLines: 1,overflow: TextOverflow.ellipsis,
                                    );
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: ScreenAdapter.getScreenWidth()/1.9,
                                top: ScreenAdapter.height(390)),
                            child: Row(
                              children: _bottomWidget(index),
                            ),
                          ),
                        ],
                      ),
                    ) ;
                  },
            )
              )
            )
          ],
        ));
  }

  List<Widget> _bottomWidget(int index){
    List<Widget> widget = [Container(width: 0,height: 0,)];
    ExActivityModel model = _exAcivityList[index];
    if(model.status<2&&model.reservable){
      if(model.reserved){
        // 显示取消预约
        if(model.cancelable){
          widget =[
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                '${model.reservedQty}人已预约',
                style: TextStyle(
                    color: Color.fromRGBO(200, 200, 200, 1.0),
                    fontSize: ScreenAdapter.size(26)
                ),
              ),
            ),
            RaisedButton(
              onPressed: () async{
                await Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return ActivityDetailPage(activityID: model.activityID,);
                    }
                )).then((data){
                  if(data){
                    _loadData(_provide.days);
                  }
                });
              },
              textColor: Colors.white,
              color: Colors.black,
              child: Text("取消预约"),
            )
          ];
        }
      }else{
        // 显示预约按钮
        if(model.inReservingTime){
          widget = [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                '${model.reservedQty}人已预约',
                style: TextStyle(
                    color: Color.fromRGBO(200, 200, 200, 1.0),
                    fontSize: ScreenAdapter.size(26)
                ),
              ),
            ),
            RaisedButton(
              onPressed: () async{
                await Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return ActivityDetailPage(activityID: model.activityID,);
                    }
                )).then((data){
                  if(data){
                    _loadData(_provide.days);
                  }
                });
              },
              textColor: Colors.white,
              color: AppConfig.blueBtnColor,
              child: Text("预约"),
            )
          ];
        }
      }
    }
    return widget;
  }

}
