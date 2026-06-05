class Reviews {
  final int rating;
  final String comment;
  final String reviewName;

  Reviews({
    required this.comment,
    required this.rating,
    required this.reviewName,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      comment: json['comment'] ?? '',
      rating: json['rating'] ?? 0,
      reviewName: json['reviewerName'] ?? 'Anonymous',
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'rating': rating,
      'reviewerName': reviewName,
    };
  }
}