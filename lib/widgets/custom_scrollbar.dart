part of '../widgets/widgets_imports.dart';

class CustomScrollbar extends StatelessWidget {
  const CustomScrollbar({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      Scrollbar(thickness: 5, radius: Radius.circular(20.r), child: child);
}
