import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/generic_cubit/generic_cubit.dart';
import 'package:untitled/core/models/api_product_model/api_product_model.dart';
import 'package:untitled/core/resources/my_colors.dart';
import 'package:untitled/views/wish_list/wish_list_imports.dart';

class FavoriteButton extends StatelessWidget {
  final ApiProductModel product;
  final WishListViewModel vm;

  const FavoriteButton({required this.product, required this.vm, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<GenericCubit<Map<int, bool>>, GenericState<Map<int, bool>>>(
      bloc: vm.favoritesMapCubit,
      builder: (context, state) {
        final isFav = state.data[product.id] ?? false;

        return IconButton(
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav ? MyColors.red : null,
          ),
          onPressed: () async {
            await vm.toggleFavorite(product);
          },
        );
      },
    );
}

