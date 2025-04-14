// Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled/core/services/local_storage_data/local_storage_data.dart';
import 'package:untitled/core/services/local_storage_data/setup_services.dart';
import 'package:untitled/views/sign_up/sign_up_imports.dart';
import 'package:untitled/widgets/widgets_imports.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/core/base/cubit/base_cubit.dart';
import 'package:untitled/core/helpers/validation_helper.dart';
import 'package:untitled/core/resources/my_strings.dart';
import 'package:untitled/core/base/cubit/base_state.dart';
import 'package:untitled/views/home/view/home_view.dart';
import 'package:untitled/core/resources/my_colors.dart';

// Sign-in feature imports
part 'view/sign_in_view.dart';
part 'viewmodel/sign_in_cubit.dart';
part 'viewmodel/sign_in_state.dart';
part 'widgets/sign_in_email_form.dart';
part 'widgets/sign_in_phone_form.dart';
part 'widgets/sign_in_body.dart';
part 'widgets/sign_in_toggle_button.dart';
