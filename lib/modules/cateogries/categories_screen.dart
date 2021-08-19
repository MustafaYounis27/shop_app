import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import 'category_details_screen.dart';

class CategoriesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state)
      {
        if (state is ShopLoadingGetCategoryDetailsState) {
          navigateTo(context, CategoryDetailsScreen());
        }
      },
      builder: (context, state)
      {
        return ListView.separated(
          itemBuilder: (context, index) => buildCatItem(AppCubit.get(context).categoriesModel.data.data[index], context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: AppCubit.get(context).categoriesModel.data.data.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel model, context) => InkWell(
    onTap: ()
    {
      AppCubit.get(context).getCategoryDetails(model.id, model.name);
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children:
        [
          Image(
            image: NetworkImage(model.image),
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            model.name,
            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 20.0),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: AppCubit.get(context).isDark ? Colors.black : Colors.white,
          ),
        ],
      ),
    ),
  );
}