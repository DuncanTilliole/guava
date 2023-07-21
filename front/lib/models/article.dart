import 'package:guava/models/content.dart';

class Article {
  String id;
  String title;
  String description;
  int views;
  int likes;
  String image;
  String author;
  String? coAuthor;
  String created;
  String updated;
  List<Content>? contents;

  Article(
      this.id,
      this.title,
      this.description,
      this.views,
      this.likes,
      this.image,
      this.author,
      this.coAuthor,
      this.created,
      this.updated,
      this.contents);

  factory Article.fromJson(Map<String, dynamic> map) {
    List<dynamic> contents = map['contents'] as List;
    return Article(
      map['_id'] as String,
      map['title'] as String,
      map['description'] as String,
      map['views'] as int,
      map['likes'] as int,
      map['image'] as String,
      map['author'] as String,
      map['coAuthor'] as String?,
      map['created'] as String,
      map['updated'] as String,
      contents.map((e) => Content.fromJson(e)).toList(),
    );
  }

  factory Article.fromJsonWithoutContents(Map<String, dynamic> map) {
    return Article(
      map['_id'] as String,
      map['title'] as String,
      map['description'] as String,
      map['views'] as int,
      map['likes'] as int,
      map['image'] as String,
      map['author'] as String,
      map['coAuthor'] as String?,
      map['created'] as String,
      map['updated'] as String,
      null,
    );
  }
}
