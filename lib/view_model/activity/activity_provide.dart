import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';




//活动页面数据供应
class ActivityProvide extends BaseProvide{
  // List<Item> _items = [];
  // get items{
  //   if (_items == null) {
  //     _items = new List<Item>();
  //   }
  //   return _items;
  // }

  // set items(Item item){
  //   print('set item$item');
  //   _items.add(item);
  //   notifyListeners();
  // }

  Color isBgColors ;

 int _currentIndex = 0 ; 
 int get  currentIndex{
   return _currentIndex;
 }

 set currentIndex(int index){
   _currentIndex = index;
   notifyListeners();
 }

 List activityListdata = [
   {
   'time':"18:00",
   'endtime':'02:00结束',
   'serialNumber':"C-03",
   'image':"assets/images/def_head_big.png",
   'title':'潮流展会抢购',
   'subTitle':"Wasted Youth Art Experience Pop Up person",
   },
   {
   'time':"18:00",
   'endtime':'02:00结束',
   'serialNumber':"C-03",
   'image':"assets/images/def_head_big.png",
   'title':'潮流展会抢购',
   'subTitle':"Wasted Youth Art Experience Pop Up person",
   },
   {
   'time':"18:00",
   'endtime':'02:00结束',
   'serialNumber':"C-03",
   'image':"assets/images/def_head_big.png",
   'title':'潮流展会抢购',
   'subTitle':"Wasted Youth Art Experience Pop Up person",
   },
   {
   'time':"18:00",
   'endtime':'02:00结束',
   'serialNumber':"C-03",
   'image':"assets/images/def_head_big.png",
   'title':'潮流展会抢购',
   'subTitle':"Wasted Youth Art Experience Pop Up person",
   },
   {
   'time':"18:00",
   'endtime':'02:00结束',
   'serialNumber':"C-03",
   'image':"assets/images/def_head_big.png",
   'title':'潮流展会抢购',
   'subTitle':"Wasted Youth Art Experience Pop Up person",
   },
 ];


}