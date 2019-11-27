import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/address_model.dart';
import 'package:innetsect/data/commodity_skus_model.dart';
import 'package:innetsect/data/order/after_order_model.dart';
import 'package:innetsect/data/order/logistice_model.dart';
import 'package:innetsect/data/order/rmareasons_model.dart';
import 'package:innetsect/data/order/shipper_model.dart';
import 'package:innetsect/data/order_detail_model.dart';
import 'package:innetsect/model/order/after_service_repository.dart';
import 'package:rxdart/rxdart.dart';

/// 我的售后
class AfterServiceProvide extends BaseProvide{

  // list 数据
  List _list = new List();
  // 商品model
  OrderDetailModel _orderDetailModel;
  // 计数器数字
  int _count;
  // 申请原因
  List<RmareasonsModel> _rmareasonsModelList = List();
  // 选中的sku
  CommoditySkusModel _skusModel;
  // 售后详情
  AfterOrderModel _afterOrderModel;
  // 物流公司list
  List<ShipperModel> _shipperModelList=List();
  // 选中物流公司
  ShipperModel _shipperModel;
  // 物流信息
  List<LogisticeModel> _logisticeModelList = List();
  // 申请类型
  List<Map<String,dynamic>> _applyTypeList = [{"val":1,"title":"退货","isSelected": false},
    {"val":2,"title":"换货","isSelected": false}];
  List<Map<String,dynamic>> get applyTypeList=>_applyTypeList;

  List get list => _list;

  OrderDetailModel get orderDetailModel=>_orderDetailModel;

  List<RmareasonsModel> get rmareasonsModelList=> _rmareasonsModelList;

  CommoditySkusModel get skusModel => _skusModel;

  AfterOrderModel get afterOrderModel => _afterOrderModel;

  List<ShipperModel> get shipperModelList => _shipperModelList;
  ShipperModel get shipperModel => _shipperModel;

  List<LogisticeModel> get logisticeModelList => _logisticeModelList;

  set logisticeModelList(List<LogisticeModel> list){
    _logisticeModelList = list;
    notifyListeners();
  }

  set shipperModel(ShipperModel model){
    _shipperModel = model;
    notifyListeners();
  }

  set afterOrderModel(AfterOrderModel model){
    _afterOrderModel = null;
    _applyTypeList.forEach((item){
      if(item['val']==model.rmaType){
        item['isSelected']=true;
      }
    });
    _afterOrderModel = model;
    notifyListeners();
  }

  set skusModel(CommoditySkusModel model){
    _skusModel = model;
    notifyListeners();
  }

  // 选择申请类型
  void onSelectedApplyType(int index){
    _applyTypeList.forEach((val)=> val['isSelected']=false);
    _applyTypeList[index]['isSelected'] = true;
    notifyListeners();
  }
  // 重置申请类型
  void resetApplyType(){
    _applyTypeList.forEach((val)=> val['isSelected']=false);
    notifyListeners();
  }

  // 设置物流公司
  set shipperModelList(List<ShipperModel> list){
    list.forEach((item)=>item.isSelected=false);
    _shipperModelList = list;
    notifyListeners();
  }

  RmareasonsModel selectModel(){
    RmareasonsModel model = RmareasonsModel();
    if(_rmareasonsModelList!=null&&_rmareasonsModelList.length>0){
      _rmareasonsModelList.forEach((item){
        if(item.isSelected){
          model = item;
        }
      });
    }
    return model;
  }

  int get count =>_count;
  set count(int count){
    _count = count;
    notifyListeners();
  }

  //设置商品model
  set orderDetailModel(OrderDetailModel models){
    _orderDetailModel = models;
    notifyListeners();
  }

  //设置售后list
  void setList(List list){
    _list.addAll(list);
    notifyListeners();
  }

  // 清除售后列表
  void clearList(){
    _list.clear();
    notifyListeners();
  }
  // 清除申请原因
  void clearReasonList(){
    if(_rmareasonsModelList!=null&&_rmareasonsModelList.length>0){
      _rmareasonsModelList.clear();
    }
    notifyListeners();
  }

  // 减少
  void reduce(){
    if(_count<=1){
      return;
    }else{
      _count --;
    }
    notifyListeners();
  }

  // 添加
  void addCount(){
    if(_count == _orderDetailModel.quantity){
      return;
    }else{
      _count ++;
    }
    notifyListeners();
  }

  //设置申请原因list
  void addRmaeasonList(List<RmareasonsModel> list){
    list.forEach((item)=> item.isSelected=false);
    if(_rmareasonsModelList!=null&&_rmareasonsModelList.length>0){
      int index = _rmareasonsModelList.indexWhere((item)=>item.isSelected==true);
      if(index>-1){
        list[index].isSelected = true;
      }
    }
    _rmareasonsModelList = list;
    notifyListeners();
  }

  // 选择原因
  void onSelectedRmareason(int index){
    _rmareasonsModelList.forEach((item)=> item.isSelected=false);
    _rmareasonsModelList[index].isSelected = true;
    notifyListeners();
  }

  // 选择物流公司
  void onSelectedShipper(int index){
    _shipperModelList.forEach((item)=> item.isSelected=false);
    _shipperModelList[index].isSelected = true;
    _shipperModel = _shipperModelList[index];
    notifyListeners();
  }

  // 修改地址
  void editAddress(AddressModel addressModel){
    _orderDetailModel.addressModel = addressModel;
    _orderDetailModel.addressID = addressModel.addressID;
    _orderDetailModel.receipient = addressModel.name;
    _orderDetailModel.tel = addressModel.tel;
    _orderDetailModel.shipTo = addressModel.province+addressModel.city+addressModel.county+addressModel.addressDetail;
    notifyListeners();
  }

  // 移除售后的订单
  void removeOrder(AfterOrderModel model){
    int index = _list.indexWhere((item)=>item.rmaID==model.rmaID);
    _list.removeAt(index);
    notifyListeners();
  }


  /// ********请求*******///

  final AfterRepo _repo = AfterRepo();

  ///获取订单全部列表
  Observable listData({String method}){
    return _repo.listData(method).doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 申请原因列表
  Observable rmareasonsListData(){
    return _repo.rmareasonsListData().doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 提交售后
  /// *[rmaType] 提交类型
  /// *[reason] 原因描述
  Observable submitSalesRma(int rmaType,String reason){
    AfterOrderModel model = AfterOrderModel();
    model.rmaType = rmaType;
    model.reason = reason;
    model.rmaPics = "testPic";
    // 申请原因
    int index = _rmareasonsModelList.indexWhere((item)=>item.isSelected);
    model.reasonType=_rmareasonsModelList[index].reasonType;
    // 原订单ID
    model.orderID=_orderDetailModel.orderID;
    model.itemID=_orderDetailModel.itemID;
    // 申请数量
    model.quantity = _count;
    // 退货、换货地址
    model.exAddressID = _orderDetailModel.addressID;
    //收货人
    model.exReceipient=_orderDetailModel.receipient;
    //联系电话
    model.exTel=_orderDetailModel.tel;
    //发货至，国家+省+城市+区县+街道地址
    model.exShipTo=_orderDetailModel.shipTo;
    if(rmaType==2){
      // 换货产品id
      model.exProdID = _orderDetailModel.prodID;
      //换货SKU编码
      if(_skusModel!=null){
        model.exSkuCode = _skusModel.skuCode;
      }
    }

    print(model);

    return _repo.submitSalesRma(model.toJson()).doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 提交成功后更新list数据
  void updateOrderListModal(){
    int index = list.indexWhere((item)=>item.orderNo==_orderDetailModel.orderNo);
    OrderDetailModel model = list[index];
    model.rmaRequested = true;
    notifyListeners();
  }

  /// 取消售后
  Future cancelAfterOrder(int rmaID){
    return _repo.cancelAfterOrder(rmaID);
  }

  /// 售后详情
  Observable getAfterDetail(int rmaID){
    return _repo.getAfterDetail(rmaID).doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  ///提交物流
  ///*[rmaID]售后订单ID
  ///*[waybillNo]物流单号
  ///*[shipperCode]物流公司code
  ///*[reasonType]原因类型
  Observable submitLogistic({
    int rmaID,
    String waybillNo,
    String shipperCode,
    int reasonType
  }){
    if(reasonType!=5||reasonType!=6){
      shipperCode = _shipperModel.shipperCode;
    }
    return _repo.submitLogistic(
        rmaID: rmaID,waybillNo: waybillNo,
        shipperCode: shipperCode,reasonType: reasonType
    ).doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 物流公司请求
  Observable getShipperData(){
    return _repo.getShipperData().doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 退换货物流
  /// 根据退换货物流状态，<3显示退货物流，>=3显示换货物流
  ///  syncStatus<3传1， >=3传2;
  ///  *[phone]取 extel
  Observable getShipperDetail(){
    int syncStatus;
    if(_afterOrderModel.syncStatus<3){
      syncStatus = 1;
    }else{
      syncStatus = 2;
    }
    return _repo.getShipperDetail(
        rmaID: _afterOrderModel.rmaID,syncStatus: syncStatus,
        shipperCode: _afterOrderModel.shipperCode,waybillNo: _afterOrderModel.waybillNo,
        phone: _afterOrderModel.exTel
    ).doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});;
  }

  ///工厂模式
  factory AfterServiceProvide() => _getInstance();
  static AfterServiceProvide get instance => _getInstance();
  static AfterServiceProvide _instance;
  static AfterServiceProvide _getInstance() {
    if (_instance == null) {
      _instance = new AfterServiceProvide._internal();
    }
    return _instance;
  }
  AfterServiceProvide._internal() {
    print('AfterServiceProvide init');
    // 初始化
  }
}