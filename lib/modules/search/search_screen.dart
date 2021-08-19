import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/products/product_details_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state)
      {
        if(state is ShopLoadingFromSearchGetProductDetailsState)
        {
          Navigator.pop(context);
          navigateTo(context, ProductDetailsScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'enter text to search';
                      }
                      return null;
                    },
                    onSubmit: (String text) {
                      AppCubit.get(context).search(text);
                    },
                    label: 'Search',
                    prefix: Icons.search,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (state is SearchLoadingState) LinearProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildListProduct(
                          AppCubit.get(context).model.data.data[index],
                          context,
                          isOldPrice: false,
                        ),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount:
                        AppCubit.get(context).model.data.data.length,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}