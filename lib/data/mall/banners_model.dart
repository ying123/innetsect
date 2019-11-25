class BannersModel{
  int bannerID;
  int portalID;
  String bannerPic;

  BannersModel({
    this.bannerID,
    this.portalID,
    this.bannerPic
  });

  factory BannersModel.fromJson(Map<String,dynamic> json){
    return BannersModel(
      bannerID: json['bannerID'],
      portalID: json['portalID'],
      bannerPic: json['bannerPic']
    );
  }

  Map<String,dynamic> toJson() =>{
    'bannerID': bannerID,
    'portalID': portalID,
    'bannerPic':bannerPic
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