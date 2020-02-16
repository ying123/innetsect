import 'package:innetsect/data/draw/pics_data.dart';
import 'package:innetsect/data/draw/shops_data.dart';
import 'package:innetsect/data/draw/steps_data.dart';

///抽签数据
class DrawsModel {
  num drawID;
  String drawPic;
  String drawName;
  num drawAwardType;
  num drawProdID;
  num drawProdPrice;
  String startTime;
  String endTime;
  String startBuyingTime;
  String expiryTime;
  String drawRule;
  num drawStatus;
  String registerPrompt;
  num wonQty;
  num approvedStatus;
  String remark;
  String createdDate;
  String createdBy;
  String lastModified;
  String lastModifiedBy;
  bool drawed;
  List<StepsModel> steps;
  List<ShopsModel> shops;
  List<PicsModel> pics;
  num status;
  bool valid;
  bool editable;
  bool deletable;
  bool drawBySku;
 

  DrawsModel({
    this.drawID,
    this.drawPic,
    this.drawName,
    this.drawAwardType,
    this.drawProdID,
    this.drawProdPrice,
    this.startTime,
    this.endTime,
    this.startBuyingTime,
    this.expiryTime,
    this.drawRule,
    this.drawStatus,
    this.registerPrompt,
    this.wonQty,
    this.approvedStatus,
    this.remark,
    this.createdDate,
    this.createdBy,
    this.lastModified,
    this.lastModifiedBy,
    this.drawed,
    this.steps,
    this.shops,
    this.pics,
    this.status,
    this.valid,
    this.editable,
    this.deletable,
    this.drawBySku,
   
  });

  factory DrawsModel.fromJson(Map<String, dynamic> json) {
    return DrawsModel(
      drawID: json['drawID'],
      drawPic: json['drawPic'],
      drawName: json['drawName'],
      drawAwardType: json['drawAwardType'],
      drawProdID: json['drawProdID'],
      drawProdPrice: json['drawProdPrice'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      startBuyingTime: json['startBuyingTime'],
      expiryTime: json['expiryTime'],
      drawRule: json['drawRule'],
      drawStatus: json['drawStatus'],
      registerPrompt: json['registerPrompt'],
      wonQty: json['wonQty'],
      approvedStatus: json['approvedStatus'],
      remark: json['remark'],
      createdDate: json['createdDate'],
      createdBy: json['createdBy'],
      lastModified: json['lastModified'],
      lastModifiedBy: json['lastModifiedBy'],
      drawed: json['drawed'],
      steps: json['steps']!=null? StepsModelList.fromJson(json['steps']).list:null,
      shops: json['shops']!=null? ShopsModelList.fromJson(json['shops']).list:null,
      pics: json['pics']!=null? PicsModelList.fromJson(json['pics']).list:null,
      status: json['status'],
      valid: json['valid'],
      editable: json['editable'],
      deletable: json['deletable'],
      drawBySku: json['drawBySku'],
   
    );
  }

  Map<String, dynamic> toJson() => {
        'drawID': drawID,
        'drawPic': drawPic,
        'drawName': drawName,
        'drawAwardType': drawAwardType,
        'drawProdID': drawProdID,
        'drawProdPrice': drawProdPrice,
        'startTime': startTime,
        'endTime': endTime,
        'startBuyingTime': startBuyingTime,
        'expiryTime': expiryTime,
        'drawRule': drawRule,
        'drawStatus': drawStatus,
        'registerPrompt': registerPrompt,
        'wonQty': wonQty,
        'approvedStatus': approvedStatus,
        'remark': remark,
        'createdDate': createdDate,
        'createdBy': createdBy,
        'lastModified': lastModified,
        'lastModifiedBy': lastModifiedBy,
        'drawed': drawed,
        'steps': steps,
        'shops': shops,
        'pics': pics,
        'status': status,
        'valid': valid,
        'editable': editable,
        'deletable': deletable,
        'drawBySku': drawBySku,
      };
}

class DrawsModelList {
  List<DrawsModel> list;

  DrawsModelList(this.list);

  factory DrawsModelList.fromJson(List json) {
    return DrawsModelList(
        json.map((item) => DrawsModel.fromJson((item))).toList());
  }
}
