import 'package:flutter/material.dart';
import 'package:innetsect/api/loading.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/draw/draw_data.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/draw/draw_provide.dart';
import 'package:innetsect/view/widget/loading_state_widget.dart';
import 'package:provide/provide.dart';

///抽签
class DrawPage extends PageProvideNode {
  final DrawProvide _provide = DrawProvide();
  DrawPage() {
    mProviders.provide(Provider<DrawProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return DrawPageContentPage(_provide);
  }
}

class DrawPageContentPage extends StatefulWidget {
  final DrawProvide provide;
  DrawPageContentPage(this.provide);
  @override
  _DrawPageContentPageState createState() => _DrawPageContentPageState();
}

class _DrawPageContentPageState extends State<DrawPageContentPage> {
  DrawProvide provide;
  LoadState _loadState = LoadState.State_Loading;
  @override
  void initState() {
    super.initState();
    provide ??= widget.provide;
     _loadDrawInfo();
  }

  _loadDrawInfo() {
    provide.draws().doOnListen(() {}).listen((items) {
      print('items.data====> ${items.data}');
      if (items.data != null) {
        provide.drawsModel = DrawsModel.fromJson(items.data);
        print('steps=====>${provide.drawsModel.steps.length}');
        print('shops=====>${provide.drawsModel.shops.length}');
        print('pics====>${provide.drawsModel.pics.length}');
        setState(() {
          _loadState = LoadState.State_Success;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('抽签'),
        centerTitle: true,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
            size: ScreenAdapter.size(60),
          ),
        ),
      ),
      body: LoadStateLayout(
        state: _loadState,
        loadingContent: '加载中...',
        successWidget: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            _setupHead(),
            _setupBody(),
            _setupEnd(),
          ],
        ),
      ),
      )
    );
  }

  Provide<DrawProvide> _setupHead() {
    return Provide<DrawProvide>(
      builder: (BuildContext context, Widget child, DrawProvide provide) {
        return Container(
          color: Colors.white,
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenAdapter.width(680),
                child: Center(
                  child: Text(provide.drawsModel.drawName,
                      style: TextStyle(
                          fontSize: ScreenAdapter.size(40),
                          fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Provide<DrawProvide> _setupBody() {
    return Provide<DrawProvide>(
      builder: (BuildContext context, Widget child, DrawProvide provide) {
        return Column(
          children: <Widget>[
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(360),
              color: Colors.white,
              child: Center(
                child: Container(
                  width: ScreenAdapter.width(695),
                  height: ScreenAdapter.height(360),
                  child: Image.network(
                    provide.drawsModel.drawPic,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: ScreenAdapter.height(50),
            ),
            Center(
              child: Container(
                width: ScreenAdapter.width(695),
                height: ScreenAdapter.height(1),
                color: Colors.black12,
              ),
            )
          ],
        );
      },
    );
  }

  Provide<DrawProvide> _setupEnd() {
    return Provide<DrawProvide>(
      builder: (BuildContext context, Widget child, DrawProvide provide) {
        return ListView.builder(
          itemCount: provide.drawsModel.shops.length,
          shrinkWrap: true,
          primary: false,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: ScreenAdapter.height(40)),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(135),
              child: InkWell(
                onTap: () {
                  print('北京被点击');
                  Navigator.pushNamed(context, '/drawDetailsPage');
                },
                child: Center(
                  child: Container(
                    width: ScreenAdapter.width(695),
                    height: ScreenAdapter.height(95),
                    // margin: EdgeInsets.only(bottom: ScreenAdapter.height(40)),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54)),
                    child: Center(
                      child: Text(
                        provide.drawsModel.shops[index].shopName,
                        style: TextStyle(
                            fontSize: ScreenAdapter.size(30),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
