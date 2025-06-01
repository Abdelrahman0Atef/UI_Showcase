part of '../product_list_imports.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final placeHolderPic = MyAssets.almasryLogo;
    final imageUrl = product.fullImageUrl ?? placeHolderPic;

    return Container(
      width: 161.w,
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.darkWhite),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.fill,
              loadingBuilder: (
                BuildContext context,
                Widget child,
                ImageChunkEvent? loadingProgress,
              ) {
                if (loadingProgress == null) return child;
                return Container(
                  color: MyColors.grey,
                  child: Center(
                    child: CircularProgressIndicator.adaptive(
                      value:
                          loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                    ),
                  ),
                );
              },
              errorBuilder:
                  (
                    BuildContext context,
                    Object exception,
                    StackTrace? stackTrace,
                  ) => Image.asset(placeHolderPic, fit: BoxFit.fill),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  textAlign: TextAlign.start,
                  text: product.name,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: MyColors.black,
                  ),
                ),
                4.verticalSpace,
                CustomText(
                  text: '${product.price.toString()} ${MyStrings.lE}',
                  textStyle: TextStyle(
                    fontSize: 12.sp,
                    color: MyColors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                4.verticalSpace,
                CustomText(
                  text: '${MyStrings.sku}: ${product.sku}',
                  textStyle: TextStyle(fontSize: 10.sp, color: MyColors.grey),
                ),
                CustomText(
                  text: '${MyStrings.outOfStock}',
                  textStyle: TextStyle(
                    fontSize: 10.sp,
                    color: MyColors.red
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
