import 'package:dio/dio.dart';
import 'package:eventplanner/core/models/organizer_model.dart';

class OrganizersRepository {
  Future<List<OrganizerModel>> getOrganizers() async {
    try {
      final response = await Dio().get("https://jsonplaceholder.typicode.com/users");
      return OrganizerModel.listFromJson((response.data as List).take(3).toList());
      
    } on DioException catch (e) {
      throw Exception(
        'Failed to load organizers: ${e.response?.statusMessage ?? e.message}'
      );
    }
  }
}
