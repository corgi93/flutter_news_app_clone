import 'package:floor/floor.dart';
import 'package:news_app/src/domain/entities/source.dart';

class SourceTypeConverter extends TypeConverter<Source, String> {
  // DB에서 가져온 string으로 encoding된 값 Source타입으로 decoding
  @override
  Source decode(String databaseValue) {
    final List<String> results =
        databaseValue.split(',') ?? const ['non', 'non'];

    return Source(id: results.first, name: results.last);
  }

  // Source타입 object를 stringify해서 encoding. DB에 string으로 저장.
  @override
  String encode(Source value) {
    final String result = '${value.id}, ${value.name}';
    return result;
  }
}
