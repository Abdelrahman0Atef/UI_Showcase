import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/core/resources/my_routs.dart';
import 'package:untitled/core/resources/my_strings.dart';
import 'package:untitled/views/home/viewmodel/home_state.dart';
import 'package:untitled/core/resources/shared_keys.dart';
import 'package:untitled/core/services/local_storage_data/local_storage_data.dart';
import 'package:untitled/core/services/local_storage_data/setup_services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/core/resources/my_colors.dart';
import 'package:untitled/widgets/widgets_imports.dart';

part 'view/home_view.dart';
part 'viewmodel/home_cubit.dart';
part 'widgets/home_body.dart';