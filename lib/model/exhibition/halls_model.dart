

import 'package:innetsect/api/net_utils.dart';
import 'package:rxdart/rxdart.dart';

class HallsService {
 Observable halls (int exhibitionID, String exhibitionHall ){
    var url = '/api/event/exhibitions/$exhibitionID/halls/$exhibitionHall/locations';
    var response = get(url);
    return response;
  }
  }

  ///场馆大厅
class HallsRepo {
  final HallsService _remote = HallsService();
  Observable halls (int exhibitionID, String exhibitionHall ){
    return _remote.halls(exhibitionID,exhibitionHall );
  }

  }