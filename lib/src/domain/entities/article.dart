import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:news_app/src/core/utils/constants.dart';

import 'source.dart';

@Entity(tableName: kArticlesTableName)
class Article extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  // nullable이 아니면 required로 넣어줘야 함.
  const Article({
    required this.id,
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  @override
  List<Object> get props {
    return [
      id,
      source,
      author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content,
    ];
  }

  @override
  bool get stringify => true;
}
