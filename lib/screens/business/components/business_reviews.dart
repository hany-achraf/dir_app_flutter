import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/models/business_model.dart';
import 'package:plant_app/models/review_model.dart';
import 'package:plant_app/models/user_model.dart';
import 'package:plant_app/providers/business_provider.dart';
import 'package:plant_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class BusinessReviews extends StatefulWidget {
  final Business business;
  final User user;
  const BusinessReviews({Key key, @required this.business, @required this.user})
      : super(key: key);

  @override
  State<BusinessReviews> createState() => _BusinessReviewsState();
}

class _BusinessReviewsState extends State<BusinessReviews> {
  bool _bottomMenuIsShown = false;

  Row _buildRatingStars(int rating) {
    List<Icon> ratingStars = [];
    for (int i = 0; i < 5; i++) {
      if (i < rating)
        ratingStars.add(Icon(Icons.star, color: Colors.yellow, size: 80.sp));
      else
        ratingStars
            .add(Icon(Icons.star, color: Colors.grey.shade300, size: 80.sp));
    }
    return Row(
      children: ratingStars,
    );
  }

  Wrap _buildBottomMenu() {
    return Wrap(
      children: [
        ListTile(
          leading: Icon(Icons.delete),
          title: Text(
            'delete',
            style: TextStyle(fontSize: 50.sp),
          ),
          onTap: () {
            Provider.of<BusinessProvider>(context, listen: false)
                .deleteReview();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void _showBottomMenu() {
    _bottomMenuIsShown = true;
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Color(0xFFE7EBEE),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          height: 200.h,
          child: _buildBottomMenu(),
        );
      },
    );
  }

  Widget renderReview(Review review) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            review.reviewer.avatarImgPath != null
                ? CircleAvatar(
                    radius: 100.r,
                    backgroundColor: Color(0xFFE7EBEE),
                    backgroundImage: NetworkImage(
                      '$api/image?path=${review.reviewer.avatarImgPath}',
                      headers: {'Connection': 'keep-alive'},
                    ),
                  )
                : CircleAvatar(
                    radius: 100.r,
                    backgroundColor: Color(0xFFE7EBEE),
                    child: Image.asset(
                      'assets/icons/avatar.png',
                      color: kPrimaryColor,
                    ),
                  ),
            InkWell(
              onTap: () {
                if (_bottomMenuIsShown) {
                  Navigator.of(context).pop();
                  _bottomMenuIsShown = false;
                }
              },
              onLongPress: () {
                User user = Provider.of<Auth>(context, listen: false).user;
                if (review.reviewer.id != user.id) return;
                _showBottomMenu();
              },
              child: Container(
                width: 1100.w,
                margin: EdgeInsets.only(left: 24.w),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.reviewer.getFullName(),
                      style: TextStyle(
                        fontSize: 50.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: _buildRatingStars(review.rate),
                        ),
                        Text(
                          DateFormat('dd MMM yyyy').format(review.date),
                          style: TextStyle(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ReadMoreText(
                      review.comment,
                      style: TextStyle(fontSize: 50.sp, color: Colors.black),
                      trimLines: 2,
                      colorClickableText: kPrimaryColor,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      moreStyle: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
    );
  }

  Column renderReviewsList(List<Review> reviews) {
    Column reviewsList = Column(
      children: [],
    );
    reviews.forEach((review) {
      reviewsList.children.add(renderReview(review));
    });
    return reviewsList;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_bottomMenuIsShown) {
          Navigator.of(context).pop();
          _bottomMenuIsShown = false;
        }
      },
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: renderReviewsList(widget.business.reviews),
        ),
      ),
    );
  }
}
