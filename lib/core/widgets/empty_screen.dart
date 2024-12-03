import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomEmptyScreen extends StatelessWidget {
  final String message;
  final IconData? icon;
  final String? imageUrl;
  final VoidCallback onTap;
  // Default values
  const CustomEmptyScreen({
    Key? key,
    this.message = "Nonthing to see here",
    this.icon,
    this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Show image if provided, otherwise show default icon
            CachedNetworkImage(
              imageUrl: imageUrl!,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onTap,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
