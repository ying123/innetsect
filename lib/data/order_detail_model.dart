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
  double totalCost;
  // 数量
  int totalCount;
  // 合计
  double totalAmount;
  // 运费
  double freight;
  // 优惠
  int totalDiscount;
  // 预售定金
  int totalDeposit;
  // 允许使用积分数量
  double allowPoint;
  // 积分支付
  int payPoint;
  // 卡券抵用
  int payCoupon;
  // 实际支付,未支付
  double payableAmount;
  // 实际支付,已支付
  int payAmount;
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

  // sku
  List<CommodityModels> skuModels;

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
    this.skuModels
  });

  factory OrderDetailModel.formJson(Map<String,dynamic> json) {
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
        skuModels: json['items']!=null?CommodityList.fromJson(json['items']).list:null
    );
  }

}