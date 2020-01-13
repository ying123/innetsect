import 'package:innetsect/base/base.dart';

///热区首页

class HotSpotsHomeProvide  extends BaseProvide{
   String _activitiedId = '';
  String get activitiedId=>_activitiedId;
  set activitiedId(String activitiedId){
    _activitiedId = activitiedId;
  }
}