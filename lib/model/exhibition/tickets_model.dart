


import 'package:innetsect/api/net_utils.dart';
import 'package:rxdart/rxdart.dart';

class TicketsService {
  Observable tickets (int exhibitionsID,int showId){
    var url = '/api/event/exhibitions/$exhibitionsID/ticketTypes?showId=$showId';
    var response = get(url);
    return response;
  }
  /// 我的门票列表
  Observable ticketsList (int pages){
    var url = '/api/event/tickets/mine?pageNo=$pages';
    var response = get(url);
    return response;
  }
// /api/event/tickets/mine?pageNo=1
}

  ///展会首页数据响应
class TicketsRepo {
  final TicketsService _remote = TicketsService();
  Observable tickets (int exhibitionsID,int showId){
    return _remote.tickets(exhibitionsID,showId);
  }

  /// 我的门票列表
  Observable ticketsList (int pages){
    return _remote.ticketsList(pages);
  }

}