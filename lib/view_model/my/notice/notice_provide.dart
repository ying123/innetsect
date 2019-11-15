import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/notice_model.dart';
import 'package:innetsect/model/notice_respository.dart';
import 'package:rxdart/rxdart.dart';

/// 购买须知
class NoticeProvide extends BaseProvide {

  List _list = [];
  List get list =>_list;

  /// 重写数据格式
  void resetData(List<NoticeModel> list){
    List resetList = new List();
    list.forEach((item){
      var result = resetList.where((wh)=>wh['topic']==item.topic).toList();
      if(result.length==0){
        List itemList = new List();
        Map<String,dynamic> map = new Map();
        // 标题
        map.putIfAbsent("topic",()=> item.topic);
        // 子元素
        itemList.add(getJson(item));

        map.putIfAbsent("item", ()=>itemList);
        resetList.add(map);
      }else{
        var index = resetList.indexWhere((wh)=>wh['topic']==item.topic).toInt();
        resetList[index]['item'].add(getJson(item));
      }
    });
    _list = resetList;
    notifyListeners();
  }

  Map<String,dynamic> getJson(NoticeModel item){
    return {
      "itemID": item.itemID,
      "answer": item.answer,
      "question": item.question
    };
  }

  final NoticeRepo _repo = NoticeRepo();

  ///获取订单全部列表
  Observable listData(){
    return _repo.listData().doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  ///工厂模式
  factory NoticeProvide() => _getInstance();
  static NoticeProvide get instance => _getInstance();
  static NoticeProvide _instance;
  static NoticeProvide _getInstance() {
    if (_instance == null) {
      _instance = new NoticeProvide._internal();
    }
    return _instance;
  }
  NoticeProvide._internal() {
    print('NoticeProvide init');
    // 初始化
  }
}