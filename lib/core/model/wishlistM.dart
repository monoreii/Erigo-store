
class wishlistM {
  List<String> image;
  String name;
  String price;
  int count;

  wishlistM({
    required this.image,
    required this.name,
    required this.price,
    required this.count,
  });

  factory wishlistM.fromJson(Map<String, dynamic> json) {
    return wishlistM(
      image: json['image'],
      name: json['name'],
      price: json['price'],
      count: json['count'],
    );
  }
}