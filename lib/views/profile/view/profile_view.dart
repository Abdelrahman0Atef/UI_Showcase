part of '../profile_imports.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileViewModel vm = ProfileViewModel();

  @override
  void initState() {
    super.initState();
    vm._init();
  }

  @override
  Widget build(BuildContext context) => Container(color: MyColors.white,child: ProfileBody(viewModel: vm));
}