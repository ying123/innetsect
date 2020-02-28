

import 'package:innetsect/base/base.dart';

class AllCoupnsProvide extends BaseProvide{

  bool _expansionChanged;
  bool get expansionChanged => _expansionChanged;
  set expansionChanged(bool expansionChanged){
    _expansionChanged = expansionChanged;
    notifyListeners();
  }
  
}