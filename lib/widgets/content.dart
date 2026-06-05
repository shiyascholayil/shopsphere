import 'package:flutter/material.dart';
import 'package:shopsphere/const.dart';
import 'package:shopsphere/riverpod/category_riverpod.dart';
import 'package:shopsphere/widgets/loading_widget.dart';
import 'package:shopsphere/widgets/product_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Content extends ConsumerWidget {
  final VoidCallback oPened;

  const Content({super.key, required this.oPened});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryProviders = ref.watch(categoryProvider);

    if (categoryProviders.isLoading) {
      return LoadingWidget(message: "Loading");
    }

    if (categoryProviders.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                height: 120,
                width: 120,

                decoration: BoxDecoration(
                  color: redColor.withValues(alpha: 0.08),

                  shape: BoxShape.circle,
                ),

                child: Icon(
                  Icons.error_outline_rounded,
                  size: 65,
                  color: redColor,
                ),
              ),

              const SizedBox(height: 28),

              Text(
                "Something Went Wrong",

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 14),

              Text(
                categoryProviders.errorMessage.toString(),

                textAlign: TextAlign.center,

                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 36),

              SizedBox(
                width: 180,
                height: 55,

                child: ElevatedButton(
                  onPressed: () {
                    categoryProviders.loadProducts();
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,

                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(Icons.refresh_rounded, color: secondaryColor),

                      const SizedBox(width: 10),

                      Text(
                        "Retry",

                        style: TextStyle(
                          color: secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ProductList(onOpened: oPened);
  }
}
