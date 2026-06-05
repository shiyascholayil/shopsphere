
import 'package:flutter/material.dart';
import 'package:shopsphere/const.dart';

class PaymentWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String value;
  final String selectedPayment;

  const PaymentWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.selectedPayment,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedPayment == value;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      margin: const EdgeInsets.only(bottom: 14),

      decoration: BoxDecoration(
        color: secondaryColor,

        borderRadius: BorderRadius.circular(22),

        border: Border.all(
          color: isSelected
              ? primaryColor
              : greyLightColor,
          width: isSelected ? 2 : 1,
        ),

        boxShadow: [
          BoxShadow(
            color: isSelected
                ? primaryColor.withValues(alpha: 0.10)
                : primaryColor.withValues(alpha: 0.03),
            blurRadius: isSelected ? 16 : 8,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),

        child: RadioListTile<String>(
          value: value,

          dense: true,
          visualDensity: VisualDensity.compact,

          activeColor: primaryColor,

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),

          controlAffinity:
          ListTileControlAffinity.trailing,

          secondary: AnimatedContainer(
            duration: const Duration(milliseconds: 250),

            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: isSelected
                  ? primaryColor.withValues(alpha: 0.12)
                  : greyBackground,

              borderRadius: BorderRadius.circular(16),
            ),

            child: Icon(
              icon,
              color: isSelected
                  ? primaryColor
                  : greyTextColor,
              size: 24,
            ),
          ),

          title: Text(
            title,
            style: isSelected
                ? selectedPaymentTitleStyle
                : paymentTitleStyles,
          ),

          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),

            child: Text(
              subtitle,
              style: paymentSubtitleStyless,
            ),
          ),
        ),
      ),
    );
  }
}