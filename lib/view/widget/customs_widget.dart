import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/utils/screen_adapter.dart';

/// 自定义通用小部件类
class CustomsWidget{

  /// 选中部件，应用于购物车、地址管理等
  /// * [isSelected] 是否选中
  /// * [onSelectedCallback] 回调函数
  Widget customRoundedWidget({
    @required isSelected,
    @required onSelectedCallback,
    double iconSize = 25.0,
    bool isDisable = false
  }){
    return GestureDetector(
      onTap: isDisable?null:(){
        onSelectedCallback();
      },
      child: new Container(
        child: isSelected? new Icon(
          Icons.check_circle,
          size: iconSize,
          color: AppConfig.fontBackColor,
        ) : new Icon(Icons.panorama_fish_eye,
          size: iconSize,
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

  /// 自定义文字标题，前面带黄色竖条
  /// * [title] 标题
  /// * [color] 竖条颜色
  Widget subTitle({
    @required title,
    Color color,
    double width,
    double height
  }){
    return new Row(
      children: <Widget>[
        new Container(
          width: width==null?ScreenAdapter.width(10):width,
          height: height==null?ScreenAdapter.height(40):height,
          margin: EdgeInsets.only(right: 8),
          color: color,
        ),
        new Text(title,style: TextStyle(
            fontSize: ScreenAdapter.size(28),
            fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  /// 自定义价格文本
  /// [price] 价格
  Widget priceTitle({
    @required price,
    Color color
  }){
    return new Row(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.only(top: 2),
          alignment: Alignment.center,
          child: new Text("¥ ",style: TextStyle(
            fontSize: ScreenAdapter.size(18.0),color: color),
          ),
        ),
        new Container(
            alignment: Alignment.center,
            child: new Text(price, style: TextStyle(
                fontSize: ScreenAdapter.size(28),fontWeight: FontWeight.w900,color: color
            ),
            )
        ),

      ],
    );
  }

  /// 自定义头部导航栏
  /// *[centerTitle]是否居中，默认true
  /// *[widget]中间title
  /// *[width]中间title宽
  /// *[isLeading]是否需要左侧返回导航
  /// *[centerTitle]title是否居中
  /// *[onTap] 左侧返回导航事件
  Widget customNav({
    @required BuildContext context,
    @required Widget widget,
    double width,
    double elevation = 0,
    bool leading = true,
    bool centerTitle = true,
    bool automaticallyImplyLeading = false,
    List<Widget> actions,
    Function() onTap
  }){
    return new AppBar(
      leading: leading ?new GestureDetector(
        onTap: (){
          onTap==null ?
            Navigator.pop(context) : onTap();
        },
        child: new Container(
            padding: EdgeInsets.all(20),
            child: new Image.asset("assets/images/mall/arrow_down.png",
              fit: BoxFit.fitWidth,
            )
        ),
      ): null,
      title: new Container(
        width: width,
        child: widget,
      ),
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading,
      elevation: elevation,
      centerTitle: centerTitle,
    );
  }

  /// 显示提示
  void showToast({
    @required String title
  }){
    Fluttertoast.showToast(msg: title,gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_SHORT,backgroundColor: Colors.black54,textColor: Colors.white);
  }

}