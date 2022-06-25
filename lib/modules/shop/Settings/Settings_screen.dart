import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_boarding/layout/shopApp/cubic/cubic.dart';
import 'package:on_boarding/layout/shopApp/cubic/states.dart';
import 'package:on_boarding/shared/componnents0/Constants.dart';
import 'package:on_boarding/shared/componnents0/components.dart';

class Settings_screen extends StatelessWidget {
  Settings_screen({Key? key}) : super(key: key);
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubic, ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubic = ShopCubic.get(context);

        nameController.text = cubic.UserModel!.data.name;
        phoneController.text = cubic.UserModel!.data.phone;
        emailController.text = cubic.UserModel!.data.email;

        return ConditionalBuilder(
          condition: cubic != null,

          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateProfileState)
                      LinearProgressIndicator(),
                    defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'name must not be empty';
                          }
                          return null;
                        },
                        label: 'Name',
                        prefix: Icons.person),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'email must not be empty';
                          }
                          return null;
                        },
                        label: 'Email Address',
                        prefix: Icons.email),
                    SizedBox(
                      height: 20,
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
                      height: 20,
                    ),
                    defaultButton(
                        function: () {
                          if (formkey.currentState!.validate()) {
                            ShopCubic.get(context).UpdateProfile(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text);

                          }




                        },
                        text: 'Updata'),
                    SizedBox(
                      height: 20,
                    ),
                        defaultButton(
                        shape: true,
                        function: () {
                          signOut(context);
                        },
                        text: 'Logout'),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => CircularProgressIndicator(),
        );
      },
    );
  }
}
