class OrderModel {
  String? id;
  String? detail;
  String? orderDate;
  String? orderStatus;

  OrderModel({this.id, this.detail, this.orderDate, this.orderStatus});
}

List<OrderModel> orderLists = [
  OrderModel(
      id: "Order-123456",
      detail: "Indian Dress with Shopping Bags and 3 more items",
      orderDate: "Ordered On 31st December, 2023",
      orderStatus: "Ordered"),
  OrderModel(
      id:  "Order-342675",
      detail: "Indian Dress with Shopping Bags and 3 more items",
      orderDate: "Ordered On 31st December, 2023",
      orderStatus: "Shipped"),
  OrderModel(
      id: "Order-7654567",
      detail: "Indian Dress with Shopping Bags and 3 more items",
      orderDate: "Ordered On 31st December, 2023",
      orderStatus: "Out for Delivery"),
  OrderModel(
      id: "Order-7654567",
      detail: "Indian Dress with Shopping Bags and 3 more items",
      orderDate: "Ordered On 31st December, 2023",
      orderStatus: "Delivered"),
  OrderModel(
      id: "Order-123456",
      detail: "Indian Dress with Shopping Bags and 3 more items",
      orderDate: "Ordered On 31st December, 2023",
      orderStatus: "Ordered"),
  OrderModel(
      id: "Order-342675",
      detail: "Indian Dress with Shopping Bags and 3 more items",
      orderDate: "Ordered On 31st December, 2023",
      orderStatus: "Shipped"),
  OrderModel(
      id: "Order-7654567",
      detail: "Indian Dress with Shopping Bags and 3 more items",
      orderDate: "Ordered On 31st December, 2023",
      orderStatus: "Out for Delivery"),
  OrderModel(
      id: "Order-7654567",
      detail: "Indian Dress with Shopping Bags and 3 more items",
      orderDate: "Ordered On 31st December, 2023",
      orderStatus: "Delivered"),
];
