import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/models/promotion_model.dart';
import 'package:readmore/readmore.dart';

class PromotionScreen extends StatelessWidget {
  final Promotion promotion;

  PromotionScreen({this.promotion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          customAppBar(context, imgUrl: promotion.imgUrl),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.loose,
                            child: Text(
                              // 'Promotion Name',
                              promotion.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              alignment: Alignment.topRight,
                              icon: Icon(Icons.favorite_border,
                                  color: Colors.grey, size: 25)),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.loose,
                            child: Text(
                              // 'Business/Provider Name',
                              promotion.promotionProvider,
                              style: TextStyle(
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                          Text(
                            // 'Until 24 Dec 2021',
                            'Untill ${DateFormat("dd MMM yyyy").format(promotion.endDate)}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        // width: 300,
                        child: ReadMoreText(
                          // 'Promotion Description',
                          promotion.description,
                          style: TextStyle(color: Colors.black),
                          trimLines: 3,
                          colorClickableText: kPrimaryColor,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          moreStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

SliverAppBar customAppBar(BuildContext context, {String imgUrl}) {
  return SliverAppBar(
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
        size: 30.0,
      ),
      onPressed: () {
        Navigator.maybePop(context);
      },
    ),
    pinned: true,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Icon(
          Icons.search,
          color: Colors.white,
          size: 30.0,
        ),
      ),
    ],
    // expandedHeight: 400,
    expandedHeight: MediaQuery.of(context).size.height / 1.5,
    flexibleSpace: FlexibleSpaceBar(
      background: Stack(children: [
        Positioned.fill(
          child: Image.network(
            imgUrl,
            fit: BoxFit.fill,
          ),
        ),
      ]),
    ),
  );
}