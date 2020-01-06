
import 'package:innetsect/api/net_utils.dart';

///注销账户

class AccountCancellationService{
Future accountCancellation( ){
    var url = '/api/accounts/deleteAccount?vcode=1';
    return delete(url);
  }
}

class AccountCancellationRepo {

  final AccountCancellationService _remote = AccountCancellationService();
  Future accountCancellation(){
    return _remote.accountCancellation();
  }
}