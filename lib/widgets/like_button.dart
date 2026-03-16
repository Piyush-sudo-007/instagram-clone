import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/post_provider.dart';

class LikeButtonWidget extends ConsumerWidget {
  final bool isLiked;
  final String postId;

  const LikeButtonWidget({
    super.key,
    required this.isLiked,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? Colors.red : Colors.black,
      ),

      onPressed: () {
        ref.read(postProvider.notifier).toggleLike(postId);
      },
    );
  }
}
