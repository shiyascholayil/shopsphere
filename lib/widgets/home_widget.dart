import 'package:flutter/material.dart';
import 'package:shopsphere/const.dart';
import 'package:shopsphere/riverpod/category_riverpod.dart';
import 'package:shopsphere/widgets/content.dart';
import 'package:shopsphere/widgets/filter.dart';
import 'package:shopsphere/widgets/loading_widget.dart';
import 'package:shopsphere/widgets/sort.dart';

class HomeWidget extends StatelessWidget {
  final CategoryProvider catoGoryProvider;
  final VoidCallback onOpened;

  const HomeWidget({
    super.key,
    required this.catoGoryProvider,
    required this.onOpened,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyBackground,

      body: SafeArea(
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: secondaryColor,
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () => _openFilter(context),
                      icon: Image.asset(
                        'assets/images/filter.png',
                        width: 22,
                        height: 22,
                        color: greyDarkColor,
                      ),
                    ),
                  ),

                   Text(
                    "ShopSphere",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () => _openSortOptions(context),
                      icon:  Icon(
                        Icons.sort,
                        color: greyDarkColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: catoGoryProvider.isLoading
                  ? const LoadingWidget(message: "Loading")
                  : Content(oPened: onOpened),
            ),
          ],
        ),
      ),
    );
  }

  void _openFilter(BuildContext context) {
    onOpened();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const Filter(),
    );
  }

  void _openSortOptions(BuildContext context) {
    onOpened();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const Sort(),
    );
  }
}