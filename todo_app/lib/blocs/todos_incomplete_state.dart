
part of 'todos_incomplete_cubit.dart';

@immutable
abstract class TodoIncompleteState {}
class TodoInitial extends TodoIncompleteState {}
class TodoLoaded extends TodoIncompleteState {
  final List<Todo> todos;

  TodoLoaded({this.todos});
}
class TodoLoadFailure extends TodoIncompleteState{}
