const String _imageBaseUrl =
    'https://backend.almasrypharmacy.com/pub/media/catalog/product';

class Product {
  final int? id;
  final String name;
  final String sku;
  final double? price;
  final String? imagePath;
  final String? stock_status;

  Product({
    required this.name, required this.sku, this.id,
    this.stock_status,
    this.price,
    this.imagePath,
  });

  String? get fullImageUrl =>
      imagePath != null ? '$_imageBaseUrl$imagePath' : null;

  factory Product.fromJson(Map<String, dynamic> json) {
    String? getImageUrl(List<dynamic>? attributes) {
      if (attributes == null) return null;
      try {
        final imageAttr = attributes.firstWhere(
          (attr) =>
              attr != null &&
              (attr['attribute_code'] == 'image' ||
                  attr['attribute_code'] == 'small_image' ||
                  attr['attribute_code'] == 'thumbnail'),
          orElse: () => null,
        );
        return imageAttr != null ? imageAttr['value'] : null;
      } catch (e) {
        print('Error parsing image attribute: $e');
        return null;
      }
    }

    return Product(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      sku: json['sku'] as String,
      price: (json['price'] as num?)?.toDouble(),
      imagePath: getImageUrl(json['custom_attributes'] as List<dynamic>?),
      stock_status: (json['extension_attributes']?['stock_status'])?.toString() ?? 'unknown',
    );
  }
}
