

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:on_boarding/shared/cubic_to_mode/states.dart';
import 'package:on_boarding/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isdark = false;
  ThemeMode appmode = ThemeMode.dark;

  void changeAppmode({bool? fromshared}) {
    if (fromshared != null) {
      isdark = fromshared;
      emit(AppChangeModeState());
    } else {
      isdark = !isdark;
      CacheHelper.putboolean(key: 'isdark', value: isdark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
