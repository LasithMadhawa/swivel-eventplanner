class CommentModel {
  final int? id;
  final int? postId;
  final String? email;
  final String? name;
  final String? body;

  const CommentModel({this.id, this.postId, this.email, this.name, this.body});

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: int.tryParse(map["id"].toString()),
      postId: int.tryParse(map["postId"].toString()),
      email: map["email"],
      name: map["name"],
      body: map["body"],
    );
  }

  static List<CommentModel> listFromJson(List<dynamic> map) {
    return List<CommentModel>.from(
      map.map((image) => CommentModel.fromMap(image)),
    );
  }
}
