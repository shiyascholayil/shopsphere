
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopsphere/const.dart';
import 'package:shopsphere/models/reviews.dart';
import 'package:shopsphere/riverpod/firestore_riverpod.dart';
import 'package:shopsphere/screens/delivery_address_screen.dart';
import 'package:shopsphere/screens/product_screendetails.dart';
import 'package:shopsphere/widgets/cart_card.dart';
import 'package:shopsphere/widgets/loading_widget.dart';
import 'package:shopsphere/models/products.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseProvider = ref.watch(firestoreProvider);

    return StreamBuilder(
      stream: firebaseProvider.getCartItems(),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: bgColor,

            appBar: AppBar(
              elevation: 0,
              backgroundColor: secondaryColor,
              centerTitle: true,

              title: Text(
                "My Cart",
                style: cartAppBarTitleStyle,
              ),
            ),

            body: const LoadingWidget(message: "Loading"),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Scaffold(
            backgroundColor:bgColor,

            appBar: AppBar(
              elevation: 0,
              backgroundColor: secondaryColor,
              centerTitle: true,

              title: Text(
                "My Cart",
                style: cartAppBarTitleStyle,
              ),
            ),

            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Container(
                    padding: const EdgeInsets.all(30),

                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),

                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 90,
                      color: primaryColor,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    "Your Cart is Empty",
                    style: emptyCartTitleStyle,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Looks like you haven't added\nanything to your cart yet",
                    textAlign: TextAlign.center,
                    style: emptyCartSubtitleStyle,
                  ),
                ],
              ),
            ),
          );
        }

        final items = snapshot.data!.docs;

        double total = 0;

        for (var item in items) {
          double price = item["price"]?.toDouble() ?? 1.0;
          int qty = item['quantity'] ?? 1;

          total += qty * price;
        }

        return Scaffold(
          backgroundColor:bgColor,

          appBar: AppBar(
            elevation: 0,
            backgroundColor: secondaryColor,
            centerTitle: true,

            title: Text(
              "My Cart",
              style: cartAppBarTitleStyle,
            ),

            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),

                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Text(
                      "${items.length} Items",
                      style: itemCountTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),

          body: Padding(
            padding: const EdgeInsets.only(top: 10),

            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,

              itemBuilder: (context, index) {
                final data = items[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),

                  child: Container(
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(24),

                      boxShadow: [
                        BoxShadow(
                          color:primaryColor.withValues(alpha: 0.05),
                          blurRadius: 14,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),

                    child: CartCard(
                      quantity: data['quantity'] ?? 1,

                      image: data['image'],

                      price: data['price'],

                      name: data['name'] ?? "",

                      onDelete: () async {
                        await firebaseProvider.deleteItems(data.id);
                      },

                      onTap: () {
                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (_) => ProductScreenDetails(
                              products: Products(
                                id: int.parse(
                                  data['id'].toString(),
                                ),

                                title: data['name'],

                                price: data['price'],

                                image: data['image'],

                                category:
                                data['category'] ?? "",

                                desc:
                                data['description'] ?? "",

                                rate:
                                data['rate'] ?? 0,

                                reviews:
                                (data['reviews']
                                as List<dynamic>?)
                                    ?.map(
                                      (e) => Reviews
                                      .fromJson(e),
                                )
                                    .toList() ??
                                    [],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          bottomNavigationBar: Container(
            padding: const EdgeInsets.fromLTRB(
              18,
              18,
              18,
              26,
            ),

            decoration: BoxDecoration(
              color: secondaryColor,

              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),

              boxShadow: [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.08),
                  blurRadius: 18,
                  offset: const Offset(0, -4),
                ),
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

                  children: [
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Total Amount",
                          style: totalLabelTextStyle,
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "\$${total.toStringAsFixed(2)}",
                          style: totalPriceTextStyle,
                        ),
                      ],
                    ),

                    Container(
                      padding: const EdgeInsets.all(14),

                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.08),
                        borderRadius:
                        BorderRadius.circular(18),
                      ),

                      child: Icon(
                        Icons.shopping_bag_outlined,
                        color: primaryColor,
                        size: 32,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 58,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (context) =>
                              DeliveryAddressScreen(
                                cartItems: snapshot.data!,
                              ),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: primaryColor,

                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(18),
                      ),
                    ),

                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,

                      children: [
                        Icon(
                          Icons.lock_outline_rounded,
                          color: secondaryColor,
                        ),

                        const SizedBox(width: 10),

                        Text(
                          "Proceed To Checkout",
                          style:
                          checkoutButtonTextStyle,
                        ),
                      ],
                    ),
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