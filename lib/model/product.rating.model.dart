class ProductRatingModel {
  String? profileImage;
  String? comments;
  List? imageList;
  int? rating;

  ProductRatingModel(
      {this.profileImage, this.comments, this.imageList, this.rating});
}

List<ProductRatingModel> ratingLists = [
  ProductRatingModel(
      profileImage: "assets/product/profile_image1.jpg",
      comments:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type.",
      imageList: [
        "assets/product/review1.jpg",
        "assets/product/review1.jpg",
        "assets/product/review1.jpg",
        "assets/product/review1.jpg",
        "assets/product/review1.jpg"
      ],
      rating: 5),
  ProductRatingModel(
      profileImage: "assets/product/profile_image2.png",
      comments:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type.",
      imageList: [
        "assets/product/review2.jpg",
        "assets/product/review2.jpg",
        "assets/product/review2.jpg",
        "assets/product/review2.jpg",
        "assets/product/review2.jpg"
      ],
      rating: 3),
  ProductRatingModel(
      profileImage: "assets/product/profile_image1.jpg",
      comments:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type.",
      imageList: [
        "assets/product/review1.jpg",
        "assets/product/review1.jpg",
        "assets/product/review1.jpg",
        "assets/product/review1.jpg",
        "assets/product/review1.jpg"
      ],
      rating: 5),
];
