import 'package:flutter_bloc/flutter_bloc.dart';

/**
 * 다른 bloc 클래스를 생성
 * 이 클래스에서 프로세스를 싱행하고 현재 bloc 상태(busy인지 idle한지)를 변경할 수 있는 기능을 제공
 *
 * Stream클래스
 * 앱을 만들다보면 테이터를 처리할 일이 많고, 어느 타이밍에 데이터가 들어올 지 정확히 알기 어렵다.
 * Stream은 이런 비동기 작업시 주로 사용. 데이터를 받아 UI로 보여줄 때 언제 받을 지 모름.
 * 이런 문제를 Stream은 데이터 생성과 소비하는 곳을 따로 둬서 이 문제를 해결
 */

enum BlocProcessState {
  busy, // 사용중인
  idle, // 가동되지 않는
}

// Event, State(dynamic)
abstract class BlocWithState<Event, State> extends Bloc<Event, State> {
  BlocWithState(State initialState) : super(initialState);

  BlocProcessState _state = BlocProcessState.idle;
  BlocProcessState get blocProcessState => _state;

  // params로 함수를 넘길 수 있다.
  Stream<State> runBlocProcess(Stream<State> Function() process) async* {
    if (_state == BlocProcessState.idle) {
      // 가동중이지 않으면 busy상태 변환 후 yield*로 process 잡은 후 완료 되면 idle로 다시 변경
      _state = BlocProcessState.busy;
      yield* process();
      _state = BlocProcessState.idle;
    }
  }
}
