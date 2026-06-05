import 'package:flutter/material.dart';
import 'package:shopsphere/const.dart';

class QuantityWidget extends StatefulWidget {
  final Function(int) onChanged;

  const QuantityWidget({super.key, required this.onChanged});

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  int quantity = 1;

  void _updateQty(int newQty) {
    setState(() {
      quantity = newQty;
    });

    widget.onChanged(quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

      decoration: BoxDecoration(
        color: secondaryColor,

        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: primaryColor.withValues(alpha: 0.15)),

        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _button(
            icon: Icons.remove,
            onTap: () {
              if (quantity > 1) {
                _updateQty(quantity - 1);
              }
            },
          ),

          const SizedBox(width: 18),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Text(
              "$quantity",
              key: ValueKey(quantity),
              style: font18SizeBlack,
            ),
          ),

          const SizedBox(width: 18),

          _button(
            icon: Icons.add,
            onTap: () {
              _updateQty(quantity + 1);
            },
          ),
        ],
      ),
    );
  }

  Widget _button({required IconData icon, required VoidCallback onTap}) {
    return Material(
      color: primaryColor.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(14),

      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,

        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, size: 20, color: primaryColor),
        ),
      ),
    );
  }
}
