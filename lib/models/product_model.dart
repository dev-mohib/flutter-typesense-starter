class ProductModel {
  final String name;
  final String? shortDescription;
  final int? bestSellingRank;
  final String? thumbnailImage;
  final double salePrice;
  final String? manufacturer;
  final String url;
  final String? type;
  final String? image;
  final int? customerReviewCount;
  final String? shipping;
  final String? salePriceRange;
  final String? objectID;
  final List<dynamic>? categories;

  ProductModel({
    required this.name,
    required this.shortDescription,
    required this.bestSellingRank,
    required this.thumbnailImage,
    required this.salePrice,
    required this.manufacturer,
    required this.url,
    required this.type,
    required this.image,
    required this.customerReviewCount,
    required this.shipping,
    required this.salePriceRange,
    required this.objectID,
    required this.categories,
  });

  static ProductModel fromJson(Map<String, dynamic> json) => ProductModel(
        name: json['name'],
        shortDescription: json['shortDescription'],
        bestSellingRank: json['bestSellingRank'],
        thumbnailImage: json['thumbnailImage'],
        salePrice: json['salePrice'],
        manufacturer: json['manufacturer'],
        url: json['url'],
        type: json['type'],
        image: json['image'],
        customerReviewCount: json['customerReviewCount'],
        shipping: json['shipping'],
        salePriceRange: json['salePriceRange'],
        objectID: json['objectID'],
        categories: json['categories'],
      );
}
