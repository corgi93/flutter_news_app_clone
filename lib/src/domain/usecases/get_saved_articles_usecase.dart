import 'package:news_app/src/core/usecases/usecase.dart';
import 'package:news_app/src/domain/entities/article.dart';
import 'package:news_app/src/domain/repositories/articles_repository.dart';

class GetSavedArticlesUseCase implements UseCase<List<Article>, void> {
  final ArticlesRepository _articlesRepository;

  GetSavedArticlesUseCase(this._articlesRepository);

  @override
  Future<List<Article>> call({void params}) {
    return _articlesRepository.getSavedArticles();
  }
}
