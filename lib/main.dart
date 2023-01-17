import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/config/routes/app_routes.dart';
import 'package:news_app/src/config/themes/app_theme.dart';
import 'package:news_app/src/core/utils/constants.dart';
import 'package:news_app/src/injector.dart';
import 'package:news_app/src/presentation/blocs/remote_articles/remote_articles_bloc.dart';

// 비동기로 main 실행되도록 수정
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // // DI적용. runApp()전에 불러주면  service provider가 injector 등록
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticlesBloc>(
      // ..은 cascade 연산자. 함수호출, 필드접근을 한 번에 할 수 있음.
      create: (BuildContext context) =>
          injector<RemoteArticlesBloc>()..add(const GetArticles()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: kMaterialAppTitle,
        theme: AppTheme.light,
        onGenerateRoute: AppRoutes.onGenerateRoutes,
      ),
    );
  }
}
