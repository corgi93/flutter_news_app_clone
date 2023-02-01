import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/src/core/utils/constants.dart';
import 'package:news_app/src/data/datasources/local/app_database.dart';
import 'package:news_app/src/data/datasources/remote/news_api_service.dart';
import 'package:news_app/src/data/repositories/items_repository_impl.dart';
import 'package:news_app/src/domain/repositories/articles_repository.dart';
import 'package:news_app/src/domain/usecases/get_articles_usecase.dart';
import 'package:news_app/src/domain/usecases/get_saved_articles_usecase.dart';
import 'package:news_app/src/domain/usecases/remove_article_usecase.dart';
import 'package:news_app/src/domain/usecases/save_article_usecase.dart';
import 'package:news_app/src/presentation/blocs/local_articles/local_articles_bloc.dart';
import 'package:news_app/src/presentation/blocs/remote_articles/remote_articles_bloc.dart';
/**
 * Dependency Injection (DI)
 * 의존성 주입을 해당 injector.dart파일에서 수행함.
 */

final GetIt injector = GetIt.instance;

class TestInjectImpl {}

Future<void> initializeDependencies() async {
  // database 추가 - floor패키지에서 FloorAppDatabase의 databaseBuilder를 사용해 db를 빌드하고
  // build()메서드는 AppDatabase의 인스턴스를 비동기적으로 반환
  // db를 가져오면 injector에 싱글톤으로 등록
  final database =
      await $FloorAppDatabase.databaseBuilder(kDatabaseName).build();
  injector.registerSingleton<AppDatabase>(database);

  // Dio client
  injector.registerSingleton<Dio>(Dio(), signalsReady: true);

  // Dependencies
  injector.registerSingleton<NewsApiService>(NewsApiService(injector()),
      signalsReady: true);

  injector.registerSingleton<ArticlesRepository>(
      // 생성자로 _newsApiService, _appDatabase 인자 2개가 필요하므로 injector()를 2개로 받음.
      ArticlesRepositoryImpl(injector(), injector()));

  // UseCases - remote api
  injector.registerSingleton<GetArticlesUseCase>(
    GetArticlesUseCase(injector()),
  );
  // UseCase - local database
  injector.registerSingleton<GetSavedArticlesUseCase>(
    GetSavedArticlesUseCase(injector()),
  );
  injector.registerSingleton<SaveArticleUseCase>(
    SaveArticleUseCase(injector()),
  );
  injector.registerSingleton<RemoveArticleUseCase>(
    RemoveArticleUseCase(injector()),
  );

  // Blocs
  injector.registerFactory<RemoteArticlesBloc>(
      () => RemoteArticlesBloc(injector()));

  injector.registerFactory<LocalArticlesBloc>(
      () => LocalArticlesBloc(injector(), injector(), injector()));
}
