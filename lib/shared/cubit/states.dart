import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class ShopChangeBottomNavState extends AppStates {}

class ShopLoadingHomeDataState extends AppStates {}

class ShopSuccessHomeDataState extends AppStates {}

class ShopErrorHomeDataState extends AppStates {}

class ShopSuccessCategoriesState extends AppStates {}

class ShopErrorCategoriesState extends AppStates {}

class ShopChangeFavoritesState extends AppStates {}

class ShopSuccessChangeFavoritesState extends AppStates
{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends AppStates {}

class ShopLoadingGetFavoritesState extends AppStates {}

class ShopSuccessGetFavoritesState extends AppStates {}

class ShopErrorGetFavoritesState extends AppStates {}

class ShopLoadingUserDataState extends AppStates {}

class ShopSuccessUserDataState extends AppStates
{
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends AppStates {}

class ShopLoadingUpdateUserState extends AppStates {}

class ShopSuccessUpdateUserState extends AppStates
{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends AppStates {}

class AppChangeModeState extends AppStates {}