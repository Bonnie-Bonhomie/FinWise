class ProductModel {

  String id;
  String name;
  String category;
  String shortDes;
  String longDes;
  String regularPrice;
  String salePrice;
  String discountPrice;
  String isDiscount;
  String coverImage;
  String otherImage;
  String deliveryDurat;

  String soldOut;
  String? status;
  String? isHot;
  String createdAt;
  String? updatedAt;


  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.shortDes,
    required this.longDes,
    required this.regularPrice,
    required this.salePrice,
    required this.discountPrice,
    required this.isDiscount,
    required this.coverImage,
    required this.otherImage,
    required this.deliveryDurat,
    required this.createdAt,
    required this.updatedAt,
    required this.soldOut,
    this.status, this.isHot
  });

  factory ProductModel.fromJson(Map<String, dynamic> json){
    return ProductModel(
      id: json['id'].toString(),
      name: json['name'].toString(),
        category: json['category'].toString(),
        shortDes: json['short_description'].toString(),
        longDes: json['long_description'].toString(),
        regularPrice: json['regular_price'].toString(),
        salePrice: json['sale_price'].toString(),
        discountPrice: json['discount_price'].toString(),
        isDiscount: json['is_discount'].toString(),
        coverImage: json['cover_image'].toString(),
        otherImage: json['other_image'].toString(),
        deliveryDurat: json['delivery_duration'].toString(),
        createdAt: json['created_at'].toString(),
        updatedAt: json['updated_at'].toString(),
        soldOut: json['is_sold_out']..toString(),
        status: json['status'].toString(),
        isHot: json['is_hot_sale'].toString(),

    );
  }

}