import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/utils/screen_adapter.dart';

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

  /// showDialog,弹框提示,material风格
  Future customShowDialog({
    @required BuildContext context,
    String title,
    String content,
    VoidCallback onPressed
  }){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return new AlertDialog(
          title: title!=null?new Text(title):new Container(),
          content: new Container(
            child: new Text(content),
          ),
          actions: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new FlatButton(
                  color:Colors.white,
                  textColor: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text("取消"),
                ),
                new FlatButton(
                  color:Colors.white,
                  textColor: Colors.blue,
                  onPressed: () {
                    onPressed();
                    Navigator.of(context).pop();
                  },
                  child: new Text("确认"),
                )
              ],
            )
          ],
        );
      }
    );
  }
}