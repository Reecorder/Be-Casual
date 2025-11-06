class BrandsModel {
  bool? enabled;
  String? name;
  List<Logo>? logo;
  String? createdAt;
  String? updatedAt;
  String? id;

  BrandsModel(
      {this.enabled,
      this.name,
      this.logo,
      this.createdAt,
      this.updatedAt,
      this.id});

  BrandsModel.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    name = json['name'];
    if (json['logo'] != null) {
      logo = <Logo>[];
      json['logo'].forEach((v) {
        logo!.add( Logo.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enabled'] = enabled;
    data['name'] = name;
    if (logo != null) {
      data['logo'] = logo!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    return data;
  }
}

class Logo {
  String? url;
  String? name;
  String? mimetype;
  int? size;
  String? sId;
  String? id;

  Logo({this.url, this.name, this.mimetype, this.size, this.sId, this.id});

  Logo.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    mimetype = json['mimetype'];
    size = json['size'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] =url;
    data['name'] =name;
    data['mimetype'] =mimetype;
    data['size'] =size;
    data['_id'] =sId;
    data['id'] =id;
    return data;
  }
}
