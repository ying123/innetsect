import 'dart:math';

import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/utils/screen_adapter.dart';

class Loading{
  static BuildContext ctx;
  static OverlayEntry entry;
  static bool isShow=false;
  static void show() {
    showDialog(context: ctx,
      barrierDismissible: false,
      builder: (BuildContext context){
        return Container(
          alignment: Alignment.center,
          width: ScreenAdapter.width(80),
          height: ScreenAdapter.height(80),
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: AppConfig.blueBtnColor,
            ),
          ),
        );
      });
//    entry = OverlayEntry(builder: (context) {
//      return ;
//    });
//    isShow = true;
//    Overlay.of(ctx).insert(entry);
  }

  static remove(){
    // 移除层可以通过调用OverlayEntry的remove方法。
    isShow = false;
//    entry.remove();
    Navigator.pop(ctx);
  }

  
}