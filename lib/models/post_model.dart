class Post {
  final String id;
  final String username;
  final String userAvatar;
  final List<String> images;
  final String caption;
  bool isLiked;
  bool isSaved;

  Post({
    required this.id,
    required this.username,
    required this.userAvatar,
    required this.images,
    required this.caption,
    this.isLiked = false,
    this.isSaved = false,
  });
}
