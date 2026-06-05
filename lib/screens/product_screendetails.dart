
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopsphere/const.dart';
import 'package:shopsphere/models/products.dart';
import 'package:shopsphere/provider/firestore_provider.dart';
import 'package:shopsphere/screens/cart_screen.dart';
import 'package:shopsphere/screens/delivery_address_screen.dart';
import 'package:shopsphere/widgets/quantity_widget.dart';
import 'package:shopsphere/widgets/review_widget.dart';

class ProductScreenDetails extends ConsumerStatefulWidget {
  final Products products;

  const ProductScreenDetails({
    super.key,
    required this.products,
  });

  @override
  ConsumerState<ProductScreenDetails> createState() =>
      _ProductScreenDetailsState();
}

class _ProductScreenDetailsState
    extends ConsumerState<ProductScreenDetails> {
  int _quantity = 1;

  int get quantity => _quantity;

  @override
  Widget build(BuildContext context) {
    final fireStoreProvider = ref.watch(firestoreProvider);

    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: secondaryColor,
        centerTitle: true,

        title: Text(
          "Product Details",
          style: screenDetailsText,
        ),

        iconTheme: IconThemeData(color: primaryColor),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CartScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),

              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(28),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: Hero(
                tag: widget.products.id.toString(),

                child: Image.network(
                  widget.products.imgUrl,
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),

              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(30),
              ),

              child: Text(
                widget.products.category.toUpperCase(),
                style: categoryTextStyle,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              widget.products.title,
              style: productTitleStyle,
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),

              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(20),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        "Price",
                        style: priceLabelStyle,
                      ),

                      const SizedBox(height: 6),

                      Text(
                        '\$${widget.products.price}',
                        style: priceTextStyle,
                      ),
                    ],
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),

                    decoration: BoxDecoration(
                      color: yellowColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: yellowColor,
                          size: 24,
                        ),

                        const SizedBox(width: 6),

                        Text(
                          widget.products.rate.toString(),
                          style: ratingTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            Text(
              "Description",
              style: sectionTitleStyle,
            ),

            const SizedBox(height: 10),

            Text(
              widget.products.desc,
              style: descriptionTextStyle,
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  "Quantity",
                  style: quantityTitleStyle,
                ),

                Container(
                  padding: const EdgeInsets.all(6),

                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(18),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: QuantityWidget(
                    onChanged: (newQty) {
                      setState(() {
                        _quantity = newQty;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            Row(
              children: [
                Text(
                  "Reviews",
                  style: reviewTitleStyle,
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Container(
                    height: 2,

                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          primaryColor,
                          primaryColor.withValues(alpha: 0.05),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ReviewWidget(
              review: widget.products.reviews,
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),

        decoration: BoxDecoration(
          color: secondaryColor,

          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, -5),
            ),
          ],
        ),

        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 56,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DeliveryAddressScreen(
                          buyItems: [
                            {
                              'id': widget.products.id.toString(),
                              'name': widget.products.title,
                              'price': widget.products.price,
                              'image': widget.products.imgUrl,
                              'quantity': quantity,
                            },
                          ],
                        ),
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: primaryColor,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  child: Text(
                    "Buy Now",
                    style: bottomButtonTextStyle,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: StreamBuilder<bool>(
                stream: fireStoreProvider.isItemInCart(
                  widget.products.id.toString(),
                ),

                builder: (context, snapshot) {
                  final isInCart = snapshot.data ?? false;

                  return SizedBox(
                    height: 56,

                    child: ElevatedButton(
                      onPressed: () async {
                        if (isInCart) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CartScreen(),
                            ),
                          );
                        } else {
                          await fireStoreProvider.addToCart(
                            {
                              'id': widget.products.id.toString(),
                              'name': widget.products.title,
                              'price': widget.products.price,
                              'image': widget.products.imgUrl,
                              'category': widget.products.category,
                              'description': widget.products.desc,
                              'rate': widget.products.rate,
                              'reviews': widget.products.reviews
                                  .map((e) => e.toMap())
                                  .toList(),
                            },
                            quantity,
                          );
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                        isInCart ? greenColor: blackTextColor,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),

                      child: Text(
                        isInCart
                            ? "Go To Cart"
                            : "Add To Cart",
                        style: bottomButtonTextStyle,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}