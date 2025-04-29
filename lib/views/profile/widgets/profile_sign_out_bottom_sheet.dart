part of '../profile_imports.dart';

class ProfileSignOutBottomSheet extends StatelessWidget {
  const ProfileSignOutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(text: MyStrings.signOutConfirmation),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: CustomButton(
                  color: MyColors.red,
                  textColor: MyColors.white,
                  text: MyStrings.yes,
                  onPressed: () {
                    context.read<ProfileCubit>().signOut().then((_) {
                      context.goNamed(MyRouts.signIn);
                    });
                  },
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: CustomButton(
                  color: MyColors.grey.withOpacity(0.2),
                  textColor: MyColors.black,
                  text: MyStrings.no,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
}
