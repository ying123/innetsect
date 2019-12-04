import 'package:innetsect/api/net_utils.dart';
import 'package:rxdart/rxdart.dart';

class ActivityService{
    ///api/event/exhibitions/201058021/activities/2019-12-03
    ///活动列表
    Observable getActivityList (int exhibitionID,String time){
      var url = '/api/event/exhibitions/$exhibitionID/activities/$time';
      var response = get(url);
      return response;
    }

    /// 活动详情
    Observable getActivityDetail (int activityID){
      var url = '/api/event/activities/$activityID';
      var response = get(url);
      return response;
    }
    /// 请求预约
    Observable vaildMark (int activityID){
      var url = '/api/event/activities/$activityID/reservations';
      var response = post(url);
      return response;
    }
    /// 生成二维码
    Observable getQrcode (int activityID,int reservationID){
      var url = '/api/event/activities/$activityID/reservations/$reservationID';
      var response = get(url);
      return response;
    }

    /// 取消预约
    Future<dynamic> cancelActivity(int activityID,int reservationID){
      var url = '/api/event/activities/$activityID/reservations/$reservationID';
      return delete(url);
    }

    /// 我的预约列表
    Observable getDataList (int exhibitionID,int pages){
      var url = '/api/event/exhibitions/$exhibitionID/reservations/mine?pageNo=$pages';
      var response = get(url);
      return response;
    }
}


class  ActivityRepo {
  final ActivityService _remote = ActivityService();
  Observable getActivityList (int exhibitionID,String time){
    return _remote.getActivityList(exhibitionID,time);
  }

  /// 活动详情
  Observable getActivityDetail (int activityID){
    return _remote.getActivityDetail(activityID);
  }

  /// 请求预约
  Observable vaildMark (int activityID){
    return _remote.vaildMark(activityID);
  }

  /// 生成二维码
  Observable getQrcode (int activityID,int reservationID){
    return _remote.getQrcode(activityID, reservationID);
  }

  /// 取消预约
  Future cancelActivity(int activityID,int reservationID){
    return _remote.cancelActivity(activityID, reservationID);
  }

  /// 我的预约列表
  Observable getDataList (int exhibitionID,int pages){
    return _remote.getDataList(exhibitionID, pages);
  }
}