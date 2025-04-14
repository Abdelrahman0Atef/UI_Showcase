library sign_in;

// Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/core/base_cubit.dart';
import 'package:untitled/core/base_state.dart';
import 'package:untitled/core/helpers/validation_helper.dart';
import 'package:untitled/core/resources/my_colors.dart';
import 'package:untitled/core/resources/my_strings.dart';
import 'package:untitled/core/widgets/widgets_imports.dart';
import 'package:untitled/views/home/view/home_view.dart';
import 'package:untitled/views/sign_up/sign_up_imports.dart';

// Sign-in feature imports
part 'view/sign_in_view.dart';
part 'viewmodel/sign_in_cubit.dart';
part 'viewmodel/sign_in_state.dart';
part 'widgets/sign_in_body.dart';
part 'widgets/sign_in_toggle_button.dart';
part '../../core/widgets/auth_text_button.dart';
part 'widgets/sign_in_email_form.dart';
part 'widgets/sign_in_phone_form.dart';