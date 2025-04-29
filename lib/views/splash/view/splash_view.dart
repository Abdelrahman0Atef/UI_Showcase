part of '../splash_imports.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    Timer(const Duration(seconds: 2), () async {
      final storageService = getIt<LocalStorageService>();

      final isRegistered = storageService.getIsChecked(SharedKeys.isRegisteredUser,);
      final isPhoneRememberMe = storageService.getIsChecked(SharedKeys.phoneRememberMe);


      if (isRegistered == true && isPhoneRememberMe == true) {
        context.goNamed(MyRouts.home);
      } else {
        context.goNamed(MyRouts.signIn);
      }
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
        builder:
            (context, child) =>
                Transform.scale(scale: _animation.value, child: child),
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Image.asset(MyAssets.almasryLogo),
        ),
      ),
    ),
  );
}
