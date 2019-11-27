class BannersModel{
  int bannerID;
  int portalID;
  String bannerPic;
  String redirectType;
  String redirectTo;
  String redirectParam;

  BannersModel({
    this.bannerID,
    this.portalID,
    this.bannerPic,
    this.redirectParam,
    this.redirectTo,
    this.redirectType
  });

  factory BannersModel.fromJson(Map<String,dynamic> json){
    return BannersModel(
      bannerID: json['bannerID'],
      portalID: json['portalID'],
      bannerPic: json['bannerPic'],
      redirectParam: json['redirectParam'],
      redirectTo: json['redirectTo'],
      redirectType: json['redirectType']
    );
  }

  Map<String,dynamic> toJson() =>{
    'bannerID': bannerID,
    'portalID': portalID,
    'bannerPic':bannerPic,
    'redirectTo': redirectTo,
    'redirectType': redirectType,
    'redirectParam': redirectParam
  };
}


class BannersModelList{
  List<BannersModel> list;

  BannersModelList(this.list);

  factory BannersModelList.fromJson(List json){
    return BannersModelList(
        json.map(
                (item)=>BannersModel.fromJson((item))
        ).toList()
    );
  }
}