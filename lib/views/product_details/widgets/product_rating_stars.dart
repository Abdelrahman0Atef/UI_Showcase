part of '../product_details_imports.dart';

class ProductRatingStars extends StatelessWidget {
  final double rating;
  final double size;

  const ProductRatingStars({required this.rating, this.size = 18, super.key});

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor();
    final hasHalfStar = (rating - fullStars) >= 0.5;
    final emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
    return Row(
      children: [
        for (int i = 0; i < fullStars; i++)
          Icon(Icons.star, color: MyColors.red, size: size),
        if (hasHalfStar) Icon(Icons.star_half, color: MyColors.red, size: size),
        for (int i = 0; i < emptyStars; i++)
          Icon(Icons.star_border, color: MyColors.grey, size: size),
      ],
    );
  }
}
