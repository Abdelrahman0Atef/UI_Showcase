part of '../search_imports.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final bool hasResults;
  final ValueChanged<String> onChanged;
  final VoidCallback onTap;
  final VoidCallback onClear;
  final bool? isHome;

  const SearchField({
    required this.controller,
    required this.hasResults,
    required this.onChanged,
    required this.onTap,
    required this.onClear,
    this.isHome = false, super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(8.r),
    child: Row(
      children: [
        isHome == true ? IconButton(
          icon: const Icon(Icons.arrow_back, color: MyColors.darkGrayish),
          onPressed: () {
            context.pushReplacementNamed(MyRouts.home);
          },
        ) : const SizedBox.shrink(),
        Expanded(
          child: TextField(
            autofocus: isHome == true ? true : false,
            onTap: onTap,
            controller: controller,
            decoration: InputDecoration(
              hintText: MyStrings.search,
              hintStyle: const TextStyle(color: MyColors.darkGrayish),
              prefixIcon: const Icon(Icons.search, color: MyColors.darkGrayish),
              suffixIcon:
                  hasResults
                      ? GestureDetector(
                        onTap: onClear,
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
