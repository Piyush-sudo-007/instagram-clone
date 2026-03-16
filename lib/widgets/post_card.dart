import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/post_model.dart';
import '../providers/post_provider.dart';
import 'carousel_images.dart';
import 'double_tap_heart.dart';

class PostCard extends ConsumerWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// POST HEADER (Avatar + Username + Menu)
        ListTile(
          leading: CachedNetworkImage(
            imageUrl: post.userAvatar,

            imageBuilder: (context, imageProvider) =>
                CircleAvatar(radius: 18, backgroundImage: imageProvider),

            placeholder: (context, url) => const CircleAvatar(
              radius: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),

            errorWidget: (context, url, error) =>
                const CircleAvatar(radius: 18, child: Icon(Icons.person)),
          ),

          title: Text(
            post.username,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),

          trailing: const Icon(Icons.more_vert),
        ),

        DoubleTapHeart(child: CarouselImages(images: post.images)),

        /// IMAGE CAROUSEL WITH DOUBLE TAP LIKE
        // GestureDetector(
        //   onDoubleTap: () {
        //     ref.read(postProvider.notifier).toggleLike(post.id);
        //   },

        //   child: CarouselImages(images: post.images),
        // ),

        /// ACTION BUTTONS ROW
        Row(
          children: [
            /// LIKE
            IconButton(
              icon: Icon(
                post.isLiked ? Icons.favorite : Icons.favorite_border,
                color: post.isLiked ? Colors.red : Colors.black,
              ),

              onPressed: () {
                ref.read(postProvider.notifier).toggleLike(post.id);
              },
            ),

            /// COMMENT
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline),

              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Comments not implemented"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),

            /// SHARE
            IconButton(
              icon: const Icon(Icons.send_outlined),

              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Share not implemented"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),

            const Spacer(),

            /// SAVE / BOOKMARK
            IconButton(
              icon: Icon(post.isSaved ? Icons.bookmark : Icons.bookmark_border),

              onPressed: () {
                ref.read(postProvider.notifier).toggleSave(post.id);
              },
            ),
          ],
        ),

        /// CAPTION
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),

          child: Text(post.caption, style: const TextStyle(fontSize: 14)),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
