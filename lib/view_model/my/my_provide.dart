import 'package:innetsect/base/base.dart';
///我的页面数据状态供应
class MyProvide extends BaseProvide{

  String myOrder = '我的订单';
  String showTickets = '展会';
  String addressManagement = '地址管理';
  String customerService = '客服';
  String afterSales = '售后';
  String shoppingCart = '购物车';
  String shoppingKnow = '购物需知';
  String carJ = '卡券';

  //List listModle =['我的订单','购物车','地址管理','展会','卡券','售后','购物需知','客服'];

///手机号码
  String _mobilePhoneNumber = '未登入';
  get mobilePhoneNumber{
    return _mobilePhoneNumber;
  }
  set mobilePhoneNumber(String mobilePhoneNumber){
    _mobilePhoneNumber = mobilePhoneNumber;
    notifyListeners();
  }

///用户头像
  String _headPortrait = 'assets/images/mall/hot_brand1.png';
  get headPortrait{
    return _headPortrait;
  }
  set headPortrait(String headPortrait){
    _headPortrait = headPortrait;
    notifyListeners();
  }

}