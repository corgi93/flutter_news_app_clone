import 'package:equatable/equatable.dart';
import 'package:news_app/src/domain/entities/article.dart';

class LocalArticlesEvent extends Equatable {
  final Article? article;
  const LocalArticlesEvent({this.article});
  @override
  List<Object> get props => [article ?? {}];
}

// Article
class GetAllSavedArticles extends LocalArticlesEvent {
  const GetAllSavedArticles();
}

class RemoveArticle extends LocalArticlesEvent {
  const RemoveArticle(Article article) : super(article: article);
}

class SaveArticle extends LocalArticlesEvent {
  const SaveArticle(Article article) : super(article: article);
}
