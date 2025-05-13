import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/generic_cubit/generic_cubit.dart';
import 'package:untitled/core/models/product_model/api_product_model.dart';
import 'package:untitled/core/services/data_sources/data_sources.dart';
import 'package:untitled/views/categoriesProduct/categories_product_imports.dart';
import 'package:dio/dio.dart';
import 'package:untitled/widgets/products_grid_view.dart';
import '../../core/resources/my_colors.dart';

part 'view/product_view.dart';
part 'viewmodel/all_product_view_model.dart';