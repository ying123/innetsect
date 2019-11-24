import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/address_model.dart';
import 'package:innetsect/model/address_repository.dart';
import 'package:rxdart/rxdart.dart';

class AddressManagementProvide extends BaseProvide{

  AddressModel _addressModel;
  AddressModel get addressModel=>_addressModel;

  set addressModel(AddressModel model){
    _addressModel= model;
    notifyListeners();
  }

  List<AddressModel> _listAddressModel=[];

  List<AddressModel> get listAddressModel => _listAddressModel;

  void addListAddress(List<AddressModel> list){
    _listAddressModel.clear();
    _listAddressModel.addAll(list);
    notifyListeners();
  }


  void clearList(){
    _listAddressModel.clear();
    notifyListeners();
  }

  void setIsDefault(AddressModel model){
    _listAddressModel.forEach((item){
      item.lastUsed = false;
      if(item.addressID==model.addressID){
        item.lastUsed = true;
      }
    });
    notifyListeners();
  }

  /// 新建地址添加到list中
  void addAddresses(AddressModel model){
    if(model.lastUsed){
      _listAddressModel.forEach((item)=>item.lastUsed = false);
    }
    _listAddressModel.add(model);
    notifyListeners();
  }

  final AddressRepo _repo = AddressRepo();

  ///地址管理列表数据
  Observable listData() {
    return _repo
        .listData()
        .doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  ///地址管理修改数据
  Observable editDatas(AddressModel model) {
    return _repo
        .editData(model)
        .doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }
  ///删除地址
  Future delDatas(AddressModel model) {
   return  _repo
       .deleteAddresses(model.addressID);
  }

  ///设置默认地址
  Future onDefaultAddresses(AddressModel model){
    return _repo.onDefaultAddresses(model.addressID);
  }
  /// 设置地址运费
  Observable onAddressFreight(int addrID){
    return  _repo.onAddressFreight(addrID).doOnData((result) {
    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }


  ///工厂模式
  factory AddressManagementProvide()=> _getInstance();
  static AddressManagementProvide get instance => _getInstance();
  static AddressManagementProvide _instance;
  static AddressManagementProvide _getInstance(){
    if (_instance == null) {
      _instance = new AddressManagementProvide._internal();
    }
    return _instance;
  }

  AddressManagementProvide._internal() {
    print('AddressManagementProvide初始化');
    // 初始化
  }

}