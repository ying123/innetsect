import 'package:innetsect/data/address_model.dart';
import 'package:innetsect/data/commodity_models.dart';

class OrderDetailModel{
  // 收货地址
  AddressModel addressModel;
  // 订单id
  int orderID;
  // 订单日期
  String orderDate;
  // 订单类型：0普通，1预售
  int orderType;
  // 订单编号
  String orderNo;
  // 快递编码
  String shipperCode;
  // 物流单号
  String waybillNo;
  // 账户id
  int acctID;
  // 账户名称
  String acctName;
  // 订单概要
  String orderSummary;
  // 渠道
  String channel;
  // 商店id
  int shopID;
  // 商品类型
  int prodType;
  // 0，代发 1：自提
  int ladingMode;
  // 提货时间
  String ladingTime;
  // 发货地址ID
  int addressID;
  // 收货人
  String receipient;
  // 联系电话
  String tel;
  // 发货地址
  String shipTo;
  // 区域编码
  String areaCode;
  // 成本
  dynamic totalCost;
  // 数量
  int totalCount;
  // 合计
  dynamic totalAmount;
  // 运费
  dynamic freight;
  // 优惠
  dynamic totalDiscount;
  // 预售定金
  dynamic totalDeposit;
  // 允许使用积分数量
  dynamic allowPoint;
  // 积分支付
  dynamic payPoint;
  // 卡券抵用
  dynamic payCoupon;
  // 实际支付,未支付
  dynamic payableAmount;
  // 实际支付,已支付
  dynamic payAmount;
  // 发票类型，0：不需要，1：个人普票，2：专票
  int invoiceType;
  // 支付方式, 0：现金，1：微信，2：支付宝，3：visa
  int payMode;
  // 支付时间
  String payDate;
  // 备注
  String remark;
  // 发货状态，按3来判断是否发货
  int syncStatus;
  // 配送方式
  String shipperName;
  // 订单状态
  int status;

  // sku
  List<CommodityModels> skuModels;

  /// 售后扩展
  String skuPic;
  String skuName;
  String skuCode;
  // 退换策略,0：此商品不支持退换货,>0申请售后
  int rmaPolicy;
  // 是否申请售后，1已申请 0未申请
  bool rmaRequested;
  // 是否在可退换时间内，0：不可申请，1：可申请
  bool rmaInPeriod;
  // 数量
  int quantity;
  // 价格
  double salesPrice;
  // 商品id
  int prodID;
  // 原订单号
  int itemID;


  OrderDetailModel({
    this.addressModel,
    this.areaCode,
    this.tel,
    this.acctID,
    this.addressID,
    this.channel,
    this.shopID,
    this.acctName,
    this.allowPoint,
    this.freight,
    this.invoiceType,
    this.ladingMode,
    this.orderDate,
    this.orderID,
    this.orderNo,
    this.orderSummary,
    this.orderType,
    this.payableAmount,
    this.payAmount,
    this.payCoupon,
    this.payDate,
    this.payMode,
    this.payPoint,
    this.prodType,
    this.receipient,
    this.remark,
    this.shipTo,
    this.syncStatus,
    this.totalAmount,
    this.totalCost,
    this.totalCount,
    this.totalDeposit,
    this.totalDiscount,
    this.skuModels,
    this.status,
    this.shipperName,
    this.shipperCode,
    this.waybillNo,
    this.skuPic,
    this.skuName,
    this.rmaPolicy,
    this.rmaRequested,
    this.rmaInPeriod,
    this.quantity,
    this.salesPrice,
    this.prodID,
    this.itemID,
    this.skuCode,
    this.ladingTime
  });

  factory OrderDetailModel.fromJson(Map<String,dynamic> json) {
    return OrderDetailModel(
        addressModel: json['address']!=null?AddressModel.fromJson(json['address']):null ,
        areaCode: json['areaCode'],
        tel: json['tel'],
        acctID: json['acctID'],
        addressID: json['addressID'],
        channel: json['channel'],
        shopID: json['shopID'],
        acctName: json['acctName'],
        allowPoint: json['allowPoint'],
        freight: json['freight'],
        invoiceType: json['invoiceType'],
        ladingMode: json['ladingMode'],
        orderDate: json['orderDate'],
        orderID: json['orderID'],
        orderNo: json['orderNo'],
        orderSummary: json['orderSummary'],
        orderType: json['orderType'],
        payableAmount: json['payableAmount'],
        payAmount: json['payAmount'],
        payCoupon: json['payCoupon'],
        payDate: json['payDate'],
        payMode: json['payMode'],
        payPoint: json['payPoint'],
        prodType: json['prodType'],
        receipient: json['receipient'],
        remark: json['remark'],
        shipTo: json['shipTo'],
        syncStatus: json['syncStatus'],
        totalAmount: json['totalAmount'],
        totalCost: json['totalCost'],
        totalCount: json['totalCount'],
        totalDeposit: json['totalDeposit'],
        totalDiscount: json['totalDiscount'],
        skuModels: json['items']!=null?CommodityList.fromJson(json['items']).list:null,
        status: json['status'],
        shipperName: json['shipperName'],
        shipperCode: json['shipperCode'],
        waybillNo: json['waybillNo'],
        skuPic: json['skuPic'],
        skuName: json['skuName'],
        rmaPolicy: json['rmaPolicy'],
        rmaRequested: json['rmaRequested'],
        rmaInPeriod: json['rmaInPeriod'],
        quantity: json['quantity'],
        salesPrice: json['salesPrice'],
        prodID: json['prodID'],
        itemID: json['itemID'],
        skuCode: json['skuCode'],
        ladingTime: json['ladingTime']
    );
  }

}

class OrderDetailModelList{
  List<OrderDetailModel> list;

  OrderDetailModelList(this.list);

  factory OrderDetailModelList.fromJson(List json){
    return OrderDetailModelList(
        json.map(
                (item)=>OrderDetailModel.fromJson((item))
        ).toList()
    );
  }
}