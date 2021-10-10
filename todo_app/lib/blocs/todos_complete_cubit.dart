import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/repository.dart';
part 'todos_complete_state.dart';

class Todocomplete extends Cubit<TodocompleteState>{
  final Repository repository;

  Todocomplete({this.repository}) : super(TodoInitial());

  void fetchTodos() {
    Timer(Duration(seconds: 3), () {
      repository.fetchTodos().then((todos) {
        emit(TodoLoaded(todos: todos));
      });
    });
  }

  void fetchTodoscomplete(){
    Timer(Duration(milliseconds: 100), () {
      repository.fetchTodos().then((todos) {
      final todo =  todos.where((element) => element.isCompleted == true).toList();
        emit(TodoLoaded(todos: todo));
      });
    });
  }
}