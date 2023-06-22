class RatingModel {
  final String userId;
  final double rating;
  RatingModel({
    required this.userId,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'rating': rating,
    };
  }

  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      userId: map['userId'] as String,
      rating: map['rating'] as double,
    );
  }

  RatingModel copyWith({
    String? userId,
    double? rating,
  }) {
    return RatingModel(
      userId: userId ?? this.userId,
      rating: rating ?? this.rating,
    );
  }

  @override
  String toString() => 'Rating(userId: $userId, rating: $rating)';

  @override
  bool operator ==(covariant RatingModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId && other.rating == rating;
  }

  @override
  int get hashCode => userId.hashCode ^ rating.hashCode;
}
