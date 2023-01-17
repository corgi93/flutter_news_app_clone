import 'package:news_app/src/core/params/article_request.dart';
import 'package:news_app/src/core/resources/data_state.dart';
import 'package:news_app/src/domain/entities/article.dart';

// 다 비동기 처리
abstract class ArticlesRepository {
  // API method.
  Future<DataState<List<Article>>> getBreakingNewsArticles(
      ArticlesRequestParams params);

  // Database
  // GET
  // Future<List<Article>> getSavedArticles();

  // PUT
  // Future<void> saveArticle(Article article);

  // DELETE
  // Future<void> removeArticle(Article article);
}
