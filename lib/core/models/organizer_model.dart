class OrganizerModel {
  final int? id;
  final String? name;
  final String? email;

  const OrganizerModel({this.id, this.name, this.email});

  factory OrganizerModel.fromMap(Map<String, dynamic> map) {
    return OrganizerModel(
      id: int.tryParse(map["id"].toString()),
      name: map["name"],
      email: map["email"],
    );
  }

  static List<OrganizerModel> listFromJson(List<dynamic> map) {
    return List<OrganizerModel>.from(
      map.map((image) => OrganizerModel.fromMap(image)),
    );
  }
}
