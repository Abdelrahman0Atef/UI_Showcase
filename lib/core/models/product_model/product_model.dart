class ProductModel {
  final String image;
  final String title;
  final double price;
  final int? points;
  final double? totalPrice;

  ProductModel({
    required this.image,
    required this.title,
    required this.price,
    this.points,
    this.totalPrice,
  });
}
