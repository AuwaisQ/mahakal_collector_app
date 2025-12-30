import 'package:flutter/material.dart';

class NoImageWidget extends StatelessWidget {
  const NoImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/mahakal.jpeg',
      fit: BoxFit.cover,
      width: double.infinity,
    );
  }
}
