class CartModel {
  String? productName;
  String? detail;
  String? image;
  String? price;
  int? quantity;

  CartModel(
      {this.productName, this.detail, this.image, this.price, this.quantity});
}

List<CartModel> cartModelLists = [
  CartModel(
      productName: "Indian Dress with Shopping Bags - Small",
      detail:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
      image: "assets/dashboard/cat2.jpg",
      price: "\$650",
      quantity: 2),
  CartModel(
      productName: "Indian Dress with Shopping Bags - large",
      detail:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
      image: "assets/dashboard/cat5.jpg",
      price: "\$650",
      quantity: 1)
];
