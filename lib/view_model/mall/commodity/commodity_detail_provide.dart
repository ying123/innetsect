
import 'package:innetsect/base/base.dart';

class CommodityDetailProvide extends BaseProvide {
  int _id;

  set setId(int id){
    _id = id;
    notifyListeners();
  }

  get id => _id;
}