// ignore_for_file: unnecessary_null_comparison

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_boarding/layout/shopApp/cubic/cubic.dart';
import 'package:on_boarding/layout/shopApp/cubic/states.dart';
import 'package:on_boarding/shared/componnents0/components.dart';




class Favorits_screen extends StatelessWidget {
  const Favorits_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubic, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubic = ShopCubic.get(context);
        return ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoritesState&& cubic.favoritesModel !=null,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildListProduct(
                    cubic.favoritesModel!.data.data[index].product, context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: cubic.favoritesModel!.data.data.length),
            fallback: (context) =>  CircularProgressIndicator());
      },
    );
  }


}
