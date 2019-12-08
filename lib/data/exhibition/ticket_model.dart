

///展会门票
class  TicketModel {
  int ticketTypeID;
  int exhibitionID;
  int exProjID;
  int exSessionID;
  int prodID;
  String prodCode;
  String prodPic;
  String prodName;
  int prodIdx;
  String showStart;
  String sellingStart;
  String sellingEnd;
  double sellingPrice;
  int quantity;
  int orderedQuantity;
  String validTimeDesc;
  String remark;
  int shopID;
  String salesPriceRange;
  int orderableQuantity;
  /// 我的订单扩展
  int ticketID;
  String ticketNo;
  String ticketName;

  TicketModel({
    this.ticketTypeID,
    this.exhibitionID,
    this.exProjID,
    this.exSessionID,
    this.prodID,
    this.prodCode,
    this.prodPic,
    this.prodName,
    this.prodIdx,
    this.showStart,
    this.sellingStart,
    this.sellingEnd,
    this.sellingPrice,
    this.quantity,
    this.orderedQuantity,
    this.validTimeDesc,
    this.remark,
    this.shopID,
    this.salesPriceRange,
    this.orderableQuantity,
    this.ticketID,
    this.ticketName,
    this.ticketNo
  });

  factory TicketModel.fromJson(Map<String, dynamic> json){
    return TicketModel(
      ticketTypeID:json['ticketTypeID'],
      exhibitionID:json['exhibitionID'],
      exProjID: json['exProjID'],
      exSessionID: json['exSessionID'],
      prodID: json['prodID'],
      prodCode: json['prodCode'],
      prodPic: json['prodPic'],
      prodName: json['prodName'],
      prodIdx: json['prodIdx'],
      showStart: json['showStart'],
      sellingStart: json['sellingStart'],
      sellingEnd: json['sellingEnd'],
      sellingPrice: json['sellingPrice'],
      quantity: json['quantity'],
      orderedQuantity: json['orderedQuantity'],
      validTimeDesc: json['validTimeDesc'],
      remark: json['remark'],
      shopID: json['shopID'],
      salesPriceRange: json['salesPriceRange'],
      orderableQuantity: json['orderableQuantity'],
      ticketID: json['ticketID'],
      ticketName: json['ticketName'],
      ticketNo: json['ticketNo']
    );
  }

  Map<String, dynamic> toJson() => {
    'ticketTypeID':ticketTypeID,
    'exhibitionID':exhibitionID,
    'exProjID':exProjID,
    'exSessionID':exSessionID,
    'prodID':prodID,
    'prodCode':prodCode,
    'prodPic':prodPic,
    'prodName':prodName,
    'prodIdx':prodIdx,
    'showStart':showStart,
    'sellingStart':sellingStart,
    'sellingEnd':sellingEnd,
    'sellingPrice':sellingPrice,
    'quantity':quantity,
    'orderedQuantity':orderedQuantity,
    'validTimeDesc':validTimeDesc,
    'remark':remark,
    'shopID':shopID,
    'salesPriceRange':salesPriceRange,
    'orderableQuantity':orderableQuantity,
    'ticketID': ticketID,
    'ticketName': ticketName,
    'ticketNo': ticketNo
  };
}

class  TicketModelList {
  List<TicketModel> list;

  TicketModelList(this.list);

  factory TicketModelList.fromJson(List json){
    return TicketModelList(
      json.map((item)=>TicketModel.fromJson((item))).toList()
    );
  }
}