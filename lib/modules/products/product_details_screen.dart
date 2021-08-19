import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/product_details_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        ProductDetailsModel model = AppCubit.get(context).productDetailsModel;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'My shop',
            ),
            actions: [
              if (model != null)
                IconButton(
                  onPressed: () {
                    AppCubit.get(context).changeFavorites(model.data.id);
                    print(model.data.id);
                  },
                  icon: CircleAvatar(
                    backgroundColor:
                        AppCubit.get(context).favorites[model.data.id]
                            ? defaultColor
                            : Colors.grey,
                    child: Icon(
                      Icons.favorite_border,
                      size: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              if (model != null)
                IconButton(
                  onPressed: ()
                  {
                    AppCubit.get(context).changeCart(model.data.id);
                  },
                  icon: CircleAvatar(
                    backgroundColor: AppCubit.get(context).carts[model.data.id]
                        ? defaultColor
                        : Colors.grey,
                    child: Icon(
                      Icons.shopping_cart,
                      size: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          body: ConditionalBuilder(
            condition: model != null,
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          CarouselSlider(
                            items: model.data.images
                                .map(
                                  (e) => Image(
                                    image: NetworkImage(e),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                )
                                .toList(),
                            options: CarouselOptions(
                              height: 300,
                              viewportFraction: 1.0,
                              enlargeCenterPage: false,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration: Duration(seconds: 1),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                          if (model.data.discount != 0)
                            Container(
                              color: Colors.red,
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.0,
                              ),
                              child: Text(
                                'DISCOUNT',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Name : ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontSize: 16.0),
                              ),
                              color: Colors.white,
                              padding: EdgeInsets.all(5.0),
                              width: 70.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  '${model.data.name}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(color: defaultColor),
                                ),
                                color: Colors.white,
                                padding: EdgeInsets.all(5.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 60.0,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Container(
                              child: Text(
                                'Price : ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontSize: 16.0),
                              ),
                              color: Colors.white,
                              padding: EdgeInsets.all(5.0),
                              width: 70.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Text(
                                      '${model.data.price}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(color: defaultColor),
                                    ),
                                    if (model.data.discount != 0)
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                    if (model.data.discount != 0)
                                      Text(
                                        '${model.data.oldPrice.round()}',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Info : ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontSize: 16.0),
                              ),
                              color: Colors.white,
                              padding: EdgeInsets.all(5.0),
                              width: 70.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  '${model.data.description}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(color: defaultColor),
                                ),
                                color: Colors.white,
                                padding: EdgeInsets.all(5.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
