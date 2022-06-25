import 'package:on_boarding/modules/login/login_model.dart';
import 'package:on_boarding/modules/shop/Favorites/ChangeFavorites_Model.dart';

abstract class ShopStates{}
class ShopInitailState extends ShopStates{}
class ShopChangeBottomNavState extends ShopStates{}
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{
  final String error;
  ShopErrorHomeDataState(this.error);
}
class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{
  final String error;
  ShopErrorCategoriesState(this.error);
}
class ShopSuccessChangeFavoritesState extends ShopStates{

   final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);

}
class ShopChangeFavoritesState extends ShopStates{}

class ShopErrorChangeFavoritesState extends ShopStates{
  final String error;
  ShopErrorChangeFavoritesState(this.error);

}
class ShopLoadingGetFavoritesState extends ShopStates {}
class ShopSuccessGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{
  final String error;
  ShopErrorGetFavoritesState(this.error);
}
class ShopLoadingProfileState extends ShopStates {}
class ShopSuccessProfileState extends ShopStates{
  final ShopLoginModel UserProfile;

  ShopSuccessProfileState(this.UserProfile);
}

class ShopErrorProfileState extends ShopStates{
  final String error;
  ShopErrorProfileState(this.error);
}
class ShopLoadingUpdateProfileState extends ShopStates {}
class ShopSuccessUpdateProfileState extends ShopStates{
  final ShopLoginModel updateProfile;

  ShopSuccessUpdateProfileState(this.updateProfile);
}

class ShopErrorUpdateProfileState extends ShopStates{
  final String error;
  ShopErrorUpdateProfileState(this.error);
}
class ShopchangeUpdateProfileState extends ShopStates {}