import 'package:flutter/material.dart';
import 'package:shopsphere/const.dart';
import 'package:shopsphere/models/products.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  final Products productItems;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.productItems,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        decoration: BoxDecoration(
          color: secondaryColor,

          borderRadius: BorderRadius.circular(28),

          boxShadow: [
            BoxShadow(
              color: primaryColor.withValues(alpha: 0.05),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              height: 180,

              width: double.infinity,

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: lightBackgroundColor,

                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),

              child: Stack(
                children: [
                  Center(
                    child: Hero(
                      tag: productItems.id.toString(),

                      child: CachedNetworkImage(
                        imageUrl: productItems.imgUrl,

                        fit: BoxFit.contain,

                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                            strokeWidth: 3,
                          ),
                        ),

                        errorWidget: (context, url, error) => Icon(
                          Icons.broken_image_rounded,

                          size: 45,

                          color: greyShadeW700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),

                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.08),

                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Text(
                        productItems.category,

                        maxLines: 1,

                        overflow: TextOverflow.ellipsis,

                        style: categoryTextStyles,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      productItems.title,

                      maxLines: 2,

                      overflow: TextOverflow.ellipsis,

                      style: productTitleStyles,
                    ),

                    const Spacer(),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "\$${productItems.price}",

                            overflow: TextOverflow.ellipsis,

                            style: priceTextStyles,
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),

                          decoration: BoxDecoration(
                            color: yellowColor.withValues(alpha: 0.12),

                            borderRadius: BorderRadius.circular(30),
                          ),

                          child: Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: yellowColor,
                                size: 16,
                              ),

                              const SizedBox(width: 4),

                              Text(
                                productItems.rate.toString(),

                                style: ratingTextStyles,
                              ),
                            ],
                          ),
                        ),
                      ],
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
}
