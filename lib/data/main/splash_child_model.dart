class SplashChildModel{
  int shopID;
  int splashID;
  // 广告展示页
  String splashFile;
  int playerType;
  int playSeconds;
  // 是否能跳转
  int status;
  // 跳转类型
  String redirectType;
  // 跳转页
  String redirectTo;
  // 跳转参数
  String redirectParam;

  SplashChildModel({
    this.shopID,
    this.status,
    this.redirectParam,
    this.redirectType,
    this.redirectTo,
    this.playerType,
    this.playSeconds,
    this.splashFile,
    this.splashID
  });

  factory SplashChildModel.fromJson(Map<String,dynamic> json){
    return SplashChildModel(
      shopID: json['shopID'],
      status: json['status'],
      redirectType: json['redirectType'],
        redirectTo: json['redirectTo'],
        redirectParam: json['redirectParam'],
        playerType: json['playerType'],
        playSeconds: json['playSeconds'],
        splashFile: json['splashFile'],
        splashID: json['splashID']
    );
  }
}

class SplashChildModelList{
  List<SplashChildModel> list;
  SplashChildModelList(this.list);

  factory SplashChildModelList.fromJson(List json){
    return SplashChildModelList(
      json.map((item)=>SplashChildModel.fromJson(item)).toList()
    );
  }
}