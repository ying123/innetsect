
class PicsModel {
  num drawID;
  num picIdx;
  String picUrl;
  
 
 

  PicsModel({
    this.drawID,
    this.picIdx,
    this.picUrl,
    
   
  });

  factory PicsModel.fromJson(Map<String, dynamic> json) {
    return PicsModel(
      drawID: json['drawID'],
      picIdx: json['picIdx'],
      picUrl: json['picUrl'],
    
   
    );
  }

  Map<String, dynamic> toJson() => {
        'drawID': drawID,
        'picIdx': picIdx,
        'picUrl': picUrl,
      };
}

class PicsModelList {
  List<PicsModel> list;

  PicsModelList(this.list);

  factory PicsModelList.fromJson(List json) {
    return PicsModelList(
        json.map((item) => PicsModel.fromJson((item))).toList());
  }
}
