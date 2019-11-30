/// 贵宾卡
class VIPCardModle{
  int cardID;
  String cardPic;
  String cardNo;
  String cardName;
  double discountRate;
  int cardSetID;
  int shopID;
  String takenTime;
  String expiryTime;
  String remark;
  String qrCode;
  bool expired;

  VIPCardModle({
    this.shopID,
    this.remark,
    this.cardID,
    this.cardName,
    this.cardNo,
    this.cardPic,
    this.cardSetID,
    this.discountRate,
    this.expired,
    this.expiryTime,
    this.qrCode,
    this.takenTime
  });

  factory VIPCardModle.fromJson(Map<String,dynamic> json){
    return VIPCardModle(
      shopID: json['shopID'],
      remark: json['remark'],
      cardID: json['cardID'],
      cardName: json['cardName'],
      cardNo: json['cardNo'],
      cardPic: json['cardPic'],
      cardSetID: json['cardSetID'],
      discountRate: json['discountRate'],
      expired: json['expired'],
      expiryTime: json['expiryTime'],
      qrCode: json['qrCode'],
      takenTime: json['takenTime']
    );
  }

}

class VIPCardModleList{
  List<VIPCardModle> list;

  VIPCardModleList(this.list);

  factory VIPCardModleList.fromJson(List json){
    return VIPCardModleList(
        json.map(
                (item)=>VIPCardModle.fromJson((item))
        ).toList()
    );
  }
}