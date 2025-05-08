part of '../home_imports.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({required this.vm, super.key});

  final HomeViewModel vm;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      SearchField(
        controller: TextEditingController(),
        hasResults: false,
        onChanged: (_) {},
        onClear: () {},
        onTap: () {
          context.goNamed(MyRouts.search);
        },
      ),
      CustomImageSlider(viewModel: vm, imageUrls: vm.imageUrls),
    ],
  );
}
