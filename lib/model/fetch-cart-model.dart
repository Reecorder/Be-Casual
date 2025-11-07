class FetchCartModel {
  String? user;
  List<Items>? items;
  int? totalPrice;
  int? totalQty;
  String? createdAt;
  String? updatedAt;
  String? id;

  FetchCartModel({
    this.user,
    this.items,
    this.totalPrice,
    this.totalQty,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory FetchCartModel.fromJson(Map<String, dynamic> json) {
    return FetchCartModel(
      user: json['user'],
      items:
          json['items'] != null
              ? List<Items>.from(json['items'].map((x) => Items.fromJson(x)))
              : null,
      totalPrice: json['totalPrice'],
      totalQty: json['totalQty'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'items': items?.map((x) => x.toJson()).toList(),
      'totalPrice': totalPrice,
      'totalQty': totalQty,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'id': id,
    };
  }
}

class Items {
  Product? product;
  int? qty;
  int? price;
  String? selectedSize;
  String? sId;
  String? id;

  Items({
    this.product,
    this.qty,
    this.price,
    this.selectedSize,
    this.sId,
    this.id,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      product:
          json['product'] is Map<String, dynamic>
              ? Product.fromJson(json['product'])
              : (json['product'] is String
                  ? Product(id: json['product'])
                  : null),
      qty: json['qty'],
      price: json['price'],
      selectedSize: json['selectedSize'],
      sId: json['_id'],
      id: json['id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'product': product?.toJson(),
      'qty': qty,
      'price': price,
      'selectedSize': selectedSize,
      '_id': sId,
      'id': id,
    };
  }
}

class Product {
  bool? enabled;
  String? name;
  List<ProductImage>? images;
  String? description;
  double? rating;
  List<String>? reviews;
  int? originalPrice;
  int? discountedPrice;
  List<String>? size;
  String? category;
  String? brand;
  String? createdAt;
  String? updatedAt;
  String? id;

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      enabled: json['enabled'],
      name: json['name'],
      images:
          json['images'] != null
              ? List<ProductImage>.from(
                json['images'].map((x) => ProductImage.fromJson(x)),
              )
              : null,
      description: json['description'],
      rating: json['rating']?.toDouble(),
      reviews:
          json['reviews'] != null ? List<String>.from(json['reviews']) : null,
      originalPrice: json['originalPrice'],
      discountedPrice: json['discountedPrice'],
      size: json['size'] != null ? List<String>.from(json['size']) : null,
      category: json['category'],
      brand: json['brand'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'name': name,
      'images': images?.map((x) => x.toJson()).toList(),
      'description': description,
      'rating': rating,
      'reviews': reviews,
      'originalPrice': originalPrice,
      'discountedPrice': discountedPrice,
      'size': size,
      'category': category,
      'brand': brand,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'id': id,
    };
  }
}

class ProductImage {
  String? url;
  String? publicId;
  String? id;

  ProductImage({this.url, this.publicId, this.id});

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      url: json['url'],
      publicId: json['public_id'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'url': url, 'public_id': publicId, 'id': id};
  }
}
