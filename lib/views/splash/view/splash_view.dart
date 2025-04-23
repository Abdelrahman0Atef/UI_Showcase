import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/core/resources/my_assets.dart';
import 'package:untitled/core/resources/my_routs.dart';
import 'package:untitled/core/services/local_storage_data/local_storage_data.dart';
import 'package:untitled/core/services/locator_services/locator_services.dart';
import 'package:untitled/core/resources/shared_keys.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    Timer(const Duration(seconds: 2), () async {
      final storageService = getIt<LocalStorageService>();

      final isRegistered = storageService.getIsChecked(SharedKeys.isRegisteredUser) ?? false;

      if (isRegistered) {
        final fullName = storageService.getString(SharedKeys.userFullName) ?? '';
        final email = storageService.getString(SharedKeys.userEmail) ??
            storageService.getString(SharedKeys.email) ?? '';
        final phone = storageService.getString(SharedKeys.userPhone) ??
            storageService.getString(SharedKeys.phone) ?? '';

        context.goNamed(MyRouts.home, extra: {
          SharedKeys.isRegisteredUser: true,
          SharedKeys.userFullName: fullName,
          SharedKeys.userEmail: email,
          SharedKeys.email: email,
          SharedKeys.userPhone: phone,
          SharedKeys.phone: phone,
        });
        return;
      }

      final emailRememberMe = storageService.getIsChecked(SharedKeys.emailRememberMe) ?? false;
      final phoneRememberMe = storageService.getIsChecked(SharedKeys.phoneRememberMe) ?? false;

      if (emailRememberMe) {
        final email = storageService.getString(SharedKeys.email) ?? '';
        final password = storageService.getString(SharedKeys.password) ?? '';
        if (email.isNotEmpty && password.isNotEmpty) {
          context.goNamed(MyRouts.home, extra: {
            SharedKeys.email: email,
            SharedKeys.userEmail: email,
            SharedKeys.isRegisteredUser: false,
          });
          return;
        }
      }

      if (phoneRememberMe) {
        final phone = storageService.getString(SharedKeys.phone) ?? '';
        if (phone.isNotEmpty) {
          context.goNamed(MyRouts.home, extra: {
            SharedKeys.phone: phone,
            SharedKeys.userPhone: phone,
            SharedKeys.isRegisteredUser: false,
          });
          return;
        }
      }

      context.goNamed(MyRouts.signIn);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => Transform.scale(
          scale: _animation.value,
          child: child,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Image.asset(MyAssets.almasryLogo),
        ),
      ),
    ),
  );
}