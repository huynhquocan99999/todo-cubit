import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/add_todo_cubit.dart';
import 'package:todo_app/blocs/appbar_cubit.dart';
import 'package:todo_app/blocs/edit_todo_cubit.dart';
import 'package:todo_app/blocs/todos_cubit.dart';
import 'package:todo_app/blocs/todos_incomplete_cubit.dart';
import 'package:todo_app/constants/strings.dart';

import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/network_service.dart';
import 'package:todo_app/data/repository.dart';
import 'package:todo_app/screens/appbar_screen.dart';
import 'package:todo_app/screens/todos_complete_screen.dart';
import 'package:todo_app/screens/todos_incomplete_screen.dart';
import 'package:todo_app/screens/todos_screen.dart';


import 'blocs/todos_complete_cubit.dart';
import 'screens/add_todo_screen.dart';
import 'screens/edit_todo_screen.dart';


class AppRouter {
  Repository repository;
  TodosCubit todosCubit;

  AppRouter() {
    repository = Repository(networkService: NetworkService());
    todosCubit = TodosCubit(repository: repository);
  }

  Route generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider<AppBarCubit>(
                create: ( context) => AppBarCubit()
            ),
            BlocProvider(
             create: (BuildContext context) => TodosCubit(
              repository: repository,
              ),
            ),
            BlocProvider(
              create: (BuildContext context) => Todocomplete(
                repository: repository,
              ),
            ),
            BlocProvider(
              create: (BuildContext context) => TodoIncomplete(
                repository: repository,
              ),
            ),
          ],
              child: AppBarScreen())
          );
      case EDIT_TODO_ROUTE:
        final todo = settings.arguments as Todo;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => EditTodoCubit(
              repository: repository,
              todosCubit: todosCubit,
            ),
            child: EditTodoScreen(todo: todo,),
          ),
        );
      case ADD_TODO_ROUTE:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (BuildContext context) => AddTodoCubit(
                repository: repository,
                todosCubit: todosCubit,
              ),
              ),
            ],
            child: AddTodoScreen(),
          ),
        );
      case INCOMPLETE_TODO_ROUTE:
        final todo = settings.arguments as Todo;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => TodoIncomplete(
              repository: repository,
            ),
            child: TodosIncompleteScreen(),
          ),
        );
      case COMPLETE_TODO_ROUTE:
        final todo = settings.arguments as Todo;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => Todocomplete(
              repository: repository,
            ),
            child: TodoscompleteScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
