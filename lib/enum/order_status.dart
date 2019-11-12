///订单状态 0待支付 1待收货 2已完成 -1已取消
enum OrderStatus{
  zero,
  one,
  two,
  minusOne
}

class OrderStatusEnum{

  String getStatusTitle(int index){
    String str="";
    //0待支付 1待收货 2已完成 -1已取消 -2已取消待退款 -4已取消已退款
    switch(index){
      case 0:
        str = "待支付";
        break;
      case 1:
        str = "待收货";
        break;
      case 2:
        str = "已完成";
        break;
      case -1:
        str = "已取消";
        break;
      case -2:
        str = "已取消待退款";
        break;
      case -4:
        str = "已取消已退款";
        break;
    }
    return str;
  }
}