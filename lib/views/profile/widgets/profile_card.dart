part of '../profile_imports.dart';

class ProfileCustomDataCard extends StatelessWidget {
  const ProfileCustomDataCard({required this.vm, super.key});

  final ProfileViewModel vm;

  @override
  Widget build(BuildContext context) => Card(
    color: MyColors.white,
    elevation: 2,
    child: ExpansionTile(
      initiallyExpanded: true,
      shape: const Border(),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: MyStrings.croCo),
          BlocBuilder<GenericCubit<String?>, GenericState<String?>>(
            bloc: vm._emailCubit,
            builder: (context, state) {
              if (state is GenericUpdateState<String?>) {
                return CustomText(
                  text: state.data ?? MyStrings.email,
                  textStyle: const TextStyle(
                    color: MyColors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      children: [
        Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: MyStrings.firstName),
                  BlocBuilder<GenericCubit<String?>, GenericState<String?>>(
                    bloc: vm._firstNameCubit,
                    builder: (context, state) {
                      if (state is GenericUpdateState<String?>) {
                        return CustomText(
                          text: state.data ?? MyStrings.firstName,
                          textStyle: const TextStyle(
                            color: MyColors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: MyStrings.lastName),
                  BlocBuilder<GenericCubit<String?>, GenericState<String?>>(
                    bloc: vm._lastNameCubit,
                    builder: (context, state) {
                      if (state is GenericUpdateState<String?>) {
                        return CustomText(
                          text: state.data ?? MyStrings.lastName,
                          textStyle: const TextStyle(
                            color: MyColors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: MyStrings.phoneNumber),
                  BlocBuilder<GenericCubit<String?>, GenericState<String?>>(
                    bloc: vm._phoneCubit,
                    builder: (context, state) {
                      if (state is GenericUpdateState<String?>) {
                        return CustomText(
                          text: state.data ?? MyStrings.phoneNumber,
                          textStyle: const TextStyle(
                            color: MyColors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: MyStrings.gender),
                  CustomText(
                    text: MyStrings.male,
                    textStyle: const TextStyle(
                      color: MyColors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: MyStrings.birthDate),
                  CustomText(
                    text: MyStrings.date,
                    textStyle: const TextStyle(
                      color: MyColors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: MyStrings.isThereChronicDisease),
                  CustomText(
                    text: MyStrings.no,
                    textStyle: const TextStyle(
                      color: MyColors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
