import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopsphere/const.dart';
import 'package:shopsphere/riverpod/category_riverpod.dart';

class Sort extends ConsumerStatefulWidget {
  const Sort({super.key});

  @override
  ConsumerState<Sort> createState() => _SortState();
}

class _SortState extends ConsumerState<Sort> {
  String? _currentSort;

  final List<String> options = [
    "A To Z",

    "Price (High → Low)",

    "Price (Low → High)",

    "Default",
  ];

  @override
  Widget build(BuildContext context) {
    final cateGory = ref.read(categoryProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Container(
              width: 60,
              height: 5,

              decoration: BoxDecoration(
                color: greyShadeW300,

                borderRadius: BorderRadius.circular(20),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Sort Products",

              style: filterSortTextStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ...options.map((e) {
              final isSelected = _currentSort == e;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),

                margin: const EdgeInsets.only(bottom: 12),

                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : secondaryColor,

                  borderRadius: BorderRadius.circular(18),

                  border: Border.all(
                    color: isSelected ? primaryColor : borderColor,

                    width: 1.3,
                  ),

                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: primaryColor.withValues(alpha: 00.15),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ]
                      : [],
                ),

                child: ListTile(
                  onTap: () {
                    setState(() {
                      _currentSort = e;
                    });
                  },

                  title: Text(
                    e,

                    style: isSelected
                        ? selectedSortTextStyle
                        : filterSortTextStyle,
                  ),

                  trailing: isSelected
                      ? Icon(Icons.check_circle, color: secondaryColor)
                      : null,
                ),
              );
            }),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton(
                onPressed: () {
                  cateGory.sort(_currentSort);

                  Navigator.pop(context);
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,

                  elevation: 0,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                child: Text("Apply", style: buttonTextStyles),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
