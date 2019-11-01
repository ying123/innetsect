import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/address_model.dart';
import 'package:innetsect/model/address_repository.dart';
import 'package:rxdart/rxdart.dart';

class AddressManagementProvide extends BaseProvide{

  List<AddressModel> _listAddressModel=[];

  List<AddressModel> get listAddressModel => _listAddressModel;

  void addListAddress(List<AddressModel> list){
    _listAddressModel..addAll(list);
    notifyListeners();
  }


  void clearList(){
    _listAddressModel.clear();
    notifyListeners();
  }

  void setIsDefault(AddressModel model){
    _listAddressModel.forEach((item){
      if(item.addressID==model.addressID){
        item.isDefault = model.isDefault;
      }else{
        item.isDefault = !model.isDefault;
      }
    });
    notifyListeners();
  }

  final AddressRepo _repo = AddressRepo();

  ///地址管理列表数据
  Observable listData(int pageNo) {
    return _repo
        .listData(pageNo)
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

}