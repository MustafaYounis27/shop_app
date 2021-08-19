import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/carts/carts_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: AppCubit.get(context).currentIndex != 3
                ? Text(
                    'My shop',
                  )
                : Text(
                    'Settings',
                  ),
            actions: [
              AppCubit.get(context).currentIndex != 3
                  ? IconButton(
                      icon: Icon(
                        Icons.search,
                      ),
                      onPressed: () {
                        navigateTo(
                          context,
                          SearchScreen(),
                        );
                      },
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.brightness_4_outlined,
                      ),
                      onPressed: () {
                        AppCubit.get(context).changeAppMode();
                      },
                    ),
            ],
          ),
          floatingActionButton: AppCubit.get(context).cartsModel != null && AppCubit.get(context).cartsModel.data.cartItems.length != 0 &&
                      AppCubit.get(context).currentIndex != 3
                  ? FloatingActionButton(
                      onPressed: () {
                        navigateTo(
                          context,
                          CartsScreen(),
                        );
                      },
                      child: Icon(
                        Icons.shopping_cart,
                      ),
                    )
                  : null,
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps,
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
