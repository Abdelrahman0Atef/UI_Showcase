import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:untitled/core/models/product_model/product_model.dart';
import 'package:untitled/core/resources/api_path.dart';
import 'package:untitled/core/resources/my_assets.dart';
import 'package:untitled/core/resources/my_strings.dart';
import 'package:untitled/core/services/locator_services/locator_services.dart';
import 'package:untitled/core/services/rest_api_services/rest_api_services.dart';
import 'package:flutter/material.dart';
import 'package:untitled/widgets/widgets_imports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/core/resources/my_colors.dart';

part 'view/product_list_view.dart';
part 'viewmodel/product_list_view_model.dart';
part 'widgets/error_indicator.dart';
part 'widgets/product_card.dart';