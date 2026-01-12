import 'package:flutter/material.dart';

class StarRatingSelector extends StatelessWidget {
  final double rating;
  final Function(double) onRatingChanged;
  final double size;
  final int starCount;

  const StarRatingSelector({
    super.key,
    required this.rating,
    required this.onRatingChanged,
    this.size = 30,
    this.starCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        return GestureDetector(
          onTap: () => onRatingChanged(index + 1.0),
          child: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: size,
          ),
        );
      }),
    );
  }
}
