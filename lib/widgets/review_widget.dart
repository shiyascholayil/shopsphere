
import 'package:flutter/material.dart';
import 'package:shopsphere/const.dart';
import 'package:shopsphere/models/reviews.dart';

class ReviewWidget extends StatelessWidget {

  final List<Reviews> review;

  const ReviewWidget({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {

    if (review.isEmpty) {

      return  Padding(

        padding: EdgeInsets.all(16),

        child: Text(
          "No reviews yet",
          style: emptyReviewStyle,
        ),
      );
    }

    return ListView.separated(

      shrinkWrap: true,

      physics:
      const NeverScrollableScrollPhysics(),

      itemCount: review.length,

      separatorBuilder: (context, index) =>
      const SizedBox(height: 12),

      itemBuilder: (context, index) {

        final reviewSection = review[index];

        return Container(

          margin:
          const EdgeInsets.symmetric(
            horizontal: 16,
          ),

          padding: const EdgeInsets.all(14),

          decoration: BoxDecoration(

            color: secondaryColor,

            borderRadius:
            BorderRadius.circular(16),

            border: Border.all(
              color: borderColor,
            ),

            boxShadow: [
          BoxShadow(
          color: primaryColor.withValues(alpha: 0.03),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
            ],
          ),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              Text(

                reviewSection.reviewName,

                style:reviewNames,
              ),

              const SizedBox(height: 8),

              Text(

                reviewSection.comment,

                style: reviewCommentStyle,
              ),

              const SizedBox(height: 10),

              Row(
                children: [

                  ...List.generate(5, (starIndex) {

                    return Icon(

                      starIndex <
                          reviewSection.rating
                          ? Icons.star_rounded
                          : Icons
                          .star_border_rounded,

                      color: yellowColor,

                      size: 18,
                    );
                  }),

                  const SizedBox(width: 8),

                  Text(

                    reviewSection.rating
                        .toString(),

                    style: reviewRatingStyle,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}