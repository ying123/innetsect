import 'package:innetsect/base/base.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/model/brand_model.dart';

class  CVenuedProvide extends BaseProvide{
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
  final List<Brand> contacts = [
    const Brand(
      avatar: 'https://randomuser.me/api/portraits/men/53.jpg',
      name: 'Maurice Sutton',
      nameIndex: 'M',
    ),
    const Brand(
      avatar: 'https://randomuser.me/api/portraits/women/76.jpg',
      name: 'Jerry',
      nameIndex: 'J',
    ),
    const Brand(
      avatar: 'https://randomuser.me/api/portraits/women/17.jpg',
      name: 'Dangdang',
      nameIndex: 'D',
    ),
    const Brand(
      avatar: 'https://randomuser.me/api/portraits/women/55.jpg',
      name: 'Teddy',
      nameIndex: 'T',
    ),
    const Brand(
      avatar: 'https://randomuser.me/api/portraits/women/11.jpg',
      name: 'Steave',
      nameIndex: 'S',
    ),
    const Brand(
      avatar: 'https://randomuser.me/api/portraits/women/65.jpg',
      name: 'Vivian',
      nameIndex: 'V',
    ),
    const Brand(
      avatar: 'https://randomuser.me/api/portraits/women/50.jpg',
      name: 'Mary',
      nameIndex: 'M',
    ),
    const Brand(
      avatar: 'https://randomuser.me/api/portraits/women/91.jpg',
      name: 'David',
      nameIndex: 'D',
    ),
    const Brand(
      avatar: 'https://randomuser.me/api/portraits/women/60.jpg',
      name: 'Bob',
      nameIndex: 'B',
    ),
    const Brand(
      avatar: 'https://randomuser.me/api/portraits/men/60.jpg',
      name: 'Jeff Green',
      nameIndex: 'J',
    ),
    const Brand(
      avatar: 'https://randomuser.me/api/portraits/men/45.jpg',
      name: 'Adam',
      nameIndex: 'A',
    ),
    const Brand(
      avatar: 'https://randomuser.me/api/portraits/men/7.jpg',
      name: 'Michel',
      nameIndex: 'M',
    ),
    const Brand(
      avatar: 'https://randomuser.me/api/portraits/men/35.jpg',
      name: 'Green',
      nameIndex: 'G',
    ),
    const Brand(
      avatar: 'https://randomuser.me/api/portraits/men/64.jpg',
      name: 'Jack Ma',
      nameIndex: 'J',
    ),
    const Brand(
      avatar: 'https://randomuser.me/api/portraits/men/86.jpg',
      name: 'Tom',
      nameIndex: 'T',
    ),
    const Brand(
      avatar: 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537868900176&di=ddbe94a75a3cc33f880a5f3f675b8acd&imgtype=0&src=http%3A%2F%2Fs2.sinaimg.cn%2Fmw690%2F003wRTwMty6IGZWzd2p31',
      name: '张伟',
      nameIndex: 'Z',
    ),
    const Brand(
      avatar: 'https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1537858866&di=fe35e4465c73122f14e1c9475dd68e47&src=http://a2.att.hudong.com/63/26/01300001128119143503262347361.jpg',
      name: '张益达',
      nameIndex: 'Z',
    ),
  ];
///品牌列表
 List<Brand> _brands = [];
 get brands{
   return _brands;
 } 
}