import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';

class CustomErrorScreen extends StatelessWidget {
  final String message;
  final IconData? icon;
  final String? imageUrl;
  final VoidCallback onTap;
  // Default values
  const CustomErrorScreen({
    Key? key,
    this.message = "Something went wrong. Please try again.",
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
            if (imageUrl != null)
              Image.network(
                imageUrl!,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              )
            else if (message.contains('No'))
              Icon(
                icon ?? Icons.search, // Default icon if none provided
                size: 120,
                color: context.primaryColor,
              )

            //   CachedNetworkImage(
            //     imageUrl: imageUrl ??
            //         'https://www.google.com/imgres?q=empt%20icon%20image&imgurl=https%3A%2F%2Fstatic.vecteezy.com%2Fsystem%2Fresources%2Fthumbnails%2F007%2F104%2F553%2Fsmall_2x%2Fsearch-no-result-not-found-concept-illustration-flat-design-eps10-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-vector.jpg&imgrefurl=https%3A%2F%2Fwww.vecteezy.com%2Ffree-vector%2Fempty-icon&docid=fFP8XVrlIY_6ZM&tbnid=ERAkG_qanmVQ9M&vet=12ahUKEwip9enMvoiOAxWsWUEAHXr8DkUQM3oECBoQAA..i&w=400&h=400&hcb=2&ved=2ahUKEwip9enMvoiOAxWsWUEAHXr8DkUQM3oECBoQAA',
            //     height: 150,
            //     width: 150,
            //     fit: BoxFit.cover,
            //   )
            else
              Icon(
                icon ?? Icons.search, // Default icon if none provided
                size: 80,
                color: Colors.redAccent,
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
