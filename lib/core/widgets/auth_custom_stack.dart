part of widgets;

class AuthCustomStack extends StatelessWidget {
  const AuthCustomStack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            Image.asset(
              MyAssets.kHalfCircle,
              opacity: AlwaysStoppedAnimation(0.7),
            ),
            Positioned(
              top: 85.h,
              left: 58.w,
              right: 39.w,
              child: Image.asset(
                MyAssets.kAlmasryLogo,
                width: 278.w,
                height: 89.h,
              ),
            ),
          ],
        ),
      ],
    );
  }
}