import 'package:innetsect/base/base.dart';
import 'package:innetsect/model/exhibition/tickets_model.dart';
import 'package:rxdart/rxdart.dart';

class TicketProvide extends BaseProvide{
  
  ///当前票的详细数据
  Map _currentTicketData;
  get currentTicketData{
    if (_currentTicketData == null) {
      _currentTicketData = {};
    }
    return _currentTicketData;
  }

  set currentTicketData(Map currentTicketData){
    _currentTicketData = currentTicketData;
    notifyListeners();
  }

///总计票数
  int _countVotes = 0;
  get countVotes{
    return _countVotes;
  }
  set countVotes(int countVotes){
    _countVotes = countVotes;
    notifyListeners();
  }


  TicketsRepo _repo = TicketsRepo();
  /// 我的门票列表
  Observable ticketsList (int pages){
    return _repo.ticketsList(pages).doOnData((item){

    }).doOnError((e, stack){

    }).doOnDone((){

    });
  }
}