part of '../layout_imports.dart';

class LayoutView extends StatelessWidget {
  final StatefulNavigationShell shell;
  final LayoutViewModel vm = LayoutViewModel();

  LayoutView({required this.shell, super.key});

  @override
  Widget build(BuildContext context) {
    final index = shell.currentIndex;
    final fullLocation = GoRouterState.of(context).fullPath ?? '';
    final isMainTab = vm.isMainTab(fullLocation);
    final title = vm.getAppBarTitle(index);
    final _ = context.locale;

    return Scaffold(
      appBar:
          isMainTab
              ? AppBar(
                centerTitle: true,
                title: Text(title, style: const TextStyle(color: Colors.black)),
                backgroundColor: Colors.white,
                elevation: 1,
                foregroundColor: Colors.black,
              )
              : null,
      body: shell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (newIndex) {
          if (newIndex == index) {
            shell.goBranch(newIndex, initialLocation: true);
          } else {
            shell.goBranch(newIndex);
          }
        },
        selectedItemColor: MyColors.red,
        unselectedItemColor: MyColors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: MyStrings.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.manage_search),
            label: MyStrings.categories,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.inventory),
            label: MyStrings.products,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart),
            label: MyStrings.cart,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: MyStrings.profile,
          ),
        ],
      ),
    );
  }
}
