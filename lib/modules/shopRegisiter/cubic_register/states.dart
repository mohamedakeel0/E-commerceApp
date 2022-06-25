import 'package:on_boarding/modules/login/login_model.dart';

abstract class ShopRegisterStates{}
class ShopRegisterInitailState extends ShopRegisterStates{}
class ShopRegisterILoadingState extends ShopRegisterStates{}
class ShopRegisterSuccessState extends ShopRegisterStates{
  final ShopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);

}
class ShopRegisterErrorState extends ShopRegisterStates{
  final String error;
  ShopRegisterErrorState(this.error);
}
class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStates{}