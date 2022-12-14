import 'package:flutter/material.dart';
import 'package:news_app/src/config/routes/app_routes.dart';
import 'package:news_app/src/config/themes/app_theme.dart';

import 'src/core/utils/constants.dart';

// 비동기로 main 실행되도록 수정
Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kMaterialAppTitle,
      theme: AppTheme.light,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
    );
  }
}
