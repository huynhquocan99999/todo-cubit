import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/appbar_cubit.dart';
import 'package:todo_app/constants/strings.dart';

import 'package:todo_app/screens/todos_complete_screen.dart';
import 'package:todo_app/screens/todos_incomplete_screen.dart';
import 'package:todo_app/screens/todos_screen.dart';


class AppBarScreen extends StatefulWidget {
  AppBarScreen({Key key}) : super( key:  key);
  @override
  _AppBarScreen createState() => _AppBarScreen();
}
class _AppBarScreen extends State<AppBarScreen>{

  final _pageNavigation = [
    TodosScreen(),
    TodoscompleteScreen(),
    TodosIncompleteScreen()
  ];
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AppBarCubit,int>(
        builder:(context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text('APP TODO'),
              actions: [
                InkWell(
                  onTap: () => Navigator.pushNamed(context, ADD_TODO_ROUTE),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.add),
                  ),
                )
              ],
            ),
            body: _buildBody(state),
            bottomNavigationBar: _buildBottomNavigaton(),
          );
        }
    );
  }
  Widget _buildBody(int index) {
    return _pageNavigation.elementAt(index);
  }
  Widget _buildBottomNavigaton (){
    return BottomNavigationBar(
      currentIndex: context.read<AppBarCubit>().state,
      type: BottomNavigationBarType.fixed,
      onTap: _getChangeNavigation,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.email),
            label : ('ALL')
        ),
        BottomNavigationBarItem(icon: Icon(Icons.email),
            label: ('Complete')
        ),
        BottomNavigationBarItem(icon: Icon(Icons.email),
            label: ('Incomplete')
        )
      ],
    );
  }
  void _getChangeNavigation(int index){
    context.read<AppBarCubit>().updateIndex(index);
  }
}