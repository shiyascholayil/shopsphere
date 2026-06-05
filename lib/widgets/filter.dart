import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopsphere/const.dart';
import 'package:shopsphere/riverpod/category_riverpod.dart';

class Filter extends ConsumerStatefulWidget {
  const Filter({super.key});

  @override
  ConsumerState<Filter> createState() => _FilterState();
}

class _FilterState extends ConsumerState<Filter> {

  String selectedCategory = "all";


  final List<String> categories = [
    "all",

    "beauty",

    "furniture",

    "home-decoration",

    "groceries",
  ];

  @override
  Widget build(BuildContext context) {
    final categoryProviderRef = ref.read(categoryProvider);

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: secondaryColor,

          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),

            topRight: Radius.circular(28),
          ),
        ),

        child: DraggableScrollableSheet(
          expand: false,

          initialChildSize: 0.65,

          minChildSize: 0.45,

          maxChildSize: 0.9,

          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),

              child: Column(
                children: [
                  const SizedBox(height: 10),

                  Container(
                    width: 55,

                    height: 5,

                    decoration: BoxDecoration(
                      color: greyShadeW300,

                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text("Filter Products", style: titleTextStyle),

                  const SizedBox(height: 6),

                  Text(
                    "Select category to refine your search",
                    style: subtitleTextStyle,
                  ),

                  const SizedBox(height: 18),

                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,

                      itemCount: categories.length,

                      itemBuilder: (context, index) {
                        final item = categories[index];

                        final bool isSelected = selectedCategory == item;

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),

                          margin: const EdgeInsets.only(bottom: 12),

                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : secondaryColor,

                            borderRadius: BorderRadius.circular(18),

                            border: Border.all(
                              color: isSelected ? primaryColor : borderColor,
                            ),

                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: primaryColor.withValues(
                                        alpha: 0.15,
                                      ),

                                      blurRadius: 12,

                                      offset: const Offset(0, 6),
                                    ),
                                  ]
                                : [],
                          ),

                          child: ListTile(
                            onTap: () {
                              setState(() {
                                selectedCategory = item;
                              });
                            },

                            leading: CircleAvatar(
                              backgroundColor: isSelected
                                  ? secondaryColor.withValues(alpha: 0.2)
                                  : primaryColor.withValues(alpha: 0.1),

                              child: Icon(
                                _getCategoryIcon(item),

                                color: isSelected
                                    ? secondaryColor
                                    : primaryColor,
                              ),
                            ),

                            title: Text(
                              item.replaceAll("-", " ").toUpperCase(),

                              style: isSelected
                                  ? selectedItemTextStyle
                                  : itemTextStyle,
                            ),

                            trailing: isSelected
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,

                    height: 52,

                    child: ElevatedButton(
                      onPressed: () async {
                        await categoryProviderRef.category(selectedCategory);

                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),

                        elevation: 0,
                      ),

                      child: Text("Apply Filter", style: buttonTextStyle),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "all":
        return Icons.apps_rounded;

      case "beauty":
        return Icons.spa_rounded;

      case "furniture":
        return Icons.chair_rounded;

      case "home-decoration":
        return Icons.home_rounded;

      case "groceries":
        return Icons.shopping_basket_rounded;

      default:
        return Icons.category_rounded;
    }
  }
}
