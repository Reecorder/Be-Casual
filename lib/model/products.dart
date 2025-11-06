class ProductsModel {
  bool? enabled;
  String? name;
  List<ImageItem>? images;
  String? description;
  double? rating;
  List<String>? reviews;
  double? originalPrice;
  double? discountedPrice;
  List<String>? size;
  Category? category;
  Brand? brand;
  String? createdAt;
  String? updatedAt;
  String? id;

  ProductsModel({
    this.enabled,
    this.name,
    this.images,
    this.description,
    this.rating,
    this.reviews,
    this.originalPrice,
    this.discountedPrice,
    this.size,
    this.category,
    this.brand,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    enabled: json['enabled'],
    name: json['name'],
    images:
        (json['images'] as List?)?.map((e) => ImageItem.fromJson(e)).toList(),
    description: json['description'],
    rating: (json['rating'] as num?)?.toDouble(),
    reviews: (json['reviews'] as List?)?.map((e) => e.toString()).toList(),
    originalPrice: (json['originalPrice'] as num?)?.toDouble(),
    discountedPrice: (json['discountedPrice'] as num?)?.toDouble(),
    size: (json['size'] as List?)?.map((e) => e.toString()).toList(),
    category:
        json['category'] != null ? Category.fromJson(json['category']) : null,
    brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    id: json['id'],
  );
  Map<String, dynamic> toJson() => {
    'enabled': enabled,
    'name': name,
    'images': images?.map((e) => e.toJson()).toList(),
    'description': description,
    'rating': rating,
    'reviews': reviews,
    'originalPrice': originalPrice,
    'discountedPrice': discountedPrice,
    'size': size,
    'category': category?.toJson(),
    'brand': brand?.toJson(),
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'id': id,
  };
}

class ImageItem {
  String? url;
  String? name;
  String? mimetype;
  int? size;
  String? id;

  ImageItem({this.url, this.name, this.mimetype, this.size, this.id});

  factory ImageItem.fromJson(Map<String, dynamic> json) => ImageItem(
    url: json['url'],
    name: json['name'],
    mimetype: json['mimetype'],
    size: json['size'],
    id: json['id'],
  );

  Map<String, dynamic> toJson() => {
    'url': url,
    'name': name,
    'mimetype': mimetype,
    'size': size,
    'id': id,
  };
}

class Category {
  bool? enabled;
  String? name;
  String? description;
  List<ImageItem>? image;
  String? createdAt;
  String? updatedAt;
  String? id;

  Category({
    this.enabled,
    this.name,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    enabled: json['enabled'],
    name: json['name'],
    description: json['description'],
    image: (json['image'] as List?)?.map((e) => ImageItem.fromJson(e)).toList(),
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    id: json['id'],
  );

  Map<String, dynamic> toJson() => {
    'enabled': enabled,
    'name': name,
    'description': description,
    'image': image?.map((e) => e.toJson()).toList(),
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'id': id,
  };
}

class Brand {
  bool? enabled;
  String? name;
  List<ImageItem>? logo;
  String? createdAt;
  String? updatedAt;
  String? id;

  Brand({
    this.enabled,
    this.name,
    this.logo,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    enabled: json['enabled'],
    name: json['name'],
    logo: (json['logo'] as List?)?.map((e) => ImageItem.fromJson(e)).toList(),
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    id: json['id'],
  );

  Map<String, dynamic> toJson() => {
    'enabled': enabled,
    'name': name,
    'logo': logo?.map((e) => e.toJson()).toList(),
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'id': id,
  };
}
