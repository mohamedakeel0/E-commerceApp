import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_boarding/layout/shopApp/cubic/cubic.dart';
import 'package:on_boarding/layout/shopApp/cubic/states.dart';
import 'package:on_boarding/modules/login/login.dart';
import 'package:on_boarding/modules/shop/Search/Search_screen.dart';

import 'package:on_boarding/shared/componnents0/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubic,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubic=ShopCubic.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [IconButton(onPressed: (){
              navigateTo(context,Search_screen());
            }, icon: Icon(Icons.search))],
          ),
       body:cubic.bottomScreens[cubic.CurrentIndex] ,
          bottomNavigationBar:BottomNavigationBar(
            onTap: (index){
              cubic.ChangeBottom(index);
            },currentIndex: cubic.CurrentIndex,
            items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorite'),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
          ],),
        );
      },
    );
  }
}
