import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/models/business_model.dart';
import 'package:plant_app/models/category_model.dart';
import 'package:plant_app/providers/business_provider.dart';
import 'package:plant_app/screens/business/business_screen.dart';
import 'package:plant_app/screens/category/components/sub_categories_slider.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  final int categoryId;
  final List<Business> _businesses = businesses;

  Body({this.categoryId});

  Row _buildRatingStars(int rating) {
    List<Icon> ratingStars = [];
    for (int i = 0; i < 5; i++) {
      if (i < rating)
        ratingStars.add(Icon(Icons.star, color: Colors.yellow));
      else
        ratingStars.add(Icon(Icons.star, color: Colors.grey.shade300));
    }
    return Row(
      children: ratingStars,
    );
  }

  @override
  Widget build(BuildContext context) {
    Category category =
        categories.firstWhere((category) => category.id == categoryId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Text(
              category.name,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        category.subcategories == null
            ? Container()
            : SubcategoriesSlider(category.subcategories),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 15.0),
            itemCount: _businesses.length,
            itemBuilder: (BuildContext context, int index) {
              Business business = _businesses[index];
              return InkWell(
                onTap: () {
                  Provider.of<BusinessProvider>(context, listen: false)
                      .setBusiness(business: _businesses[index]);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusinessScreen(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                  height: 170.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 5),
                        blurRadius: 5,
                        color: kPrimaryColor.withOpacity(0.23),
                      ),
                    ],
                  ),
                  child: Card(
                    // elevation: 1.5,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset(
                                business.thumbnailUrl,
                                height: 200,
                                width: 110.0,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 120.0,
                                    child: Text(
                                      business.name,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              _buildRatingStars(business.rating),
                              SizedBox(height: 10.0),
                              Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    width: 190.0,
                                    decoration: BoxDecoration(
                                      // color: Theme.of(context).accentColor,
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(business.workingTime),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
