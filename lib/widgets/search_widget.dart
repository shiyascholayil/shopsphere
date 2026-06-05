import 'package:flutter/material.dart';
import 'package:shopsphere/const.dart';
import 'package:shopsphere/provider/category_provider.dart';
import 'package:shopsphere/screens/product_screendetails.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.categoryProvider,
    required this.searchController,
  });

  final CategoryProvider categoryProvider;

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    if (categoryProvider.isLoading) {
      return Center(child: CircularProgressIndicator(color: primaryColor));
    }

    if (searchController.text.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                height: 120,
                width: 120,

                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.08),

                  shape: BoxShape.circle,
                ),

                child: Icon(
                  Icons.search_rounded,
                  size: 60,
                  color: primaryColor,
                ),
              ),

              const SizedBox(height: 28),

              Text("Search Products", style: searchTitleStyle),

              const SizedBox(height: 10),

              Text(
                "Start typing to discover your favorite products.",

                textAlign: TextAlign.center,

                style: searchSubTitleStyle,
              ),
            ],
          ),
        ),
      );
    }

    if (categoryProvider.searchResult.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),

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
                  Icons.search_off_rounded,
                  size: 60,
                  color: redAccentColor,
                ),
              ),

              const SizedBox(height: 28),

              Text("No Product Found", style: searchTitleStyle),

              const SizedBox(height: 10),

              Text(
                "We couldn't find any matching products.",

                textAlign: TextAlign.center,

                style: searchSubTitleStyle,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),

      physics: const BouncingScrollPhysics(),

      itemCount: categoryProvider.searchResult.length,

      itemBuilder: (context, index) {
        final data = categoryProvider.searchResult[index];

        return InkWell(
          borderRadius: BorderRadius.circular(24),

          onTap: () {
            Navigator.push(
              context,

              MaterialPageRoute(
                builder: (context) => ProductScreenDetails(products: data),
              ),
            );
          },

          child: Container(
            margin: const EdgeInsets.only(bottom: 18),

            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color: secondaryColor,

              borderRadius: BorderRadius.circular(24),

              boxShadow: [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.04),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),

            child: Row(
              children: [
                Container(
                  height: 95,
                  width: 95,

                  padding: const EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    color: lightBackgroundColor,

                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),

                    child: Image.network(
                      data.image,

                      fit: BoxFit.contain,

                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.broken_image,
                          color: greyShadeW500,
                          size: 40,
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        data.title,

                        maxLines: 2,

                        overflow: TextOverflow.ellipsis,

                        style: searchProductTitleStyle,
                      ),

                      const SizedBox(height: 12),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),

                        decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: 0.08),

                          borderRadius: BorderRadius.circular(30),
                        ),

                        child: Text(
                          data.category,

                          style: searchCategoryTextStyle,
                        ),
                      ),

                      const SizedBox(height: 14),

                      Row(
                        children: [
                          Text(
                            "\$ ${data.price}",

                            style: searchPriceTextStyles,
                          ),

                          const Spacer(),

                          Container(
                            padding: const EdgeInsets.all(10),

                            decoration: BoxDecoration(
                              color: primaryColor,

                              borderRadius: BorderRadius.circular(14),
                            ),

                            child: Icon(
                              Icons.arrow_forward_ios_rounded,

                              size: 16,

                              color: secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
