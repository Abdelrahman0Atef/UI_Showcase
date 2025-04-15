// Flutter imports
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/core/helpers/validation_helper.dart';
import 'package:untitled/generated/locale_keys.g.dart';
import 'package:untitled/widgets/widgets_imports.dart';
import 'package:untitled/core/base/cubit/base_cubit.dart';
import 'package:untitled/core/base/cubit/base_state.dart';

// Sign-up feature imports
part 'view/sign_up_view.dart';
part 'viewmodel/sign_up_state.dart';
part 'viewmodel/sign_up_cubit.dart';
part 'widgets/sign_up_validation_password.dart';
part 'widgets/sign_up_fields.dart';
part 'widgets/sign_up_buttons.dart';