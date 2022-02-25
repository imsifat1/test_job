import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

Padding Ratings(ratingNumber) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.s,
      children: [
        RatingBar.builder(
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemSize: 20.0,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            ratingNumber.value = rating;
            print(rating);
          },
        ),
        SizedBox(
          width: 10,
        ),
        Obx(
          () => Text(
            "$ratingNumber/5",
            style: TextStyle(color: Color(0xFFF56018)),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "48 Ratings",
          style: TextStyle(color: Color(0xFFF56018)),
        ),
      ],
    ),
  );
}
