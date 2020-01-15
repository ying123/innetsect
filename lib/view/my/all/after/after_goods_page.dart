import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/order/shipper_model.dart';
import 'package:innetsect/data/user_info_model.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/commodity/qimo_page.dart';
import 'package:innetsect/view/my/all/after/after_shipper_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/my_order/after_service_provide.dart';
import 'package:provide/provide.dart';
import 'package:url_launcher/url_launcher.dart';

/// 寄回商品
class AfterGoodsPage extends PageProvideNode{
  final AfterServiceProvide _afterServiceProvide = AfterServiceProvide.instance;
  AfterGoodsPage(){
    mProviders.provide(Provider<AfterServiceProvide>.value(_afterServiceProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return AfterGoodsContent(_afterServiceProvide);
  }
}

class AfterGoodsContent extends StatefulWidget {
  final AfterServiceProvide _afterServiceProvide;
  AfterGoodsContent(this._afterServiceProvide);

  @override
  _AfterGoodsContentState createState() => new _AfterGoodsContentState();
}

class _AfterGoodsContentState extends State<AfterGoodsContent> {
  AfterServiceProvide _afterServiceProvide;
  // 物流单号
  String _logisticsNo;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
        widget: new Text("我的售后",style: TextStyle(fontSize: ScreenAdapter.size((30)),
            fontWeight: FontWeight.w900)),
      ),
      body: Container(
        width: ScreenAdapter.size(750),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            // 寄回物流单号
            _logisticsNumber(),
            Divider(height: 5,color: Colors.grey,indent: 40,endIndent: 40,),
            // 选择物流公司
            _selLogistics(),
            Divider(height: 5,color: Colors.grey,indent: 40,endIndent: 40,),
            // 文案
            Container(
              margin: EdgeInsets.only(left: 40,top: 20),
              child: Row(
                children: <Widget>[
                  Text("请将商品寄回",style: TextStyle(fontSize: ScreenAdapter.size(26),
                  color: Colors.black,fontWeight: FontWeight.w600),)
                ],
              ),
            ),
            _descWidget(desc: "1、请在申请通过起7天内将商品寄回，超时则自动关闭售后。"),
            _afterServiceProvide.afterOrderModel.reasonType==5
                ||_afterServiceProvide.afterOrderModel.reasonType==6?
            _descWidget(desc: "2、因质量问题/平台发错货导致退/换货请使用顺丰到付，如您选择其他快递则自理运费。")
            :_descWidget(desc: "2、您可使用任意快递寄回，运费需自理，不支持到付件。发到付件会被拒收或在退款时扣除到付运费。"),
            _descWidget(desc: "收件人：INNERSECT",top: 40),
            _descWidget(desc: "收件地址：上海市浦东新区航川路52号28栋2楼西"),
            _descWidget(desc: "联系电话：400-168-6368"),
            Container(
              padding: EdgeInsets.only(left:40,top:40,right: 40),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("客户服务时间：10:00-18:00",
                      style: TextStyle(fontSize: ScreenAdapter.size(24),fontWeight: FontWeight.w600)),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: <Widget>[
                        Text("如有疑问，请联系:  ",
                            style: TextStyle(fontSize: ScreenAdapter.size(24),fontWeight: FontWeight.w600)),
                        InkWell(
                          onTap: (){
                            UserInfoModel userInfoModel = UserTools().getUserInfo();
                            // 数据结构组装
                            var url = Uri.encodeComponent("https://proadmin.innersect.net/eshop/stores/shopProductDetail?id=${_afterServiceProvide.afterOrderModel.prodID}"
                                "&shopId=${_afterServiceProvide.afterOrderModel.shopID}");
                            var json={
                              "nickName": userInfoModel.nickName==null?userInfoModel.mobile:userInfoModel.nickName,
                              "peerId":"10052522",
                              "cardInfo":{
                                "left":{
                                  "url": _afterServiceProvide.afterOrderModel.skuPic
                                },
                                "right1":{
                                  "text": _afterServiceProvide.afterOrderModel.skuName,  // 首行文字内容，展示时超出两行隐藏，卡片上单行隐藏
                                  "color": "#595959",                 // 字体颜色，支持十六位 #ffffff 格式的颜色，不填或错误格式默认#595959
                                  "fontSize": 12
                                },
                                "right2": {
                                  "text": "¥${_afterServiceProvide.afterOrderModel.salesPrice}",        // 第二行文字内容，展示时超出两行隐藏，卡片上单行隐藏
                                  "color": "#595959",                 // 字体颜色，支持十六位 #ffffff 格式的颜色，不填或错误格式默认#595959
                                  "fontSize": 12                      // 字体大小， 默认12 ， 请传入number类型的数字
                                },
                                "url": url
                              }
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
                          },
                          child: Text("在线客服", style: TextStyle(fontSize: ScreenAdapter.size(28),fontWeight: FontWeight.w600,color: Colors.blue),),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("或拨打     ",
                            style: TextStyle(fontSize: ScreenAdapter.size(24),fontWeight: FontWeight.w600)),
                        GestureDetector(
                          onTap: () async{
                            CustomsWidget().customShowDialog(context: context,
                                content: "联系客服",submitTitle: "拨打",onPressed: () async{
                                  await _call("400-168-6368");
                                });
                          },
                          child: Text("400-168-6368",
                              style: TextStyle(fontSize: ScreenAdapter.size(24),fontWeight: FontWeight.w600,
                                  color: Colors.blue)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: ScreenAdapter.height(60),
        margin: EdgeInsets.only(right: 20,left: 20,bottom: 20),
        child: RaisedButton(
          textColor: Colors.white,
          color: Colors.black,
          onPressed: (){
            // 提交物流信息
            if(_logisticsNo==null){
              CustomsWidget().showToast(title: "请输入物流单号");
            }else{
              // 物流单号请求
              _submitLogistics();
            }
          },
          child: Text("提交",style: TextStyle(fontSize: ScreenAdapter.size(24),
          fontWeight: FontWeight.w600),),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _afterServiceProvide ??= widget._afterServiceProvide;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _afterServiceProvide.shipperModel = null;
  }

  ///寄回物流单号
  Provide<AfterServiceProvide> _logisticsNumber(){
    return Provide<AfterServiceProvide>(
      builder: (BuildContext context,Widget widget,AfterServiceProvide provoide){
        return Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 40,right: 40,top: 20),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "请输入寄回的物流单号",
                  hintStyle: TextStyle(fontSize: ScreenAdapter.size(26))
                ),
                onChanged: (val){
                  setState(() {
                    _logisticsNo = val;
                  });
                },
              ),
            )
          ],
        );
      },
    );
  }

  ///选择物流公司如果是5、6为顺丰到付
  Provide<AfterServiceProvide> _selLogistics(){
    return Provide<AfterServiceProvide>(
      builder: (BuildContext context,Widget widget,AfterServiceProvide provide){
        bool flag = provide.afterOrderModel.reasonType==5||provide.afterOrderModel.reasonType==6;
        String shipperName = provide.shipperModel!=null?provide.shipperModel.shipperName:"请选择物流公司";
        return GestureDetector(
          onTap: (){
            if(!flag){
              // 物流公司请求
              _getShipperData();
              showModalBottomSheet(context: context,
                  builder: (BuildContext context){
                return AfterShipperPage();
              });
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              flag?Container(
                width: ScreenAdapter.getScreenWidth()-80,
                margin: EdgeInsets.only(top: 10,left: 40,right: 40),
                padding: EdgeInsets.only(bottom: 20,top: 10),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))
                ),
                child: Text("顺丰到付",style: TextStyle(fontSize: ScreenAdapter.size(24)),),
              ): Container(
                width: ScreenAdapter.getScreenWidth()-120,
                margin: EdgeInsets.only(top: 10,left: 40,),
                padding: EdgeInsets.only(bottom: 20,top: 10),
                child: Text(shipperName,style: TextStyle(color:provide.shipperModel!=null?Colors.black:Colors.grey,
                    fontSize: ScreenAdapter.size(24)),),
              ),
              flag?Container():
              Container(
                margin: EdgeInsets.only(right: 40),
                child: Icon(Icons.chevron_right),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 文字描述
  Provide<AfterServiceProvide> _descWidget({String desc,double top=10}) {
    return Provide<AfterServiceProvide>(
        builder: (BuildContext context, Widget widget,
            AfterServiceProvide provide) {
      return Container(
        padding: EdgeInsets.only(left: 40,top:top,right: 40),
        alignment: Alignment.centerLeft,
        child: Text(desc,
            style: TextStyle(fontSize: ScreenAdapter.size(24),)),
      );
    });
  }

  /// 提交物流请求
  _submitLogistics(){
    String code = "SFDF";
    if(_afterServiceProvide.afterOrderModel.reasonType!=5&&
        _afterServiceProvide.afterOrderModel.reasonType!=6){
      // 如果不是5、6申请类型，则是物流公司code
      code = _afterServiceProvide.shipperModel.shipperCode.toString();
    }
    _afterServiceProvide.submitLogistic(
      rmaID: _afterServiceProvide.afterOrderModel.rmaID,
      waybillNo: _logisticsNo,
      shipperCode: code,
      reasonType: _afterServiceProvide.afterOrderModel.reasonType
    ).doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        // 设置详情数据
        _afterServiceProvide.removeOrder(_afterServiceProvide.afterOrderModel);
        Navigator.pop(context);
        CustomsWidget().showToast(title: "提交成功");
      }
    }, onError: (e) {});
  }

  /// 物流公司请求
  _getShipperData(){
    _afterServiceProvide.getShipperData().doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        _afterServiceProvide.shipperModelList = ShipperModelList.fromJson(item.data).list;
      }
    }, onError: (e) {});
  }

  /// 拨打电话
  _call(String tel) async {
    String url = 'tel:$tel';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}