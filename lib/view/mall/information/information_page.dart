import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/mall/content_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/information/infor_web_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:innetsect/view_model/mall/information/information_provide.dart';
import 'package:provide/provide.dart';

class InformationPage extends PageProvideNode{

  final InformationProvide _provide = InformationProvide.instance;

  InformationPage(){
    mProviders.provide(Provider<InformationProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return InformationContent(_provide);
  }
}

class InformationContent extends StatefulWidget {
  final InformationProvide _provide;
  InformationContent(this._provide);

  @override
  _InformationContentState createState() => _InformationContentState();
}

class _InformationContentState extends State<InformationContent> {
  int pageNo = 1;
  List<ContentModel> list = new List();
  EasyRefreshController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomsWidget().customNav(context: context, widget: new Text("资讯",style: TextStyle(fontSize: ScreenAdapter.size((30)),
        fontWeight: FontWeight.w900 )),leading:false),
      body: ListWidgetPage(
        controller: _controller,
        onRefresh: () async{
          pageNo = 1;
          list.clear();
          await this._onLoadData();
        },
        onLoad: () async{
          await this._onLoadData();
        },
        child: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              new Container(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: list.map((item){
                    return InkWell(
                      onTap: (){
                        // 请求详情
                        widget._provide.contentID = item.contentID;
                        this._navToWebPage();
                      },
                      child: new Container(
                        child: new Column(
                          children: <Widget>[
                            new CachedNetworkImage(imageUrl: item.poster,fit: BoxFit.cover,width: double.infinity,
                              height:ScreenAdapter.height(420),),
                            new Container(
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(10),
                              child: new Text(item.title,style: TextStyle(
                                  fontSize: ScreenAdapter.size(32),
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  color: Colors.black,
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 20,bottom: 20),
                                  padding: EdgeInsets.all(5),
                                  child: new Text(item.tags,style: TextStyle(color:Colors.white,fontSize: ScreenAdapter.size(18))),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new EasyRefreshController();
    // 初始化列表
    this._onLoadData();
  }

  _onLoadData(){
    widget._provide
        .listData(pageNo: pageNo ++)
        .doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      setState(() {
        list.addAll(ContentModelList.fromJson(item.data).list);
      });
    }, onError: (e) {});
  }

  _navToWebPage(){
    Navigator.push(context, MaterialPageRoute(
        builder: (context){
          return new InforWebPage();
        }
    ));
  }
}
