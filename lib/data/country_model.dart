/// 国家
class CountryModel{
  int localeCode;
  String countryCode;
  String briefName;
  String fullName;
  String telPrefix;
  String timeDiff;

  CountryModel({
    this.briefName,
    this.countryCode,
    this.fullName,
    this.localeCode,
    this.telPrefix,
    this.timeDiff
  });

  factory CountryModel.fromJson(Map<String,dynamic> json){
    return CountryModel(
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

class CountryModelList{
  List<CountryModel> list;

  CountryModelList(this.list);

  factory CountryModelList.fromJson(List json){
    return CountryModelList(
        json.map(
                (item)=>CountryModel.fromJson((item))
        ).toList()
    );
  }
}