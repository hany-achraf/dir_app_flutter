import 'package:flutter/material.dart';
import 'package:plant_app/delegates/custom_search_delegate.dart';
import 'package:plant_app/models/business_model.dart';
import 'package:plant_app/models/destination_model.dart';
import 'package:plant_app/providers/businesses_provider.dart';
import 'package:plant_app/screens/business/business_screen.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants.dart';

class DestinationScreen extends StatefulWidget {
  final Destination destination;

  DestinationScreen({@required this.destination});

  @override
  State<DestinationScreen> createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
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

  final RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    Provider.of<BusinessesProvider>(context, listen: false)
        .loadInitialBusinesses(destinationId: widget.destination.id);
  }

  @override
  Widget build(BuildContext context) {
    final List<Business> businesses =
        Provider.of<BusinessesProvider>(context, listen: true).businesses;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            customAppBar(
              context,
              imgPath: widget.destination.imgPath,
              destinationName: widget.destination.name,
            ),
          ];
        },
        body: businesses == null
            ? Center(child: CircularProgressIndicator(color: kPrimaryColor))
            : businesses.isEmpty
                ? Center(
                    child: Text(
                      'No Data to Show!',
                      style: TextStyle(color: kPrimaryColor, fontSize: 20),
                    ),
                  )
                : SmartRefresher(
                    controller: refreshController,
                    enablePullDown: false,
                    enablePullUp: true,
                    onLoading: () async {
                      // load more, and return true if there is more to load and vice versa
                      bool gotMoreToLoad =
                          await Provider.of<BusinessesProvider>(context,
                                  listen: false)
                              .loadMoreBusinesses();

                      // if no more to load exeute the laodNoData() method on refreshController
                      if (!gotMoreToLoad) {
                        refreshController.loadNoData();
                      } else {
                        refreshController.loadComplete();
                      }
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                      itemCount: businesses.length,
                      itemBuilder: (BuildContext context, int index) {
                        Business business = businesses[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BusinessScreen(businessId: business.id)),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 5),
                                  blurRadius: 5,
                                  color: kPrimaryColor.withOpacity(0.23),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.14,
                                  width:
                                      MediaQuery.of(context).size.height * 0.14,
                                  margin:
                                      EdgeInsets.only(left: 8.0, right: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE7EBEE),
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.14 /
                                              2),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.14 /
                                              2),
                                      child: Image.network(
                                        '${api}/image?path=${business.iconImgPath}',
                                        headers: {'Connection': 'keep-alive'},
                                        fit: BoxFit.fill,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Icon(
                                          Icons.image,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.63,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        business.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      _buildRatingStars(business.avgRate),
                                      SizedBox(height: 10.0),
                                      Container(
                                        padding: EdgeInsets.all(5.0),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        decoration: BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          business.workingTime,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}

SliverAppBar customAppBar(BuildContext context,
    {String imgPath, String destinationName}) {
  return SliverAppBar(
    title: Text(
      destinationName,
    ),
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
        child: IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {
            showSearch(context: context, delegate: CustomSearchDelegate());
          },
        ),
      ),
    ],
    expandedHeight: MediaQuery.of(context).size.height / 1.9,
    flexibleSpace: FlexibleSpaceBar(
      background: Container(
        decoration: BoxDecoration(
          color: kBackgroundColor,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Image.network(
              '${api}/image?path=${imgPath}',
              headers: {'Connection': 'keep-alive'},
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.image,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
