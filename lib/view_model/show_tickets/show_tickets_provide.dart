import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/exhibition/ticket_model.dart';
import 'package:innetsect/model/exhibition/tickets_model.dart';
import 'package:rxdart/rxdart.dart';

class ShowTicketsProvide extends BaseProvide {
  List<TicketModel> _showTickets = [];
  List<TicketModel> get showTickets=> _showTickets;

  void addTickets(List<TicketModel>list){
    _showTickets.addAll(list);
    notifyListeners();
  }

  

  TicketsRepo _repo = TicketsRepo();

  Observable tickets(int exhibitionsID,int showId){
   return _repo.tickets(exhibitionsID,showId).doOnData((item){

    }).doOnError((e, stack){

    }).doOnDone((){

    });
  }



}
