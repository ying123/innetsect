import 'package:innetsect/data/main/splash_child_model.dart';

class SplashModel{
  int shopID;
  int exhibitionID;
  List<SplashChildModel> splashes;
  bool attended;

  SplashModel({
    this.shopID,
    this.attended,
    this.exhibitionID,
    this.splashes
  });

  factory SplashModel.fromJson(Map<String,dynamic> json){
    return SplashModel(
      shopID: json['shopID'],
      attended: json['attended'],
      exhibitionID: json['exhibitionID'],
      splashes: json['splashes']!=null?SplashChildModelList.fromJson(json['splashes']).list:null
    );
  }
}