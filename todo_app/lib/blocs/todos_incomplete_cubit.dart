import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/repository.dart';



part 'todos_incomplete_state.dart';

class TodoIncomplete extends Cubit<TodoIncompleteState>{
  final Repository repository;

  TodoIncomplete({this.repository}) : super(TodoInitial());

  void fetchTodos() {
    Timer(Duration(seconds: 3), () {
      repository.fetchTodos().then((todos) {
        emit(TodoLoaded(todos: todos));
      });
    });
  }

  void fetchTodosIncomplete(){
    Timer(Duration(milliseconds: 200), () {
      repository.fetchTodos().then((todos) {
       final todo =  todos.where((element) => element.isCompleted == false ).toList();
        emit(TodoLoaded(todos: todo));
      });
    });
  }
}