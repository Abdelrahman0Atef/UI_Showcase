import 'package:untitled/core/constants/imports.dart';

class CustomStack extends StatelessWidget {
  const CustomStack({
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
              kCirclePic,
              opacity: AlwaysStoppedAnimation(0.7),
            ),
            Positioned(
              top: 85.h,
              left: 58.w,
              right: 39.w,
              child: Image.asset(
                kLogo,
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