import '../models/post_model.dart';
import '../services/mock_data_service.dart';

class PostRepository {
  final MockDataService service;

  PostRepository(this.service);

  Future<List<Post>> getPosts(int page) {
    return service.fetchPosts(page);
  }
}
