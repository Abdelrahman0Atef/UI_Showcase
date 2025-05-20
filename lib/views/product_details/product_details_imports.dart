import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/core/generic_cubit/generic_cubit.dart';
import 'package:untitled/core/models/api_product_model/api_product_model.dart';
import 'package:untitled/core/resources/my_colors.dart';
import 'package:untitled/core/resources/my_strings.dart';
import 'package:untitled/core/services/locator_services/locator_services.dart';
import 'package:untitled/core/services/rest_api_services/rest_api_services.dart';
import 'package:untitled/views/categories_product/categories_product_imports.dart';
import 'package:untitled/views/home/home_imports.dart';
import 'package:untitled/views/wish_list/wish_list_imports.dart';
import 'package:untitled/widgets/widgets_imports.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/views/search/search_imports.dart';

part 'view/product_details.dart';

part 'widgets/product_rating_stars.dart';

part 'widgets/product_details_order_control.dart';

part 'viewmodel/product_details_view_model.dart';
