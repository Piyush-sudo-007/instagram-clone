import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post_model.dart';
import '../repositories/post_repository.dart';
import '../services/mock_data_service.dart';

final postRepositoryProvider = Provider((ref) {
  return PostRepository(MockDataService());
});

final postProvider = StateNotifierProvider<PostNotifier, List<Post>>((ref) {
  return PostNotifier(ref.read(postRepositoryProvider));
});

class PostNotifier extends StateNotifier<List<Post>> {
  final PostRepository repository;

  int page = 0;
  bool isLoading = false;

  PostNotifier(this.repository) : super([]);

  Future<void> fetchPosts() async {
    if (isLoading) return;

    isLoading = true;

    final newPosts = await repository.getPosts(page);

    state = [...state, ...newPosts];

    page++;

    isLoading = false;
  }

  void toggleLike(String id) {
    state = state.map((post) {
      if (post.id == id) {
        post.isLiked = !post.isLiked;
      }
      return post;
    }).toList();
  }

  void toggleSave(String id) {
    state = state.map((post) {
      if (post.id == id) {
        post.isSaved = !post.isSaved;
      }
      return post;
    }).toList();
  }
}
