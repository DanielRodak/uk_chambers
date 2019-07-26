import 'dart:convert';

Chamber chamberFromJson(String str) => Chamber.fromJson(json.decode(str));

String chamberToJson(Chamber data) => json.encode(data.toJson());

class Chamber {
  String id;
  String name;
  String imageUrl;

  Chamber({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory Chamber.fromJson(Map<String, dynamic> json) => new Chamber(
    id: json["id"],
    name: json["name"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image_url": imageUrl,
  };
}