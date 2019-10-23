import 'package:flutter/material.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/commodity_modal_child_page.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';

class CommodityModalBottom {
  /// 从底部弹出modal
  /// [isScrollControlled]是否是一个路由，默认为false
  /// * 如果为false在子组件中使用将无法找到根组件会报错
  static showBottomModal(BuildContext context,
      CommodityAndCartProvide provide){
    double height = ScreenAdapter.getScreenHeight()-200;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
          return new Container(
            height: height,
            color: Colors.white,
            child: new CommodityModalChildPage(provide,height),
          );
      },
      isScrollControlled: true
    );
  }
}