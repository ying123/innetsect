/// 售后model
class AfterOrderModel{
  // 售后单号ID
  int rmaID;
  //售后单号
  String rmaNo;
  //售后类型
  int rmaType;
  //原因描述
  String reason;
  //图片
  String rmaPics;
  //换货产品ID
  int exProdID;
  //换货SKU编码
  String exSkuCode;
  // 原订单ID
  int orderID;
  // 原订单编号
  String orderNo;
  // 原订单号
  int itemID;
  //申请数量
  int quantity;
  //换货收货地址ID
  int exAddressID;
  //申请原因
  int reasonType;
  // 申请原因（售后详情返回）
  String reasonName;
  //收货人
  String exReceipient;
  //联系电话
  String exTel;
  //发货至，国家+省+城市+区县+街道地址
  String exShipTo;
  // 金额
  dynamic salesPrice;
  // 订单创建日期
  String requestDate;
  // 应退补商品金额
  dynamic refundableAmount;
  // 应退积分
  dynamic refundablePoint;
  // 退款单号
  String refundNo;
  // 退款时间
  String refundDate;
  // 退款金额
  dynamic refundAmount;
  // skucode
  String skuCode;
  String skuName;
  String skuPic;
  // 售后状态
  int status;
  // 退换货物流状态，<3显示退货物流，>=3显示换货物流
  int syncStatus;
  // 物流单号
  String waybillNo;
  // 物流公司code
  String shipperCode;

  AfterOrderModel({
    this.exAddressID,
    this.exProdID,
    this.exReceipient,
    this.exShipTo,
    this.exSkuCode,
    this.exTel,
    this.itemID,
    this.orderID,
    this.quantity,
    this.reason,
    this.reasonType,
    this.rmaPics,
    this.rmaType,
    this.rmaNo,
    this.salesPrice,
    this.requestDate,
    this.refundableAmount,
    this.refundablePoint,
    this.refundAmount,
    this.refundDate,
    this.refundNo,
    this.skuCode,
    this.skuName,
    this.skuPic,
    this.status,
    this.rmaID,
    this.reasonName,
    this.orderNo,
    this.syncStatus,
    this.waybillNo,
    this.shipperCode
  });

  factory AfterOrderModel.fromJson(Map<String,dynamic> json){
    return AfterOrderModel(
      exAddressID: json['exAddressID'],
          exProdID: json['exProdID'],
      exReceipient: json['exReceipient'],
      exShipTo: json['exShipTo'],
      exSkuCode: json['exSkuCode'],
      exTel: json['exTel'],
      itemID: json['itemID'],
      orderID: json['orderID'],
      quantity: json['quantity'],
      reason: json['reason'],
      reasonType: json['reasonType'],
      rmaPics: json['rmaPics'],
      rmaType: json['rmaType'],
        rmaNo: json['rmaNo'],
        salesPrice: json['salesPrice'],
        requestDate: json['requestDate'],
        refundableAmount: json['refundableAmount'],
        refundablePoint: json['refundablePoint'],
        refundAmount: json['refundAmount'],
        refundDate: json['refundDate'],
        refundNo: json['refundNo'],
        skuCode: json['skuCode'],
        skuName: json['skuName'],
        skuPic: json['skuPic'],
        status: json['status'],
        rmaID: json['rmaID'],
        reasonName: json['reasonName'],
        orderNo: json['orderNo'],
        syncStatus: json['syncStatus'],
        waybillNo: json['waybillNo'],
        shipperCode: json['shipperCode']
    );
  }

  Map<String,dynamic> toJson()=>{
    'exAddressID': exAddressID,
    'exProdID': exProdID,
    'exReceipient': exReceipient,
    'exShipTo': exShipTo,
    'exSkuCode': exSkuCode,
    'exTel': exTel,
    'itemID': itemID,
    'orderID': orderID,
    'quantity': quantity,
    'reason': reason,
    'reasonType': reasonType,
    'rmaPics': rmaPics,
    'rmaType': rmaType,
    'rmaNo': rmaNo,
    'salesPrice':salesPrice,
    'requestDate':requestDate,
    'refundableAmount': refundableAmount,
    'refundablePoint': refundablePoint,
    'refundAmount':refundAmount,
    'refundDate':refundDate,
    'refundNo': refundNo,
    'skuCode': skuCode,
    'skuName': skuName,
    'skuPic': skuPic,
    'status': status,
    'rmaID': rmaID,
    'reasonName': reasonName,
    'orderNo': orderNo,
    'syncStatus': syncStatus,
    'waybillNo': waybillNo,
    'shipperCode': shipperCode
  };
}

class AfterOrderModelList{
  List<AfterOrderModel> list;

  AfterOrderModelList(this.list);

  factory AfterOrderModelList.fromJson(List json){
    return AfterOrderModelList(
        json.map(
                (item)=>AfterOrderModel.fromJson((item))
        ).toList()
    );
  }
}