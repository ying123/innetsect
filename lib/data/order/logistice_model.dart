/// 物流信息model
class LogisticeModel{
  String ftime;
  String context;

  LogisticeModel({
    this.context,
    this.ftime
  });

  factory LogisticeModel.fromJson(Map<String,dynamic> json){
    return LogisticeModel(
      context: json['context'],
      ftime: json['ftime']
    );
  }

  Map<String,dynamic> toJson()=>{
    'ftime': ftime,
    'context': context
  };
}

class LogisticeModelList{
  final List<LogisticeModel> list;
  LogisticeModelList(this.list);

  factory LogisticeModelList.fromJson(List json){
    return LogisticeModelList(
      json.map((item)=>LogisticeModel.fromJson(item)).toList()
    );
  }
}