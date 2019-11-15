/// 购买须知
class NoticeModel{
  int shopID;
  int itemID;
  String topic;
  String question;
  String answer;

  NoticeModel({
    this.shopID,
    this.itemID,
    this.topic,
    this.question,
    this.answer
  });

  factory NoticeModel.fromJson(Map<String,dynamic> json){
    return NoticeModel(
      shopID: json['shopID'],
      itemID: json['itemID'],
      topic: json['topic'],
      question: json['question'],
        answer: json['answer']
    );
  }

  Map<String,dynamic> toJson() =>{
    'shopID': shopID,
    'itemID': itemID,
    'topic': topic,
    'question': question,
    'answer': answer
  };
}

class NoticeModelList{
  List<NoticeModel> list;

  NoticeModelList(this.list);

  factory NoticeModelList.fromJson(List json){
    return NoticeModelList(
        json.map(
                (item)=>NoticeModel.fromJson((item))
        ).toList()
    );
  }
}