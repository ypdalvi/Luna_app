// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:luna/models/rating_model.dart';

class ProductModel {
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? pid;
  final List<RatingModel> rating;
  ProductModel({
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    required this.pid,
    required this.rating,
  });

  ProductModel copyWith({
    String? name,
    String? description,
    double? quantity,
    List<String>? images,
    String? category,
    double? price,
    String? pid,
    List<RatingModel>? rating,
  }) {
    return ProductModel(
      name: name ?? this.name,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      images: images ?? this.images,
      category: category ?? this.category,
      price: price ?? this.price,
      pid: pid ?? this.pid,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'pid': pid,
      'rating': rating.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] as String,
      description: map['description'] as String,
      quantity: map['quantity'] as double,
      images: (map['images'] as List).map((item) => item as String).toList(),
      category: map['category'] as String,
      price: map['price'] as double,
      pid: map['pid'] != null ? map['pid'] as String : null,
      rating : (map['rating'] as List<dynamic>).map((e) => RatingModel.fromMap(e)).toList(),
      // rating: List<RatingModel>.from(
      //   (map['rating'] as List<int>).map<RatingModel>(
      //     (x) => RatingModel.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
    );
  }

  @override
  String toString() {
    return 'ProductModel(name: $name, description: $description, quantity: $quantity, images: $images, category: $category, price: $price, pid: $pid, rating: $rating)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.name == name &&
        other.description == description &&
        other.quantity == quantity &&
        listEquals(other.images, images) &&
        other.category == category &&
        other.price == price &&
        other.pid == pid &&
        listEquals(other.rating, rating);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        quantity.hashCode ^
        images.hashCode ^
        category.hashCode ^
        price.hashCode ^
        pid.hashCode ^
        rating.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
