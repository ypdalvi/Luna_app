import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:luna/theme/pallete.dart';

class Stars extends StatelessWidget {
  final double rating;
  const Stars({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return RatingBarIndicator(
      unratedColor: Pallete.objColor,
      direction: Axis.horizontal,
      itemCount: 5,
      rating: rating,
      itemSize: 30,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Pallete.darkestObjColor,
      ),
    );
  }
}
