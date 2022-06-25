import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_boarding/layout/Shop_home/home_model.dart';
import 'package:on_boarding/layout/shopApp/cubic/states.dart';
import 'package:on_boarding/modules/login/login_model.dart';

import 'package:on_boarding/modules/shop/Categories/Categories_screen.dart';
import 'package:on_boarding/modules/shop/Categories/model_Categories.dart';
import 'package:on_boarding/modules/shop/Favorites/ChangeFavorites_Model.dart';
import 'package:on_boarding/modules/shop/Favorites/Favorites.dart';
import 'package:on_boarding/modules/shop/Favorites/favorites_Model.dart';
import 'package:on_boarding/modules/shop/Products/Products_Screen.dart';
import 'package:on_boarding/modules/shop/Settings/Settings_screen.dart';

import 'package:on_boarding/shared/componnents0/Constants.dart';
import 'package:on_boarding/shared/network/End_point.dart';
import 'package:on_boarding/shared/network/remot/dio_helper.dart';

class ShopCubic extends Cubit<ShopStates> {
  ShopCubic() : super(ShopInitailState());

  static ShopCubic get(context) => BlocProvider.of(context);
  int CurrentIndex = 0;
  List<Widget> bottomScreens = [
    Products_Screen(),
    Categories_screen(),
    Favorits_screen(),
    Settings_screen(),
  ];

  void ChangeBottom(int index) {
    CurrentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getdata(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
     // printFullText(homeModel!.data.banners[0].image.toString());
      homeModel!.data.products.forEach((element) {
        favorites.addAll({element.id: element.in_favorites});
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getdata(url: CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }
  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId]=!favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postdata(
            url: FAVORITES, data: {"product_id": productId}, token: token,lang: 'ar')
        .then((value) {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
     // print(value.data);
      if(!changeFavoritesModel!.status){
        favorites[productId]=!favorites[productId]!;
      }else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId]=!favorites[productId]!;
      emit(ShopErrorChangeFavoritesState(error.toString()));
    });
  }
  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getdata(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      //printFullText(value.data.toString());
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {

        print(error);

   //   print(error.toString());
      emit(ShopErrorGetFavoritesState(error.toString()));
    });
  }

  ShopLoginModel? UserModel;
  Future<void> getProfile() async {
    emit(ShopLoadingProfileState());
   await DioHelper.getdata(url: PROFILE, token: token).then((value) {
      UserModel = ShopLoginModel.fromJson(value.data);

     printFullText(UserModel!.data.name.runtimeType.toString());
      emit(ShopSuccessProfileState(UserModel!));
    }).catchError((error) {

      print(error);

     print('33333'+error.toString());
      emit(ShopErrorProfileState(error.toString()));
    });
  }
  late ShopLoginModel UpdateModel;

  Future<void> UpdateProfile({required name,required email,required phone}) async {
    emit(ShopLoadingUpdateProfileState());

   await DioHelper.putdata(url: UPDATAPROFILE, token: token,data: {
      "name": name,
      "email": email,
      "phone": phone

    }).then((value) {
      UpdateModel = ShopLoginModel.fromJson(value.data);

      printFullText(UpdateModel.data.name.runtimeType.toString());

      emit(ShopSuccessUpdateProfileState(UpdateModel));
getProfile();

    }).catchError((error) {

      print('error : $error');

      print('33333'+error.toString());
      emit(ShopErrorUpdateProfileState(error.toString()));
    });
  }


}
