import 'package:flutter/material.dart';
import 'package:shopsphere/const.dart';

class CartCard extends StatelessWidget {
  final String name;
  final String image;
  final double price;
  final int quantity;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const CartCard({
    super.key,
    required this.quantity,
    required this.image,
    required this.price,
    required this.name,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(28),

      onTap: onTap,

      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),

        padding: const EdgeInsets.all(14),

        decoration: BoxDecoration(
          color: secondaryColor,

          borderRadius: BorderRadius.circular(28),

          boxShadow: [
            BoxShadow(
              color: primaryColor.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,

              padding: EdgeInsets.all(12),

              decoration: BoxDecoration(
                color: lightBackgroundColor,

                borderRadius: BorderRadius.circular(22),
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),

                child: Image.network(
                  image,

                  fit: BoxFit.contain,

                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.broken_image_rounded,
                      size: 40,
                      color: greyShadeW500,
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
                    name,

                    maxLines: 2,

                    overflow: TextOverflow.ellipsis,

                    style: cartTitleStyle,
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

                    child: Text("Qty : $quantity", style: quantityStyle),
                  ),

                  const SizedBox(height: 14),

                  Text("\$$price", style: priceStyle),
                ],
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: redColor.withValues(alpha: 0.08),

                borderRadius: BorderRadius.circular(16),
              ),

              child: IconButton(
                onPressed: onDelete,

                icon: Icon(Icons.delete_outline_rounded, color: redAccentColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
