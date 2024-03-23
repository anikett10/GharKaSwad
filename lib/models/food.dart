class Food {
  String name;
  String image;
  double cal;
  double time;
  double rate;
  int reviews;
  bool isLiked;

  Food({
    required this.name,
    required this.image,
    required this.cal,
    required this.time,
    required this.rate,
    required this.reviews,
    required this.isLiked,
  });
}

final List<Food> foods = [
  Food(
    name: "Butter Chicken",
    image: "assets/images/butterchicken.jpeg",
    cal: 120,
    time: 15,
    rate: 350,
    reviews: 23,
    isLiked: false,
  ),
  Food(
    name: "Chana Masala",
    image: "assets/images/chanamasala.jpeg",
    cal: 140,
    time: 25,
    rate: 230,
    reviews: 23,
    isLiked: true,
  ),
  Food(
    name: "Dal Palak",
    image: "assets/images/dalpalak.jpeg",
    cal: 130,
    time: 18,
    rate: 250,
    reviews: 10,
    isLiked: false,
  ),
  Food(
    name: "Gajarmuliachar",
    image: "assets/images/gajarmuliachar.jpeg",
    cal: 110,
    time: 16,
    rate: 230,
    reviews: 90,
    isLiked: true,
  ),
  Food(
      name: "Haldi",
    image: "assets/images/haldi.jpeg",
    cal: 150,
    time: 30,
    rate: 135,
    reviews: 76,
    isLiked: false,
  ),
  Food(
    name: "Poha",
    image: "assets/images/poha.jpeg",
    cal: 140,
    time: 25,
    rate: 30,
    reviews: 23,
    isLiked: false,
  ),
];
