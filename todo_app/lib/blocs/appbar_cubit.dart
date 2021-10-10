
import 'package:flutter_bloc/flutter_bloc.dart';



class AppBarCubit extends Cubit<int>{
  AppBarCubit() : super(0);
  void updateIndex(int index) => emit(index);
  void  All() => emit(0);
  void Incpmlete() => emit(1);
  void Complete() => emit(2);
}