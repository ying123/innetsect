import 'package:innetsect/base/base.dart';
import 'package:innetsect/model/personal_center/account_cancellation.dart';

///注销

class AccountCancellationProvide extends BaseProvide {
  

  AccountCancellationRepo _repo = AccountCancellationRepo();
   ///账户注销
  Future accountCancellation( ) {
   return  _repo.accountCancellation();
       
  }
}