// lib/features/appointment/presentation/views/blog_screen.dart

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/string_extensions.dart';
import 'package:sound_mind/core/gen/assets.gen.dart';
import 'package:sound_mind/core/utils/image_util.dart';
import 'package:sound_mind/features/appointment/data/models/blog.dart';

class BlogScreen extends StatelessWidget {
  final Blog blog;

  const BlogScreen({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ─── HEADER IMAGE & BACK BUTTON ─────────────────────────────────────
            Stack(
              children: [
                // Rounded bottom corners on the header image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: blog.imageUrl.isEmpty || blog.imageUrl.contains('test.con')
                        ? ImageUtils.defaultImage
                        : blog.imageUrl,
                    width: double.infinity,
                    height: context.screenHeight * .35,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      width: double.infinity,
                      height: context.screenHeight * .35,
                      color: Colors.grey[300],
                    ),
                    errorWidget: (_, __, ___) => Container(
                      width: double.infinity,
                      height: context.screenHeight * .35,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 40),
                    ),
                  ),
                ),
                // Back arrow
                Positioned(
                  top: kToolbarHeight + 12,
                  left: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.black38,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                Positioned(
                    left: 12,
                    bottom: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          blog.title,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colors.white,
                          ),
                        ),
                        const Gap(8),

                        // Author row
                        Assets.application.assets.images.logoBatch.image(
                          width: 113,
                          height: 18,
                          fit: BoxFit.cover,
                        ),
                        const Gap(20),
                      ],
                    ))
              ],
            ),

            // ─── CONTENT ──────────────────────────────────────────────────────────
            Container(
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Body text
                  Text(
                    blog.content.capitalize,
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: theme.colorScheme.background,
    );
  }
}
