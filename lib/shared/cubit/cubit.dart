import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/address/get_address_model.dart';
import 'package:shop_app/models/cart/change_cart_model.dart';
import 'package:shop_app/models/cart/carts_model.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/category_details_model.dart';
import 'package:shop_app/models/favorites/change_favorites_model.dart';
import 'package:shop_app/models/favorites/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/product_details_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/cateogries/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;

    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel;

  Map<int, bool> favorites = {};

  Map<int, bool> carts = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      homeModel.data.products.forEach((element) {
        carts.addAll({
          element.id: element.inCart,
        });
      });
      print(carts.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId];

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if (!changeFavoritesModel.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId];

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ChageCartModel changeCartModel;

  void changeCart(int productId) {
    carts[productId] = !carts[productId];

    emit(ShopChangeCartState());

    DioHelper.postData(
      url: CART,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeCartModel = ChageCartModel.fromJson(value.data);
      print(changeCartModel.data.id);
      print(changeCartModel.message);

      if (!changeCartModel.status) {
        carts[productId] = !carts[productId];
      } else {
        getCarts();
      }

      emit(ShopSuccessChangeCartState());
    }).catchError((error) {
      carts[productId] = !carts[productId];

      emit(ShopErrorChangeCartState());
    });
  }

  CartsModel cartsModel;

  void getCarts() {
    emit(ShopLoadingGetCartsState());

    DioHelper.getData(
      url: CART,
      token: token,
    ).then((value) {
      cartsModel = CartsModel.fromJson(value.data);
      print(cartsModel.data.total);

      emit(ShopSuccessGetCartsState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetCartsState());
    });
  }

  void changeQuantity(int id, int quantity) {
    emit(ShopLoadingChangeQuantityState());

    DioHelper.putData(
      url: '$CART/$id',
      data: {
        'quantity': quantity,
      },
      token: token,
    ).then((value) {
      emit(ShopSuccessChangeQuantityState());
      getCarts();
    }).catchError(((error) {
      print(error);
      emit(ShopErrorChangeQuantityState());
    }));
  }

  GetAddressModel addressModel;

  void getAddress()
  {
    emit(ShopLoadingGetAddressState());

    DioHelper.getData(
      url: ADDRESS,
      token: token,
    ).then((value) {
      addressModel = GetAddressModel.fromJson(value.data);
      emit(ShopSuccessGetAddressState());
    }).catchError((error){
      print(error);
      emit(ShopErrorGetAddressState());
    });
  }

  void addOrder(int addressId)
  {
    emit(ShopLoadingAddOrderState());
    DioHelper.postData(
      url: ORDER,
      token: token,
      data: {
      'address_id' : addressId,
      'payment_method' : 1,
      'use_points' : false,
    },).then((value)
    {
      print(value.statusMessage);
      getCarts();
      emit(ShopSuccessAddOrderState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorAddOrderState());
    });
  }

  ShopLoginModel userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel.data.name);

      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel.data.name);

      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }

  bool isDark = true;

  void changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  ProductDetailsModel productDetailsModel;

  getProductDetails({int id, bool isSearch = true}) {
    productDetailsModel = null;

    if (isSearch)
      emit(ShopLoadingGetProductDetailsState());
    else
      emit(ShopLoadingFromSearchGetProductDetailsState());

    DioHelper.getData(
      url: 'products/$id',
      token: token,
    ).then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      print(productDetailsModel.data.name);
      emit(ShopSuccessGetProductDetailsState());
    }).catchError((error) {
      emit(ShopErrorGetProductDetailsState());
    });
  }

  CategoryDetailsModel categoryDetailsModel;

  getCategoryDetails(int id, String name) {
    categoryDetailsModel = null;

    emit(ShopLoadingGetCategoryDetailsState());

    DioHelper.getData(
      url: 'categories/$id',
      token: token,
    ).then((value) {
      categoryDetailsModel = CategoryDetailsModel.fromJson(value.data);

      emit(ShopSuccessGetCategoryDetailsState(name));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetCategoryDetailsState());
    });
  }

  SearchModel model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
