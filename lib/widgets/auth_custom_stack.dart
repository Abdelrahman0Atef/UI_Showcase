part of 'widgets_imports.dart';

class AuthCustomStack extends StatelessWidget {
  const AuthCustomStack({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              MyAssets.halfCircle,
              opacity: const AlwaysStoppedAnimation(0.7),
            ),
          ),
          Positioned(
            top: 85.h,
            left: 58.w,
            right: 39.w,
            child: Image.asset(
              MyAssets.almasryLogo,
              width: 278.w,
              height: 89.h,
            ),
          ),
        ],
      ),
    ],
  );
}
