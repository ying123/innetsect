class ContentModel{
  int contentID;
  String contentColumn;
  String title;
  String subtitle;
  String poster;
  int mediaType;
  String mediaFiles;
  String tags;
  int status;
  int portletID;

  ContentModel({
    this.portletID,
    this.status,
    this.contentColumn,
    this.contentID,
    this.mediaFiles,
    this.mediaType,
    this.poster,
    this.subtitle,
    this.tags,
    this.title
  });

  factory ContentModel.fromJson(Map<String,dynamic> json){
    return ContentModel(
      contentColumn: json['contentColumn'],
      contentID: json['contentID'],
      title: json['title'],
      subtitle: json['subtitle'],
      poster: json['poster'],
      mediaFiles: json['mediaFiles'],
      mediaType: json['mediaType'],
      tags: json['tags'],
      status: json['status'],
      portletID: json['portletID'],
    );
  }

}

class ContentModelList{

  List<ContentModel> list;

  ContentModelList(this.list);

  factory ContentModelList.fromJson(List json){
    return ContentModelList(
        json.map(
                (item)=>ContentModel.fromJson((item))
        ).toList()
    );
  }

}