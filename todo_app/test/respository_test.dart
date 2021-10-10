import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/blocs/todos_cubit.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/repository.dart';

class TodoRepository extends Mock implements Repository {}

void main() {
  TodosCubit todosCubit;
  var repos = TodoRepository();

  setUp(() {
    repos = TodoRepository();
    todosCubit = TodosCubit(repository: repos);
  });
  tearDown(() {
    todosCubit?.close();
  });
  final List<Todo> todo = [Todo(todoMessage: '1', isCompleted: false, id: 1)];
  blocTest(
    'success',
    build: () {
      when(repos.fetchTodos()).thenAnswer(
        (_) => Future.value(todo),
      );
    },
    expect: () => [],
  );
  group('Task TodosCubit_test', () {
    blocTest<TodosCubit, TodoState>('successful todo loads',
        build: () => TodosCubit(),
        act: (cubit) => cubit.fetchTodos(),
        expect: () => []);
  });
}
