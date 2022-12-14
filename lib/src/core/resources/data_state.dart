import 'package:dio/dio.dart';

// API 통신 후 네트워크 응답을 DataState로 래핑하는 래퍼 클래스
// 응답이 DioError유형의 오류로 success or fail 두가지 상태를 가질 수 있음
abstract class DataState<T> {
  final T? data; // ? 로 nullable 하게 코드 수정
  final DioError? error; // ? 로 nullable 하게 코드 수정

  const DataState({this.data, this.error});
}

// 네트워크 성공 (200)시 래퍼 클래스
class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

// 네트워크 실패 시 래퍼 클래스
class DataFailed<T> extends DataState<T> {
  const DataFailed(DioError error) : super(error: error);
}
