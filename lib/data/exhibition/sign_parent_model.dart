import 'package:innetsect/data/exhibition/sign_model.dart';

class SignParentModel{
  SignModel data;
  int redirectParam;
  String redirectTo;
  String redirectType;
  SignParentModel({
    this.redirectTo,
    this.redirectType,
    this.redirectParam,
    this.data
  });

  factory SignParentModel.fromJson(Map<String,dynamic> json){
    return SignParentModel(
      data: SignModel.fromJson(json['data']),
      redirectType: json['redirectType'],
      redirectTo: json['redirectTo'],
      redirectParam: json['redirectParam']
    );
  }
}