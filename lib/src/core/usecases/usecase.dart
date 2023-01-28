// UseCase(사용 경우)를 작성 이유.
// call이 call 메서드를 호출하는 대신 인스턴스를 호출하게 만드는게
// T는 call이 반환하는 Type, P는 call이 요구하는 매개변수.
abstract class UseCase<T, P> {
  Future<T> call({required P params});
}
