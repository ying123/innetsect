import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:innetsect/view_model/mall/home/mall_home_provide.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MallHomePage extends PageProvideNode {
  final MallHomeProvide _provide = MallHomeProvide();
  MallHomePage(){
    mProviders.provide(Provider<MallHomeProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {

    return MallHomeContent(_provide);
  }

}

class MallHomeContent extends StatefulWidget {

  final MallHomeProvide _provide;

  MallHomeContent(this._provide);

  @override
  _MallHomeContentState createState() => new _MallHomeContentState();
}

class _MallHomeContentState extends State<MallHomeContent> {

  // 控制器
  EasyRefreshController _controller;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        title: Text(
          '商城',
          style: TextStyle(
              fontSize: ScreenAdapter.size(40),
              fontWeight: FontWeight.w600,
              color: AppConfig.fontPrimaryColor),
        ),
        centerTitle: true,
        leading: Container(),
        actions: <Widget>[
          GestureDetector(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, ScreenAdapter.height(38), 0, 0),
              child: Text(
                '进入展会',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: ScreenAdapter.size(30),
                  color: AppConfig.fontPrimaryColor,
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/appNavigationBarPage');
            },
          ),
          SizedBox(
            width: ScreenAdapter.width(20),
          )
        ],
      ),
      body: new ListWidgetPage(
        controller: _controller,
        child: <Widget>[
            // 数据内容
            SliverList(
              delegate:
                SliverChildListDelegate([
                  _setupSwiperImage(),
                  _setupListItemsContent()
                ])
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
  }

  ///轮播图
  Provide<MallHomeProvide> _setupSwiperImage() {
    return Provide<MallHomeProvide>(
      builder: (BuildContext context, Widget child, MallHomeProvide provide) {
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(470),
          color: Colors.white,
          child: Center(
            child: Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(420),
              color: Colors.white,
              child: Swiper(
                index: 0,
                loop: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print('第$index 页被点击');
                    },
                    child: ClipPath(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: ScreenAdapter.width(750),
                            height: ScreenAdapter.height(420),
                            child: CachedNetworkImage(
                              fadeOutDuration:
                              const Duration(milliseconds: 300),
                              fadeInDuration: const Duration(milliseconds: 700),
                              fit: BoxFit.fill,
                              imageUrl: provide.bannerImages[index],
                              errorWidget: (context, url, error) {
                                return Icon(Icons.error);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: provide.bannerImages.length,
                // pagination: SwiperPagination(),
                autoplay: true,
                duration: 300,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        );
      },
    );
  }

  Provide<MallHomeProvide> _setupListItemsContent() {
    return Provide<MallHomeProvide>(
      builder: (BuildContext context, Widget child, MallHomeProvide provide) {
        var itemWith = (ScreenAdapter.getScreenWidth()) / 1;
        return Container(
          child: Wrap(
            runSpacing: 0,
            spacing: 0,
            children: provide.listItems.map((value) {
              return Container(
                // padding: EdgeInsets.all(10),

                width: itemWith,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: AspectRatio(
                        //防止服务器返回的图片大小不一致导致高度不一致问题
                        aspectRatio: 2 / 1,
                        child: Image.asset(
                          value['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenAdapter.height(20),
                          left: ScreenAdapter.width(20)),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          value['title'],
                          softWrap: true,
                          style: TextStyle(fontSize: ScreenAdapter.size(30)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenAdapter.height(20),
                          left: ScreenAdapter.width(20)),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: ScreenAdapter.width(85),
                            height: ScreenAdapter.height(30),
                            color: AppConfig.fontPrimaryColor,
                            child: Center(
                              child: Text(
                                value['subTitle'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenAdapter.size(21)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(10),
                          ),
                          Container(
                            width: ScreenAdapter.width(85),
                            height: ScreenAdapter.height(30),
                            color: AppConfig.fontPrimaryColor,
                            child: Center(
                              child: Text(
                                value['subTitle1'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenAdapter.size(21)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(10),
                          ),
                          Container(
                            width: ScreenAdapter.width(85),
                            height: ScreenAdapter.height(30),
                            color: AppConfig.fontPrimaryColor,
                            child: Center(
                              child: Text(
                                value['subTitle2'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenAdapter.size(21)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(10),
                          ),
                          Text(
                            value['time'],
                            style: TextStyle(
                                color: Color.fromRGBO(180, 180, 180, 1.0)),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Image.asset(
                            'assets/images/关注.png',
                            fit: BoxFit.cover,
                            width: ScreenAdapter.width(30),
                            height: ScreenAdapter.height(25),
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(6),
                          ),
                          Text(value['focusNuber'],
                              style: TextStyle(
                                  color: Color.fromRGBO(180, 180, 180, 1.0))),
                          SizedBox(
                            width: ScreenAdapter.width(35),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenAdapter.height(38),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}