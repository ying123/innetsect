import 'dart:ui';

import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/exhibition/ticket_model.dart';
import 'package:innetsect/model/exhibition/tickets_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class ShowTicketsProvide extends BaseProvide {
  List<TicketModel> _showTickets = [];
  List<TicketModel> get showTickets=> _showTickets;

  void addTickets(List<TicketModel>list){
    _showTickets.addAll(list);
    notifyListeners();
  }

  

  TicketsRepo _repo = TicketsRepo();

  Observable tickets(int showId){
   return _repo.tickets(showId).doOnData((item){

    }).doOnError((e, stack){

    }).doOnDone((){

    });
  }

}
