import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/main_screen_state.dart';


class MainScreenController extends Cubit<MainScreenState>{
  MainScreenController():super(const MainScreenState());

  void setPageIndex(int value){
    emit(state.copyWith(pageIndex: value));
  }
}