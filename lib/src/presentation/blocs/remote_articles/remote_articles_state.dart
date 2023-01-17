part of 'remote_articles_bloc.dart';

enum ArticlesStatus { initial, success, error, loading }

class RemoteArticlesState extends Equatable {
  final List<Article> articles;
  final bool noMoreData;
  final ArticlesStatus status;
  final DioError? error;

  const RemoteArticlesState({
    this.status = ArticlesStatus.initial,
    this.articles = const <Article>[],
    this.noMoreData = false,
    this.error,
  });

  @override
  List<Object> get props => [
        status,
        articles,
        noMoreData,
        error ?? {},
      ];

  // copyWith로 가능한 모든 state를 처리하기 위해 object의 새 복사본을 생성.
  RemoteArticlesState copyWith({
    ArticlesStatus? status,
    List<Article>? articles,
    bool? noMoreData,
  }) {
    return RemoteArticlesState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      noMoreData: noMoreData ?? this.noMoreData,
    );
  }
}

class RemoteArticlesLoading extends RemoteArticlesState {
  const RemoteArticlesLoading();
}

class RemoteArticlesDone extends RemoteArticlesState {
  const RemoteArticlesDone(List<Article> article, {required bool noMoreData})
      : super(articles: article, noMoreData: noMoreData);
}

class RemoteArticlesError extends RemoteArticlesState {
  const RemoteArticlesError(DioError error) : super(error: error);
}
