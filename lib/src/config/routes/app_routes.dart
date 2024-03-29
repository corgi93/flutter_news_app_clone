import 'package:flutter/material.dart';
import 'package:news_app/src/domain/entities/article.dart';
import 'package:news_app/src/presentation/views/article_details_view.dart';
import 'package:news_app/src/presentation/views/breaking_news_view.dart';

class AppRoutes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const BreakingNewsView());
        break;
      case '/ArticleDetailsView':
        return _materialRoute(
            ArticleDetailsView(article: settings.arguments as Article));
        break;
      case '/SavedArticlesView':
        // return _materialRoute(const SavedArticlesView());
        break;
      default:
        return null;
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}

// import 'package:flutter/material.dart';
//
// import '../../presentation/views/breaking_news_view.dart';
//
// class AppRoutes {
//   static Route onGenerateRoutes(RouteSettings settings) {
//     switch (settings.name) {
//       case '/':
//         return _materialRoute(const BreakingNewsView());
//
//       default:
//         return null;
//     }
//   }
//
//   static Route<dynamic> _materialRoute(Widget view) {
//     return MaterialPageRoute(builder: (_) => view);
//   }
// }
