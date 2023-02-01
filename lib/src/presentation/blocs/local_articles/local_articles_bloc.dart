import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/domain/usecases/get_saved_articles_usecase.dart';
import 'package:news_app/src/domain/usecases/remove_article_usecase.dart';
import 'package:news_app/src/domain/usecases/save_article_usecase.dart';
import 'package:news_app/src/presentation/blocs/local_articles/local_articles_event.dart';
import 'package:news_app/src/presentation/blocs/local_articles/local_articles_state.dart';
import 'package:news_app/src/presentation/blocs/remote_articles/remote_articles_bloc.dart';

class LocalArticlesBloc extends Bloc<LocalArticlesEvent, LocalArticlesState> {
  final GetSavedArticlesUseCase _getSavedArticlesUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticlesBloc(
    this._getSavedArticlesUseCase,
    this._saveArticleUseCase,
    this._removeArticleUseCase,
  ) : super(const LocalArticlesState()) {
    on<GetAllSavedArticles>(_onLocalArticlesFetched);
  }

  Future<void> _onLocalArticlesFetched(
      GetAllSavedArticles event, Emitter<LocalArticlesState> emit) async {
    if (state.status == LocalArticlesStatus.done) return;
    try {
      if (state.status == ArticlesStatus.loading) {
        final dataState = await _getSavedArticlesUseCase();
        // return emit(state.copyWith(
        //   status: LocalArticlesStatus.done,
        //    articles:
        // ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: LocalArticlesStatus.error,
      ));
    }
  }
}
