import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_boarding/layout/Shop_home/shop_home.dart';

import 'package:on_boarding/modules/shopRegisiter/cubic_register/cubic.dart';
import 'package:on_boarding/modules/shopRegisiter/cubic_register/states.dart';
import 'package:on_boarding/shared/componnents0/Constants.dart';


import 'package:on_boarding/shared/componnents0/components.dart';
import 'package:on_boarding/shared/network/local/cache_helper.dart';

class shop_register extends StatelessWidget {
  const shop_register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController PasswordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    return BlocProvider(create: (context) => ShopRegisterCubic(),
      child: BlocConsumer<ShopRegisterCubic, ShopRegisterStates>(
        listener: (context, state) {

          if (state is ShopRegisterSuccessState) {
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
        }, builder:(context, state) =>  Scaffold(
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
                      'REGISTER',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.black),
                    ),
                    Text(
                      'Register now to brower our hot offers',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'please enter your name';
                          }
                        },
                        label: 'Name',
                        prefix: Icons.person),
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
                        isPassword: ShopRegisterCubic.get(context).isPassword,

                        controller: passwordController,
                        suffix: ShopRegisterCubic.get(context).suffix,
                        suffixPressed: () {
                          ShopRegisterCubic.get(context).changePasswordvisibility();
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
                    defaultFormField(
                        isPassword: ShopRegisterCubic.get(context).isPassword,

                        controller: PasswordController,
                        suffix: ShopRegisterCubic.get(context).suffix,
                        suffixPressed: () {
                          ShopRegisterCubic.get(context).changePasswordvisibility();
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
                    defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'phone must not be empty';
                          }
                          return null;
                        },
                        label: 'Phone',
                        prefix: Icons.phone),
                    SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                        condition: state is! ShopRegisterILoadingState,
                        builder: (context) => defaultButton(
                            function: () {
                              if (formkey.currentState!.validate()) {
                                print(passwordController.text);
                                ShopRegisterCubic.get(context).userRegister(
                                name:nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text, phone: phoneController.text );

                              }
                            },
                            text: 'Register',
                            isUpperCase: true),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator())),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )),);
  }
}
