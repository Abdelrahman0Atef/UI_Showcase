import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:untitled/generated/locale_keys.g.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Center(child: Text(LocaleKeys.Auth_rememberMe.tr()),),
    );
}
