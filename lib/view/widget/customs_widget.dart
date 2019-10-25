import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';

/// 自定义通用小部件类
class CustomsWidget{

  /// 选中部件，应用于购物车、地址管理等
  /// * [isSelected] 是否选中
  /// * [onSelectedCallback] 回调函数
  Widget customRoundedWidget({
    @required isSelected,
    @required onSelectedCallback
  }){
    return GestureDetector(
      onTap: (){
        onSelectedCallback();
      },
      child: new Container(
        child: isSelected? new Icon(
          Icons.check_circle,
          size: 25.0,
          color: AppConfig.fontBackColor,
        ) : new Icon(Icons.panorama_fish_eye,
          size: 25.0,
        ),
      ),
    );
  }
}