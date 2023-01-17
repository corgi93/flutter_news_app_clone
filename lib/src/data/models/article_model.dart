import 'package:news_app/src/data/models/source_model.dart';
import 'package:news_app/src/domain/entities/article.dart';

class ArticleModel extends Article {
  const ArticleModel({
    required int id,
    required SourceModel source,
    required String author,
    required String title,
    required String description,
    required String url,
    required String urlToImage,
    required String publishedAt,
    required String content,
  }) : super(
          id: id,
          source: source,
          author: author,
          title: title,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          content: content,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    //TODO: null체크를 꼭 해야하는지 서치. factory예약어로 싱글톤 구현해서 없어도 될듯?
    // if (map == null) {
    //   return null
    // };

    return ArticleModel(
      id: map['id'] as int,
      source: SourceModel.fromJson(map['source'] as Map<String, dynamic>),
      author: map['author'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      url: map['url'] as String,
      urlToImage: map['urlToImage'] as String,
      publishedAt: map['publishedAt'] as String,
      content: map['content'] as String,
    );
  }
}
