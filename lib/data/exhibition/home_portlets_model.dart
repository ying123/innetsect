


import 'package:innetsect/data/exhibition/home_contents_model.dart';

class  HomePortletsModel {
  int portletID;
  int portalID;
  int portletIdx;
  int portletType;
  String promotionCode;
  int layout;
  String renderer;
  ///促销活动
  String promotion;
  List<HomeContentsModel> contents;

  HomePortletsModel({
    this.portletID,
    this.portalID,
    this.portletIdx,
    this.portletType,
    this.promotionCode,
    this.layout,
    this.renderer,
    this.promotion,
    this.contents,
  });

  factory HomePortletsModel.fromJson(Map<String, dynamic> json){
    return HomePortletsModel(
      portletID:json['portletID'],
      portalID:json['portalID'],
      portletIdx: json['portletIdx'],
      portletType: json['portletType'],
      promotionCode: json['promotionCode'],
      layout: json['layout'],
      renderer: json['renderer'],
      promotion: json['promotion'],
      contents: json['contents']!= null? HomeContentsModelList.fromJson(json['contents']).list:null,
    );
  }

  Map<String, dynamic> toJson() => {
    'portletID':portletID,
    'portalID':portalID,
    'portletIdx':portletIdx,
    'portletType':portletType,
    'promotionCode':promotionCode,
    'layout':layout,
    'renderer':renderer,
    'promotion':promotion,
    'contents':contents,
  };
}

class  HomePortletsModelList {
  List<HomePortletsModel> list;

  HomePortletsModelList(this.list);

  factory HomePortletsModelList.fromJson(List json){
    return HomePortletsModelList(
      json.map((item)=>HomePortletsModel.fromJson((item))).toList()
    );
  }
}