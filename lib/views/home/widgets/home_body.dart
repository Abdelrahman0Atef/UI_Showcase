part of '../home_imports.dart';

class HomeBody extends StatelessWidget {
  final BuildContext context;
  final HomeLoaded state;
  final VoidCallback onPressed;

  const HomeBody({
    required this.context, required this.state, required this.onPressed, super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with welcome message
          Center(
            child: Text(
              state.isRegisteredUser
                  ? MyStrings.welcomeRegisteredUser
                  : MyStrings.welcomeGeneric,
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          30.verticalSpace,
          if (state.isRegisteredUser && state.userFullName != null)
            _buildProfileItem(
              Icons.person,
              MyStrings.userName,
              state.userFullName!,
            ),
          if (state.isRegisteredUser && state.userEmail != null)
            _buildProfileItem(
              Icons.email,
              MyStrings.email,
              state.userEmail!,
            ),
          if (state.isRegisteredUser && state.userPhone != null)
            _buildProfileItem(
              Icons.phone,
              MyStrings.phone,
              state.userPhone!,
            ),
          if (!state.isRegisteredUser && state.userEmail != null)
            _buildProfileItem(
              Icons.email,
              MyStrings.userName,
              state.userEmail!,
            ),
          if (!state.isRegisteredUser && state.userPhone != null)
            _buildProfileItem(
              Icons.phone,
              MyStrings.signInWithPhoneNumber,
              state.userPhone!,
            ),
          Center(
            child: CustomButton(
              onPressed: onPressed,
              text: MyStrings.signOut,
              textColor: MyColors.myWhite,
              color: MyColors.myRed,
            ),
          ),
          16.verticalSpace,
        ],
      ),
    );

  Widget _buildProfileItem(IconData icon, String label, String value) => Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Row(
            children: [
              Icon(icon, color: MyColors.myRed),
              16.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(color: MyColors.myGrey, fontSize: 14.sp),
                  ),
                  16.verticalSpace,
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
}
