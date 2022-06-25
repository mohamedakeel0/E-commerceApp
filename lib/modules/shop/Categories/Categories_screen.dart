import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_boarding/layout/shopApp/cubic/cubic.dart';
import 'package:on_boarding/layout/shopApp/cubic/states.dart';
import 'package:on_boarding/model/model_Categories.dart';
import 'package:on_boarding/shared/componnents0/components.dart';

class Categories_screen extends StatelessWidget {
  const Categories_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubic, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubic = ShopCubic.get(context);
        return ListView.separated(
            itemBuilder: (context, index) =>
                buildCatItem(cubic.categoriesModel!.data.data[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubic.categoriesModel!.data.data.length);
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 100,
              height: 100,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              model.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
