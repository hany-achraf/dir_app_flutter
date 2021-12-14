import 'package:flutter/material.dart';
import 'package:plant_app/components/my_bottom_nav_bar.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/business/business_screen.dart';

Row _buildRatingStars(int rating) {
  List<Icon> ratingStars = [];
  for (int i = 0; i < 5; i++) {
    if (i < rating)
      ratingStars.add(Icon(Icons.star, color: Colors.yellow, size: 17));
    else
      ratingStars.add(Icon(Icons.star, color: Colors.grey.shade300, size: 17));
  }
  return Row(
    children: ratingStars,
  );
}

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: ListView(
        children: [
          SavedBusiness(),
          SizedBox(
            height: 8,
          ),
          SavedBusiness(),
          SizedBox(
            height: 8,
          ),
          SavedBusiness(),
          SizedBox(
            height: 8,
          ),
          SavedBusiness(),
          SizedBox(
            height: 8,
          ),
          SavedBusiness(),
          SizedBox(
            height: 8,
          ),
          SavedBusiness(),
          SizedBox(
            height: 8,
          ),
          SavedBusiness(),
          SizedBox(
            height: 8,
          ),
          SavedBusiness(),
          SizedBox(
            height: 8,
          ),
          SavedBusiness(),
          SizedBox(
            height: 8,
          ),
          SavedBusiness(),
          SizedBox(
            height: 8,
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}

class SavedBusiness extends StatelessWidget {
  const SavedBusiness({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BusinessScreen()),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://savorsunsets.com/wp-content/uploads/2019/04/IMG_1891.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 8,
                    ),
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            text: TextSpan(
                              text:
                                  'Everyday Parenting: The ABCs of Child Rearing',
                              // 'Hany Mohamed',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        _buildRatingStars(3),
                        Row(
                          children: [
                            Icon(
                              Icons.circle_rounded,
                              color: kPrimaryColor,
                              size: 7,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                text: TextSpan(
                                  text: 'Added 6d ago',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          PopupMenuButton(
            icon: Icon(
              Icons.more_horiz,
            ),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.remove_circle_outline_rounded),
                    Container(
                        margin: const EdgeInsets.only(left: 4),
                        child: Text('Remove from wishlist')),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}