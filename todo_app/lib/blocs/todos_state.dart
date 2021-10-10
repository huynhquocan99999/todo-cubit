part of 'todos_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}
class TodoLoaded extends TodoState {
  final List<Todo> todos;

  TodoLoaded({this.todos});
}
class TodoLoadFailure extends TodoState{}
