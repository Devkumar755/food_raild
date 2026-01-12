class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final double mrp;
  final double sellPrice;
  final double costPrice;
  final int quantity;
  final int minQty;
  final String bannerImage;
  final List<String> productImages;
  final String categoryId;
  final String continentId;
  final String restaurantId;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.mrp,
    required this.sellPrice,
    required this.costPrice,
    required this.quantity,
    required this.minQty,
    required this.bannerImage,
    required this.productImages,
    required this.categoryId,
    required this.continentId,
    required this.restaurantId,
  });
}
