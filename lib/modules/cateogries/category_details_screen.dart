import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_details_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class CategoryDetailsScreen extends StatelessWidget
{
  String name;

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state)
      {
        if(state is ShopSuccessGetCategoryDetailsState)
          name = state.name;
      },
      builder: (context, state)
      {
        CategoryDetailsModel model = AppCubit.get(context).categoryDetailsModel;
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            title: Text(
              name??'',
            ),
          ),
          body: ConditionalBuilder(
            condition: AppCubit.get(context).categoryDetailsModel != null,
            builder: (context) => Container(
              color: Colors.grey[300],
              child: AppCubit.get(context).categoryDetailsModel.data.data.length != 0 ? Container(
                child: GridView.count(
                  physics: BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: 1 / 1.58,
                  children: List.generate(
                    model.data.data.length,
                        (index) =>
                        buildGridProduct(model.data.data[index], context),
                  ),
                ),
              ) : Container(
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
                        'Unfortunately, $name is empty now !',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(color: defaultColor),
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

  Widget buildGridProduct(Product model, context) => InkWell(
    onTap: () {
      AppCubit.get(context).getProductDetails(id: model.id);
    },
    child: Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 170.0,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        AppCubit.get(context).changeFavorites(model.id);
                        print(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: AppCubit.get(context).favorites[model.id] != null && AppCubit.get(context).favorites[model.id]
                            ? defaultColor
                            : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color: Colors.white,
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
}
