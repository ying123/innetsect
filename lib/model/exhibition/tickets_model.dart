


import 'package:innetsect/api/net_utils.dart';
import 'package:rxdart/rxdart.dart';

class TicketsService {
 Observable tickets (int showId){
    var url = '/api/event/exhibitions/201058021/ticketTypes?showId=$showId';
    var response = get(url);
    return response;
  }
  }

  ///展会首页数据响应
class TicketsRepo {
  final TicketsService _remote = TicketsService();
  Observable tickets (int showId){
    return _remote.tickets(showId);
  }

  }