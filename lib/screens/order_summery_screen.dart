import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopsphere/const.dart';
import 'package:shopsphere/provider/firestore_provider.dart';
import 'package:shopsphere/screens/order_success_screen.dart';

class OrderSummeryScreen extends ConsumerWidget {
  final QuerySnapshot<Map<String, dynamic>>? cartItems;
  final String paymentMethod;
  final List<Map<String, dynamic>>? buyItems;

  const OrderSummeryScreen({
    super.key,
    this.cartItems,
    required this.paymentMethod,
    this.buyItems,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestoreProviders = ref.watch(firestoreProvider);

    final List<Map<String, dynamic>> items =
        buyItems ?? cartItems?.docs.map((e) => e.data()).toList() ?? [];

    double totalPrice = 0;

    for (var data in items) {
      final price = double.tryParse(data['price'].toString()) ?? 0;

      final qty = int.tryParse(data['quantity'].toString()) ?? 1;

      totalPrice += price * qty;
    }

    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: secondaryColor,

        title: Text("Order Summary", style: orderSummaryAppBarStyle),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        physics: const BouncingScrollPhysics(),

        children: [
          Container(
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withValues(alpha: 0.85)],
              ),

              borderRadius: BorderRadius.circular(26),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),

                      decoration: BoxDecoration(
                        color: secondaryColor.withValues(alpha: 0.18),

                        borderRadius: BorderRadius.circular(16),
                      ),

                      child: Icon(
                        Icons.receipt_long,
                        color: secondaryColor,
                        size: 28,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text("Review Your Order", style: headerTitleStyle),

                          const SizedBox(height: 6),

                          Text(
                            "${items.length} items selected",
                            style: headerSubtitleStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          Text("Payment Method", style: sectionTitleStyle),

          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(
              color: secondaryColor,

              borderRadius: BorderRadius.circular(22),

              boxShadow: [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),

            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),

                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.08),

                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: Icon(
                    Icons.account_balance_wallet,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(paymentMethod, style: paymentMethodStyle),

                      const SizedBox(height: 4),

                      Text(
                        "Selected payment option",
                        style: paymentSubtitleStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          Row(
            children: [
              Text("Products", style: sectionTitleStyle),

              const SizedBox(width: 12),

              Expanded(
                child: Container(height: 1.5, color: Colors.grey.shade300),
              ),
            ],
          ),

          const SizedBox(height: 20),

          ...items.map((data) {
            return Container(
              margin: const EdgeInsets.only(bottom: 18),

              padding: const EdgeInsets.all(14),

              decoration: BoxDecoration(
                color: secondaryColor,

                borderRadius: BorderRadius.circular(24),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              child: Row(
                children: [
                  Container(
                    width: 90,
                    height: 90,

                    padding: const EdgeInsets.all(10),

                    decoration: BoxDecoration(
                      color: const Color(0xffF8F9FB),

                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),

                      child: Image.network(data['image'], fit: BoxFit.contain),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          data['name'] ?? "",

                          maxLines: 2,

                          overflow: TextOverflow.ellipsis,

                          style: productNameStyle,
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
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
                                "Qty : ${data['quantity'] ?? 1}",
                                style: quantityStyle,
                              ),
                            ),

                            const Spacer(),

                            Text(
                              "\$ ${data['price']}",
                              style: productPriceStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(22),

            decoration: BoxDecoration(
              color: secondaryColor,

              borderRadius: BorderRadius.circular(28),

              boxShadow: [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),

            child: Column(
              children: [
                _buildPriceRow("Items", "${items.length}"),

                const SizedBox(height: 16),

                _buildPriceRow("Delivery", "Free"),

                const SizedBox(height: 16),

                Divider(color: greyShadeW300),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text("Total Amount", style: totalLabelStyle),

                    Text(
                      "\$ ${totalPrice.toStringAsFixed(2)}",
                      style: totalPriceStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 120),
        ],
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),

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

        child: SizedBox(
          width: double.infinity,
          height: 58,

          child: ElevatedButton(
            onPressed: () async {
              try {
                await firestoreProviders.placeAnOrder(
                  items,
                  paymentMethod,
                  totalPrice,
                );

                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,

                    MaterialPageRoute(
                      builder: (context) => const OrderSuccessScreen(),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              }
            },

            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: primaryColor,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Icon(Icons.shopping_bag_outlined, color: secondaryColor),

                const SizedBox(width: 12),

                Text("Place Order", style: placeOrderButtonStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(title, style: priceRowTitleStyle),

        Text(value, style: priceRowValueStyle),
      ],
    );
  }
}
