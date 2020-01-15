import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:innetsect/base/platform_menu_config.dart';
import 'package:innetsect/data/user_info_model.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/login/login_page.dart';
import 'package:innetsect/view/mall/commodity/qimo_page.dart';
import 'package:innetsect/view/my/all/after/after_service_list_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';

/// 我的售后

class AfterServicePage extends StatefulWidget {

  @override
  _AfterServicePageState createState() => new _AfterServicePageState();
}

class _AfterServicePageState extends State<AfterServicePage>
with SingleTickerProviderStateMixin{
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(
        context: context,
        elevation: 0.5,
        widget: new Text("我的售后",style: TextStyle(fontSize: ScreenAdapter.size((30)),
            fontWeight: FontWeight.w900 ),
          ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: (){
                if(UserTools().getUserToken()==''){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return LoginPage();
                      }
                  ));
                }else{
                  UserInfoModel userInfoModel = UserTools().getUserInfo();
                  // 数据结构组装
//                var url = Uri.encodeComponent("https://proadmin.innersect.net/eshop/stores/shopProductDetail?id=${_provide.skusModel.prodID}&shopId=${_provide.commodityModels.shopID}");
                  var json={
                    "nickName": userInfoModel.nickName==null?userInfoModel.mobile:userInfoModel.nickName,
                    "peerId":"10052522",
//                  "cardInfo":{
//                    "left":{
//                      "url": _provide.commodityModels.skuPic
//                    },
//                    "right1":{
//                      "text": _provide.commodityModels.skuName,  // 首行文字内容，展示时超出两行隐藏，卡片上单行隐藏
//                      "color": "#595959",                 // 字体颜色，支持十六位 #ffffff 格式的颜色，不填或错误格式默认#595959
//                      "fontSize": 12
//                    },
//                    "right2": {
//                      "text": "¥${_provide.commodityModels.salesPriceRange}",        // 第二行文字内容，展示时超出两行隐藏，卡片上单行隐藏
//                      "color": "#595959",                 // 字体颜色，支持十六位 #ffffff 格式的颜色，不填或错误格式默认#595959
//                      "fontSize": 12                      // 字体大小， 默认12 ， 请传入number类型的数字
//                    },
//                    "url": url
//                  }
                  };
                  var otherParams = jsonEncode(json);
                  // 用户id
                  var clientId = "1000${userInfoModel.acctID}";
                  // 自定义字段
                  var userInfo={
                    "手机号":userInfoModel.mobile
                  };

                  var qimoPath = "https://webchat.7moor.com/wapchat.html?accessId=20ed0990-2268-11ea-a2c3-49801d5a0f66"
                      +"&fromUrl=m3.innersect.net&urlTitle=innersect"
                      +"&otherParams="+Uri.encodeFull(otherParams)+"&clientId="+clientId+"&customField="+Uri.encodeFull(jsonEncode(userInfo));
                  print(qimoPath);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return QimoPage(url: qimoPath,);
                      }
                  ));
                }
              },
              child: Image.asset("assets/images/newpersonalcentre/联系客服@3x.png",fit: BoxFit.fitWidth,width: ScreenAdapter.width(40),),
            ),
          )
        ],
        bottom: new TabBar(
            controller: _tabController,
            unselectedLabelColor: Colors.black38,
            indicatorColor: Colors.black54,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 1.0,
            isScrollable: true,
            indicator: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black54))
            ),
            tabs: afterTabBarList.map((item){
              return new Tab(
                child: new Text(item.title),
              );
            }).toList())
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new AfterServiceListPage(idx: 0),
          new AfterServiceListPage(idx: 1),
          new AfterServiceListPage(idx: 2),
          new AfterServiceListPage(idx: 3),
          new AfterServiceListPage(idx: 4)
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }
}