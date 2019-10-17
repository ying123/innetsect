

import 'package:innetsect/base/base.dart';
///小部件提供视频数据状态
class VideoWidgetProvide extends BaseProvide{

//视频是否初始化
  bool _videoPrepared = false;
  get videoPrepared{
    return _videoPrepared;
  }

  set videoPrepared (bool videoPrepared){
    _videoPrepared = videoPrepared;
    notifyListeners();
  }

  
///隐藏操作按钮
  bool _hideActionButton = true;
  get hideActionButton{
    return _hideActionButton;
  }

  set hideActionButton(bool hideActionButton){
     _hideActionButton = hideActionButton;
     notifyListeners();
  }




}