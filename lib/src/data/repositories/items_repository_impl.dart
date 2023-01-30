import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_app/src/core/params/article_request.dart';
import 'package:news_app/src/core/resources/data_state.dart';
import 'package:news_app/src/data/datasources/local/app_database.dart';
import 'package:news_app/src/data/datasources/remote/news_api_service.dart';
import 'package:news_app/src/domain/entities/article.dart';
import 'package:news_app/src/domain/repositories/articles_repository.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  // API 서비스 실행
  final NewsApiService _newsApiService;
  // local database 실행
  final AppDatabase _appDatabase;

  const ArticlesRepositoryImpl(this._newsApiService, this._appDatabase);

  @override
  Future<DataState<List<Article>>> getBreakingNewsArticles(
    ArticlesRequestParams params,
  ) async {
    try {
      print("check!!");
      final httpResponse = await _newsApiService.getBreakingNewsArticles(
        apiKey: params.apiKey,
        country: params.country,
        category: params.category,
        page: params.page,
        pageSize: params.pageSize,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.articles);
      }
      return DataFailed(
        DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          request: httpResponse.response.request,
          type: DioErrorType.RESPONSE,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  // DB - 여기서 db인스턴스화 하지않고 injector에서 종속성 주입함. 여기선 dao로 DB access하는 함수를 호출하는 역할만 제공.
  @override
  Future<List<Article>> getSavedArticles() {
    return _appDatabase.articleDao.getAllArticles();
  }

  @override
  Future<void> removeArticle(Article article) {
    return _appDatabase.articleDao.insertArticle(article);
  }

  @override
  Future<void> saveArticle(Article article) {
    return _appDatabase.articleDao.deleteArticle(article);
  }
}
