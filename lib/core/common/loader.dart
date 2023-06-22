import 'package:flutter/material.dart';
import 'package:luna/theme/pallete.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Pallete.backgroundColor),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
