
import 'package:innetsect/api/net_utils.dart';
import 'package:rxdart/rxdart.dart';

class QrcodeService {
 Observable qrcode (){
    var url = '/api/accounts/myqrcode';
    var response = get(url);
    return response;
  }
  }

  ///展会签到绑定二维数据
class QrcodeRepo {
  final QrcodeService _remote = QrcodeService();
  Observable qrcode (){
    return _remote.qrcode();
  }

  }