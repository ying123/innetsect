class UserInfoModel{

  // id
  int acctID;
  // 头像
  String portrait;
  int acctType;
  // 昵称
  String nickName;
  String telPrefix;
  // 手机号
  String mobile;
  // email
  String email;
  String acctCode;
  int rank;
  String channel;
  int referralAcctID;
  int parentAcctID;
  int level;
  int credit;
  String registerDate;
  int status;
  String accountRank;

  UserInfoModel({
    this.acctID,
    this.portrait,
    this.acctType,
    this.nickName,
    this.telPrefix,
    this.mobile,
    this.email,
    this.acctCode,
    this.rank,
    this.channel,
    this.referralAcctID,
    this.parentAcctID,
    this.level,
    this.credit,
    this.registerDate,
    this.status,
    this.accountRank
  });

  factory UserInfoModel.fromJson(Map<String,dynamic> json){
    return UserInfoModel(
      acctID: json['acctID'],
      portrait: json['portrait'],
      acctType: json['acctType'],
      nickName: json['nickName'],
      telPrefix: json['telPrefix'],
      mobile: json['mobile'],
      email: json['email'],
      acctCode: json['acctCode'],
      rank: json['rank'],
      channel: json['channel'],
      referralAcctID: json['referralAcctID'],
      parentAcctID: json['parentAcctID'],
      level: json['level'],
      credit: json['credit'],
      registerDate: json['registerDate'],
      status: json['status'],
      accountRank: json['accountRank']
    );
  }

  Map<String, dynamic> toJson()=> {
    'acctID': acctID,
    'portrait': portrait,
    'acctType': acctType,
    'nickName': nickName,
    'telPrefix': telPrefix,
    'mobile': mobile,
    'email': email,
    'acctCode': acctCode,
    'rank': rank,
    'channel': channel,
    'referralAcctID': referralAcctID,
    'parentAcctID': parentAcctID,
    'level': level,
    'credit': credit,
    'registerDate': registerDate,
    'status': status,
    'accountRank': accountRank
  };
}