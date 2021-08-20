import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/address/address_model.dart';
import 'package:shop_app/models/cart/carts_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/widgets/custom_show_dialog.dart';

class CartsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state)
      {
        if (state is ShopSuccessAddOrderState)
        {
          Navigator.pop(context);
          showToast(text: 'your order added successfully', state: ToastStates.SUCCESS,);
        }

        if (state is ShopErrorAddOrderState)
        {
          showToast(text: 'an error happened !!!', state: ToastStates.ERROR,);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Shopping Cart',
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! ShopLoadingChangeQuantityState,
            builder: (context) => AppCubit.get(context).cartsModel.data.cartItems.length != 0 ? Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildCartItem(context,
                        AppCubit.get(context).cartsModel.data.cartItems[index]),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount:
                        AppCubit.get(context).cartsModel.data.cartItems.length,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '${AppCubit.get(context).cartsModel.data.total} \$',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontSize: 24),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: defaultButton(
                            radius: 15,
                            function: () {
                              AppCubit.get(context).getAddress();
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    buildLocationDialog(context),
                              );
                            },
                            text: 'buy all',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ) :
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  [
                    CircleAvatar(
                      radius: 40.0,
                      backgroundColor: defaultColor,
                      child: Icon(
                        Icons.face_unlock_sharp,
                        size: 40.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Unfortunately, Shopping Cart is empty now !',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(color: defaultColor),
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildCartItem(context, CartItem cartItem) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 20.0,
        ),
        child: Container(
          height: 150,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(
                  cartItem.product.image,
                ),
                height: 150.0,
                width: 150.0,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      cartItem.product.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 16.0),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            AppCubit.get(context).changeQuantity(
                                cartItem.id, cartItem.quantity + 1);
                          },
                          child: CircleAvatar(
                            child: Text(
                              '+',
                              style: TextStyle(fontSize: 25.0),
                            ),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Text(
                          '${cartItem.quantity}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        InkWell(
                          onTap: () {
                            if (cartItem.quantity > 1)
                              AppCubit.get(context).changeQuantity(
                                  cartItem.id, cartItem.quantity - 1);
                            else
                              showToast(
                                text: '1 is minimum',
                                state: ToastStates.WARNING,
                              );
                          },
                          child: CircleAvatar(
                            child: Text(
                              '-',
                              style: TextStyle(fontSize: 35.0),
                            ),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                            '${cartItem.quantity * cartItem.product.price} \$'),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () 
                            {
                              AppCubit.get(context).changeCart(cartItem.product.id);
                            },
                            child: Text(
                              'Cancel',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildLocationDialog(context) => CustomAlertDialog(
        title: Text(
          'Choose your location',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: defaultColor),
        ),
        content: ConditionalBuilder(
          condition: AppCubit.get(context).addressModel != null,
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height / 4,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildLocationItem(
                  context, AppCubit.get(context).addressModel.data.data[index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: AppCubit.get(context).addressModel.data.data.length,
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        ),
        actions: [
          defaultTextButton(
            function: ()
            {
              print('add location');
            },
            text: 'Add Location',
            isUppercase: false,
          ),
        ],
      );

  Widget buildLocationItem(context, AddressData model) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: ()
          {
            AppCubit.get(context).addOrder(model.id);
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on,
                  color: defaultColor,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Text(
                    model.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
