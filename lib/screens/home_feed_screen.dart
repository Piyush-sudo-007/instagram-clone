import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/post_provider.dart';
import '../widgets/post_card.dart';
import '../widgets/shimmer_post.dart';
import '../widgets/story_tray.dart';

class HomeFeedScreen extends ConsumerStatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  ConsumerState<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends ConsumerState<HomeFeedScreen> {
  final controller = ScrollController();

  int index = 0;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(postProvider.notifier).fetchPosts();
    });

    controller.addListener(() {
      if (controller.position.pixels >
          controller.position.maxScrollExtent - 500) {
        ref.read(postProvider.notifier).fetchPosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,

        leading: const Icon(Icons.add_box_outlined, color: Colors.black),

        title: const Text(
          "Instagram",
          style: TextStyle(
            fontFamily: "Billabong",
            fontSize: 28,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),

        centerTitle: true,

        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.favorite_border, color: Colors.black),
          ),
        ],
      ),

      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: controller,

        itemCount: posts.isEmpty ? 5 : posts.length + 1,

        itemBuilder: (context, index) {
          if (posts.isEmpty) {
            return const ShimmerPost();
          }

          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: StoryTray(),
            );
          }

          if (index <= posts.length) {
            return PostCard(post: posts[index - 1]);
          }

          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        type: BottomNavigationBarType.fixed,

        onTap: (i) {
          setState(() {
            index = i;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),

          BottomNavigationBarItem(icon: Icon(Icons.movie_outlined), label: ""),

          BottomNavigationBarItem(icon: Icon(Icons.send), label: ""),

          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}
