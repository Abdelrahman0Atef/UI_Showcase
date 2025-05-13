import 'package:untitled/core/generic_cubit/generic_cubit.dart';
import 'package:untitled/core/models/product_model/api_product_model.dart';
import 'package:untitled/core/resources/my_colors.dart';
import 'package:untitled/core/services/data_sources/data_sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:untitled/views/search/search_imports.dart';
import 'package:untitled/widgets/products_grid_view.dart';
import 'package:untitled/widgets/widgets_imports.dart';
import '../../core/resources/my_strings.dart';


part 'viewmodel/categories_product_view_model.dart';
part 'view/categories_product_view.dart';