import 'package:innetsect/data/mall/content_model.dart';

class PortletsModel{
  int portletID;
  int portalID;
  int portletIdx;
  int portletType;
  int prodCollID;
  int layout;
  dynamic renderer;

  List<ContentModel> contents;

  PortletsModel({
    this.contents,
    this.layout,
    this.portalID,
    this.portletID,
    this.portletIdx,
    this.portletType,
    this.prodCollID,
    this.renderer
  });

  factory PortletsModel.fromJson(Map<String,dynamic> json){
    return PortletsModel(
      portalID: json['portalID'],
      portletID: json['portletID'],
      portletIdx: json['portletIdx'],
      portletType: json['portletType'],
      prodCollID: json['prodCollID'],
      layout: json['layout'],
      renderer: json['renderer'],
      contents: json['contents']!=null?ContentModelList.fromJson(json['contents']).list:[]
    );
  }
}

class PortletsModelList{

  List<PortletsModel> list;

  PortletsModelList(this.list);

  factory PortletsModelList.fromJson(List json){
    print(json);
    return PortletsModelList(
        json.map(
                (item)=>PortletsModel.fromJson((item))
        ).toList()
    );
  }

}