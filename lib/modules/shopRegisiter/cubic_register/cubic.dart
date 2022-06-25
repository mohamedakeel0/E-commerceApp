import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_boarding/modules/login/cubic_login/states.dart';
import 'package:on_boarding/modules/login/login_model.dart';
import 'package:on_boarding/modules/shopRegisiter/cubic_register/states.dart';
import 'package:on_boarding/shared/network/End_point.dart';
import 'package:on_boarding/shared/network/remot/dio_helper.dart';


class ShopRegisterCubic extends Cubit<ShopRegisterStates> {
  ShopRegisterCubic() : super(ShopRegisterInitailState());

  static ShopRegisterCubic get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userRegister({required String email, required String password,required name,required phone}) {
    emit(ShopRegisterILoadingState());
    DioHelper.postdata(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);

      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordvisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
