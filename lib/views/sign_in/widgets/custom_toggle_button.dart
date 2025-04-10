import 'package:untitled/core/constants/imports.dart';

class CustomToggleButton extends StatelessWidget {
  final SignInInitial currentState;
  final SignInCubit cubit;

  const CustomToggleButton({super.key, required this.currentState, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color(0x5A5A5A1A),
                offset: Offset(0, 1),
                blurRadius: 8.0,
              ),
            ],
          ),
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  cubit.toggleLogInMethod(0);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: currentState.selectedIndex == 0 ? Colors.red : Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: CustomText(
                    label: kPhoneLogIn,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: currentState.selectedIndex == 0 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  cubit.toggleLogInMethod(1);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: currentState.selectedIndex == 1 ? Colors.red : Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: CustomText(
                    label: kUserNameLogIn,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: currentState.selectedIndex == 1 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        16.verticalSpace,
        SignInBody(currentState: currentState, cubit: cubit),
      ],
    );
  }
}