// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class HealthModel {
  final Map<String, dynamic> attributes;

  HealthModel({
    required this.attributes,
  });

  HealthModel copyWith({
    Map<String, dynamic>? attributes,
  }) {
    return HealthModel(
      attributes: attributes ?? this.attributes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'attributes': attributes,
    };
  }

  factory HealthModel.fromMap(Map<String, dynamic> map) {
    return HealthModel(
      attributes: Map<String, dynamic>.from(
        (map['attributes'] as Map<String, dynamic>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory HealthModel.fromJson(String source) =>
      HealthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HealthModel(attributes: $attributes)';

  @override
  bool operator ==(covariant HealthModel other) {
    if (identical(this, other)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return mapEquals(other.attributes, attributes);
  }

  @override
  int get hashCode => attributes.hashCode;
}
