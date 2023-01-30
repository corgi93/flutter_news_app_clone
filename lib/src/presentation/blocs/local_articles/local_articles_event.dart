import 'package:equatable/equatable.dart';

class LocalArticlesEvent extends Equatable {
  const LocalArticlesEvent();

  @override
  List<Object> get props => [];
}

// Article
class GetLocalArticles extends LocalArticlesEvent {
  const GetLocalArticles();

  List<Object> get props => [];
}
