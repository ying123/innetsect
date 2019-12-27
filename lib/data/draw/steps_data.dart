
class StepsModel {
  num drawID;
  num stepIdx;
  String stepName;
  
 
 

  StepsModel({
    this.drawID,
    this.stepIdx,
    this.stepName,
    
   
  });

  factory StepsModel.fromJson(Map<String, dynamic> json) {
    return StepsModel(
      drawID: json['drawID'],
      stepIdx: json['stepIdx'],
      stepName: json['stepName'],
    
   
    );
  }

  Map<String, dynamic> toJson() => {
        'drawID': drawID,
        'stepIdx': stepIdx,
        'stepName': stepName,
      };
}

class StepsModelList {
  List<StepsModel> list;

  StepsModelList(this.list);

  factory StepsModelList.fromJson(List json) {
    return StepsModelList(
        json.map((item) => StepsModel.fromJson((item))).toList());
  }
}
