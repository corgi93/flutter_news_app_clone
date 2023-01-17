import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/src/data/datasources/remote/news_api_service.dart';
import 'package:news_app/src/data/repositories/items_repository_impl.dart';
import 'package:news_app/src/domain/repositories/articles_repository.dart';
import 'package:news_app/src/domain/usecases/get_articles_usecase.dart';
import 'package:news_app/src/presentation/blocs/remote_articles/remote_articles_bloc.dart';
/**
 * Dependency Injection (DI)
 * 의존성 주입을 해당 injector.dart파일에서 수행함.
 */

final GetIt injector = GetIt.instance;

class TestInjectImpl {}

Future<void> initializeDependencies() async {
  // Dio client
  injector.registerSingleton<Dio>(Dio(), signalsReady: true);

  // Dependencies
  injector.registerSingleton<NewsApiService>(NewsApiService(injector()),
      signalsReady: true);

  injector.registerSingleton<ArticlesRepository>(
      ArticlesRepositoryImpl(injector()));

  // UseCases
  injector
      .registerSingleton<GetArticlesUseCase>(GetArticlesUseCase(injector()));

  // Blocs
  injector.registerFactory<RemoteArticlesBloc>(
      () => RemoteArticlesBloc(injector()));
}
