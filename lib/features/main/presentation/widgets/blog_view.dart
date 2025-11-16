import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/gen/assets.gen.dart';
import 'package:sound_mind/core/utils/image_util.dart';

class BlogView extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String author;
  final Widget? authorIcon;

  const BlogView({
    Key? key,
    required this.title,
    required this.imageUrl,
    this.author = 'SoundMind Inc',
    this.authorIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .8,
      // card styling
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // subtle shadow
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Title + author
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title
                Text(
                  title,
                  style: context.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                // const SizedBox(height: 2),
                // Author row
                Assets.application.assets.images.logoBatch.image(
                  width: 81,
                  height: 13,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Image on the right
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: imageUrl.isEmpty || imageUrl.contains('test.con') ? ImageUtils.defaultImage : imageUrl,
              width: 72,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
