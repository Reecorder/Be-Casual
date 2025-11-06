class AddressModel {
  final String addressType;
  final String fullAddress;
  final String state;
  final String city;
  final int pin;
  final String userId;
  final String createdAt;
  final String updatedAt;
  final String id;

  AddressModel({
    required this.addressType,
    required this.fullAddress,
    required this.state,
    required this.city,
    required this.pin,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressType: json['addressType'] ?? '',
      fullAddress: json['fullAddress'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      pin: json['pin'] ?? 0,
      userId: json['userId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addressType': addressType,
      'fullAddress': fullAddress,
      'state': state,
      'city': city,
      'pin': pin,
      'userId': userId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'id': id,
    };
  }
}
