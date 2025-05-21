class Course {
  final String image;
  final String title;
  final int lessons;
  final int price;
  final bool isBookmarked;

  Course({
    required this.image,
    required this.title,
    required this.lessons,
    required this.price,
    this.isBookmarked = false,
  });
}
