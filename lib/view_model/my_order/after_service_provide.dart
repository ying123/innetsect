import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/address_model.dart';
import 'package:innetsect/data/commodity_skus_model.dart';
import 'package:innetsect/data/order/after_order_model.dart';
import 'package:innetsect/data/order/rmareasons_model.dart';
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
  //选中的sku
  CommoditySkusModel _skusModel;

  List get list => _list;

  OrderDetailModel get orderDetailModel=>_orderDetailModel;

  List<RmareasonsModel> get rmareasonsModelList=> _rmareasonsModelList;

  CommoditySkusModel get skusModel => _skusModel;

  set skusModel(CommoditySkusModel model){
    _skusModel = model;
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

  // 修改地址
  void editAddress(AddressModel addressModel){
    _orderDetailModel.addressModel = addressModel;
    _orderDetailModel.addressID = addressModel.addressID;
    _orderDetailModel.receipient = addressModel.name;
    _orderDetailModel.tel = addressModel.tel;
    _orderDetailModel.shipTo = addressModel.province+addressModel.city+addressModel.county+addressModel.addressDetail;
    notifyListeners();
  }

  // 移除取消售后的订单
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
    // 申请原因
    int index = _rmareasonsModelList.indexWhere((item)=>item.isSelected);
    model.reasonType=_rmareasonsModelList[index].reasonType;
    // 原订单ID
    model.orderID=_orderDetailModel.orderID;
    model.itemID=_orderDetailModel.itemID;
    // 申请数量
    model.quantity = _count;
    if(rmaType==2){
      // 换货产品id
      model.exProdID = _orderDetailModel.prodID;
      //换货SKU编码
      if(_skusModel!=null){
        model.exSkuCode = _skusModel.skuCode;
      }
      // 换货地址
      model.exAddressID = _orderDetailModel.addressID;
      //收货人
      model.exReceipient=_orderDetailModel.receipient;
      //联系电话
      model.exTel=_orderDetailModel.tel;
      //发货至，国家+省+城市+区县+街道地址
      model.exShipTo=_orderDetailModel.shipTo;
    }

    return _repo.submitSalesRma(model.toJson()).doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 取消售后
  Future cancelAfterOrder(int rmaID){
    return _repo.cancelAfterOrder(rmaID);
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