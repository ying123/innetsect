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
    switch(index){
      case 0:
        str = "待支付";
        break;
    }
    return str;
  }
}