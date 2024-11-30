class ProductResponse {
  final String? title;
  final String? message;
  final ProductData? data;

  ProductResponse({this.title, this.message, this.data});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      title: json['title'],
      message: json['message'],
      data: json['data'] != null ? ProductData.fromJson(json['data']) : null,
    );
  }
}

class ProductData {
  final String? id;
  final String? slug;
  final Category? category;
  final Brand? brand;
  final String? title;
  final String? ingredient;
  final String? howToUse;
  final String? description;
  final int? price;
  final int? rewardPoint;
  final int? commissionPercentage;
  final int? strikePrice;
  final int? offPercent;
  final int? minOrder;
  final int? maxOrder;
  final bool? status;
  final List<String>? images;
  final List<ColorAttribute>? colorAttributes;
  final List<dynamic>?
      sizeAttributes; // Assuming sizeAttributes contains dynamic data
  final String? variantType;
  final List<ColorVariant>? colorVariants;
  final int? ratings;
  final int? totalRatings;
  final int? ratedBy;
  final FilterOptions? filterOptions;

  ProductData({
    this.id,
    this.slug,
    this.category,
    this.brand,
    this.title,
    this.ingredient,
    this.howToUse,
    this.description,
    this.price,
    this.rewardPoint,
    this.commissionPercentage,
    this.strikePrice,
    this.offPercent,
    this.minOrder,
    this.maxOrder,
    this.status,
    this.images,
    this.colorAttributes,
    this.sizeAttributes,
    this.variantType,
    this.colorVariants,
    this.ratings,
    this.totalRatings,
    this.ratedBy,
    this.filterOptions,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['_id'],
      slug: json['slug'],
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,
      title: json['title'],
      ingredient: json['ingredient'],
      howToUse: json['howToUse'],
      description: json['description'],
      price: json['price'],
      rewardPoint: json['rewardPoint'],
      commissionPercentage: json['commissionPercentage'],
      strikePrice: json['strikePrice'],
      offPercent: json['offPercent'],
      minOrder: json['minOrder'],
      maxOrder: json['maxOrder'],
      status: json['status'],
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      colorAttributes: (json['colorAttributes'] as List<dynamic>?)
          ?.map((e) => ColorAttribute.fromJson(e))
          .toList(),
      sizeAttributes: json['sizeAttributes'] as List<dynamic>?,
      variantType: json['variantType'],
      colorVariants: (json['colorVariants'] as List<dynamic>?)
          ?.map((e) => ColorVariant.fromJson(e))
          .toList(),
      ratings: json['ratings'],
      totalRatings: json['totalRatings'],
      ratedBy: json['ratedBy'],
      filterOptions: json['filterOptions'] != null
          ? FilterOptions.fromJson(json['filterOptions'])
          : null,
    );
  }
}

class Category {
  final String? id;
  final String? slug;
  final String? title;
  final int? level;
  final String? parentId;

  Category({this.id, this.slug, this.title, this.level, this.parentId});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      slug: json['slug'],
      title: json['title'],
      level: json['level'],
      parentId: json['parentId'],
    );
  }
}

class Brand {
  final String? id;
  final String? slug;
  final String? name;

  Brand({this.id, this.slug, this.name});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['_id'],
      slug: json['slug'],
      name: json['name'],
    );
  }
}

class ColorAttribute {
  final String? id;
  final bool? isTwin;
  final String? name;
  final List<String>? colorValue;

  ColorAttribute({this.id, this.isTwin, this.name, this.colorValue});

  factory ColorAttribute.fromJson(Map<String, dynamic> json) {
    return ColorAttribute(
      id: json['_id'],
      isTwin: json['isTwin'],
      name: json['name'],
      colorValue: (json['colorValue'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }
}

class ColorVariant {
  final ColorAttribute? color;
  final int? price;
  final int? rewardPoint;
  final int? strikePrice;
  final int? offPercent;
  final int? minOrder;
  final int? maxOrder;
  final bool? status;
  final List<dynamic>? images;
  final String? productCode;
  final String? id;

  ColorVariant({
    this.color,
    this.price,
    this.rewardPoint,
    this.strikePrice,
    this.offPercent,
    this.minOrder,
    this.maxOrder,
    this.status,
    this.images,
    this.productCode,
    this.id,
  });

  factory ColorVariant.fromJson(Map<String, dynamic> json) {
    return ColorVariant(
      color:
          json['color'] != null ? ColorAttribute.fromJson(json['color']) : null,
      price: json['price'],
      rewardPoint: json['rewardPoint'],
      strikePrice: json['strikePrice'],
      offPercent: json['offPercent'],
      minOrder: json['minOrder'],
      maxOrder: json['maxOrder'],
      status: json['status'],
      images: json['images'] as List<dynamic>?,
      productCode: json['productCode'],
      id: json['_id'],
    );
  }
}

class FilterOptions {
  // Add appropriate fields here based on the JSON structure

  FilterOptions();

  factory FilterOptions.fromJson(Map<String, dynamic> json) {
    return FilterOptions();
  }
}
