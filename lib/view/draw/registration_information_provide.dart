import 'package:innetsect/base/base.dart';

///登记信息
class RegistrationInformationProvide extends BaseProvide {
  bool _groupValuea = true;
  bool get groupValuea => _groupValuea;
  set groupValuea(bool obj) {
    _groupValuea = obj;
    notifyListeners();
  }

  int _registrationStatus = 0;
  int get registrationStatus => _registrationStatus;
  set registrationStatus(int registrationStatus) {
    _registrationStatus = registrationStatus;
    notifyListeners();
  }
}
