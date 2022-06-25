import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_boarding/modules/login/login.dart';
import 'package:on_boarding/shared/bloc_observer/blocObserver.dart';
import 'package:on_boarding/shared/cubic_to_mode/cubic.dart';
import 'package:on_boarding/shared/cubic_to_mode/states.dart';
import 'package:on_boarding/shared/network/local/cache_helper.dart';
import 'package:on_boarding/shared/network/remot/dio_helper.dart';

import 'package:on_boarding/shared/style/Theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'layout/Shop_home/shop_home.dart';
import 'layout/shopApp/cubic/cubic.dart';

import 'modules/shop/onboarding/On__boarding.dart';
import 'modules/shopRegisiter/cubic_register/cubic.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance();

  Bloc.observer = MyBlocObserver();

  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  dynamic onBoarding=CacheHelper.getData(key: 'onBoarding');
  dynamic token=CacheHelper.getData(key: 'token');
  print(token);
 bool? isDark = CacheHelper.getData(key: 'isdark');
 if(onBoarding!=null){
   if(token!=null)widget=ShopLayout();
   else widget=Shoplogin();
 }else{
   widget=Onboarding();
 }
  runApp( MyApp(startWidget:widget));

}

class MyApp extends StatelessWidget {

 Widget? startWidget;
 bool? isDark;
 MyApp({required this.startWidget}) ;



  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubic()..getHomeData()..getCategories()..getFavorites()..getProfile()

        ),

        BlocProvider(
          create: (context) => AppCubit()),
        BlocProvider(
            create: (context) =>  ShopRegisterCubic()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: startWidget,
          );
        },
      ),
    );

  }
}

