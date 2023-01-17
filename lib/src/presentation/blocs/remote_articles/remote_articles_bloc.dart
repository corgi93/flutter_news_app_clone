import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/core/params/article_request.dart';
import 'package:news_app/src/domain/entities/article.dart';
import 'package:news_app/src/domain/usecases/get_articles_usecase.dart';

import '../../../core/bloc/bloc_with_state.dart';

part 'remote_articles_event.dart';
part 'remote_articles_state.dart';

/**
 * BlocWithState class 상속 받아 각 bloc 정의
 */

class RemoteArticlesBloc
    extends BlocWithState<RemoteArticlesEvent, RemoteArticlesState> {
  final GetArticlesUseCase _getArticlesUseCase;

  RemoteArticlesBloc(this._getArticlesUseCase)
      : super(const RemoteArticlesState()) {
    // on<GetArticles>((event, emit) => emit(state + 1));
    on<GetArticles>(_onArticlesFetched);
  }

  final List<Article> _articles = [];
  int _page = 1;
  static const int _pageSize = 20;

  Future<void> _onArticlesFetched(
      GetArticles event, Emitter<RemoteArticlesState> emit) async {
    if (state.noMoreData) return;

    try {
      emit(state.copyWith(status: ArticlesStatus.initial));
      if (state.status == ArticlesStatus.initial) {
        print("initial!!");
        // await로  데이터 불러오기
        final dataState = await _getArticlesUseCase(
          params: ArticlesRequestParams(page: _page),
        );

        return emit(state.copyWith(
          status: ArticlesStatus.success,
          articles: dataState.data,
          noMoreData: false,
        ));
      }
      // dataState is DataSuccess && dataState.data.isNotEmpty
      // if (dataState is DataSuccess) {
      //   // 성공적으로 data 가져오면 List<Article>타입으로 받을 것
      //   final articles =
      //       dataState.data as List<Article>; // as 로 type지정해줘야 하는지 체크.
      //   final noMoreData = articles.length < _pageSize;
      //   _articles.addAll(articles);
      //   _page++;
      //
      //   RemoteArticlesDone(_articles, noMoreData: noMoreData);
      // }
    } catch (_) {
      // RemoteArticlesError(dataState.error);
    }
  }
}
