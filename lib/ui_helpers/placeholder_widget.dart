import 'package:flutter/material.dart';

class PlaceholderImage extends StatelessWidget {
  const PlaceholderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/mahakal.jpeg',
      fit: BoxFit.cover,
      width: double.infinity,
    );
  }
}
