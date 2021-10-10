import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/todos_complete_cubit.dart';
import 'package:todo_app/data/models/todo.dart';

class TodoscompleteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<Todocomplete>(context).fetchTodoscomplete();

    return Scaffold(
        body: BlocBuilder<Todocomplete, TodocompleteState>(
          builder: (context, state) {
            if (!(state is TodoLoaded))
              return Center(child: CircularProgressIndicator());

            final todos = (state as TodoLoaded).todos;

            return SingleChildScrollView(
              child:Column(
                children: todos.map((e) => _todo(e, context)).toList(),
              ),
            );
          },
        ));
  }
  Widget _todo(Todo todo, context) {
    return InkWell(
      child: _todoTile(todo, context),
    );
  }

  Widget _todoTile(Todo todo, context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200],
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(todo.todoMessage),
          _completionIndicator(todo,context),
        ],
      ),
    );
  }

  Widget _completionIndicator(Todo todo,context) {
    return   Checkbox(
      value: todo.isCompleted,
      onChanged: (bool value) {

    },
    );
  }
}