
//展会数据
import 'package:innetsect/data/exhibition/halls_model.dart';
import 'package:innetsect/data/exhibition/sessions_model.dart';

class  ExhibitiondModel {
  int exhibitionID;
  String exhibitionName;
  String addr;
  String locOverview;
  String openTime;
  String closeTime;
  String mediaFiles;
  int shopID;
  String welcomeTitle;
  String welcomeText;
  int status;
  String createdDate;
  String createdBy;
  String lastModified;
  String lastModifiedBy;
  List<HallsModel> halls;
  List<SessionsModel> sessions;
  String locations;
  bool editable;
  bool deletable;

  ExhibitiondModel({
    this.exhibitionID,
    this.exhibitionName,
    this.addr,
    this.locOverview,
    this.openTime,
    this.closeTime,
    this.mediaFiles,
    this.shopID,
    this.welcomeTitle,
    this.welcomeText,
    this.status,
    this.createdDate,
    this.createdBy,
    this.lastModified,
    this.lastModifiedBy,
    this.halls,
    this.sessions,
    this.locations,
    this.editable,
    this.deletable,
  });

  factory ExhibitiondModel.fromJson(Map<String, dynamic> json){
    return ExhibitiondModel(
      exhibitionID:json['exhibitionID'],
      exhibitionName:json['exhibitionName'],
      addr: json['addr'],
      locOverview: json['locOverview'],
      openTime: json['openTime'],
      closeTime: json['closeTime'],
      mediaFiles: json['mediaFiles'],
      shopID: json['shopID'],
      welcomeTitle: json['welcomeTitle'],
      welcomeText: json['welcomeText'],
      status: json['status'],
      createdDate: json['createdDate'],
      createdBy: json['createdBy'],
      lastModified: json['lastModified'],
      lastModifiedBy: json['lastModifiedBy'],
      halls: json['halls']!= null? HallsModelList.fromJson(json['halls']).list:null,
      sessions: json['sessions']!= null ? SessionsModelList.fromJson(json['sessions']).list:null,
      locations: json['locations'],
      editable: json['editable'],
      deletable: json['deletable'],
      //contents: json['contents']!= null? HomeContentsModelList.fromJson(json['contents']).list:null,
    );
  }

  Map<String, dynamic> toJson() => {
    'exhibitionID':exhibitionID,
    'exhibitionName':exhibitionName,
    'addr':addr,
    'locOverview':locOverview,
    'openTime':openTime,
    'closeTime':closeTime,
    'mediaFiles':mediaFiles,
    'shopID':shopID,
    'welcomeTitle':welcomeTitle,
    'welcomeText':welcomeText,
    'status':status,
    'createdDate':createdDate,
    'createdBy':createdBy,
    'lastModified':lastModified,
    'lastModifiedBy':lastModifiedBy,
    'halls':halls,
    'sessions':sessions,
    'locations':locations,
    'editable':editable,
    'deletable':deletable,
  };
}

class  ExhibitiondModelList {
  List<ExhibitiondModel> list;

  ExhibitiondModelList(this.list);

  factory ExhibitiondModelList.fromJson(List json){
    return ExhibitiondModelList(
      json.map((item)=>ExhibitiondModel.fromJson((item))).toList()
    );
  }
}