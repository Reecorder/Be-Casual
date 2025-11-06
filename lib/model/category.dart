import 'dart:convert';

class CategoryItem {
  bool? enabled;
  String? name;
  String? description;
  List<ImageModel>? image;
  String? createdAt;
  String? updatedAt;
  String? id;

  CategoryItem({
    this.enabled,
    this.name,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      enabled: json["enabled"],
      name: json["name"],
      description: json["description"],
      image: json["image"] != null
          ? List<ImageModel>.from(json["image"].map((x) => ImageModel.fromJson(x)))
          : [],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "enabled": enabled,
      "name": name,
      "description": description,
      "image": image != null ? List<dynamic>.from(image!.map((x) => x.toJson())) : [],
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "id": id,
    };
  }
}

class ImageModel {
  String? url;
  String? name;
  String? mimetype;
  int? size;
  String? id;

  ImageModel({
    this.url,
    this.name,
    this.mimetype,
    this.size,
    this.id,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      url: json["url"],
      name: json["name"],
      mimetype: json["mimetype"],
      size: json["size"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "url": url,
      "name": name,
      "mimetype": mimetype,
      "size": size,
      "_id": id,
    };
  }
}

