class PostModel {
  final int? id;
  final int? userId;
  final String? title;
  final String? body;

  const PostModel({this.id, this.userId, this.title, this.body});

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: int.tryParse(map["id"].toString()),
      userId: int.tryParse(map["userId"].toString()),
      title: map["title"],
      body: map["body"],
    );
  }

  static List<PostModel> listFromJson(List<dynamic> map) {
    return List<PostModel>.from(
      map.map((image) => PostModel.fromMap(image)),
    );
  }
}
