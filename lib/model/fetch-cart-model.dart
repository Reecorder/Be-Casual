// class FetchCartModel {
//   String? user;
//   List<Items>? items;
//   int? totalPrice;
//   int? totalQty;
//   String? createdAt;
//   String? updatedAt;
//   String? id;

//   FetchCartModel(
//       {user,
//       items,
//       totalPrice,
//       totalQty,
//       createdAt,
//       updatedAt,
//       id});

//   FetchCartModel.fromJson(Map<String, dynamic> json) {
//     user = json['user'];
//     if (json['items'] != null) {
//       items = <Items>[];
//       json['items'].forEach((v) {
//         items!.add(Items.fromJson(v));
//       });
//     }
//     totalPrice = json['totalPrice'];
//     totalQty = json['totalQty'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['user'] = user;
//     if (items != null) {
//       data['items'] = items!.map((v) => v.toJson()).toList();
//     }
//     data['totalPrice'] = totalPrice;
//     data['totalQty'] = totalQty;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['id'] = id;
//     return data;
//   }
// }

// class Items {
//   Product? product;
//   int? qty;
//   int? price;
//   String? selectedSize;
//   String? sId;
//   String? id;

//   Items(
//       {product,
//       qty,
//       price,
//       selectedSize,
//       sId,
//       id});

//   Items.fromJson(Map<String, dynamic> json) {
//     product =
//         json['product'] != null ? Product.fromJson(json['product']) : null;
//     qty = json['qty'];
//     price = json['price'];
//     selectedSize = json['selectedSize'];
//     sId = json['_id'];
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  <String, dynamic>{};
//     if (product != null) {
//       data['product'] = product!.toJson();
//     }
//     data['qty'] = qty;
//     data['price'] = price;
//     data['selectedSize'] = selectedSize;
//     data['_id'] = sId;
//     data['id'] = id;
//     return data;
//   }
// }

// class Product {
//   bool? enabled;
//   String? name;
//   List<Images>? images;
//   String? description;
//   double? rating;
//   List<String>? reviews;
//   int? originalPrice;
//   int? discountedPrice;
//   List<String>? size;
//   String? category;
//   String? brand;
//   String? createdAt;
//   String? updatedAt;
//   String? id;

//   Product(
//       {enabled,
//       name,
//       images,
//       description,
//       rating,
//       reviews,
//       originalPrice,
//       discountedPrice,
//       size,
//       category,
//       brand,
//       createdAt,
//       updatedAt,
//       id});

//   Product.fromJson(Map<String, dynamic> json) {
//     enabled = json['enabled'];
//     name = json['name'];
//     if (json['images'] != null) {
//       images = <Images>[];
//       json['images'].forEach((v) {
//         images!.add( Images.fromJson(v));
//       });
//     }
//     description = json['description'];
//     rating = json['rating'];
//     reviews = json['reviews'].cast<String>();
//     originalPrice = json['originalPrice'];
//     discountedPrice = json['discountedPrice'];
//     size = json['size'].cast<String>();
//     category = json['category'];
//     brand = json['brand'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  <String, dynamic>{};
//     data['enabled'] = enabled;
//     data['name'] = name;
//     if (images != null) {
//       data['images'] = images!.map((v) => v.toJson()).toList();
//     }
//     data['description'] = description;
//     data['rating'] = rating;
//     data['reviews'] = reviews;
//     data['originalPrice'] = originalPrice;
//     data['discountedPrice'] = discountedPrice;
//     data['size'] = size;
//     data['category'] = category;
//     data['brand'] = brand;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['id'] = id;
//     return data;
//   }
// }

// class Images {
//   String? url;
//   String? name;
//   String? mimetype;
//   int? size;
//   String? sId;
//   String? id;

//   Images({url, name, mimetype, size, sId, id});

//   Images.fromJson(Map<String, dynamic> json) {
//     url = json['url'];
//     name = json['name'];
//     mimetype = json['mimetype'];
//     size = json['size'];
//     sId = json['_id'];
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  <String, dynamic>{};
//     data['url'] = url;
//     data['name'] = name;
//     data['mimetype'] = mimetype;
//     data['size'] = size;
//     data['_id'] = sId;
//     data['id'] = id;
//     return data;
//   }
// }
class FetchCartModel {
  String? user;
  List<CartItem>? items;
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
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => CartItem.fromJson(item))
          .toList(),
      totalPrice: json['totalPrice'],
      totalQty: json['totalQty'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      id: json['id'],
    );
  }
}

class CartItem {
  Product? product;
  int? qty;
  int? price;
  String? selectedSize;
  String? id;

  CartItem({
    this.product,
    this.qty,
    this.price,
    this.selectedSize,
    this.id,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
      qty: json['qty'],
      price: json['price'],
      selectedSize: json['selectedSize'],
      id: json['id'],
    );
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
      images: (json['images'] as List<dynamic>?)
          ?.map((img) => ProductImage.fromJson(img))
          .toList(),
      description: json['description'],
      rating: (json['rating'] as num?)?.toDouble(),
      reviews: List<String>.from(json['reviews'] ?? []),
      originalPrice: json['originalPrice'],
      discountedPrice: json['discountedPrice'],
      size: List<String>.from(json['size'] ?? []),
      category: json['category'],
      brand: json['brand'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      id: json['id'],
    );
  }
}

class ProductImage {
  String? url;
  String? name;
  String? mimetype;
  int? size;
  String? id;

  ProductImage({
    this.url,
    this.name,
    this.mimetype,
    this.size,
    this.id,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      url: json['url'],
      name: json['name'],
      mimetype: json['mimetype'],
      size: json['size'],
      id: json['id'],
    );
  }
}
