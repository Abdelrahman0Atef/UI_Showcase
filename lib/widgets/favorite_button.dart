part of '../widgets/widgets_imports.dart';

class FavoriteButton extends StatelessWidget {
  final ApiProductModel product;
  final WishListViewModel vm;

  const FavoriteButton({required this.product, required this.vm, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<GenericCubit<Map<int, bool>>, GenericState<Map<int, bool>>>(
      bloc: vm.favoritesMapCubit,
      builder: (context, state) {
        final isFavorite = state.data[product.id] ?? false;

        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? MyColors.red : null,
          ),
          onPressed: () async {
            await vm.toggleFavorite(product);
          },
        );
      },
    );
}

