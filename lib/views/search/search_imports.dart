import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/core/models/api_product_model/api_product_model.dart';
import 'package:untitled/core/models/home_model/home_model.dart';
import 'package:untitled/core/resources/my_assets.dart';
import 'package:untitled/core/resources/my_routs.dart';
import 'package:untitled/core/resources/my_strings.dart';
import 'package:untitled/core/services/locator_services/locator_services.dart';
import 'package:untitled/core/services/rest_api_services/rest_api_services.dart';
import 'package:untitled/views/categories_product/categories_product_imports.dart';
import 'package:untitled/widgets/widgets_imports.dart';
import '../../core/generic_cubit/generic_cubit.dart';
import 'package:untitled/core/resources/my_colors.dart';

part 'view/search_view.dart';

part 'viewmodel/search_view_model.dart';

part 'widgets/product_icon_button.dart';

part '../../widgets/product_item_widget.dart';

part 'widgets/search_field.dart';

part 'widgets/search_body.dart';
