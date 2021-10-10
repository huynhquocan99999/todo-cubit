part of 'todos_complete_cubit.dart';

@immutable
abstract class TodocompleteState {}
class TodoInitial extends TodocompleteState {}
class TodoLoaded extends TodocompleteState {
  final List<Todo> todos;

  TodoLoaded({this.todos});
}
class TodoLoadFailure extends TodocompleteState{}