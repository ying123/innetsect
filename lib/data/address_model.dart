// 地址model
class AddressModel{
  int addressID;
  int acctID;
  String name;
  String telPrefix;
  String tel;
  String countryCode;
  String province;
  String city;
  String county;
  String areaCode;
  String addressDetail;
  String postalCode;
  String email;
  bool lastUsed;

  AddressModel({
    this.addressID,
    this.acctID,
    this.name,
    this.telPrefix,
    this.tel,
    this.countryCode,
    this.province,
    this.city,
    this.county,
    this.areaCode,
    this.addressDetail,
    this.postalCode,
    this.email,
    this.lastUsed,
  }){
    lastUsed = false;
  }

  factory AddressModel.fromJson(Map<String,dynamic> json){
    return AddressModel(
        addressID: json['addressID'],
        acctID: json['acctID'],
        name: json['name'],
        telPrefix: json['telPrefix'],
        tel: json['tel'],
        countryCode: json['countryCode'],
        province: json['province'],
        city: json['city'],
        county: json['county'],
        areaCode: json['areaCode'],
        addressDetail: json['addressDetail'],
        postalCode: json['postalCode'],
        email: json['email'],
        lastUsed: json['lastUsed']
    );
  }


  Map<String, dynamic> toJson()=>{
    'addressID': addressID,
    'acctID': acctID,
    'name': name,
    'telPrefix': telPrefix,
    'tel': tel,
    'countryCode': countryCode,
    'province': province,
    'city': city,
    'county': county,
    'areaCode': areaCode,
    'addressDetail': addressDetail,
    'postalCode': postalCode,
    'email': email,
    'lastUsed': lastUsed
  };
}

class AddressModelList{
  List<AddressModel> list;

  AddressModelList(this.list);

  factory AddressModelList.fromJson(List json){
    return AddressModelList(
        json.map(
                (item)=>AddressModel.fromJson((item))
        ).toList()
    );
  }
}