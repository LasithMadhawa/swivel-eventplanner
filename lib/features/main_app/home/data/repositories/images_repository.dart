import 'package:dio/dio.dart';
import 'package:eventplanner/core/constants/strings.dart';
import '../../../../../core/models/image_model.dart';

class ImagesRepository {
  Future<List<ImageModel>> getImages() async {
    try {
      final response = await Dio().get("${AppStrings.baseUrl}/photos");
      return ImageModel.listFromJson((response.data as List).take(10).toList());
      
    } on DioException catch (e) {
      throw Exception(
        'Failed to load images: ${e.response?.statusMessage ?? e.message}'
      );
    }
  }
}