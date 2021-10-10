import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/repository.dart';
part 'todos_state.dart';

class TodosCubit extends Cubit<TodoState> {
  final Repository repository;

  TodosCubit({this.repository}) : super(TodoInitial());

  void fetchTodos() {
    Timer(Duration(milliseconds: 500), () {
      repository.fetchTodos().then((todos) {
        emit(TodoLoaded(todos: todos));
      });
    });
  }

  void changeCompletion(Todo todo) {
    repository.changeCompletion(!todo.isCompleted, todo.id).then((isChanged) {
      if (isChanged) {
        todo.isCompleted = !todo.isCompleted;
        updateTodoList();
      }
    });
  }

  void updateTodoList() {
    final currentState = state;
    if (currentState is TodoLoaded)
      emit(TodoLoaded(todos: currentState.todos));
  }

 void addTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodoLoaded) {
      final todoList = currentState.todos;
      todoList.add(todo);
      emit(TodoLoaded(todos: todoList));
    }
  }

  void deleteTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodoLoaded) {
      final todoList = currentState.todos.where((element) => element.id != todo.id).toList();
      emit(TodoLoaded(todos: todoList));
    }
  }

}
