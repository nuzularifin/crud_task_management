import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_crud_task_management/data/model/response/login_response_model.dart';
import 'package:flutter_crud_task_management/domain/repositories/login/login_repository.dart';
import 'package:flutter_crud_task_management/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_crud_task_management/presentation/bloc/login/login_event.dart';
import 'package:flutter_crud_task_management/presentation/bloc/login/login_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([LoginRepository])
void main() {
  late MockLoginRepository mockLoginRepository;
  late LoginBloc loginBloc;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    loginBloc = LoginBloc(mockLoginRepository);
  });

  tearDown(() {
    loginBloc.close();
  });

  blocTest<LoginBloc, LoginState>(
    'Emits [TaskAdded, TaskLoaded] when AddTaskEvent is followed by GetTasksEvent',
    build: () {
      when(mockLoginRepository.requestLogin('evo.holt@reqres.in', 'cityslicka'))
          .thenAnswer((_) async {
        return LoginResponseModel(token: 'token_123');
      });

      return loginBloc;
    },
    act: (bloc) async {
      bloc.add(
          LoginRequest(username: 'evo.holt@reqres.in', password: 'cityslicka'));
    },
    expect: () => [
      isA<LoginLoading>(),
      isA<LoginSuccess>(),
    ],
    verify: (bloc) {
      verify(mockLoginRepository.requestLogin(
              'evo.holt@reqres.in', 'cityslicka'))
          .called(1);
    },
  );
}
