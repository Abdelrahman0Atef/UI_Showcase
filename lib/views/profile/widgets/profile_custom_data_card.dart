part of '../profile_imports.dart';

class ProfileCustomDataCard extends StatelessWidget {
  final String? phoneNumber;

  const ProfileCustomDataCard({super.key, this.phoneNumber});

  @override
  Widget build(BuildContext context) => BlocBuilder<ProfileCubit, ProfileState>(
    builder: (context, state) => Card(
        color: MyColors.white,
        elevation: 2,
        child: ExpansionTile(
          initiallyExpanded: true,
          shape: const Border(),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               CustomText(text: MyStrings.croCo),
              CustomText(
                text: MyStrings.support,
                textStyle: TextStyle(
                  color: MyColors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          children: [
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (phoneNumber != null && phoneNumber!.trim().isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(text: MyStrings.phoneNumber),
                        CustomText(
                          text: phoneNumber!,
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
                      CustomText(text: MyStrings.gender),
                      const CustomText(
                        text: MyStrings.male,
                        textStyle: TextStyle(
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
                      const CustomText(
                        text: MyStrings.date,
                        textStyle: TextStyle(
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
      ),
  );
}