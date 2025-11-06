// class OrderModel {
//   final String? orderId;
//   final String status;
//   final String paymentMethod;
//   final int totalAmount;
//   final DateTime createdAt;

//   OrderModel({
//     required this.orderId,
//     required this.status,
//     required this.paymentMethod,
//     required this.totalAmount,
//     required this.createdAt,
//   });

//   factory OrderModel.fromJson(Map<String, dynamic> json) {
//     return OrderModel(
//       orderId: json['orderId'] ?? json['id'],
//       status: json['status'],
//       paymentMethod: json['paymentMethod'],
//       totalAmount: json['totalAmount'],
//       createdAt: DateTime.parse(json['createdAt']),
//     );
//   }
// }
class OrderModel {
  final String? id;
  final String? orderId;
  final Cart? cart;
  final Address? address;
  final int? totalAmount;
  final String? paymentMethod;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  OrderModel({
    this.id,
    this.orderId,
    this.cart,
    this.address,
    this.totalAmount,
    this.paymentMethod,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      orderId: json['orderId'],
      cart: json['cart'] != null ? Cart.fromJson(json['cart']) : null,
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      totalAmount: json['totalAmount'],
      paymentMethod: json['paymentMethod'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'cart': cart?.toJson(),
      'address': address?.toJson(),
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class Cart {
  final List<CartItem>? items;
  final int? totalPrice;
  final int? totalQty;

  Cart({this.items, this.totalPrice, this.totalQty});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => CartItem.fromJson(item))
          .toList(),
      totalPrice: json['totalPrice'],
      totalQty: json['totalQty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items?.map((item) => item.toJson()).toList(),
      'totalPrice': totalPrice,
      'totalQty': totalQty,
    };
  }
}

class CartItem {
  final String? product;
  final int? qty;
  final String? selectedSize;
  final String? id;

  CartItem({this.product, this.qty, this.selectedSize, this.id});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: json['product'],
      qty: json['qty'],
      selectedSize: json['selectedSize'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'qty': qty,
      'selectedSize': selectedSize,
      'id': id,
    };
  }
}

class Address {
  final String? fullAddress;
  final String? state;
  final String? city;
  final int? pin;
  final String? id;

  Address({this.fullAddress, this.state, this.city, this.pin, this.id});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      fullAddress: json['fullAddress'],
      state: json['state'],
      city: json['city'],
      pin: json['pin'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullAddress': fullAddress,
      'state': state,
      'city': city,
      'pin': pin,
      'id': id,
    };
  }
}
