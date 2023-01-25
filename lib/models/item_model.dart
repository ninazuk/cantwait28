class ItemModel {
  ItemModel({
    required this.title,
    required this.id,
    required this.imageURL,
    required this.releaseDate,
  });

  final String title;
  final String id;
  final String imageURL;
  final DateTime releaseDate;
}
