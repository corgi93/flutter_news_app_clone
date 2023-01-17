import 'package:news_app/src/core/params/article_request.dart';

import '../../core/resources/data_state.dart';
import '../../core/usecases/usecase.dart';
import '../entities/article.dart';
import '../repositories/articles_repository.dart';

/**
    DataState<List<Article>>을 return타입으로 사용.
    ArticlesRequestParams를 재정의된 call메서드에 대한 매개변수
    여기서 GetArticlesUseCase는 ArticlesRepository클래스에 의존하지만
    이 UseCase클래스 내부에서 인스턴스화 하지않음! get_it을 사용해 추후 종속성 주입할 것! (Dependency Injection)
    지금까지 작성한건 entity와 추상화이고 실제 구현은 data계층에서 이루어짐
    data계층 내부에서 모든 변경사항이 발생하고 domain계층에 영향이 x
 */
class GetArticlesUseCase
    implements UseCase<DataState<List<Article>>, ArticlesRequestParams> {
  final ArticlesRepository _articlesRepository;

  GetArticlesUseCase(this._articlesRepository);

  // TODO: nullable하게 처리했는데 null이 들어오면 안되긴하므로 추후 수정.
  @override
  Future<DataState<List<Article>>> call({ArticlesRequestParams? params}) {
    print("call.. article repository");
    return _articlesRepository.getBreakingNewsArticles(params!);
  }
}
