import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/core/generic_cubit/generic_cubit.dart';
import 'package:untitled/core/models/api_product_model/api_product_model.dart';
import 'package:untitled/core/resources/my_assets.dart';
import 'package:untitled/core/resources/my_colors.dart';
import 'package:untitled/core/resources/my_routs.dart';
import 'package:untitled/core/resources/my_strings.dart';
import 'package:untitled/core/services/locator_services/locator_services.dart';
import 'package:untitled/views/categorie/categorie_imports.dart';
import 'package:untitled/views/search/search_imports.dart';
import 'package:untitled/widgets/widgets_imports.dart';

part 'view/home_view.dart';

part 'widgets/home_body.dart';

part 'widgets/home_slider.dart';

part 'widgets/home_offers_card.dart';

part '../../widgets/split_text_row.dart';

part 'widgets/home_split_card.dart';

part 'widgets/home_info_card.dart';

part 'viewmodel/home_view_model.dart';
