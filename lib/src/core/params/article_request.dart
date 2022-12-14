import 'package:news_app/src/core/utils/constants.dart';

// 왜 이런 reqParam을 class로 만드냐. rest api에서 데이터 가져오기 위해 매개변수를  메서드에 전달.
//
class ArticlesRequestParams {
  // final로 immutable하게 선언
  final String apiKey;
  final String country;
  final String category;
  final int page;
  final int pageSize;

  // constructor
  const ArticlesRequestParams({
    this.apiKey = kApiKey,
    this.country = 'us',
    this.category = 'general',
    this.page = 1,
    this.pageSize = 20,
  });
}
