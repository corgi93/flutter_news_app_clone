part of 'remote_articles_bloc.dart';

/**
 * Bloc의 수행할 작업(Event)를 정의함.
 * 여기선 articles를 가져오는 단일 event를 정의
 */
abstract class RemoteArticlesEvent extends Equatable {
  const RemoteArticlesEvent();

  @override
  List<Object> get props => [];
}

// Article
class GetArticles extends RemoteArticlesEvent {
  const GetArticles();

  @override
  List<Object> get props => [];
}
