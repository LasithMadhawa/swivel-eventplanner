import 'dart:convert';

class ImageModel {
  final String? title;
  final String? url;
  final String? thumbnailUrl;

  const ImageModel({this.title, this.url, this.thumbnailUrl});

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      title: map["title"],
      url: _convertUrl(map["url"], "600x600"),
      thumbnailUrl: _convertUrl(map["thumbnailUrl"], "150x150"),
    );
  }

  static List<ImageModel> listFromJson(List<dynamic> map) {
    return List<ImageModel>.from(
      map.map((image) => ImageModel.fromMap(image)),
    );
  }

  static _convertUrl(String url, String resolution) {
    final colorCode = url.split('/').last;
    return "https://placehold.co/$resolution/$colorCode/FFF/png";
  }
}
