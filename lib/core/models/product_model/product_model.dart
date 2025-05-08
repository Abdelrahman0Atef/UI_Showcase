import 'package:untitled/core/generic_cubit/generic_cubit.dart';

class ProductModel {
  final String image;
  final String title;
  final double price;
  final int? points;
  final double? totalPrice;
  final GenericCubit<int> quantityCubit;

  ProductModel({
    required this.image,
    required this.title,
    required this.price,
    this.points,
    this.totalPrice,
  }) : quantityCubit = GenericCubit<int>(0);
}
