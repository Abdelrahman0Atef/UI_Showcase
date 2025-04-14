library sign_up;

// Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/core/base_cubit.dart';
import 'package:untitled/core/widgets/widgets_imports.dart';
import 'package:untitled/views/sign_in/sign_in_imports.dart';
import '../../../core/resources/my_strings.dart';
import 'package:untitled/core/helpers/validation_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/base_state.dart';
import 'package:untitled/views/home/view/home_view.dart';

// Sign-up feature imports
part 'view/sign_up_view.dart';
part 'viewmodel/sign_up_cubit.dart';
part 'viewmodel/sign_up_state.dart';
part 'widgets/sign_up_validation_password.dart';
part 'widgets/sign_up_fields.dart';