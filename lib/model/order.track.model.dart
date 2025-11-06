class OrderTrackModel {
  String? title;
  String? subTitle;
  OrderTrackModel({this.title, this.subTitle});
}


List<OrderTrackModel> orderStatusLists = [
  OrderTrackModel(title: "Ordered on 25th December", subTitle: ""),
  OrderTrackModel(title: "Ordered on 25th December", subTitle: "Expected Time"),
  OrderTrackModel(title: "Out for Delivery", subTitle: "Not Processed"),
  OrderTrackModel(title: "Delivered", subTitle: "D")
];
