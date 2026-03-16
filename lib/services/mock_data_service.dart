import 'dart:async';
import '../models/post_model.dart';

class MockDataService {
  Future<List<Post>> fetchPosts(int page) async {
    await Future.delayed(const Duration(seconds: 2));

    List<String> images = [
      "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d",
      "https://images.unsplash.com/photo-1519681393784-d120267933ba",
      "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
    ];

    return List.generate(10, (index) {
      return Post(
        id: "post_${page}_$index",
        username: "user_$index",
        userAvatar:
            // "https://randomuser.me/api/portraits/men/${index + 10}.jpg",
            "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200",
        images: images,
        caption: "Beautiful moment captured",
      );
    });
  }
}
