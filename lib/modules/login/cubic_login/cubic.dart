import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_boarding/modules/login/cubic_login/states.dart';


import 'package:on_boarding/modules/login/login_model.dart';
import 'package:on_boarding/shared/network/End_point.dart';
import 'package:on_boarding/shared/network/remot/dio_helper.dart';



class ShoploginCubic extends Cubit<ShopLoginStates> {
  ShoploginCubic() : super(ShopLoginInitailState());

  static ShoploginCubic get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void userLogin({required String email, required String password }) {
    emit(ShopLoginILoadingState());
    DioHelper.postdata(url: LOGIN, data: {
      'email': email,
      'password': password,
    },
    ).then((value){

      print(value.data);
      loginModel= ShopLoginModel.fromJson(value.data);

      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }
  IconData suffix= Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordvisibility(){
    isPassword=!isPassword;
    suffix= isPassword?Icons.visibility_outlined:Icons.visibility_off;
    emit( ShopChangePasswordVisibilityState());
  }

}