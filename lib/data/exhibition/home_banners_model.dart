

///展会banner模型
class  HomeBannersModel {
  int bannerID;
  int portalID;
  String bannerPic;

  HomeBannersModel({
    this.bannerID,
    this.portalID,
    this.bannerPic,
  });

  factory HomeBannersModel.fromJson(Map<String, dynamic> json){
    return HomeBannersModel(
      bannerID:json['bannerID'],
      portalID:json['portalID'],
      bannerPic: json['bannerPic'],
    );
  }

  Map<String, dynamic> toJson() => {
    'bannerID':bannerID,
    'portalID':portalID,
    'bannerPic':bannerPic,
  };
}

class  HomeBannersModelList {
  List<HomeBannersModel> list;

  HomeBannersModelList(this.list);

  factory HomeBannersModelList.fromJson(List json){
    return HomeBannersModelList(
      json.map((item)=>HomeBannersModel.fromJson((item))).toList()
    );
  }
}