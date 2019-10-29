import 'package:innetsect/base/base.dart';

import 'package:flutter/material.dart';
import 'package:innetsect/model/a_venues_repository.dart';
import 'package:innetsect/model/brand_model.dart';
import 'package:rxdart/rxdart.dart';


class  AVenuedProvide extends BaseProvide{

///索引栏背景颜色
  Color _indexBarBgColor = Colors.transparent;
  get indexBarBgColor{
    return _indexBarBgColor;
  }

  set indexBarBgColor(Color color){
      _indexBarBgColor = color;
      notifyListeners();
  }

  ///当前字母
  String _currntLetter = '';
  get currntLetter{
    return _currntLetter;
  }
  set currntLetter(String str){
    _currntLetter = str;
    notifyListeners();
  }
  
  ///联系人页面数据
   List<Brand> _contacts = [
   
  ];
  get contacts{
    return _contacts;
  }
  set contacts(Brand brands){
    _contacts.add(brands);
  }
///品牌列表
 List<Brand> brands = [];
//  get brands{
//    return _brands;
//  }
 

 Observable loadAVenues(){
   final AVenuesRepo _repo = AVenuesRepo();
   return _repo.loadAVenues().doOnData((data){
     print('loadAVenuesData->$data');
   });
 }
 
}