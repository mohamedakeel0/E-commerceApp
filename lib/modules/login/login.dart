import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:on_boarding/layout/Shop_home/shop_home.dart';

import 'package:on_boarding/modules/shopRegisiter/shop_register.dart';



import 'package:on_boarding/shared/componnents0/Constants.dart';

import 'package:on_boarding/shared/componnents0/components.dart';
import 'package:on_boarding/shared/network/local/cache_helper.dart';

import 'cubic_login/cubic.dart';
import 'cubic_login/states.dart';

class Shoplogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => ShoploginCubic(),
      child: BlocConsumer<ShoploginCubic, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.email);

              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data.token)
                  .then((value) {token=state.loginModel.data.token;navigateAndFinish(context, ShopLayout());});
              ShowToast(
                  text: state.loginModel.message, state: Toaststates.SUCCESS);
            } else {
              ShowToast(
                  text: state.loginModel.message, state: Toaststates.ERROR);
            }
          }

        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Login now to brower our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'please enter your email address';
                              }
                            },
                            label: 'Email Address',
                            prefix: Icons.email_outlined),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                            isPassword: ShoploginCubic.get(context).isPassword,
                            onSubmit: (value) {
                              if (formkey.currentState!.validate()) {
                                ShoploginCubic.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            controller: passwordController,
                            suffix: ShoploginCubic.get(context).suffix,
                            suffixPressed: () {
                              ShoploginCubic.get(context)
                                  .changePasswordvisibility();
                            },
                            type: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'password is too short ';
                              }
                            },
                            label: 'password',
                            prefix: Icons.lock_outline),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                            condition: state is! ShopLoginILoadingState,
                            builder: (context) => defaultButton(
                                function: () {
                                  if (formkey.currentState!.validate()) {
                                    print(passwordController.text);
                                    ShoploginCubic.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }

                                },
                                text: 'login',
                                isUpperCase: true),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator())),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don`t have an account?',
                              style: TextStyle(fontSize: 12),
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, shop_register());
                                },
                                child: Text(
                                  'register',
                                  style: TextStyle(fontSize: 12),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
