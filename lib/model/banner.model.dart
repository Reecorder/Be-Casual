class BannerModel {
  bool? status;
  String? message;
  List<String>? data;

  BannerModel({this.status, this.message, this.data});

  BannerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? List<String>.from(json['data']) : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['status'] = status;
    dataMap['message'] = message;
    dataMap['data'] = data;
    return dataMap;
  }
}
