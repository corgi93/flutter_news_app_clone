import 'package:equatable/equatable.dart';
import 'package:news_app/src/domain/entities/article.dart';

enum LocalArticlesStatus {
  loading,
  done,
  error,
}

class LocalArticlesState extends Equatable {
  final List<Article> articles;
  final LocalArticlesStatus status;

  const LocalArticlesState({
    this.articles = const <Article>[],
    this.status = LocalArticlesStatus.loading,
  });

  @override
  List<Object> get props => [status, articles];

  LocalArticlesState copyWith({
    LocalArticlesStatus? status,
    List<Article>? articles,
  }) {
    return LocalArticlesState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
    );
  }
}
