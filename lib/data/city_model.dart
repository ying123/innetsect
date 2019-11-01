class CityModel{
  int localeCode;
  String countryCode;
  String briefName;
  String fullName;
  String telPrefix;
  String timeDiff;

  CityModel({
    this.briefName,
    this.countryCode,
    this.fullName,
    this.localeCode,
    this.telPrefix,
    this.timeDiff
  });

  factory CityModel.fromJson(Map<String,dynamic> json){
    return CityModel(
      localeCode: json['localeCode'],
      countryCode: json['countryCode'],
      briefName: json['briefName'],
      fullName: json['fullName'],
      telPrefix: json['telPrefix'],
      timeDiff: json['timeDiff']
    );
  }

  Map<String,dynamic> toJson() =>{
    'localeCode': localeCode,
    'countryCode': countryCode,
    'briefName': briefName,
    'fullName': fullName,
    'telPrefix': telPrefix,
    'timeDiff': timeDiff
  };
}

class CityModelList{
  List<CityModel> list;

  CityModelList(this.list);

  factory CityModelList.fromJson(List json){
    return CityModelList(
        json.map(
                (item)=>CityModel.fromJson((item))
        ).toList()
    );
  }
}