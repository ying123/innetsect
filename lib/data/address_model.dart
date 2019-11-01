class AddressModel{
  int addressID;
  String acctID;
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
  bool isDefault;

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
    this.isDefault
  });

  factory AddressModel.formJson(Map<String,dynamic> json){
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
        lastUsed: json['lastUsed'],
        isDefault: json['isDefault']
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
    'lastUsed': lastUsed,
    'isDefault': isDefault
  };
}