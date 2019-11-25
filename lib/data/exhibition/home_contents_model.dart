

///首页内容数据
class  HomeContentsModel {
  int contentID;
  String contentColumn;
  String title;
  String subtitle;
  String poster;
  int mediaType;
  String mediaFiles;
  String tags;
  String author;
  int status;
  String createdDate;
  String lastModified;
  String refName;
  String refID;
  String pics;
  String authorPortrait;
  int portletID;
  int hitCount;
  int commentCount;
  int praiseCount;
 

  HomeContentsModel({
    this.contentID,
    this.contentColumn,
    this.title,
    this.subtitle,
    this.poster,
    this.mediaType,
    this.mediaFiles,
    this.tags,
    this.author,
    this.status,
    this.createdDate,
    this.lastModified,
    this.refName,
    this.refID,
    this.pics,
    this.authorPortrait,
    this.portletID,
    this.hitCount,
    this.commentCount,
    this.praiseCount,
  });

  factory HomeContentsModel.fromJson(Map<String, dynamic> json){
    return HomeContentsModel(
      contentID:json['contentID'],
      contentColumn:json['contentColumn'],
      title: json['title'],
      subtitle: json['subtitle'],
      poster: json['poster'],
      mediaType: json['mediaType'],
      mediaFiles: json['mediaFiles'],
      tags: json['tags'],
      author: json['author'],
      status: json['status'],
      createdDate: json['createdDate'],
      lastModified: json['lastModified'],
      refName: json['refName'],
      refID: json['refID'],
      pics: json['pics'],
      authorPortrait: json['authorPortrait'],
      portletID: json['portletID'],
      hitCount: json['hitCount'],
      commentCount: json['commentCount'],
      praiseCount: json['praiseCount'],
    );
  }

  Map<String, dynamic> toJson() => {
    'contentID':contentID,
    'contentColumn':contentColumn,
    'title':title,
    'subtitle':subtitle,
    'poster':poster,
    'mediaType':mediaType,
    'mediaFiles':mediaFiles,
    'tags':tags,
    'author':author,
    'status':status,
    'createdDate':createdDate,
    'lastModified':lastModified,
    'refName':refName,
    'refID':refID,
    'pics':pics,
    'authorPortrait':authorPortrait,
    'portletID':portletID,
    'hitCount':hitCount,
    'commentCount':commentCount,
    'praiseCount':praiseCount,
  };
}

class  HomeContentsModelList {
  List<HomeContentsModel> list;

  HomeContentsModelList(this.list);

  factory HomeContentsModelList.fromJson(List json){
    return HomeContentsModelList(
      json.map((item)=>HomeContentsModel.fromJson((item))).toList()
    );
  }
}