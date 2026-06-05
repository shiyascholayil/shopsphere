import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopsphere/const.dart';

import 'package:shopsphere/riverpod/firestore_riverpod.dart';
import 'package:shopsphere/widgets/confirmation_dialog.dart';
import 'package:shopsphere/widgets/loading_widget.dart';

class OrderedPdtScreen extends ConsumerWidget {
  const OrderedPdtScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestoreProviderRef = ref.watch(firestoreProvider);

    return StreamBuilder(
      stream: firestoreProviderRef.getOrderedItems(),

      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: bgColor,

            appBar: _buildAppBar("My Orders"),

            body: const LoadingWidget(message: "Loading"),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Scaffold(
            backgroundColor: bgColor,

            appBar: _buildAppBar("My Orders"),

            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Container(
                    padding: EdgeInsets.all(28),

                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),

                    child: Icon(
                      Icons.inventory_2_outlined,
                      size: 90,
                      color: primaryColor,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text("No Orders Yet", style: appBarTitleStyle),

                  const SizedBox(height: 10),

                  Text("Your placed orders will appear here", style: subtitle),
                ],
              ),
            ),
          );
        }

        final orderDocs = snapshot.data!.docs;

        return Scaffold(
          backgroundColor: bgColor,

          appBar: AppBar(
            elevation: 0,
            backgroundColor: secondaryColor,
            centerTitle: true,

            title: Text("My Orders", style: appBarTitleStyle),

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
                      "${orderDocs.length} Orders",

                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          body: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),

            physics: const BouncingScrollPhysics(),

            itemCount: orderDocs.length,

            itemBuilder: (context, index) {
              final orderData = orderDocs[index];

              final List<dynamic> products = orderData["products"] ?? [];

              final String paymentMethod = orderData["paymentMethod"] ?? "";

              final dynamic totalPrice = orderData["totalPrice"] ?? 0;

              return Container(
                margin: const EdgeInsets.only(bottom: 18),

                decoration: BoxDecoration(
                  color: secondaryColor,

                  borderRadius: BorderRadius.circular(28),

                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.05),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: Padding(
                  padding: const EdgeInsets.all(18),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                "Order #${index + 1}",
                                style: orderTitleStyle,
                              ),

                              const SizedBox(height: 6),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),

                                decoration: BoxDecoration(
                                  color: greenColor.withValues(alpha: 0.12),

                                  borderRadius: BorderRadius.circular(30),
                                ),

                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      size: 16,
                                      color: greenColor,
                                    ),

                                    SizedBox(width: 6),

                                    Text(
                                      "Order Placed",
                                      style: greenSmallStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Container(
                            padding: const EdgeInsets.all(12),

                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: 0.08),

                              borderRadius: BorderRadius.circular(16),
                            ),

                            child: Icon(
                              Icons.shopping_bag_outlined,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      Container(
                        padding: const EdgeInsets.all(16),

                        decoration: BoxDecoration(
                          color: bgColor,

                          borderRadius: BorderRadius.circular(18),
                        ),

                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Text("Payment Method", style: subtitle),

                                Text(paymentMethod, style: boldStyle),
                              ],
                            ),

                            const SizedBox(height: 14),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Text("Total Amount", style: subtitle),

                                Text("\$ $totalPrice", style: priceStyle),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      Row(
                        children: [
                          Text("Products", style: orderTitleStyle),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Container(
                              height: 1.5,
                              color:greyShadeW300,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Column(
                        children: products.map((product) {
                          final String image = product['image'] ?? "";

                          final String name = product['name'] ?? "";

                          final dynamic price = product['price'] ?? 0;

                          final dynamic quantity = product['quantity'] ?? 1;

                          return Container(
                            margin: const EdgeInsets.only(bottom: 14),

                            padding: const EdgeInsets.all(12),

                            decoration: BoxDecoration(
                              color:  lightBackgroundColor,

                              borderRadius: BorderRadius.circular(20),
                            ),

                            child: Row(
                              children: [
                                Container(
                                  height: 75,
                                  width: 75,

                                  padding: const EdgeInsets.all(8),

                                  decoration: BoxDecoration(
                                    color: secondaryColor,

                                    borderRadius: BorderRadius.circular(18),
                                  ),

                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),

                                    child: Image.network(
                                      image,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 14),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      Text(
                                        name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,

                                        style: productNameStyle,
                                      ),

                                      const SizedBox(height: 8),

                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),

                                            decoration: BoxDecoration(
                                              color: primaryColor.withValues(
                                                alpha: 0.08,
                                              ),

                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),

                                            child: Text(
                                              "Qty : $quantity",
                                              style: primarySmallStyle,
                                            ),
                                          ),

                                          const SizedBox(width: 10),

                                          Text("\$ $price", style: boldStyle),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerRight,

                        child: SizedBox(
                          height: 48,

                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,

                              backgroundColor: Colors.red.shade50,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),

                            onPressed: () async {
                              final bool?
                              shouldCancel = await ConfirmationDialog.show(
                                context: context,

                                title: "Cancel Order",

                                content:
                                    "Are you sure you want to cancel this order?",
                              );

                              if (shouldCancel == true) {
                                await firestoreProviderRef.deleteOrderedProduct(
                                  orderData.id,
                                );
                              }
                            },

                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.red.shade700,
                            ),

                            label: Text(
                              "Cancel Order",

                              style: TextStyle(
                                color: Colors.red.shade700,

                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(String title) {
    return AppBar(
      elevation: 0,

      backgroundColor: secondaryColor,

      centerTitle: true,

      title: Text(title, style: appBarTitleStyle),
    );
  }
}
