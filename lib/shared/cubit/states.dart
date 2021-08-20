import 'package:shop_app/models/favorites/change_favorites_model.dart';
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

class ShopChangeCartState extends AppStates {}

class ShopSuccessChangeCartState extends AppStates {}

class ShopErrorChangeCartState extends AppStates {}

class ShopLoadingGetCartsState extends AppStates {}

class ShopSuccessGetCartsState extends AppStates {}

class ShopErrorGetCartsState extends AppStates {}

class ShopLoadingChangeQuantityState extends AppStates {}

class ShopSuccessChangeQuantityState extends AppStates {}

class ShopErrorChangeQuantityState extends AppStates {}

class ShopLoadingGetAddressState extends AppStates {}

class ShopSuccessGetAddressState extends AppStates {}

class ShopErrorGetAddressState extends AppStates {}

class ShopLoadingAddAddressState extends AppStates {}

class ShopSuccessAddAddressState extends AppStates {}

class ShopErrorAddAddressState extends AppStates {}

class ShopLoadingUpdateAddressState extends AppStates {}

class ShopSuccessUpdateAddressState extends AppStates {}

class ShopErrorUpdateAddressState extends AppStates {}

class ShopLoadingAddOrderState extends AppStates {}

class ShopSuccessAddOrderState extends AppStates {}

class ShopErrorAddOrderState extends AppStates {}

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

class ShopLoadingGetProductDetailsState extends AppStates {}

class ShopLoadingFromSearchGetProductDetailsState extends AppStates {}

class ShopSuccessGetProductDetailsState extends AppStates {}

class ShopErrorGetProductDetailsState extends AppStates {}

class ShopLoadingGetCategoryDetailsState extends AppStates {}

class ShopSuccessGetCategoryDetailsState extends AppStates
{
  final String name;

  ShopSuccessGetCategoryDetailsState(this.name);
}

class ShopErrorGetCategoryDetailsState extends AppStates {}

class SearchLoadingState extends AppStates {}

class SearchSuccessState extends AppStates {}

class SearchErrorState extends AppStates {}

class ShopSuccessBannersState extends AppStates {}

class ShopErrorBannersState extends AppStates {}