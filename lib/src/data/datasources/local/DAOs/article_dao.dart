import 'package:floor/floor.dart';
import 'package:news_app/src/core/utils/constants.dart';
import 'package:news_app/src/domain/entities/article.dart';

@dao
abstract class ArticleDao {
  @Query('SELECT * FROM $kArticlesTableName')
  Future<List<Article>> getAllArticles();

  /// insert: db에 데이터 삽입.
  /// onConflint는 엔티티를 추가하는 동안 db 충돌이 발생할 경우
  /// 어떻게 처리할 지 옵션을 선택.
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertArticle(Article article);

  /// 받은 entity 삭제
  @delete
  Future<void> deleteArticle(Article article);
}
