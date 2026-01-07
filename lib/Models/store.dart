class StoreModel {
  final String categoryId;
  final String name;
  final String address;
  final String logoUrl;

  StoreModel({
    required this.categoryId,
    required this.name,
    required this.address,
    required this.logoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      "categoryId": categoryId,
      "name": name,
      "address": address,
    };
  }

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      categoryId: json['categoryId'],
      name: json['name'],
      address: json['address'],
      logoUrl: json['logoUrl'] ?? '',
    );
  }
}
