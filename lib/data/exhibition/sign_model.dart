class SignModel{
  ///  "redirectParam":963197,
  ///  "redirectTo":"/my/profile",
  ///  "redirectType":"EXHIBITION_SIGNED_IN"
  bool success;
  String welcomeTitle;
  String welcomeText;

  SignModel({
    this.success,
    this.welcomeText,
    this.welcomeTitle
  });

  factory SignModel.fromJson(Map<String,dynamic> json){
    return SignModel(
      success: json['success'],
      welcomeText: json['welcomeText'],
      welcomeTitle: json['welcomeTitle']
    );
  }
}