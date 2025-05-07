part of '../home_imports.dart';

class HomeSearch extends StatelessWidget {
  final TextEditingController controller;
  final bool hasResults;
  final ValueChanged<String> onChanged;
  final VoidCallback onTap;

  const HomeSearch({
    required this.controller,
    required this.hasResults,
    required this.onChanged,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(8.r),
    child: Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: MyColors.darkGrayish),
          onPressed: () {
            context.pushReplacementNamed(MyRouts.home);
          },
        ),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: MyStrings.search,
              hintStyle: const TextStyle(color: MyColors.darkGrayish),
              prefixIcon: const Icon(Icons.search, color: MyColors.darkGrayish),
              suffixIcon:
                  hasResults
                      ? GestureDetector(
                        onTap: onTap,
                        child: const Icon(
                          Icons.close,
                          color: MyColors.darkGrayish,
                        ),
                      )
                      : null,
              filled: true,
              fillColor: MyColors.darkWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.r),
            ),
            onChanged: onChanged,
          ),
        ),
        IconButton(icon: const Icon(Icons.image_search), onPressed: () {}),
      ],
    ),
  );
}
