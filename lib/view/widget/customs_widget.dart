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
    VoidCallback onPressed,
    VoidCallback onCancel,
    bool isCancel=true,
    String cancelTitle = "放弃",
    String submitTitle="确认"
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
                isCancel?new FlatButton(
                  color:Colors.white,
                  textColor: Colors.blue,
                  onPressed: () {
                    if(onCancel!=null){
                      onCancel();
                    }else{
                      Navigator.of(context).pop();
                    }
                  },
                  child: new Text(cancelTitle),
                ):Container(width: 0.0,height: 0.0,),
                new FlatButton(
                  color:Colors.white,
                  textColor: Colors.blue,
                  onPressed: () {
                    if(onPressed!=null){
                      onPressed();
                    }else{
                      Navigator.of(context).pop();
                    }
                  },
                  child: new Text(submitTitle,style: TextStyle(color: AppConfig.blueBtnColor),),
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
    Color color,
    FontWeight fontWeight = FontWeight.w900,
    double fontSize
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
                fontSize: fontSize!=null?fontSize:ScreenAdapter.size(28),fontWeight: fontWeight,color: color
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
    Function() onTap,
    PreferredSizeWidget bottom,
  }){
    return new AppBar(
      leading: leading ?new InkWell(
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
      bottom: bottom,
    );
  }

  /// 显示提示
  void showToast({
    @required String title
  }){
    Fluttertoast.showToast(msg: title,gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_SHORT,backgroundColor: Colors.black54,textColor: Colors.white);
  }

  /// list操作栏
  Widget listSlider({String icon,String title,double titleFontSize,Color titleColor,
    Function() onTap,FontWeight titleFont,bool rightTitle=false,String rightDesc,
    bool isRightIcon=true
  }){
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(125),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: ScreenAdapter.width(50),
                ),
                icon!=null?Center(
                  child: Container(
                    width: ScreenAdapter.width(43),
                    height: ScreenAdapter.height(33),
                    child: Image.asset(icon),
                  ),
                ):Container(),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: titleColor==null?Color.fromRGBO(95, 95, 95, 1.0):titleColor,
                      fontSize: titleFontSize==null?ScreenAdapter.size(27):titleFontSize,
                      fontWeight: titleFont
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 10),
                    child: rightTitle?
                        Text(rightDesc,softWrap: false,style: TextStyle(color: Colors.grey,
                            fontSize: ScreenAdapter.size(24)),):Container(),
                  ),
                ),
                isRightIcon?Image.asset(
                  'assets/images/mall/arrow_right.png',
                  width: ScreenAdapter.width(25),
                  height: ScreenAdapter.width(25),
                ):Container(),
                SizedBox(
                  width: ScreenAdapter.width(43),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 搜索组件
  Widget searchWidget({Function() onTap}){
    return new Container(
      margin: EdgeInsets.only(left: 10,right: 10),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: AppConfig.assistLineColor,
          borderRadius: BorderRadius.circular(5.0)
      ),
      child: InkWell(
        onTap: (){
          onTap();
        },
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Image.asset("assets/images/search.png",width: 40,height: 40,),
            new Text("搜索商品、品牌",style: TextStyle(color: AppConfig.assistFontColor),)
          ],
        ),
      ),
    );
  }

  /// 暂无数据
  List<Widget> noDataWidget(){
    return <Widget>[
      Container(
        width: double.infinity,
        height: ScreenAdapter.height(240),
        margin: EdgeInsets.only(top: 120),
        child: Image.asset("assets/images/mall/no_data.png",
          fit: BoxFit.contain,
          width: ScreenAdapter.width(120),
          height: ScreenAdapter.height(120),
        ),
      ),
      Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text("暂无相关数据",style: TextStyle(color: Colors.black54,fontSize: ScreenAdapter.size(28)),),
        ),
      )
    ];
  }

}