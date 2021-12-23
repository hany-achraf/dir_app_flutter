import 'package:flutter/material.dart';

class Review {
  int id;
  int rating;
  String reviewerName;
  String reviewerImgPath;
  String comment;
  DateTime date = DateTime.now();

  Review({
    this.id,
    @required this.rating,
    @required this.reviewerName,
    @required this.reviewerImgPath,
    @required this.comment,
  });
}

List<Review> reviews1 = [
  Review(
    rating: 4,
    reviewerName: 'هاني أشرف',
    comment:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    reviewerImgPath: 'assets/images/santorini.png',
  ),
  Review(
    rating: 2,
    reviewerName: 'Omar K. Al Wakeel',
    comment:
        'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
    reviewerImgPath: 'assets/images/paris.png',
  ),
  Review(
    rating: 3,
    reviewerName: '楊仁忠',
    comment: 'Very professional!',
    reviewerImgPath: 'assets/images/murano.png',
  ),
  Review(
    rating: 5,
    reviewerName: 'Khaled Qabel',
    comment:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    reviewerImgPath: 'assets/images/saopaulo.png',
  ),
];

List<Review> reviews2 = [
  Review(
    rating: 5,
    reviewerName: 'Khaled Qabel',
    comment:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    reviewerImgPath: 'assets/images/saopaulo.png',
  ),
];

List<Review> reviews3 = [
  Review(
    rating: 4,
    reviewerName: 'هاني أشرف',
    comment:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    reviewerImgPath: 'assets/images/santorini.png',
  ),
  Review(
    rating: 2,
    reviewerName: 'Omar K. Al Wakeel',
    comment:
        'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
    reviewerImgPath: 'assets/images/paris.png',
  ),
];