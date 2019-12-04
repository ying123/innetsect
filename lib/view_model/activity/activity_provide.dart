import 'package:innetsect/base/base.dart';
import 'package:innetsect/model/exhibition/activity_repository.dart';
import 'package:rxdart/rxdart.dart';

//活动页面数据供应
class ActivityProvide extends BaseProvide{
  String _days;
  String get days => _days;
  set days(String days){
    _days = days;
    notifyListeners();
  }
 int _currentIndex = 0 ; 
 int get  currentIndex{
   return _currentIndex;
 }

 set currentIndex(int index){
   _currentIndex = index;
   notifyListeners();
 }

 ActivityRepo _repo =  ActivityRepo();
 ///活动列表
 Observable getActivityList(int exhibitionID,String time){
   return _repo.getActivityList(exhibitionID,time).doOnData((item){

   }).doOnError((e, stack){

   }).doOnDone((){

   });
 }

 /// 活动详情
 Observable getActivityDetail (int activityID){
   return _repo.getActivityDetail(activityID).doOnData((item){

   }).doOnError((e, stack){

   }).doOnDone((){

   });
 }

  /// 请求预约
  Observable vaildMark (int activityID){
    return _repo.vaildMark(activityID).doOnData((item){

    }).doOnError((e, stack){

    }).doOnDone((){

    });
  }

  /// 生成二维码
  Observable getQrcode (int activityID,int reservationID){
    return _repo.getQrcode(activityID,reservationID).doOnData((item){

    }).doOnError((e, stack){

    }).doOnDone((){

    });
  }

  /// 取消预约
  Future cancelActivity(int activityID,int reservationID){
    return _repo.cancelActivity(activityID, reservationID);
  }

  /// 我的预约列表
  Observable getDataList (int exhibitionID,int pages){
    return _repo.getDataList(exhibitionID,pages).doOnData((item){

    }).doOnError((e, stack){

    }).doOnDone((){

    });
  }

 ///工厂模式
 factory ActivityProvide()=> _getInstance();
 static ActivityProvide get instance => _getInstance();
 static ActivityProvide _instance;
 static ActivityProvide _getInstance(){
   if (_instance == null) {
     _instance = new ActivityProvide._internal();
   }
   return _instance;
 }

 ActivityProvide._internal() {
   print('ActivityProvide');
   // 初始化
 }

}