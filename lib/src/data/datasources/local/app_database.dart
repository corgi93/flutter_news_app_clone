import 'dart:async';

import 'package:floor/floor.dart';
import 'package:news_app/src/data/datasources/local/DAOs/article_dao.dart';
import 'package:news_app/src/data/datasources/local/converter/source_type_converter.dart';
import 'package:news_app/src/domain/entities/article.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

/**
 * FloorDatabase에서 확장되는 추상화된 클래스를 정의하고 그 안에 DAO가 있고
 * 해당 Dao를 구현해야한다고 DB에 알림.
 *
 * sqflite가 floor에 추상화되어 있지만 import해줘야 build_runner로 build시 에러 x.
 * > flutter pub run build_runner build --delete-conflicting-outputs
 */
@TypeConverters([SourceTypeConverter])
@Database(version: 1, entities: [Article])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}
