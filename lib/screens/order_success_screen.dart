import 'package:flutter/material.dart';
import 'package:shopsphere/const.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  height: 180,
                  width: 180,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    gradient: LinearGradient(
                      colors: [
                        primaryColor,
                        primaryColor.withValues(alpha: 0.75),
                      ],
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withValues(alpha: 0.25),
                        blurRadius: 30,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),

                  child: Center(
                    child: Container(
                      height: 130,
                      width: 130,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: secondaryColor,
                      ),

                      child: Icon(
                        Icons.check_rounded,
                        size: 80,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 45),

                Text(
                  "Order Placed Successfully",
                  textAlign: TextAlign.center,
                  style: successTitleStyle,
                ),

                const SizedBox(height: 18),

                Text(
                  "Your order has been placed successfully.\nThank you for shopping with us.",
                  textAlign: TextAlign.center,
                  style: successSubtitleStyle,
                ),

                const SizedBox(height: 45),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),

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

                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),

                        decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: 0.08),

                          borderRadius: BorderRadius.circular(18),
                        ),

                        child: Icon(
                          Icons.local_shipping_outlined,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [
                            Text(
                              "Estimated Delivery",
                              style: deliveryLabelStyle,
                            ),

                            const SizedBox(height: 6),

                            Text(
                              "2 - 4 Business Days",
                              style: deliveryTimeStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 60),

                SizedBox(
                  width: double.infinity,
                  height: 58,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: primaryColor,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    onPressed: () {
                      Navigator.popUntil(
                        context,
                            (route) => route.isFirst,
                      );
                    },

                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,

                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          color: secondaryColor,
                        ),

                        const SizedBox(width: 12),

                        Text(
                          "Continue Shopping",
                          style: continueButtonStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}