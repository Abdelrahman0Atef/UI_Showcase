part of '../product_details_imports.dart';

class ProductDetailsView extends StatefulWidget {
  final ApiProductModel product;

  const ProductDetailsView({required this.product, super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final ProductDetailsViewModel vm = ProductDetailsViewModel();
  late final GenericCubit<int> countCubit = vm.homeVM.getProductCounter(
    widget.product,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MyColors.white,
    appBar: AppBar(
      backgroundColor: MyColors.white,
      elevation: 0,
      title: CustomText(
        text: widget.product.title ?? '',
        textStyle: TextStyle(
          color: MyColors.black,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Center(
                child: Image.network(
                  widget.product.image ?? '',
                  height: 200.h,
                  fit: BoxFit.contain,
                ),
              ),
              GestureDetector(
                onTap: (){vm.shareProductImageWithDio(widget.product.image.toString());},
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: MyColors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Icon(Icons.share,color: MyColors.black,),
                ),
              ),
            ],
          ),
          20.verticalSpace,
          CustomText(
            text: widget.product.title ?? '',
            textStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: MyColors.navy,
            ),
          ),
          10.verticalSpace,
          CustomText(
            text:
                "${widget.product.price?.toStringAsFixed(2) ?? '0.00'} ${MyStrings.pound}",
            textStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              //color: MyColors.green,
            ),
          ),
          30.verticalSpace,
          CustomText(text: MyStrings.categories),
          15.verticalSpace,
          HomeOffersCard(
            isSelected: true,
            label: '${widget.product.category ?? ''}',
          ),
          30.verticalSpace,
          const HomeSplitTextRow(
            label: MyStrings.details,
            horizontalPadding: 0,
            color: MyColors.grey,
          ),
          15.verticalSpace,
          CustomText(
            text: widget.product.description ?? '',
            maxLines: 10,
            textAlign: TextAlign.start,
            textStyle: TextStyle(
              fontSize: 12.sp,
              color: MyColors.darkGrey,
              fontWeight: FontWeight.w700,
            ),
          ),
          30.verticalSpace,
          const CustomText(text: MyStrings.rate),
          15.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.r, horizontal: 8.r),
            child: Row(
              children: [
                CustomText(
                  text:
                      "${widget.product.rating?.rate?.toStringAsFixed(1) ?? '0.0'}",
                  textStyle: TextStyle(fontSize: 12.sp, color: MyColors.red),
                ),
                5.horizontalSpace,
                ProductRatingStars(
                  rating: widget.product.rating?.rate ?? 0.0,
                  size: 18.sp,
                ),
              ],
            ),
          ),
          30.verticalSpace,
          ProductDetailsOrderControl(
            vm: vm.homeVM,
            product: widget.product,
            countCubit: countCubit,
            onTap: () {},
          ),
          25.verticalSpace,
        ],
      ),
    ),
  );
}
