class CategoryOptions {
  String? image;
  String? name;
  String? price;

  CategoryOptions({this.image, this.name, this.price});
}

List<CategoryOptions> categoryOptionLists = [
  CategoryOptions(
    image: "assets/dashboard/cat1.jpg",
    name:  "Western Gown",
    price: "Starting from \$250"
  ),
  CategoryOptions(
    image: "assets/dashboard/cat2.jpg",
    name:  "Skirt",
    price: "Starting from \$500"
  ),CategoryOptions(
    image: "assets/dashboard/cat1.jpg",
    name:  "Western Overcoat",
    price: "Starting from \$750"
  ),
];
