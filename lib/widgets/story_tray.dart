import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StoryTray extends StatelessWidget {
  const StoryTray({super.key});

  final List<String> avatars = const [
    "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200",
    "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200",
    "https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=200",
    "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200",
    "https://images.unsplash.com/photo-1502767089025-6572583495b0?w=200",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (_, index) {
          final avatarUrl = avatars[index % avatars.length];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: SizedBox(
              width: 72,
              child: Column(
                children: [
                  /// FIRST STORY (Your Story + Plus Icon)
                  if (index == 0)
                    Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: avatarUrl,

                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                                radius: 28,
                                backgroundImage: imageProvider,
                              ),

                          placeholder: (context, url) => const CircleAvatar(
                            radius: 28,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),

                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                                radius: 28,
                                child: Icon(Icons.person),
                              ),
                        ),

                        /// PLUS ICON
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.add,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  /// OTHER STORIES WITH GRADIENT RING
                  else
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,

                        /// INSTAGRAM GRADIENT
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFFEDA75),
                            Color(0xFFFA7E1E),
                            Color(0xFFD62976),
                            Color(0xFF962FBF),
                            Color(0xFF4F5BD5),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),

                      child: CachedNetworkImage(
                        imageUrl: avatarUrl,

                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 26,
                          backgroundImage: imageProvider,
                        ),

                        placeholder: (context, url) => const CircleAvatar(
                          radius: 26,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),

                        errorWidget: (context, url, error) =>
                            const CircleAvatar(
                              radius: 26,
                              child: Icon(Icons.person),
                            ),
                      ),
                    ),

                  const SizedBox(height: 4),

                  /// USERNAME
                  Text(
                    index == 0 ? "Your Story" : "user$index",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
