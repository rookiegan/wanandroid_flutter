import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class BannerData {
  final String desc;
  final int id;
  final String imagePath;
  final int isVisible;
  final int order;
  final String title;
  final int type;
  final String url;

  BannerData({
    required this.desc,
    required this.id,
    required this.imagePath,
    required this.isVisible,
    required this.order,
    required this.title,
    required this.type,
    required this.url,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) {
    return _$BannerDataFromJson(json);
  }

  Map<String, dynamic> toJson(Object Function(BannerData value) toJsonT) {
    return _$BannerDataToJson(this);
  }
}

@JsonSerializable()
class ArticleData {
  bool adminAdd;
  String apkLink;
  int audit;
  String author;
  bool canEdit;
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  String desc;
  String descMd;
  String envelopePic;
  bool fresh;
  String host;
  int id;
  bool isAdminAdd;
  String link;
  String niceDate;
  String niceShareDate;
  String origin;
  String prefix;
  String projectLink;
  int publishTime;
  int realSuperChapterId;
  int selfVisible;
  int shareDate;
  String shareUser;
  int superChapterId;
  String superChapterName;

  // List<Tags> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  ArticleData(
    this.adminAdd,
    this.apkLink,
    this.audit,
    this.author,
    this.canEdit,
    this.chapterId,
    this.chapterName,
    this.collect,
    this.courseId,
    this.desc,
    this.descMd,
    this.envelopePic,
    this.fresh,
    this.host,
    this.id,
    this.isAdminAdd,
    this.link,
    this.niceDate,
    this.niceShareDate,
    this.origin,
    this.prefix,
    this.projectLink,
    this.publishTime,
    this.realSuperChapterId,
    this.selfVisible,
    this.shareDate,
    this.shareUser,
    this.superChapterId,
    this.superChapterName,
    // this.tags,
    this.title,
    this.type,
    this.userId,
    this.visible,
    this.zan,
  );

  factory ArticleData.fromJson(Map<String, dynamic> json) {
    return _$ArticleDataFromJson(json);
  }

  Map<String, dynamic> toJson(Object Function(ArticleData value) toJsonT) {
    return _$ArticleDataToJson(this);
  }
}
