part of '../layout_imports.dart';

class LayoutViewModel {
  final GenericCubit<int> _pageCubit = GenericCubit(0);

  void _changeScreen(int index) {
    _pageCubit.onUpdateData(index);
  }
}
