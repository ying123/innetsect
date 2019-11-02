/// 省份
class ProvincesModel{
  String localeCode;
  String countryCode;
  String regionCode;
  String regionName;
  int regionType;
  String parentRegionCode;
  double longitude;
  double latitude;
  String briefName;
  String fullName;
  String telPrefix;
  String timeDiff;

  ProvincesModel({
    this.briefName,
    this.countryCode,
    this.regionCode,
    this.regionName,
    this.regionType,
    this.parentRegionCode,
    this.longitude,
    this.latitude,
    this.fullName,
    this.localeCode,
    this.telPrefix,
    this.timeDiff
  });

  factory ProvincesModel.fromJson(Map<String,dynamic> json){
    return ProvincesModel(
        localeCode: json['localeCode'],
        countryCode: json['countryCode'],
        regionCode: json['regionCode'],
        regionName: json['regionName'],
        regionType: json['regionType'],
        parentRegionCode: json['parentRegionCode'],
        longitude: json['longitude'],
        latitude: json['latitude'],
        briefName: json['briefName'],
        fullName: json['fullName'],
        telPrefix: json['telPrefix'],
        timeDiff: json['timeDiff']
    );
  }

  Map<String,dynamic> toJson() =>{
    'localeCode': localeCode,
    'countryCode': countryCode,
    'regionCode': regionCode,
    'regionName': regionName,
    'regionType': regionType,
    'parentRegionCode':parentRegionCode,
    'longitude': longitude,
    'latitude': latitude,
    'briefName': briefName,
    'fullName': fullName,
    'telPrefix': telPrefix,
    'timeDiff': timeDiff
  };
}

class ProvincesModelList{
  List<ProvincesModel> list;

  ProvincesModelList(this.list);

  factory ProvincesModelList.fromJson(List json){
    return ProvincesModelList(
        json.map(
                (item)=>ProvincesModel.fromJson((item))
        ).toList()
    );
  }
}