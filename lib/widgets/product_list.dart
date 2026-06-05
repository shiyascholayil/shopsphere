import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopsphere/provider/category_provider.dart';
import 'package:shopsphere/screens/product_screendetails.dart';
import 'package:shopsphere/widgets/product_card.dart';

class ProductList extends ConsumerWidget {
  final VoidCallback onOpened;

  const ProductList({
    super.key,
    required this.onOpened,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final categoryProviders = ref.watch(
      categoryProvider,
    );

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(
        10,
        6,
        10,
        30,
      ),

      physics: const BouncingScrollPhysics(),

      itemCount: categoryProviders.all.length,

      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,

        crossAxisSpacing: 14,
        mainAxisSpacing: 16,

        mainAxisExtent: 320,
      ),

      itemBuilder: (context, index) {
        final product =
        categoryProviders.all[index];

        return ProductCard(
          productItems: product,

          onTap: () async {
            await Navigator.push(
              context,

              PageRouteBuilder(
                transitionDuration:
                const Duration(
                  milliseconds: 450,
                ),

                reverseTransitionDuration:
                const Duration(
                  milliseconds: 350,
                ),

                pageBuilder:
                    (
                    context,
                    animation,
                    secondaryAnimation,
                    ) => FadeTransition(
                  opacity: animation,

                  child:
                  ProductScreenDetails(
                    products: product,
                  ),
                ),
              ),
            );

            onOpened();
          },
        );
      },
    );
  }
}