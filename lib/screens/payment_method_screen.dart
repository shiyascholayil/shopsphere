import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopsphere/const.dart';
import 'package:shopsphere/screens/order_summery_screen.dart';
import 'package:shopsphere/widgets/payment_widget.dart';

class PaymentMethodScreen extends StatefulWidget {
  final QuerySnapshot<Map<String, dynamic>>? cartItems;
  final List<Map<String, dynamic>>? buyItems;

  const PaymentMethodScreen({
    super.key,
    this.cartItems,
    this.buyItems,
  });

  @override
  State<PaymentMethodScreen> createState() =>
      _PayementMethodScreenState();
}

class _PayementMethodScreenState
    extends State<PaymentMethodScreen> {
  String selectedPayment = "Cash on Delivery";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: secondaryColor,

        title: Text(
          "Payment Method",
          style: paymentAppBarTitleStyle,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: RadioGroup<String>(
          groupValue: selectedPayment,

          onChanged: (value) {
            setState(() {
              selectedPayment = value!;
            });
          },

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "Choose your payment option",
                style: paymentTitleStyle,
              ),

              const SizedBox(height: 8),

              Text(
                "Select your preferred payment method",
                style: paymentSubtitleStyle,
              ),

              const SizedBox(height: 28),

              PaymentWidget(
                title: "Cash on Delivery",
                subtitle: "Pay when order arrives",
                icon: Icons.payments_outlined,
                value: "Cash on Delivery",
                selectedPayment: selectedPayment,

              ),

              const SizedBox(height: 18),

              PaymentWidget(
                title: "UPI",
                subtitle: "Google Pay, PhonePe",
                icon: Icons.qr_code_2_outlined,
                value: "UPI",
                selectedPayment: selectedPayment,

              ),

              const SizedBox(height: 18),

              PaymentWidget(
                title: "Card",
                subtitle: "Credit / Debit Card",
                icon: Icons.credit_card_rounded,
                value: "Card",
                selectedPayment: selectedPayment,

              ),

              const SizedBox(height: 18),

              PaymentWidget(
                title: "Wallet",
                subtitle: "Amazon Pay Wallet",
                icon: Icons.account_balance_wallet_outlined,
                value: "Wallet",
                selectedPayment: selectedPayment,

              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(
          16,
          14,
          16,
          24,
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

        child: SizedBox(
          width: double.infinity,
          height: 58,

          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (context) => OrderSummeryScreen(
                    cartItems: widget.cartItems,
                    buyItems: widget.buyItems,
                    paymentMethod: selectedPayment,
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

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                  "Proceed",
                  style: proceedButtonTextStyle,
                ),

                const SizedBox(width: 10),

                Icon(
                  Icons.arrow_forward_rounded,
                  color: secondaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}