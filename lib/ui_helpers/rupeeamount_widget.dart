import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RupeeAmountText extends StatelessWidget {
  final String amount;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const RupeeAmountText({
    super.key,
    required this.amount,
    this.fontSize = 18,
    this.fontWeight = FontWeight.bold,
    this.color = Colors.black,
  });

  String _formatAmount(num value) {
    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0, // remove if you want decimals
    );
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatAmount(int.parse("${amount}")),
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
