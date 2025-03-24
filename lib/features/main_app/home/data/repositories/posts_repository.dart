import 'package:dio/dio.dart';
import 'package:eventplanner/core/constants/strings.dart';
import '../../../../../core/models/comment_model.dart';
import '../../../../../core/models/post_model.dart';

class PostsRepository {
  Future<List<PostModel>> getPosts() async {
    try {
      final response = await Dio().get("${AppStrings.baseUrl}/posts");
      return PostModel.listFromJson((response.data as List).toList());
      
    } on DioException catch (e) {
      throw Exception(
        'Failed to load posts: ${e.response?.statusMessage ?? e.message}'
      );
    }
  }

  Future<List<CommentModel>> getComments(int postId) async {
    try {
      final response = await Dio().get("${AppStrings.baseUrl}/comments?postId=$postId");
      return CommentModel.listFromJson((response.data as List).toList());
      
    } on DioException catch (e) {
      throw Exception(
        'Failed to load comments: ${e.response?.statusMessage ?? e.message}'
      );
    }
  }
}
