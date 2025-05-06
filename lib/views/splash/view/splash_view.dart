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
  late final SplashViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = SplashViewModel(context);
    _viewModel.handleNavigation();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
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
