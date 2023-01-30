import 'package:news_app/src/core/usecases/usecase.dart';
import 'package:news_app/src/domain/entities/article.dart';
import 'package:news_app/src/domain/repositories/articles_repository.dart';

class SaveArticleUseCase extends UseCase<void, Article> {
  final ArticlesRepository _articlesRepository;
  SaveArticleUseCase(this._articlesRepository);

  @override
  Future<void> call({required Article params}) {
    return _articlesRepository.saveArticle(params);
  }
}
